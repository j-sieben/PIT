create or replace  package body pit_pkg
as
  /************************ TYPE DECLARATIONS ********************************/
  -- list of modules
  type module_list_type is table of pit_module index by varchar2(30 char);
  
  -- debug and trace settings, stored within a context
  type context_rec is record (
    log_level pls_integer,
    trace_level pls_integer,
    trace_timing char(1),
    active_log_modules module_list_type,
    context_type varchar2(30));
    
  -- all modules that could be instantiated
  g_module_list module_list_type;
  
  -- all modules which are available for logging
  -- (meaning: status = msg.MODULE_INSTANTIATED)
  g_available_modules module_list_type;
  
  /* call stack */
  type call_stack_tab is table of call_stack_type index by binary_integer;
  g_call_stack call_stack_tab;
  
  /************************ PACKAGE VARIABLES ********************************/
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
  --c_trace_session constant varchar2(20) := 'TRACE_SESSION';
  c_env constant varchar2(10) := 'USERENV';
  c_client_id constant varchar2(20) := 'CLIENT_IDENTIFIER';
  
  /* generic constants */
  c_true constant char(1) := 'Y';
  c_false constant char(1) := 'N';
  
  /* "events" */
  c_event_focus_all constant varchar2(10) := 'ALL';
  c_event_focus_active constant varchar2(10) := 'ACTIVE';
  
  c_context_event constant integer := 1;
  c_log_event constant integer := 2;
  c_purge_event constant integer := 3;
  c_print_event constant integer := 4;
  c_enter_event constant integer := 5;
  c_leave_event constant integer := 6;
  
  /* package vars */
  g_active_adapter default_adapter;
  g_language varchar2(30);
  g_user_name varchar2(30);
  g_client_id varchar2(64);
  g_owner varchar2(30);
  g_name varchar2(30);
  g_lineno number;
  g_caller_t varchar2(30);
  g_ctx context_rec;
  
  
  /********************* GENERIC HELPER FUNCTIONS ****************************/
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
    l_idx pls_integer := 1;
    l_start_position pls_integer := 1;
    l_delimiter_position pls_integer;
    l_arg_list args := args();
    l_entry varchar2(50);
  begin
    loop
      l_delimiter_position := instr(p_string_value, p_delimiter, l_start_position);
      if l_delimiter_position > 0 then
        l_arg_list.extend;
        l_entry := substr(p_string_value, l_start_position, l_delimiter_position - l_start_position);
        l_arg_list(l_idx) := l_entry;
        l_start_position := l_delimiter_position + 1;
        l_idx := l_idx + 1;
      else
        l_arg_list.extend;
        l_entry := substr(p_string_value, l_start_position);
        l_arg_list(l_idx) := l_entry;
        exit;
      end if;
    end loop;
    return l_arg_list;
  end string_to_table;
  
  
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
    l_idx varchar2(50);
    l_ctx pit_context;
    l_modules module_list_type;
  begin
    l_ctx := pit_context(g_ctx.log_level, g_ctx.trace_level, g_ctx.trace_timing);
    
    case p_event_focus
      when c_event_focus_all then
        l_modules := g_available_modules;
      when c_event_focus_active then
        l_modules := g_ctx.active_log_modules;
      else
      null;
    end case;
    -- propagate event to output modules
    l_idx := l_modules.first;
    while l_idx is not null loop
       case p_event
          when c_context_event then
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
  end raise_event;
  
  
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
  
  
  /************************ CONTEXT MAINTENANCE ******************************/
  /* Helper to read in a list of all available output modules for a given context
   * %param p_requested_modules Colon-separated list of requested output modules
   * %return Collection of available and requested module instances
   * %usage This function is used to fill a list of available modules as requested
   *        by the actual context. These modules will then be used to log to.
   */
  function get_context_modules(
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
  end get_context_modules;
  
  
  /* Helper to read the actual context settings for PIT
   * %return Active context, if available, default context else.
   * %usage This function is called to read the actual context from the
   *        globally accessed context.
   */
  procedure get_context
  as
    l_focus varchar2(20) := c_focus_default;
  begin 
    g_active_adapter.get_session_details(g_user_name, g_client_id);
    if utl_context.get_value(c_global_context, c_focus_active || c_log_level, g_client_id) > 10 then
      l_focus := c_focus_active;
    end if;
    g_ctx.log_level := utl_context.get_value(c_global_context, l_focus || c_log_level, g_client_id);
    g_ctx.trace_level := utl_context.get_value(c_global_context, l_focus || c_trace_level, g_client_id);
    g_ctx.trace_timing := utl_context.get_value(c_global_context, l_focus || c_trace_timing, g_client_id);
    g_ctx.active_log_modules :=
      get_context_modules(
        utl_context.get_value(c_global_context, l_focus || c_modules, g_client_id));
    g_ctx.context_type :=
      nvl(g_ctx.context_type, param.get_string(c_context_type, c_context_group));
  end get_context;
  
  
  /* Helper to create a default context as defined in the parameters for PIT
   * procedure to create the default context from parameter table
   * %usage Is called during initialization of the package to set up the
   *        default logging context as requested by the parameters.
   */
  procedure create_default_context
  as
  begin      
    set_context(
       p_log_level => param.get_integer(c_focus_default || c_log_level, c_param_group),
       p_trace_level => param.get_integer(c_focus_default || c_trace_level, c_param_group),
       p_trace_timing => param.get_boolean(c_focus_default || c_trace_timing, c_param_group),
       p_module_list => param.get_string(c_focus_default || c_log_modules, c_param_group),
       p_focus => c_focus_default);
  end create_default_context;
  
  
  /************************* MODULE MAINTENANCE ******************************/
  /* Helper to load all output modules installed extending PIT_MODULE
   * %usage procedure loads and instantiates all output modules which are
   *        create under PIT_MODULE and at the same time listed in parameter
   *        DEFAULT_LOG_MODULES.
   *        After instantiation, all modules are made available in PL/SQL table MODULES
   */
  procedure load_modules
  as
   -- list of all installed output modules under PIT_MODULE
   cursor module_cur is
    select to_char(type_name) type_name
      from all_types
     where supertype_name = c_base_module
       and owner = upper('&INSTALL_USER.');
    l_module_instance pit_module;
  begin
    g_module_list.delete;
    for module in module_cur loop
       /* Instanziiere Untertyp mittels parameterloser Konstruktormethode */
       execute immediate 'begin :i := new ' || module.type_name || '(); end;'
         using out l_module_instance;
       g_module_list(module.type_name) := l_module_instance;
       if l_module_instance.status = msg.MODULE_INSTANTIATED then
         g_available_modules(module.type_name) := l_module_instance;
       end if;
    end loop;
    if g_module_list.count = 0 then
       raise_application_error(-20000, 'No output modules instantiated.');
    end if;
  end load_modules;
  
  
  /* Helper to create a |-separated list of available output modules
   * %return String of pipe-separated list of available output modules
   * %usage Is called to prepare a pipe separated list of available modules
   *        to store it in the context
   */
  function get_available_module_list
    return varchar2
  as
    l_idx varchar2(30);
    l_result varchar2(1000);
  begin
    l_idx := g_available_modules.first;
    while l_idx is not null loop
       l_result := l_result || l_idx || '|';
       l_idx := g_available_modules.next(l_idx);
    end loop;
    l_result := substr(l_result, 1, length(l_result) - 1);
    return l_result;
  end get_available_module_list;
  
  
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
    l_sql varchar2(200);
  begin
    l_adapter_list :=
       string_to_table(
          param.get_string(c_adapter_preference, c_param_group));
    l_idx := l_adapter_list.first;
    while l_idx is not null loop
       begin
          l_sql := 'begin :a := new ' || l_adapter_list(l_idx) || '(); end;';
         execute immediate l_sql using out l_adapter;
       exception
          when others then
             -- ignore instantiation error
             null;
       end;
       if l_adapter is not null and l_adapter.status = 1 then
          g_active_adapter := l_adapter;
          exit;
       end if;
       l_idx := l_adapter_list.next(l_idx);
    end loop;
    -- secure that default adapter is installed
    if g_active_adapter is null then
       g_active_adapter := default_adapter();
    end if;
  end load_adapter;
  
  
  /* Procedure to report all modules that have not succesfully loaded
   * %usage This procedure is called after initialization of the output modules.
   *        It will emit warnings for any module that has not loaded succesfully.
   */
  procedure report_module_status
  as
    l_idx varchar2(30);
  begin
    l_idx := g_module_list.first;
    while l_idx is not null loop
       if g_module_list(l_idx).status != msg.MODULE_INSTANTIATED then
          pit.warn(msg.MODULE_INITIALIZATION_ERROR, msg_args(l_idx, g_module_list(l_idx).stack));
       end if;
       l_idx := g_module_list.next(l_idx);
    end loop;
  end report_module_status;
  
  
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
    get_context;
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
    get_context;
    return p_level <= g_ctx.trace_level;
  end trace_me;
  
  
  /* Helper to maintain a call stack
   * %param p_call_stack instance of call_stack_type to pop to the stack
   * %return Last entry found on the call stack. Used to maintain timing etc.
   * %usage Called internally to maintain a call stack of the calle blocks.
   */
  function pop_stack(
    p_call_stack in call_stack_type)
    return call_stack_type
  as
    l_last_entry binary_integer;
    l_last_name varchar2(200 char);
    l_module_name p_call_stack.module_name%type;
    l_method_name p_call_stack.method_name%type;
    l_last_trace_entry call_stack_type;
  begin
    g_active_adapter.get_session_details(g_user_name, g_client_id);
    l_last_entry := g_call_stack.last;
    l_module_name := nvl(p_call_stack.module_name, g_call_stack(l_last_entry).module_name);
    l_method_name := nvl(p_call_stack.method_name, g_call_stack(l_last_entry).method_name);
  
    if l_last_entry is not null then
       l_last_trace_entry := g_call_stack(l_last_entry);
       l_last_trace_entry.id := get_id;
       -- maintain timing for call stack entries
       if g_ctx.trace_timing = 'Y' then
          l_last_trace_entry.leave;
  
          if l_last_entry > 1 then
             g_call_stack(l_last_entry - 1).resume();
          end if;
       end if;
       if (l_module_name = l_last_trace_entry.module_name or l_module_name is null)
          and (l_method_name = l_last_trace_entry.method_name or l_method_name is null)
       then
          g_call_stack.delete(l_last_entry);
       end if;
    end if;
    return l_last_trace_entry;
  end pop_stack;
  
  
  /***************************** INTERFACE ***********************************/
  procedure initialize
  as
  begin
    load_modules;
    load_adapter;
    create_default_context;
    -- starting here, PIT is initialized and prepared to create messages
    report_module_status;
    pit.verbose(
       msg.LOGGING_PACKAGE_INITIALIZED,
       msg_args(to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'),
       get_available_module_list));
    -- set package vars
    select value
      into g_language
      from nls_session_parameters
     where parameter = 'NLS_LANGUAGE';
    g_call_stack.delete;
  end initialize;
  
  
  /* MODULE MAINTENANCE */
  function get_active_modules
    return args
    pipelined
  as
    l_idx varchar2(50);
  begin
    get_context;
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
    get_context;
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
  
  /* CONTEXT MAINTENANCE */
  function get_context
    return context_type
  is
    l_focus varchar2(20) := c_focus_default;
    l_context context_type;
  begin
    if utl_context.get_value(c_global_context, c_focus_active || c_log_level, g_client_id) > 10 then
      l_focus := c_focus_active;
      l_context.is_default := true;
      
      get_context;
      l_context.log_level := g_ctx.trace_level;
      l_context.trace_level := g_ctx.trace_level;
      l_context.trace_timing := g_ctx.trace_timing = c_true;
      l_context.log_modules := utl_context.get_value(c_global_context, l_focus || c_modules, g_client_id);
    else
      l_context.is_default := true;
    end if;
    return l_context;
  end get_context;
  
  procedure set_context(
    p_log_level in integer,
    p_trace_level in integer,
    p_trace_timing in boolean,
    p_module_list in varchar2,
    p_focus in varchar2 default 'ACTIVE')
  as
    l_timing_on char(1);
  begin
    pit.assert(upper(p_focus) in (c_focus_default, c_focus_active));
    if p_trace_timing then
      l_timing_on := c_true;
    else
      l_timing_on := c_false;
    end if;
    g_active_adapter.get_session_details(g_user_name, g_client_id);
    g_ctx.context_type := coalesce(g_ctx.context_type, param.get_string(c_context_type, c_context_group));

    -- In Default, extend visibility of parameter according to the type of CONTEXT
    -- by setting user_name and/or client_id to a predefined CONTEXT_PKG.C_NO_VALUE
    -- Available Types:
    --   GLOBAL | FORCE_USER | ORCE_CLIENT_ID | FORCE_USER_CLIENT_ID |
    --   PREFER_CLIENT_ID | PREFER_USER_CLIENT_ID | SESSION
    if p_focus = c_focus_default then
      case
        when g_ctx.context_type in ('SESSION', 'FORCE_CLIENT_ID', 'FORCE_USER_CLIENT_ID') then
          null;
        else
          g_client_id := utl_context.c_no_value;
      end case;
    end if;

    utl_context.set_value(c_global_context, p_focus || c_log_level, p_log_level, g_client_id);
    utl_context.set_value(c_global_context, p_focus || c_trace_level, p_trace_level, g_client_id);
    utl_context.set_value(c_global_context, p_focus || c_trace_timing, l_timing_on, g_client_id);
    utl_context.set_value(c_global_context, p_focus || c_modules, p_module_list, g_client_id);

    pit.verbose(msg.context_changed, msg_args(c_focus_default, p_focus));
  end set_context;
  
  
  procedure set_context(
    p_context in context_type)
  as
  begin
    set_context(
      p_context.log_level,
      p_context.trace_level,
      p_context.trace_timing,
      p_context.log_modules);
  end set_context;
  
  
  procedure reset_active_context
  as
  begin
    g_active_adapter.get_session_details(g_user_name, g_client_id);
    
    utl_context.clear_value(c_global_context, c_focus_active || c_log_level, g_client_id);
    utl_context.clear_value(c_global_context, c_focus_active || c_trace_level, g_client_id);
    utl_context.clear_value(c_global_context, c_focus_active || c_trace_timing, g_client_id);
    utl_context.clear_value(c_global_context, c_focus_active || c_modules, g_client_id);   
  
    raise_event(c_context_event, c_event_focus_all);
  
    pit.verbose(msg.context_changed, msg_args(c_focus_active, c_focus_default));
  end reset_active_context;
  
  
  procedure reset_context
  as
  begin
    utl_context.reset_context(c_global_context);
    create_default_context;
  end reset_context;
  
  
  /* CORE */
  procedure log(
    p_level in integer,
    p_message_name in varchar2,
    p_affected_id in varchar2,
    p_arg_list in msg_args)
  as
    l_message message_type;
    pragma autonomous_transaction;
  begin
    if log_me(p_level) then
      -- intantiate message
      l_message := get_message(p_message_name, p_affected_id, p_arg_list);

      raise_event(
        p_event => c_log_event,
        p_event_focus => c_event_focus_active,
        p_message => l_message);
    end if;
    if p_level = pit.level_fatal then
       raise_error(p_message_name, p_arg_list);
    end if;
    commit;
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
      if p_log_modules is not null then
        l_ctx_new.log_modules := p_log_modules;
        l_ctx_change := true;
      end if;
      if p_log_threshold is not null then
        l_ctx_new.log_level := p_log_threshold;
        l_ctx_change := true;
      end if;
      if l_ctx_change then
        set_context(l_ctx_new);
      end if;
      
      log(
        p_level => l_message.severity,
        p_message_name => p_message_name,
        p_affected_id => p_affected_id,
        p_arg_list => p_arg_list);
      
      if l_ctx_change then
        if l_ctx_old.is_default then
          reset_context;
        else
          set_context(l_ctx_old);
        end if;
      end if;
    end if;
  end log;
  
  
  procedure purge(
    p_date_before in date)
  as
    pragma autonomous_transaction;
  begin
    raise_event(
          p_event => c_purge_event,
          p_event_focus => c_event_focus_active,
          p_date_before => p_date_before);
    commit;
    exception
       when others then
          commit;
          pit.error(msg.message_purge_error);
  end purge;
  
  
  procedure enter(
    p_action in varchar2,
    p_module in varchar2,
    p_params in msg_params,
    p_trace_level in number,
    p_client_info in varchar2 default null)
  as
    l_call_stack call_stack_type;
    l_last_entry binary_integer;
    l_action varchar2(30);
    l_module varchar2(30);
    $IF dbms_db_version.ver_le_12 $THEN
    l_module_position integer;
    l_action_position integer;
    l_qualified_name utl_call_stack.unit_qualified_name;
    l_trace_depth integer := 3;
    $END 
    pragma autonomous_transaction;
  begin
    -- Module des aktuellen Kontextes lesen
    if trace_me(p_trace_level) then
      $IF dbms_db_version.ver_le_12 $THEN
      -- Call-Stack analysieren, um fehlende Prozedurnamen zu surrogieren
      if p_action is null or p_module is null then
        if p_trace_level < pit.trace_all then
          l_trace_depth := l_trace_depth + 1;
        end if;
        l_qualified_name := utl_call_stack.subprogram(l_trace_depth);
        l_module_position := least(l_qualified_name.count - 1, 2);
        l_action_position := l_qualified_name.count;
      end if;
      l_module := lower(coalesce(p_module, l_qualified_name(l_module_position)));
      l_action := lower(coalesce(p_action, l_qualified_name(l_action_position)));
      $ELSE
      l_module := p_module;
      l_action := p_action;
      $END 
      if p_trace_level = pit.trace_mandatory then
        dbms_application_info.set_module(l_module, l_action);
        dbms_application_info.set_client_info(p_client_info);
      end if;
      g_active_adapter.get_session_details(g_user_name, g_client_id);
      l_last_entry := g_call_stack.count;
    
      if g_ctx.trace_timing = 'Y' and l_last_entry > 0 then
         g_call_stack(l_last_entry).pause();
      end if;
      g_call_stack(l_last_entry + 1) :=
         call_stack_type(
            id => get_id,
            session_id => g_client_id,
            user_name => g_user_name,
            module_name => l_module,
            method_name => l_action,
            params => p_params,
            call_level => l_last_entry + 1,
            trace_timing => g_ctx.trace_timing);
      
      raise_event(
        p_event => c_enter_event,
        p_event_focus => c_event_focus_active,
        p_call_stack => g_call_stack(g_call_stack.last));
    end if;
    commit;
  exception
    when others then
       commit;
       pit.error(msg.message_creation_error);
  end enter;
  
  
  procedure leave(
    p_trace_level in number)
  is
    l_call_stack call_stack_type;
    pragma autonomous_transaction;
  begin
    if trace_me(p_trace_level) then
       -- finalize entry in call stack and pass to output modules
       l_call_stack := pop_stack(l_call_stack);
      
       raise_event(
          p_event => c_leave_event,
          p_event_focus => c_event_focus_active,
          p_call_stack => l_call_stack);
    end if;
    commit;
  exception
    when others then
       commit;
       pit.error(msg.message_creation_error);
  end leave;
  
  
  procedure print(
    p_message_name in varchar2,
    p_arg_list msg_args default null)
  as
    l_message message_type;
    pragma autonomous_transaction;
  begin
    l_message := get_message(p_message_name, null, p_arg_list);
    raise_event(
       p_event => c_print_event,
       p_event_focus => c_event_focus_active,
       p_message => l_message);
    commit;
    exception
       when others then
          commit;
  end print;
  
  
  procedure raise_error(
    p_message_name varchar2,
    p_arg_list in msg_args)
  as
    l_message message_type;
    l_arg_list msg_args := p_arg_list;
  begin
    if p_arg_list is null and sqlerrm is not null then
       l_arg_list := msg_args(sqlerrm);
    end if;
    l_message := get_message(p_message_name, null, p_arg_list);
  
    raise_application_error(-20000, dbms_lob.substr(l_message.message_text, 1, 2048));
  end raise_error;


  function get_message(
    p_message_name in varchar2,
    p_affected_id in varchar2,
    p_arg_list msg_args)
   return message_type
  as
    l_message message_type;
    l_message_name varchar2(30);
    l_args varchar2(2000);
    l_arg_list msg_args;
  begin
    l_message := message_type(
                 message_name => p_message_name,
                 message_language => g_language,
                 affected_id => p_affected_id,
                 session_id => g_client_id,
                 user_name => g_user_name,
                 arg_list => p_arg_list);
    return l_message;
  end get_message;
  
  
begin
  initialize;
end pit_pkg;
/