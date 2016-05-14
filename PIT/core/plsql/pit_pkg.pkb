create or replace package body pit_pkg
as
  /************************* TYPE DECLARATIONS ********************************/
  -- list of modules
  type module_list_type is table of pit_module index by varchar2(30 char);

  -- all modules that could be instantiated
  g_all_modules module_list_type;

  -- all modules which are available for logging
  -- (meaning: status = msg.MODULE_INSTANTIATED)
  g_available_modules module_list_type;

  -- debug and trace settings, stored within a context
  type context_rec is record (
    settings varchar2(4000),
    log_level pls_integer,
    trace_level pls_integer,
    trace_timing boolean,
    active_log_modules module_list_type,
    module_list varchar2(4000),
    context_type varchar2(30),
    allow_toggle boolean);
  g_ctx context_rec;
  
  type named_ctx_list_tab is table of context_type index by varchar2(30);
  g_named_ctx_list named_ctx_list_tab;

  /* call stack */
  type call_stack_tab is table of call_stack_type index by binary_integer;
  g_call_stack call_stack_tab;

  /************************* PACKAGE VARIABLES ********************************/
  /* parameter constants */
  c_param_group constant varchar2(20) := 'PIT';
  c_base_module constant varchar2(20) := 'PIT_MODULE';

  /* log level constants */
  c_focus_active constant varchar2(15) := 'ACTIVE';
  c_focus_default constant varchar2(10) := 'DEFAULT';
  c_log_level constant varchar2(15) := '_LOG_LEVEL';
  c_trace_level constant varchar2(15) := '_TRACE_LEVEL';
  c_trace_timing constant varchar2(20) := '_TRACE_TIMING';
  c_modules constant varchar2(15) := '_MODULES';
  c_log_modules constant varchar2(20) := '_LOG_MODULES';
  c_adapter_preference constant varchar2(20) := 'ADAPTER_PREFERENCE';

  /* context constants */
  c_global_context constant varchar2(20) := 'PIT_CTX';
  c_context_type constant varchar2(30) := c_global_context || '_TYPE';
  c_context_group constant varchar2(30) := 'CONTEXT';
  c_context_prefix constant varchar2(20) := c_context_group || '_';
  c_context_default constant varchar2(30) := c_context_group || '_DEFAULT';
  c_context_active constant varchar2(30) := c_context_group || '_ACTIVE';
  c_toggle_group constant varchar2(30) := 'TOGGLE';
  c_toggle_prefix constant varchar2(20) := c_toggle_group || '_';
  c_allow_toggle constant varchar2(30) := 'ALLOW_TOGGLE';
  
  /* adapter constants */
  c_adapter_ok constant pls_integer := 1;

  /* generic constants */
  c_true constant char(1) := 'Y';
  c_false constant char(1) := 'N';
  c_count_regex constant varchar2(10) := '\|';
  c_split_regex constant varchar2(10) := '[^\|]+';

  /* "events" */
  c_event_focus_all constant varchar2(10) := 'ALL';
  c_event_focus_active constant varchar2(10) := 'ACTIVE';

  c_context_event constant integer := 1;
  c_log_event constant integer := 2;
  c_purge_event constant integer := 3;
  c_print_event constant integer := 4;
  c_enter_event constant integer := 5;
  c_leave_event constant integer := 6;
  
  -- defined here to avoid dependency from PIT
  c_trace_mandatory constant integer := 20;

  /* package vars */
  g_active_adapter default_adapter;
  g_language varchar2(30);
  g_user_name varchar2(30);
  g_client_id varchar2(64);
  g_unrecoverable_error boolean;


  /********************** GENERIC HELPER FUNCTIONS ****************************/
  /* Helper to convert a string with a given separator into an instance of type ARGS
   * %param p_string_value List of items to be split
   * %param p_delimiter character that separates the items in <code>p_string_value</code>
   * %return Array of items (up to 50) of <code>varchar2(50)</code>
   * %usage internal helper to split a string into an array of chars.
   */
  function string_to_table(
    p_string_value in varchar2,
    p_delimiter in varchar2 := ':')
    return args
  as
    l_arg_list args := args();
  begin
    if p_string_value is not null then
      for i in 1 .. regexp_count(p_string_value, '\' || p_delimiter) + 1 loop
        l_arg_list.extend;
        l_arg_list(i) := regexp_substr(p_string_value, '[^\' || p_delimiter || ']+', 1, i);
      end loop;
    end if;
    return l_arg_list;
  end string_to_table;


  /* Helper to get a new message id
   * %return New message ID
   * %usage Every message or call stack instance are provided with a unique id
   *        which is sorted even across RAC environments to allow for a solid
   *        ordering of the messages raised.
   */
  function get_id
   return number
  as
    l_id number;
  begin
    $IF dbms_db_version.VER_LE_10_2 $THEN
       select pit_log_seq.nextval
         into l_id
         from dual;
    $ELSE
       l_id := pit_log_seq.nextval;
    $END
    return l_id;
  end get_id;


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
    p_event in integer,
    p_event_focus in varchar2,
    p_call_stack in call_stack_type default null,
    p_date_before in date default null,
    p_message message_type default null)
  as
    pragma autonomous_transaction;
    l_idx varchar2(50);
    l_ctx pit_context;
    l_modules module_list_type;
    l_trace_timing char(1 byte);
  begin

    case p_event_focus
      when c_event_focus_all then
        l_modules := g_available_modules;
      when c_event_focus_active then
        l_modules := g_ctx.active_log_modules;
      else
      null;
    end case;
    
    -- propagate event to output modules
    -- l_modules is indexed by varchar2, therefore this loop mimic is required
    l_idx := l_modules.first;
    while l_idx is not null loop
      case p_event
        when c_context_event then
          l_trace_timing := case when g_ctx.trace_timing then c_true else c_false end;
          l_ctx := pit_context(g_ctx.log_level, g_ctx.trace_level, l_trace_timing, g_ctx.module_list);
          l_modules(l_idx).context_changed(l_ctx);
        when c_log_event then
          l_modules(l_idx).log(p_message);
        when c_purge_event then
          l_modules(l_idx).purge(p_date_before);
        when c_print_event then
          l_modules(l_idx).print(p_message);
        when c_enter_event then
          l_modules(l_idx).enter(p_call_stack);
        when c_leave_event then
          l_modules(l_idx).leave(p_call_stack);
        else
          null;
      end case;
      l_idx := l_modules.next(l_idx);
    end loop;
    commit;
  end raise_event;
  
  
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
         and owner = user;
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
          dbms_output.put_line('Error when executing "' || l_stmt || '": ' || sqlerrm);
      end;
      
      -- persist reference to out module in module_list
      g_all_modules(module.type_name) := l_module_instance;
      if l_module_instance.status = msg.MODULE_INSTANTIATED then
        -- persiste reference to out module in available_modules
        g_available_modules(module.type_name) := l_module_instance;
      end if;
    end loop;
    if g_all_modules.count = 0 then
       raise_application_error(-20000, 'No output modules instantiated.');
    end if;
  end load_modules;
  

  /* Procedure to report all modules that have not succesfully loaded
   * %usage This procedure is called after initialization of the output modules.
   *        It will emit warnings for any module that has not loaded succesfully.
   */
  procedure report_module_status
  as
    l_idx varchar2(30);
  begin
    l_idx := g_all_modules.first;
    while l_idx is not null loop
       if g_all_modules(l_idx).status != msg.MODULE_INSTANTIATED then
          pit.warn(msg.MODULE_INITIALIZATION_ERROR, msg_args(l_idx, g_all_modules(l_idx).stack));
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
    l_module varchar2(50);
    l_modules module_list_type;
  begin
    l_module_names := string_to_table(p_requested_modules);
    for l_idx in 1 .. l_module_names.count loop
       l_module := l_module_names(l_idx);
       if g_available_modules.exists(l_module) then
          l_modules(l_module) := g_available_modules(l_module);
       end if;
    end loop;
    return l_modules;
  end get_modules_by_name;
  
  
  /************************ CONTEXT MAINTENANCE ******************************/
  function context_to_string(
    p_log_level in number,
    p_trace_level in varchar2,
    p_trace_timing in boolean,
    p_module_list in varchar2)
    return varchar2
  as
    c_del char(1 byte) := '|';
  begin
    return g_ctx.log_level || c_del || g_ctx.trace_level || c_del ||
           case when g_ctx.trace_timing then c_true else c_false end || c_del ||
           g_ctx.module_list;
  end context_to_string;
    
  
  /* Helper method to persist context settings in package variable for easy access
   * %param p_settings List of actual settings
   * %usage Is called to spread settings string to context type
   */
  procedure store_settings_locally(
    p_settings in varchar2)
  as
  begin
    g_ctx.settings := p_settings;
    g_ctx.log_level := to_number(regexp_substr(p_settings, c_split_regex, 1, 1));
    g_ctx.trace_level := to_number(regexp_substr(p_settings, c_split_regex, 1, 2));
    g_ctx.trace_timing := regexp_substr(p_settings, c_split_regex, 1, 3) = c_true;
    g_ctx.module_list := regexp_substr(p_settings, c_split_regex, 1, 4);
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
  begin
    g_active_adapter.get_session_details(g_user_name, g_client_id);
    utl_context.set_value(c_global_context, c_context_active, p_settings, g_client_id);
    store_settings_locally(p_settings);    
    raise_event(c_context_event, c_event_focus_all);
  end set_active_context;
  
  
  /* Procedure gets settings from a predefined context and copies it to the active context
   * %param p_context_name Name of the context that shall be set active
   * %usage Is called to set the active context to a predefined context
   */
  procedure set_named_context(
    p_context_name in varchar2)
  as
    l_settings varchar2(4000);
  begin
    if p_context_name = c_context_default then
      reset_active_context;
    else
      l_settings := utl_context.get_value(c_global_context, p_context_name);
      set_active_context(l_settings);
    end if;
  end set_named_context;
  
  
  /* Helper to check whether a toggle for a given package/method exists
   * %return Settings for the package/method
   */
  function get_toggle_context(
    p_module in varchar2,
    p_method in varchar2)
    return varchar2
  as
    l_args args;
    l_settings varchar2(4000);
  begin
    -- Check whether toggle for package/method exists.
    l_args := args(
                upper(c_toggle_prefix || p_module || '.' ||  p_method),
                upper(c_toggle_prefix || p_module));
    l_settings := utl_context.get_first_match(c_global_context, l_args, g_client_id);
    return l_settings;
  end get_toggle_context;
  
  
  /* Helper to read the actual context settings
   * %return Active context, if available, default context else.
   * %usage This function is called to read the actual context from the
   *        globally accessed context.
   */
  procedure get_context_values
  as
    l_args args;
    l_settings varchar2(4000);
  begin
    l_args := args(c_context_active, c_context_default);
    l_settings := utl_context.get_first_match(c_global_context, l_args, g_client_id);   
    store_settings_locally(l_settings);
  end get_context_values;
  
  
  /* Reads all predefined context and toggles and stores it in global context
   * %usage Method is called upon package initialization to serve two purposes:
   *        1. persist the settings globally for harmonized access over the sessions
   *        2. retrieve actual log settings
   */
  procedure get_context_list
  as
    c_list_del constant char(1 byte) := ':';
    c_del constant char(1 byte) := '|';
    cursor context_cur is
        with toggles as (
             select c_toggle_prefix || 
                    replace(to_char(substr(string_value, 1, 
                            instr(string_value, c_del) - 1)), c_list_del, c_list_del || c_toggle_prefix) tgl_name,
                    c_context_prefix || to_char(substr(string_value, instr(string_value, c_del) + 1)) ctx_name
               from parameter_tab
              where parameter_id like c_toggle_prefix || '%'
                and parameter_group_id = c_param_group),
             contexts as (
             select parameter_id ctx_name, 
                    to_char(string_value) string_value
               from parameter_tab
              where parameter_id like c_context_prefix || '%'
                and parameter_group_id = c_param_group
             )
      select to_char(tgl_name) name, c.string_value setting
        from toggles t
        join contexts c
          on t.ctx_name = c.ctx_name
      union all
      select ctx_name, string_value
        from contexts
       where ctx_name != c_context_active;
    l_ctx context_type;
    l_ctx_name varchar2(30);
  begin
    g_named_ctx_list.delete;
    
    -- In Default, extend visibility of parameter according to the type of CONTEXT
    -- by setting user_name and/or client_id to a predefined UTL_CONTEXT.C_NO_VALUE
    -- Available Types: utl_contxt.c_...
    --   GLOBAL | FORCE_USER | ORCE_CLIENT_ID | FORCE_USER_CLIENT_ID |
    --   PREFER_CLIENT_ID | PREFER_USER_CLIENT_ID | SESSION
    g_ctx.context_type := param.get_string(c_context_type, c_context_group);
    if g_ctx.context_type not in (
                utl_context.c_session, 
                utl_context.c_force_client_id, 
                utl_context.c_force_user_client_id) 
    then g_client_id := utl_context.c_no_value;
    end if;
    
    for ctx in context_cur loop
      -- Switch between Toggles and Contextes
      if ctx.name like c_toggle_prefix || '%' then
        for i in 1 .. regexp_count(ctx.name, ':') + 1 loop
          l_ctx_name := regexp_substr(ctx.name, '[^:]+', 1, i);
          utl_context.set_value(c_global_context, l_ctx_name, ctx.setting, g_client_id);
        end loop;
      else
        utl_context.set_value(c_global_context, ctx.name, ctx.setting, g_client_id);
      end if;
    end loop;  
  end get_context_list;
  
  
  /* Helper method to restore default context after active context is deactivated
   * %usage Is called if an active context shall be reset. Clear the active settings
   *        from the context and raises context switch event
   */
  procedure restore_context
  as
  begin
    g_active_adapter.get_session_details(g_user_name, g_client_id);

    utl_context.clear_value(c_global_context, c_context_active, g_client_id);
    get_context_values;
    raise_event(c_context_event, c_event_focus_all);
  end restore_context;
  
  
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
    l_idx varchar2(30);
    c_stmt_template constant varchar2(200) := 'begin :a := new #ADAPTER#(); end;';
    l_stmt varchar2(200);
  begin
    l_adapter_list := string_to_table(param.get_string(c_adapter_preference, c_param_group));
    l_idx := l_adapter_list.first;
    while l_idx is not null loop
      begin
        l_stmt := replace(c_stmt_template, '#ADAPTER#', l_adapter_list(l_idx));
        execute immediate  l_stmt using out l_adapter;
      exception
        when others then
          -- ignore instantiation error
          null;
      end;
      if l_adapter is not null and l_adapter.status = c_adapter_ok then
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
    l_last_trace_entry call_stack_type;
    l_trace_settings varchar2(4000);
  begin
    l_last_entry := g_call_stack.count;
    
    if l_last_entry > 0 then
      if g_ctx.allow_toggle then
        -- is not first entry on stack, read last stack entry
        l_last_trace_entry := g_call_stack(l_last_entry);
        -- as a default, continue trace settings from last entry
        l_trace_settings := g_call_stack(l_last_entry).trace_settings;
        -- If a toggle is found, check whether trace settings differs from current setting
        if p_trace_settings is not null and coalesce(l_last_trace_entry.trace_settings, 'FOO') != p_trace_settings then
          -- Switch settings and persist new trace settings
          l_trace_settings := p_trace_settings;
          set_active_context(l_trace_settings);
        end if;
      end if;
      -- maintain timing
      if g_ctx.trace_timing then
         g_call_stack(l_last_entry).pause();
       end if;
    else 
      l_trace_settings := p_trace_settings;
      if g_ctx.allow_toggle and p_trace_settings is not null then
        set_active_context(l_trace_settings);
      end if;
    end if;
    
    g_call_stack(l_last_entry + 1) :=
       call_stack_type(
          p_id => get_id,
          p_session_id => g_client_id,
          p_user_name => g_user_name,
          p_module_name => p_module,
          p_method_name => p_action,
          p_params => p_params,
          p_call_level => l_last_entry + 1,
          p_trace_timing => case when g_ctx.trace_timing then c_true else c_false end,
          p_trace_settings => l_trace_settings);
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
          p_new_trace_settings := c_context_default;
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
   * %usage Called from method LOG if level is C_LEVEL_FATAL. Cleans open
   *        call stack entries
   */
  procedure clean_stack
  as
    l_call_stack call_stack_type;
    l_trace_settings varchar2(4000);
  begin
    for i in 1 .. g_call_stack.count loop
      leave(c_trace_mandatory);
    end loop;
  end clean_stack;
  
  
  /************************** CENTRAL FUNCTIONALITY **************************/
  /* Helper function to decide whether a message shall be logged.
   * %param p_level log_level for which a decision is requested
   * %return flag that indicates whether settings allow for logging.
   * %usage This function is called during logging to decide whether the actual
   *        settings allow for logging.<br>
   *        The decision is based on the requested log level as well as
   *        upon settings in the global context
   */
  function log_me(
    p_level in integer)
    return boolean
  as
  begin
    get_context_values;
    return p_level <= g_ctx.log_level;
  end log_me;


  /* Helper function to decide whether an entry or leave shall be traced.
   * %param p_level trace_level for which a decision is requested
   * %return flag that indicates whether settings allow for tracing.
   * %usage This function is called during tracing to decide whether the actual
   *        settings allow for tracing.<br>
   *        The decision is based on the requested trace level as well as
   *        upon settings in the global context
   */
  function trace_me(
    p_level in integer)
    return boolean
  as
  begin
    if g_call_stack.count = 0 then
      get_context_values;
    end if;
    return p_level <= g_ctx.trace_level;
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
    $IF dbms_db_version.ver_le_12 $THEN
    l_module_position integer;
    l_action_position integer;
    l_qualified_name utl_call_stack.unit_qualified_name;
    -- variable to adjust recursive call level for UTL_CALL_STACK
    l_trace_depth integer := 4;
    $END
  begin
    $IF dbms_db_version.ver_le_12 $THEN
    if p_action is null or p_module is null then
      l_qualified_name := utl_call_stack.subprogram(l_trace_depth);
      l_module_position := greatest(least(l_qualified_name.count - 1, 1), 1);
      l_action_position := l_qualified_name.count;
    end if;

    p_module := lower(coalesce(p_module, l_qualified_name(l_module_position)));
    p_action := lower(coalesce(p_action, l_qualified_name(l_action_position)));
    $ELSE
    null;
    $END
  end get_module_and_action;
  
  
  /* Helper to raise an error based on a message_name
   * %param p_message_name Name of the error to raise
   */
  procedure raise_error(
    p_message_name in varchar2)
  as
  begin
    execute immediate 'begin raise(msg.' || p_message_name || '_ERR; end;';
  end raise_error;
  

  /****************************** INTERFACE ***********************************/
  procedure initialize
  as
  begin
    -- set package vars
    g_unrecoverable_error := false;
    select value
      into g_language
      from nls_session_parameters
     where parameter = 'NLS_LANGUAGE';
    g_call_stack.delete;
    g_ctx.context_type := param.get_string(c_context_type, c_context_group);
    g_ctx.allow_toggle := param.get_boolean(c_allow_toggle, c_param_group);
    load_modules;
    load_adapter;    
    get_context_list;
    
    -- starting here, PIT is initialized and prepared to create messages
    report_module_status;
  end initialize;

  /* CORE */
  procedure log(
    p_level in integer,
    p_message_name in varchar2,
    p_affected_id in varchar2,
    p_arg_list in msg_args)
  as
    l_message message_type;
  begin
    if p_level <= pit.level_error or log_me(p_level) then
      -- instantiate message
      l_message := get_message(p_message_name, p_affected_id, p_arg_list);

      raise_event(
        p_event => c_log_event,
        p_event_focus => c_event_focus_active,
        p_message => l_message);
    end if;
  end log;


  procedure log(
    p_message_name in varchar2,
    p_affected_id in varchar2,
    p_arg_list in msg_args,
    p_log_threshold in number,
    p_log_modules in varchar2)
  as
    l_message message_type;
    l_ctx_old context_type;
    l_ctx_new context_type;
    l_ctx_change boolean := false;
  begin
    l_ctx_old := pit_pkg.get_context;
    l_ctx_new := l_ctx_old;
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

      -- call super()
      log(
        p_level => l_message.severity,
        p_message_name => p_message_name,
        p_affected_id => p_affected_id,
        p_arg_list => p_arg_list);

      -- clean up after setting changes
      if l_ctx_change then
        if l_ctx_old.is_default then
          reset_context;
        else
          set_context(l_ctx_old);
        end if;
      end if;
    end if;
  end log;


  procedure enter(
    p_action in varchar2,
    p_module in varchar2,
    p_params in msg_params,
    p_trace_level in number,
    p_client_info in varchar2 default null)
  as
    l_action varchar2(30) := p_action;
    l_module varchar2(30) := p_module;
  begin
    case when g_ctx.allow_toggle then
      -- Do minimal tracing if context toggle is active
      get_module_and_action(
        p_module => l_module, 
        p_action => l_action);
        
      push_stack(
        p_module => l_module,
        p_action => l_action,
        p_params => p_params,
        p_trace_settings => get_toggle_context(p_module, p_action));
      
      -- Get settings after toggle evaluation
      get_context_values;
    when trace_me(p_trace_level) then
      -- Do tracing with actual settings
      get_module_and_action(
        p_module => l_module, 
        p_action => l_action);
      
      push_stack(
        p_module => l_module,
        p_action => l_action,
        p_params => p_params);
    else
      null;
    end case;

    if p_trace_level <= g_ctx.trace_level then
      raise_event(
        p_event => c_enter_event,
        p_event_focus => c_event_focus_active,
        p_call_stack => g_call_stack(g_call_stack.last));
    end if;
    
    -- set dbms_application info anyway in mandatory level
    if p_trace_level = pit.trace_mandatory then
      dbms_application_info.set_module(l_module, l_action);
      dbms_application_info.set_client_info(p_client_info);
    end if;
  exception
    when others then
       pit.error(msg.message_creation_error);
  end enter;


  procedure leave(
    p_trace_level in number)
  is
    l_call_stack call_stack_type;
    l_trace_me boolean;
    l_new_trace_settings varchar2(4000);
  begin
    l_trace_me := trace_me(p_trace_level);
    
    -- Do minimal tracing if context toggle is active
    if g_ctx.allow_toggle or l_trace_me then
       -- finalize entry in call stack and pass to output modules
       pop_stack(l_call_stack, l_new_trace_settings);
    end if;
    
    if l_trace_me then
       raise_event(
          p_event => c_leave_event,
          p_event_focus => c_event_focus_active,
          p_call_stack => l_call_stack);
    end if;
    
    if g_ctx.allow_toggle then
      -- after raised event, check whether toggle context requires context switch
      case 
      when l_new_trace_settings = c_context_default then
        reset_active_context;
      when l_new_trace_settings is not null then
        set_active_context(l_new_trace_settings);
      else
        null;
      end case;
    end if;
  exception
    when others then
      pit.error(msg.message_creation_error);
  end leave;


  procedure print(
    p_message_name in varchar2,
    p_arg_list msg_args default null)
  as
  begin
    raise_event(
       p_event => c_print_event,
       p_event_focus => c_event_focus_active,
       p_message => get_message(p_message_name, null, p_arg_list));
  exception
    when others then
      pit.error(msg.message_creation_error);
  end print;


  procedure raise_error(
    p_level in number,
    p_message_name varchar2,
    p_affected_id in number,
    p_arg_list in msg_args)
  as
    l_arg_list msg_args;
    l_error_number number;
  begin
    if sqlcode = 0 then
      execute immediate
        'begin :n := msg.' || p_message_name || '#; end;' using out l_error_number;
    else
      l_error_number := sqlcode;
    end if;
    l_arg_list := coalesce(p_arg_list, msg_args(to_char(l_error_number)));
    
    raise_application_error(
      l_error_number, 
      dbms_lob.substr(get_message_text(p_message_name, l_arg_list), 2048, 1));
  end raise_error;
  
  
  procedure handle_error(
    p_level in number,
    p_message_name varchar2,
    p_affected_id in number,
    p_arg_list in msg_args)
  as
    l_message_name varchar2(30);
  begin
    log(p_level, p_message_name, p_affected_id, p_arg_list);
    if p_level = pit.level_fatal then
      clean_stack;
      l_message_name := coalesce(p_message_name, msg.FATAL_ERROR_OCCURRED);
      raise_error(pit.level_fatal, l_message_name, null, p_arg_list);
    end if;
  end;    


  procedure purge(
    p_date_before in date)
  as
  begin
    raise_event(
          p_event => c_purge_event,
          p_event_focus => c_event_focus_active,
          p_date_before => p_date_before);
    exception
      when others then
        pit.error(msg.message_purge_error);
  end purge;
  

  function get_message(
    p_message_name in varchar2,
    p_affected_id in varchar2,
    p_arg_list msg_args)
   return message_type
  as
  begin
    return message_type(
             message_name => p_message_name,
             message_language => g_language,
             affected_id => p_affected_id,
             session_id => g_client_id,
             user_name => g_user_name,
             arg_list => p_arg_list);
  end get_message;
  
  
  function get_message_text(
    p_message_name in varchar2,
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
    l_context.log_level := g_ctx.trace_level;
    l_context.trace_level := g_ctx.trace_level;
    l_context.trace_timing := g_ctx.trace_timing;
    l_context.log_modules := g_ctx.module_list;
    return l_context;
  end get_context;
  
  
  procedure set_context(
    p_log_level in integer,
    p_trace_level in integer,
    p_trace_timing in boolean,
    p_module_list in varchar2)
  as
  begin
    set_active_context(
      context_to_string(
        p_log_level, p_trace_level, p_trace_timing, p_module_list));
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
    p_context_name in varchar2)
  as
    l_focus varchar2(30);
  begin
    set_named_context(p_context_name);
  end set_context;
  

  procedure reset_active_context
  as
  begin
    restore_context;
  end reset_active_context;


  procedure reset_context
  as
  begin
    utl_context.reset_context(c_global_context);
    initialize;
  end reset_context;


  /* MODULE MAINTENANCE */
  function get_active_modules
    return args
    pipelined
  as
    l_idx varchar2(50);
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
    when no_data_needed then
       null;
    when others then
      pit.error(msg.read_module_list_error);
      return;
  end get_active_modules;


  function get_available_modules
    return args
    pipelined
  as
    l_idx varchar2(50);
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
    when no_data_needed then
       null;
    when others then
      pit.error(msg.read_module_list_error);
      return;
  end get_available_modules;


begin
  initialize;
end pit_pkg;
/