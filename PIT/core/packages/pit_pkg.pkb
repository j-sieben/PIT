create or replace package body pit_pkg
as
  /************************* TYPE DECLARATIONS ********************************/
  
  -- list of modules
  type module_list_type is table of pit_module index by pit_util.ora_name_type;

  -- all modules that could be instantiated
  g_all_modules module_list_type;

  -- all modules which are available for logging (meaning: status = msg.MODULE_INSTANTIATED)
  g_available_modules module_list_type;

  -- debug and trace settings, stored within a context
  type context_rec is record (
    context_name pit_util.ora_name_type,
    settings pit_util.max_sql_char,
    log_level binary_integer,
    trace_level binary_integer,
    trace_timing boolean,
    active_log_modules module_list_type,
    module_list pit_util.max_sql_char,
    context_type pit_util.ora_name_type,
    allow_toggle boolean,
    broadcast_context_switch boolean);
  g_ctx context_rec;

  type named_ctx_list_tab is table of context_type index by pit_util.ora_name_type;
  g_named_ctx_list named_ctx_list_tab;

  /* call stack */
  type call_stack_tab is table of call_stack_type index by binary_integer;
  g_call_stack call_stack_tab;

  /************************* PACKAGE VARIABLES ********************************/
  /* parameter constants */
  c_package_owner constant pit_util.ora_name_type := '&INSTALL_USER.';
  c_param_group constant pit_util.ora_name_type := 'PIT';
  c_base_module constant pit_util.ora_name_type := 'PIT_MODULE';

  /* log level constants */
  c_adapter_preference constant pit_util.ora_name_type := 'ADAPTER_PREFERENCE';

  /* context constants */
  C_GLOBAL_CONTEXT constant pit_util.ora_name_type := substr('PIT_CTX_' || c_package_owner, 1, 30);
  C_CONTEXT_TYPE constant pit_util.ora_name_type := C_GLOBAL_CONTEXT || '_TYPE';
  C_CONTEXT_GROUP constant pit_util.ora_name_type := 'CONTEXT';
  C_CONTEXT_PREFIX constant pit_util.ora_name_type := C_CONTEXT_GROUP || '_';
  C_CONTEXT_DEFAULT constant pit_util.ora_name_type := C_CONTEXT_GROUP || '_DEFAULT';
  C_CONTEXT_ACTIVE constant pit_util.ora_name_type := C_CONTEXT_GROUP || '_ACTIVE';
  C_TOGGLE_GROUP constant pit_util.ora_name_type := 'TOGGLE';
  C_TOGGLE_PREFIX constant varchar2(20) := C_TOGGLE_GROUP || '_';
  C_ALLOW_TOGGLE constant pit_util.ora_name_type := 'ALLOW_TOGGLE';
  C_BROADCAST_CONTEXT_SWITCH constant pit_util.ora_name_type := 'BROADCAST_CONTEXT_SWITCH';
  C_PASS_MESSAGE constant pit_util.ora_name_type := 'PIT_PASS_MESSAGE';
  C_CTX_DEL constant pit_util.flag_type := '|';
  C_LIST_DEL constant pit_util.flag_type := ':';
  C_CTX_NAME_DEL constant pit_util.flag_type := '@';

  /* adapter constants */
  C_ADAPTER_OK constant binary_integer := 1;

  /* generic constants */
  C_TRUE constant pit_util.flag_type := 'Y';
  C_FALSE constant pit_util.flag_type := 'N';
  C_SPLIT_REGEX constant varchar2(10) := '[^\|]+';

  /* "events" */
  C_EVENT_FOCUS_ALL constant varchar2(10) := 'ALL';
  C_EVENT_FOCUS_ACTIVE constant varchar2(10) := 'ACTIVE';

  C_CONTEXT_EVENT constant integer := 1;
  C_LOG_EVENT constant integer := 2;
  C_PURGE_EVENT constant integer := 3;
  C_PRINT_EVENT constant integer := 4;
  C_ENTER_EVENT constant integer := 5;
  C_LEAVE_EVENT constant integer := 6;
  C_NOTIFY_EVENT constant integer := 7;

  -- defined here to avoid dependency from PIT
  C_TRACE_MANDATORY constant integer := 20;

  /* package vars */
  g_active_adapter default_adapter;
  g_language pit_util.ora_name_type;
  g_user_name pit_util.ora_name_type;
  g_client_id varchar2(64);


  /************************* FORWARD DECLARATION ******************************/
  procedure raise_event(
    p_event in binary_integer,
    p_event_focus in varchar2,
    p_call_stack in call_stack_type default null,
    p_date_before in date default null,
    p_severity_greater_equal in binary_integer default null,
    p_message message_type default null);
    

  /************************** MODULE MAINTENANCE ******************************/
  /* Helper to load all output modules installed extending PIT_MODULE
   * %usage procedure loads and instantiates all output modules which are
   *        create under PIT_MODULE and at the same time listed in parameter
   *        DEFAULT_LOG_MODULES.
   *        After instantiation, all modules are made available in PL/SQL table MODULES
   */
  procedure load_modules
  as
    cursor installed_modules_cur is
      select to_char(type_name) type_name
        from all_types
       where supertype_name = c_base_module
         and owner = c_package_owner;
    c_stmt_template constant varchar2(100) := 'begin :i := new #MODULE#(); end;';
    l_stmt varchar2(200);
    l_module_instance pit_module;
  begin
    g_all_modules.delete;
    for module in installed_modules_cur loop

      -- instantiate subtype with parameterless constructor method
      l_stmt := replace(c_stmt_template, '#MODULE#', module.type_name);
      begin
        execute immediate l_stmt using out l_module_instance;
      exception
        when others then
          -- PIT is not yet instantiated, no output modules available. Simply write to console
          dbms_output.put_line('Error when executing "' || l_stmt || '": ' || sqlerrm);
      end;

      -- persist reference to out module in module_list
      g_all_modules(module.type_name) := l_module_instance;
      if l_module_instance.status = msg.PIT_MODULE_INSTANTIATED then
        -- persiste reference to out module in available_modules
        g_available_modules(module.type_name) := l_module_instance;
      end if;
    end loop;
    if g_all_modules.count = 0 then
      raise_application_error(-20000, 'No output modules instantiated.');
    end if;
  end load_modules;


  /* Procedure to report all modules that have not been loaded succesfully
   * %usage This procedure is called after initialization of the output modules.
   *        It will emit warnings for any module that has not been loaded succesfully.
   */
  procedure report_module_status
  as
    l_idx pit_util.ora_name_type;
  begin
    l_idx := g_all_modules.first;
    while l_idx is not null loop
       if g_all_modules(l_idx).status != msg.PIT_MODULE_INSTANTIATED then
          pit.warn(msg.PIT_FAIL_MODULE_INIT, msg_args(l_idx, g_all_modules(l_idx).stack));
       end if;
       l_idx := g_all_modules.next(l_idx);
    end loop;
  end report_module_status;


  /* Helper to read a list of all available output modules for a given context
   * %param p_requested_modules Colon-separated list of requested output modules
   * %return Collection of available and requested module instances
   * %usage This function is used to fill a list of available modules as requested
   *        by the actual context. These modules will then be used to log to.
   */
  function get_modules_by_name(
    p_requested_modules in varchar2)
    return module_list_type
  as
    l_module_names args;
    l_module pit_util.ora_name_type;
    l_modules module_list_type;
  begin
    l_module_names := pit_util.string_to_table(p_requested_modules);
    for l_idx in 1 .. l_module_names.count loop
       l_module := l_module_names(l_idx);
       if g_available_modules.exists(l_module) then
          l_modules(l_module) := g_available_modules(l_module);
       end if;
    end loop;
    return l_modules;
  end get_modules_by_name;


  /************************ CONTEXT MAINTENANCE ******************************/
  /* Helper method to persist context settings in package variable for easy access
   * %param p_settings List of actual settings
   * %usage Is called to spread settings string to context type
   */
  procedure store_settings_locally(
    p_settings in varchar2)
  as
  begin
    g_ctx.settings := substr(p_settings, 1, instr(p_settings, C_CTX_NAME_DEL) - 1);
    g_ctx.context_name := substr(g_ctx.settings, instr(p_settings, C_CTX_NAME_DEL) + 1);
    g_ctx.log_level := to_number(regexp_substr(g_ctx.settings, C_SPLIT_REGEX, 1, 1));
    g_ctx.trace_level := to_number(regexp_substr(g_ctx.settings, C_SPLIT_REGEX, 1, 2));
    g_ctx.trace_timing := regexp_substr(g_ctx.settings, C_SPLIT_REGEX, 1, 3) = C_TRUE;
    g_ctx.module_list := regexp_substr(g_ctx.settings, C_SPLIT_REGEX, 1, 4);
    g_ctx.active_log_modules := get_modules_by_name(g_ctx.module_list);
  end store_settings_locally;


  /* Helper to set new context settings for PIT
   * %param p_settings New context settings
   * %usage Is called from the interface methods set_context to actually persist
   *        the required settings in the global context and raise a context switch
   *        event
   */
  procedure set_active_context(
    p_settings in varchar2)
  as
    l_raise_focus pit_util.ora_name_type;
  begin
    if instr(p_settings, g_ctx.settings) = 0 then
      g_active_adapter.get_session_details(g_user_name, g_client_id);
      store_settings_locally(p_settings);
      utl_context.set_value(C_GLOBAL_CONTEXT, C_CONTEXT_ACTIVE, g_ctx.settings, g_client_id);
      case when g_ctx.broadcast_context_switch 
        then l_raise_focus := C_EVENT_FOCUS_ALL;
        else l_raise_focus := C_EVENT_FOCUS_ACTIVE;
      end case;
      raise_event(C_CONTEXT_EVENT, l_raise_focus);
    end if;
  end set_active_context;


  /* Helper to check whether a toggle for a given package/method exists
   * %return Settings for the package/method
   */
  function get_toggle_context(
    p_module in pit_util.ora_name_type,
    p_method in pit_util.ora_name_type)
    return varchar2
  as
    l_args args;
    l_settings pit_util.max_char;
  begin
    -- Check whether toggle for package/method exists.
    l_args := args(
                substr(upper(C_TOGGLE_PREFIX || p_module || '.' ||  p_method), 1, 30),
                upper(C_TOGGLE_PREFIX || p_module),
                C_CONTEXT_ACTIVE, C_CONTEXT_DEFAULT);
    l_settings := utl_context.get_first_match(C_GLOBAL_CONTEXT, l_args, true, g_client_id);
    return l_settings;
  end get_toggle_context;


  procedure reset_toggle_context(
    p_settings in varchar2)
  as
  begin
    if g_ctx.allow_toggle then
      -- after raised event, check whether toggle context requires context switch
      case
      when instr(p_settings, C_CONTEXT_DEFAULT) > 0 then
        reset_active_context;
      when p_settings is not null then
        set_active_context(p_settings);
      else
        null;
      end case;
    end if;
  end reset_toggle_context;


  /* Helper to read the actual context settings
   * %return Active context, if available, default context else.
   * %usage This function is called to read the actual context from the
   *        globally accessed context.
   */
  procedure get_context_values
  as
    l_args args;
    l_settings pit_util.max_sql_char;
  begin
    g_active_adapter.get_session_details(g_user_name, g_client_id);
    l_args := args(C_CONTEXT_ACTIVE, C_CONTEXT_DEFAULT);
    l_settings := utl_context.get_first_match(C_GLOBAL_CONTEXT, l_args, true, g_client_id);
    store_settings_locally(l_settings);
  end get_context_values;


  /* Reads all predefined context and toggles and stores it in global context
   * %usage Method is called upon package initialization to serve two purposes:
   *        1. persist the settings globally for harmonized access over the sessions
   *        2. retrieve actual log settings
   */
  procedure get_context_list
  as
    cursor context_cur is
        with toggles as (
             select C_TOGGLE_PREFIX ||
                    replace(to_char(substr(par_string_value, 1,
                            instr(par_string_value, C_CTX_DEL) - 1)), C_LIST_DEL, C_LIST_DEL || C_TOGGLE_PREFIX) tgl_name,
                    C_CONTEXT_PREFIX || to_char(substr(par_string_value, instr(par_string_value, C_CTX_DEL) + 1)) ctx_name
               from parameter_tab
              where par_id like C_TOGGLE_PREFIX || '%'
                and par_pgr_id = c_param_group),
             contexts as (
             select par_id ctx_name,
                    to_char(par_string_value) string_value
               from parameter_tab
              where par_id like C_CONTEXT_PREFIX || '%'
                and par_pgr_id = c_param_group
             )
      select to_char(tgl_name) name, c.string_value setting
        from toggles t
        join contexts c
          on t.ctx_name = c.ctx_name
      union all
      select ctx_name, string_value
        from contexts
       where ctx_name != C_CONTEXT_ACTIVE;
    l_ctx context_type;
    l_ctx_name pit_util.ora_name_type;
  begin
    g_named_ctx_list.delete;

    -- In Default, extend visibility of parameter according to the type of CONTEXT
    -- by setting user_name and/or client_id to a predefined UTL_CONTEXT.C_NO_VALUE
    -- Available Types: utl_contxt.c_...
    --   GLOBAL | FORCE_USER | ORCE_CLIENT_ID | FORCE_USER_CLIENT_ID |
    --   PREFER_CLIENT_ID | PREFER_USER_CLIENT_ID | SESSION
    g_ctx.context_type := param.get_string(C_CONTEXT_TYPE, C_CONTEXT_GROUP);
    if g_ctx.context_type not in (
                utl_context.c_session,
                utl_context.c_force_client_id,
                utl_context.c_force_user_client_id)
    then g_client_id := utl_context.c_no_value;
    end if;

    for ctx in context_cur loop
      -- Switch between Toggles and Contextes
      if ctx.name like C_TOGGLE_PREFIX || '%' then
        for i in 1 .. regexp_count(ctx.name, C_LIST_DEL) + 1 loop
          l_ctx_name := regexp_substr(ctx.name, '[^' || C_LIST_DEL || ']+', 1, i);
          utl_context.set_value(C_GLOBAL_CONTEXT, l_ctx_name, ctx.setting, g_client_id);
        end loop;
      else
        utl_context.set_value(C_GLOBAL_CONTEXT, ctx.name, ctx.setting, g_client_id);
      end if;
    end loop;
  end get_context_list;


  /************************* ADATPER MAINTENANCE ******************************/
  /* Helper to load and instantiate an adapter to read client information
   * %usage procedure loads and instantiates adapters which are created
   *        under <code>DEFAULT_ADAPTER</code> plus <code>DEFAULT_ADAPTER</code> itself.<br>
   *        Which modules are instantiated depends on parameter <code>ADAPTER_PREFERENCE</code>
   *        <code>LOAD_ADAPTER</code> tries to instantiate the adpaters
   *        in the order specified in the parameter and stops upon first successful instantiation.<br>
   *        The instantiated module provides information about the actual environment.
   */
  procedure load_adapter
  as
    l_adapter_list args;
    l_adapter default_adapter;
    l_idx pit_util.ora_name_type;
    c_stmt_template constant varchar2(200) := 'begin :a := new #ADAPTER#(); end;';
    l_stmt varchar2(200);
  begin
    l_adapter_list := pit_util.string_to_table(param.get_string(c_adapter_preference, c_param_group));
    l_idx := l_adapter_list.first;
    
    while l_idx is not null loop
      begin
        l_stmt := replace(c_stmt_template, '#ADAPTER#', l_adapter_list(l_idx));
        execute immediate l_stmt using out l_adapter;
      exception
        when others then
          -- ignore instantiation error
          dbms_output.put_line('Error instantiating adapter "' || l_adapter_list(l_idx) || '": ' || sqlerrm);
      end;
      if l_adapter is not null and l_adapter.status = C_ADAPTER_OK then
        g_active_adapter := l_adapter;
        exit;
      end if;
      l_idx := l_adapter_list.next(l_idx);
    end loop;
    -- confirm that default adapter is installed anyway
    if g_active_adapter is null then
      g_active_adapter := default_adapter();
    end if;
  end load_adapter;


  /************************** CALL STACK MAINTENANCE **************************/
  function check_context_toggle(
    p_trace_settings in varchar2,
    p_last_entry in binary_integer)
    return varchar2
  as
    l_trace_settings pit_util.max_sql_char;
  begin
    if g_ctx.allow_toggle then
      if p_last_entry = 0 then
        -- first entry on stack
        if p_trace_settings is not null then
          l_trace_settings := p_trace_settings;
          set_active_context(l_trace_settings);
        end if;
      else
        -- get last trace settings from stack
        l_trace_settings := g_call_stack(p_last_entry).trace_settings;
        -- If a toggle is found, check whether trace settings differs from current setting
        if p_trace_settings != coalesce(l_trace_settings, 'FOO') then
          -- Switch settings and persist new trace settings
          l_trace_settings := p_trace_settings;
          set_active_context(l_trace_settings);
        end if;
      end if;
    end if;
    return l_trace_settings;
  end check_context_toggle;
  
  
  /* Method to add a call to the call stack
   * %param p_module Module that was called
   * %param p_action Method of the module that was called
   * %param p_params Parameter list of parameters passed to the method
   * %usage Called from the ENTER-Method
   */
  procedure push_stack(
    p_module in varchar2,
    p_action in varchar2,
    p_params in msg_params,
    p_trace_settings in varchar2 default null)
  as
    l_last_entry binary_integer;
  begin
    l_last_entry := g_call_stack.count;

    -- maintain timing
    if l_last_entry > 0 and g_ctx.trace_timing then
       g_call_stack(l_last_entry).pause();
    end if;

    g_call_stack(l_last_entry + 1) :=
       call_stack_type(
          p_session_id => g_client_id,
          p_user_name => g_user_name,
          p_module_name => p_module,
          p_method_name => p_action,
          p_params => p_params,
          p_call_level => l_last_entry + 1,
          p_trace_timing => case when g_ctx.trace_timing then C_TRUE else C_FALSE end,
          p_trace_settings => check_context_toggle(p_trace_settings, l_last_entry));
  end push_stack;


  /* Method to remove an entry from the call stack
   * %param p_call_stack instance of call_stack_type to pop to the stack
   * %return Last entry found on the call stack. Used to maintain timing etc.
   * %usage Called from LEAVE-method.
   */
  procedure pop_stack(
    p_call_stack in out nocopy call_stack_type,
    p_new_trace_settings out nocopy varchar2)
  as
    l_last_entry binary_integer;
    l_module_name p_call_stack.module_name%type;
    l_method_name p_call_stack.method_name%type;
    l_predecessor call_stack_type;
  begin
    l_last_entry := g_call_stack.last;
    if l_last_entry > 0 then
      p_call_stack := g_call_stack(l_last_entry);
      -- maintain timing for call stack entries
      if g_ctx.trace_timing then
        p_call_stack.leave;
      end if;

      if l_last_entry > 1 then
        l_predecessor := g_call_stack(l_last_entry - 1);
        l_predecessor.resume();
        case
        when p_call_stack.trace_settings is not null
         and l_predecessor.trace_settings is null then
          p_new_trace_settings := C_CONTEXT_DEFAULT;
        when p_call_stack.trace_settings != l_predecessor.trace_settings then
          p_new_trace_settings := l_predecessor.trace_settings;
        else
          null;
        end case;
      end if;
      
      g_call_stack.delete(l_last_entry);
    end if;
  end pop_stack;


  /* Helper method to clean stack after a fatal error has ocurred.
   * %usage Called from method LOG if level is C_LEVEL_FATAL.
   *        Pops all call stack entries
   */
  procedure clean_stack
  as
    l_call_stack call_stack_type;
    l_trace_settings pit_util.max_sql_char;
  begin
    for i in 1 .. g_call_stack.count loop
      leave(C_TRACE_MANDATORY);
    end loop;
  end clean_stack;


  /************************** CENTRAL FUNCTIONALITY **************************/
  /* Helper to raise an event
   * %param p_event Integer indicating the type of "event" (i.e. LOG|PRINT|ENTER etc.) thrown by PIT
   * %param p_event_focus Flag to indicate whether the message shall be broadcasted to all
   *        available modules or only to active ones.
   * %param p_call_stack Instance of the actual call stack in the event of ENTER|LEAVE
   * %param p_date_before Date indicating the point in time, up to when the log shall be purged
   * %param p_message Instance of the message to raise
   * %usage Called internally as a generic helper to throw messages to output modules
   */
  procedure raise_event(
    p_event in binary_integer,
    p_event_focus in varchar2,
    p_call_stack in call_stack_type default null,
    p_date_before in date default null,
    p_severity_greater_equal in binary_integer default null,
    p_message message_type default null)
  as
    pragma autonomous_transaction;
    l_idx pit_util.ora_name_type;
    l_ctx pit_context;
    l_modules module_list_type;
    l_trace_timing pit_util.flag_type;
  begin

    case p_event_focus
      when C_EVENT_FOCUS_ALL then
        l_modules := g_available_modules;
      when C_EVENT_FOCUS_ACTIVE then
        l_modules := g_ctx.active_log_modules;
      else
      null;
    end case;

    -- propagate event to output modules
    -- l_modules is indexed by varchar2, therefore this loop mimic is required
    l_idx := l_modules.first;
    while l_idx is not null loop
      case p_event
        when C_CONTEXT_EVENT then
          l_trace_timing := case when g_ctx.trace_timing then C_TRUE else C_FALSE end;
          l_ctx := pit_context(g_ctx.log_level, g_ctx.trace_level, l_trace_timing, g_ctx.module_list);
          l_modules(l_idx).context_changed(l_ctx);
        when C_LOG_EVENT then
          l_modules(l_idx).log(p_message);
        when C_PURGE_EVENT then
          l_modules(l_idx).purge(p_date_before, p_severity_greater_equal);
        when C_PRINT_EVENT then
          l_modules(l_idx).print(p_message);
        when C_NOTIFY_EVENT then
          l_modules(l_idx).notify(p_message);
        when C_ENTER_EVENT then
          l_modules(l_idx).enter(p_call_stack);
        when C_LEAVE_EVENT then
          l_modules(l_idx).leave(p_call_stack);
        else
          null;
      end case;
      l_idx := l_modules.next(l_idx);
    end loop;
    commit;
  end raise_event;


  /* Helper function to decide whether a message shall be logged.
   * %param p_severity log_level for which a decision is requested
   * %return flag that indicates whether settings allow for logging.
   * %usage This function is called during logging to decide whether the actual
   *        settings allow for logging.<br>
   *        The decision is based on the requested log level as well as
   *        upon settings in the global context
   */
  function log_me(
    p_severity in pit_message.pms_pse_id%type,
    p_message_name in pit_message.pms_name%type)
    return boolean
  as
  begin
    get_context_values;
    return p_severity <= greatest(g_ctx.log_level, pit.level_error);
  exception
    when no_data_found then
      return false;
  end log_me;


  /* Helper function to decide whether an entry or leave shall be traced.
   * %param p_severity trace_level for which a decision is requested
   * %return flag that indicates whether settings allow for tracing.
   * %usage This function is called during tracing to decide whether the actual
   *        settings allow for tracing.<br>
   *        The decision is based on the requested trace level as well as
   *        upon settings in the global context
   */
  function trace_me(
    p_severity in integer)
    return boolean
  as
  begin
    get_context_values;
    return p_severity <= g_ctx.trace_level;
  end trace_me;


  /* Helper method to get module and action from UTL_CALL_STACK
   * %param p_trace_level Controls the recursive level needed by UTL_CALL_STACK
   * %param p_module Module that was called
   * %param p_action Method with module that was called
   * %usage Is used only from Oracle 12c onwards. Should p_module and/or p_action
   *        be null, UTL_CALL_STACK is called to get the respective information
   */
  procedure get_module_and_action(
    p_module in out nocopy varchar2,
    p_action in out nocopy varchar2)
  as
    $IF dbms_db_version.ver_le_11 $THEN
    $ELSE
    l_module_position integer;
    l_action_position integer;
    l_qualified_name utl_call_stack.unit_qualified_name;
    -- variable to adjust recursive call level for UTL_CALL_STACK
    l_trace_depth integer := 5;
    l_invalid_depth exception;
    pragma exception_init(l_invalid_depth, -64610);
    $END
  begin
    $IF dbms_db_version.ver_le_11 $THEN
    null;
    $ELSE
    if p_action is null or p_module is null then
      begin
        l_qualified_name := utl_call_stack.subprogram(l_trace_depth);
      exception
        when l_invalid_depth then
          l_qualified_name := utl_call_stack.subprogram(3);
      end;
      l_module_position := greatest(least(l_qualified_name.count - 1, 1), 1);
      l_action_position := l_qualified_name.count;
    end if;
    if l_action_position > 1 then
      -- Anonymous blocks don't have a module, leave it out
      p_module := lower(coalesce(p_module, l_qualified_name(l_module_position)));
    end if;
    p_action := lower(coalesce(p_action, l_qualified_name(l_action_position)));
    $END
  end get_module_and_action;


  /****************************** INTERFACE ***********************************/
  procedure initialize
  as
  begin
    g_language := sys_context('USERENV', 'LANGUAGE');
    g_language := substr(g_language, 1, instr(g_language, '_') - 1);
    g_call_stack.delete;
    g_ctx.context_type := param.get_string(C_CONTEXT_TYPE, C_CONTEXT_GROUP);
    g_ctx.allow_toggle := param.get_boolean(C_ALLOW_TOGGLE, c_param_group);
    g_ctx.broadcast_context_switch := param.get_boolean(C_BROADCAST_CONTEXT_SWITCH, c_param_group);
    load_modules;
    load_adapter;
    get_context_list;

    -- starting here, PIT is initialized and prepared to create messages
    report_module_status;
  end initialize;

  /* CORE */
  procedure log_event(
    p_severity in binary_integer,
    p_message_name in pit_util.ora_name_type,
    p_arg_list in msg_args,
    p_affected_id in pit_util.max_sql_char)
  as
    l_message message_type;
  begin
    if log_me(p_severity, p_message_name) then
      -- instantiate message
      l_message := get_message(p_message_name, p_affected_id, p_arg_list);
      -- Persist severity of calling environment with message
      l_message.severity := p_severity;

      raise_event(
        p_event => C_LOG_EVENT,
        p_event_focus => C_EVENT_FOCUS_ACTIVE,
        p_message => l_message);
    end if;
  end log_event;
                                                          
                                                          
  procedure log_specific(
    p_severity in binary_integer,
    p_message_name in pit_util.ora_name_type,
    p_arg_list in msg_args,
    p_affected_id in pit_util.max_sql_char,
    p_module_list in pit_util.max_sql_char)
  as
    l_message message_type;
    l_module_list varchar2(2000);
  begin
    get_context_values;
    l_message := get_message(p_message_name, p_affected_id, p_arg_list);
    -- log only, if message severity level is below optionally passed in P_SEVERITY param
    if l_message.severity <= p_severity then
      -- persist output modules for later recovery
      if p_module_list is not null then
        l_module_list := g_ctx.module_list;
        set_context(g_ctx.log_level, g_ctx.trace_level, g_ctx.trace_timing, p_module_list);
      end if;
                                                          
      raise_event(
        p_event => c_log_event,
        p_event_focus => c_event_focus_active,
        p_message => l_message);
                                                          
      -- reset output modules                                                    
      if p_module_list is not null then
        set_context(g_ctx.log_level, g_ctx.trace_level, g_ctx.trace_timing, l_module_list);
      end if;
    end if;
  end log_specific;


  procedure log_specific(
    p_message_name in pit_util.ora_name_type,
    p_affected_id in pit_util.max_sql_char,
    p_arg_list in msg_args,
    p_log_threshold in pit_message.pms_pse_id%type,
    p_log_modules in pit_util.max_sql_char)
  as
    l_message message_type;
    l_ctx_old context_type;
    l_ctx_new context_type;
    l_context_name pit_util.ora_name_type;
    l_ctx_change boolean := false;
  begin
    get_context_values;
    l_ctx_old.log_level := g_ctx.log_level;
    l_ctx_old.trace_level := g_ctx.trace_level;
    l_ctx_old.trace_timing := g_ctx.trace_timing;
    l_ctx_old.log_modules := g_ctx.module_list;
    l_ctx_new := l_ctx_old;
    l_context_name := g_ctx.context_name;
    l_message := get_message(p_message_name, p_affected_id, p_arg_list);

    if l_message.severity <= coalesce(p_log_threshold, g_ctx.log_level) then
      -- Switch to log modules passed in if necessary
      if p_log_modules is not null then
        l_ctx_new.log_modules := p_log_modules;
        l_ctx_change := true;
      end if;
      -- Set differing log_threshold if necessary
      if p_log_threshold is not null then
        l_ctx_new.log_level := p_log_threshold;
        l_ctx_change := true;
      end if;
      -- persist changes
      if l_ctx_change then
        set_context(l_ctx_new);
      end if;

      raise_event(
        p_event => C_LOG_EVENT,
        p_event_focus => C_EVENT_FOCUS_ACTIVE,
        p_message => l_message);

      -- clean up after setting changes
      if l_ctx_change then
        if l_context_name = c_context_default then
          reset_context;
        else
          set_context(l_ctx_old);
        end if;
      end if;
    end if;
  end log_specific;


  procedure enter(
    p_action in pit_util.ora_name_type,
    p_module in pit_util.ora_name_type,
    p_params in msg_params,
    p_trace_level in binary_integer,
    p_client_info in varchar2 default null)
  as
    l_action pit_util.ora_name_type := p_action;
    l_module pit_util.ora_name_type := p_module;
    l_trace_me boolean;
  begin
    l_trace_me := trace_me(p_trace_level);
    
    -- Do minimal tracing if context toggle is active
    if g_ctx.allow_toggle or l_trace_me then
      get_module_and_action(
        p_module => l_module,
        p_action => l_action);

      push_stack(
        p_module => l_module,
        p_action => l_action,
        p_params => p_params,
        p_trace_settings => get_toggle_context(p_module, p_action));
        
      if g_ctx.allow_toggle then
        l_trace_me := trace_me(p_trace_level);
      end if;
    end if;

    if l_trace_me then
      raise_event(
        p_event => C_ENTER_EVENT,
        p_event_focus => C_EVENT_FOCUS_ACTIVE,
        p_call_stack => g_call_stack(g_call_stack.last));
    end if;

    -- set dbms_application info anyway in mandatory level
    if p_trace_level = pit.trace_mandatory then
      dbms_application_info.set_module(l_module, l_action);
      dbms_application_info.set_client_info(p_client_info);
    end if;
  exception
    when others then
      pit.error(msg.PIT_FAIL_MESSAGE_CREATION, msg_args(sqlerrm));
  end enter;


  procedure leave(
    p_trace_level in binary_integer)
  is
    l_call_stack call_stack_type;
    l_trace_me boolean;
    l_new_trace_settings pit_util.max_sql_char;
  begin
    l_trace_me := trace_me(p_trace_level);

    -- Do minimal tracing if context toggle is active
    if g_ctx.allow_toggle or l_trace_me then
       -- finalize entry in call stack and pass to output modules
       pop_stack(l_call_stack, l_new_trace_settings);
    end if;

    if l_trace_me and l_call_stack is not null then
      -- replace existing ID with new ID to allow for persitance
      l_call_stack.id := pit_log_seq.nextval;
      raise_event(
        p_event => C_LEAVE_EVENT,
        p_event_focus => C_EVENT_FOCUS_ACTIVE,
        p_call_stack => l_call_stack);
    end if;

    reset_toggle_context(l_new_trace_settings);
  exception
    when others then
      pit.error(msg.PIT_FAIL_MESSAGE_CREATION);
  end leave;


  procedure print(
    p_message_name in pit_util.ora_name_type,
    p_arg_list msg_args default null)
  as
  begin
    raise_event(
       p_event => C_PRINT_EVENT,
       p_event_focus => C_EVENT_FOCUS_ACTIVE,
       p_message => get_message(p_message_name, null, p_arg_list));
  exception
    when others then
      pit.error(msg.PIT_FAIL_MESSAGE_CREATION, msg_args(p_message_name));
  end print;
  
  
  procedure notify(
    p_message_name in pit_util.ora_name_type,
    p_affected_id in pit_util.max_sql_char,
    p_arg_list in msg_args,
    p_log_threshold in pit_message.pms_pse_id%type,
    p_log_modules in pit_util.max_sql_char)
  as
    l_message message_type;
    l_ctx_old context_type;
    l_ctx_new context_type;
    l_context_name pit_util.ora_name_type;
    l_ctx_change boolean := false;
  begin
    get_context_values;
    l_ctx_old.log_level := g_ctx.log_level;
    l_ctx_old.trace_level := g_ctx.trace_level;
    l_ctx_old.trace_timing := g_ctx.trace_timing;
    l_ctx_old.log_modules := g_ctx.module_list;
    l_ctx_new := l_ctx_old;
    l_context_name := coalesce(g_ctx.context_name, C_CONTEXT_DEFAULT);
    l_message := get_message(p_message_name, p_affected_id, p_arg_list);

    if l_message.severity <= coalesce(p_log_threshold, g_ctx.log_level) then
      -- Switch to log modules passed in if necessary
      if p_log_modules is not null then
        l_ctx_new.log_modules := p_log_modules;
        l_ctx_change := true;
      end if;
      -- Set differing log_threshold if necessary
      if p_log_threshold is not null then
        l_ctx_new.log_level := p_log_threshold;
        l_ctx_change := true;
      end if;
      -- persist changes
      if l_ctx_change then
        set_context(l_ctx_new);
      end if;

      raise_event(
        p_event => C_NOTIFY_EVENT,
        p_event_focus => C_EVENT_FOCUS_ACTIVE,
        p_message => l_message);

      -- clean up after setting changes
      if l_ctx_change then
        if l_context_name = c_context_default then
          reset_context;
        else
          set_context(l_ctx_old);
        end if;
      end if;
    end if;
  end notify;


  procedure raise_error(
    p_severity in binary_integer,
    p_message_name pit_util.ora_name_type,
    p_affected_id in pit_util.max_sql_char,
    p_arg_list in msg_args)
  as
    l_arg_list msg_args;
    l_message message_type;
  begin

    l_message := get_message(p_message_name, p_affected_id, p_arg_list);

    -- If message is C_PASS_MESSAGE, it does not contain the original
    -- error number. Replace with active SQLCODE and get message from SQLERRM
    if p_message_name = C_PASS_MESSAGE then
      l_message.error_number := sqlcode;
      $IF dbms_db_version.ver_le_11 $THEN
      l_message.message_text := substr(sqlerrm, instr(sqlerrm, ' ') + 1);
      $ELSE
      l_message.message_text := utl_call_stack.error_msg(1);
      $END
    end if;
    raise_application_error(
      l_message.error_number,
      dbms_lob.substr(l_message.message_text, 2048, 1));
  end raise_error;


  procedure handle_error(
    p_severity in binary_integer,
    p_message_name pit_util.ora_name_type,
    p_affected_id in pit_util.max_sql_char,
    p_arg_list in msg_args)
  as
  begin
    log_event(p_severity, p_message_name, p_arg_list, p_affected_id, null);
    if p_severity = pit.level_fatal then
      clean_stack;
      raise_error(pit.level_fatal, p_message_name, p_affected_id, p_arg_list);
    end if;
  end;


  procedure purge_log(
    p_date_before in date,
    p_severity_greater_equal in binary_integer default null)
  as
  begin
    raise_event(
          p_event => C_PURGE_EVENT,
          p_event_focus => C_EVENT_FOCUS_ACTIVE,
          p_date_before => p_date_before,
          p_severity_greater_equal => p_severity_greater_equal);
    exception
      when others then
        pit.error(msg.PIT_FAIL_MESSAGE_PURGE);
  end purge_log;


  function get_message(
    p_message_name in pit_util.ora_name_type,
    p_affected_id in pit_util.max_sql_char,
    p_arg_list msg_args)
   return message_type
  as
  begin
    return message_type(
             p_message_name => p_message_name,
             p_message_language => g_language,
             p_affected_id => p_affected_id,
             p_session_id => g_client_id,
             p_user_name => g_user_name,
             p_arg_list => p_arg_list);
  exception
    when NO_DATA_FOUND then
      pit.stop(msg.PIT_MSG_NOT_EXISTING, msg_args(p_message_name));
  end get_message;


  function get_message_text(
    p_message_name in pit_util.ora_name_type,
    p_arg_list in msg_args default null)
    return clob
  as
  begin
    return get_message(p_message_name, null, p_arg_list).message_text;
  end get_message_text;


  /* CONTEXT MAINTENANCE */
  function get_context
    return context_type
  is
    l_context context_type;
  begin
    get_context_values;
    l_context.log_level := g_ctx.log_level;
    l_context.trace_level := g_ctx.trace_level;
    l_context.trace_timing := g_ctx.trace_timing;
    l_context.log_modules := g_ctx.module_list;
    return l_context;
  end get_context;


  procedure set_context(
    p_log_level in binary_integer,
    p_trace_level in binary_integer,
    p_trace_timing in boolean,
    p_module_list in pit_util.max_sql_char)
  as
    l_trace_timing pit_util.flag_type;
    l_trace_settings pit_util.max_sql_char;
  begin
    l_trace_timing := case when p_trace_timing then C_TRUE else C_FALSE end;
    l_trace_settings := pit_util.concatenate(char_table(p_log_level, p_trace_level, l_trace_timing, p_module_list), C_CTX_DEL);
    pit_util.check_context_settings(C_CONTEXT_ACTIVE, l_trace_settings);
    
    set_active_context(l_trace_settings || C_CTX_NAME_DEL || C_CONTEXT_ACTIVE);
  end set_context;


  procedure set_context(
    p_context in context_type)
  as
  begin
    set_context(
      p_log_level => p_context.log_level,
      p_trace_level => p_context.trace_level,
      p_trace_timing => p_context.trace_timing,
      p_module_list => p_context.log_modules);
  end set_context;


  procedure set_context(
    p_context_name in pit_util.ora_name_type)
  as
    l_context_name pit_util.ora_name_type;
    l_settings pit_util.max_sql_char;
  begin
    l_context_name := pit_util.harmonize_name(C_CONTEXT_PREFIX, p_context_name);
    if l_context_name = C_CONTEXT_DEFAULT then
      reset_active_context;
    else
      l_settings := utl_context.get_value(C_GLOBAL_CONTEXT, l_context_name);
      if l_settings is not null then
        set_active_context(l_settings || C_CTX_NAME_DEL || l_context_name);
      else
        pit.fatal(msg.PIT_UNKNOWN_NAMED_CONTEXT, msg_args(p_context_name));
      end if;
    end if;
  exception
    when msg.PIT_UNKNOWN_NAMED_CONTEXT_ERR then
      pit.stop;
  end set_context;


  procedure reset_active_context
  as
    l_raise_focus pit_util.ora_name_type;
  begin
    g_active_adapter.get_session_details(g_user_name, g_client_id);

    utl_context.clear_value(C_GLOBAL_CONTEXT, C_CONTEXT_ACTIVE, g_client_id);
    get_context_values;
    l_raise_focus := case when g_ctx.broadcast_context_switch then C_EVENT_FOCUS_ALL else C_EVENT_FOCUS_ACTIVE end;
    raise_event(C_CONTEXT_EVENT, l_raise_focus);
  end reset_active_context;


  procedure reset_context
  as
  begin
    utl_context.reset_context(C_GLOBAL_CONTEXT);
    initialize;
  end reset_context;


  /* MODULE MAINTENANCE */
  function get_modules
    return pit_module_list
    pipelined
  as
    l_idx pit_util.ora_name_type;
    l_available pit_util.flag_type;
    l_active pit_util.flag_type;
  begin
    if g_all_modules.count > 0 then
      get_context_values;
      -- g_ctx.active_log_modules indexed by varchar2, therefore while loop is required
      l_idx := g_all_modules.first;
      while l_idx is not null loop
        l_available := case when g_available_modules.exists(l_idx) then C_TRUE else C_FALSE end;
        l_active := case when g_ctx.active_log_modules.exists(l_idx) then C_TRUE else C_FALSE end;
        pipe row(pit_module_meta(l_idx, l_available, l_active));
        l_idx := g_all_modules.next(l_idx);
      end loop;
    end if;
    return;
  end get_modules;
  
  
  function get_active_modules
    return args
    pipelined
  as
    l_idx pit_util.ora_name_type;
  begin
    get_context_values;
    -- g_ctx.active_log_modules indexed by varchar2, therefore while loop is required
    l_idx := g_ctx.active_log_modules.first;
    while l_idx is not null loop
      pipe row(l_idx);
      l_idx := g_ctx.active_log_modules.next(l_idx);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
       null;
    when others then
      pit.error(msg.PIT_FAIL_READ_MODULE_LIST);
      return;
  end get_active_modules;


  function get_available_modules
    return args
    pipelined
  as
    l_idx pit_util.ora_name_type;
  begin
    get_context_values;
    -- g_available_modules indexed by varchar2, therefore while loop is required
    l_idx := g_available_modules.first;
    while l_idx is not null loop
      pipe row(l_idx);
      l_idx := g_available_modules.next(l_idx);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
       null;
    when others then
      pit.error(msg.PIT_FAIL_READ_MODULE_LIST);
      return;
  end get_available_modules;


  function cast_to_char_list(
    p_msg_args msg_args)
    return msg_args_char
  as
    l_arg_list msg_args_char := msg_args_char();
  begin
    if p_msg_args is not null then
      for i in p_msg_args.first .. p_msg_args.last loop
        l_arg_list.extend;
        l_arg_list(i) := dbms_lob.substr(p_msg_args(i), 4000, 1);
      end loop;
    end if;
    return l_arg_list;
  end cast_to_char_list;


begin
  initialize;
end pit_pkg;
/
