create or replace package body pit_pkg
as
  /** Project:      PIT (www.github.com/j-sieben/PIT)
   *  Descriptioon: Package body to implement the core PIT logic. 
   *                This package is called by PIT as the API for PIT_PKG only.
   *  @headcom
   */
   
  /************************* TYPE DECLARATIONS ********************************/
  
  /** List of output modules */
  type module_list_type is table of pit_module index by pit_util.ora_name_type;

  /** Type to store a call stack */
  type call_stack_tab is table of call_stack_type index by pls_integer;
  
  subtype client_info_t is varchar2(64 byte);

  /************************* PACKAGE VARIABLES ********************************/
  /** parameter constants */
  C_PACKAGE_OWNER constant pit_util.ora_name_type := $$PLSQL_UNIT_OWNER;
  C_PARAM_GROUP constant pit_util.ora_name_type := 'PIT';
  C_BASE_MODULE constant pit_util.ora_name_type := 'PIT_MODULE';
  C_WARN_IF_UNUSABLE_MODULES constant pit_util.ora_name_type := 'WARN_IF_UNUSABLE_MODULES';
  C_LOG_STATE_THRESHOLD constant pit_util.ora_name_type := 'LOG_STATE_THRESHOLD';
  
  /** message constants to avoid dependency from MSG package */
  C_MODULE_INSTANTIATED constant pit_util.ora_name_type := 'PIT_MODULE_INSTANTIATED';
  C_FAIL_MODULE_INIT constant pit_util.ora_name_type := 'PIT_FAIL_MODULE_INIT';
  C_FAIL_MESSAGE_CREATION constant pit_util.ora_name_type := 'PIT_FAIL_MESSAGE_CREATION';
  C_FAIL_MESSAGE_PURGE constant pit_util.ora_name_type := 'PIT_FAIL_MESSAGE_PURGE';
  C_MSG_NOT_EXISTING constant pit_util.ora_name_type := 'PIT_MSG_NOT_EXISTING';
  C_UNKNOWN_NAMED_CONTEXT constant pit_util.ora_name_type := 'PIT_UNKNOWN_NAMED_CONTEXT';
  C_BULK_ERROR constant pit_util.ora_name_type := 'PIT_BULK_ERROR';
  C_BULK_FATAL constant pit_util.ora_name_type := 'PIT_BULK_FATAL';
  C_FAIL_READ_MODULE_LIST constant pit_util.ora_name_type := 'PIT_FAIL_READ_MODULE_LIST';
  C_NO_CONTEXT_SETTINGS constant pit_util.ora_name_type := 'PIT_NO_CONTEXT_SETTINGS';

  /** context constants */
  C_GLOBAL_CONTEXT constant pit_util.ora_name_type := substr('PIT_CTX_' || C_PACKAGE_OWNER, 1, 30);
  C_CONTEXT_TYPE constant pit_util.ora_name_type := C_GLOBAL_CONTEXT || '_TYPE';
  C_CONTEXT_GROUP constant pit_util.ora_name_type := 'CONTEXT';
  C_CONTEXT_PREFIX constant pit_util.ora_name_type := C_CONTEXT_GROUP || '_';
  C_CONTEXT_DEFAULT constant pit_util.ora_name_type := C_CONTEXT_PREFIX || 'DEFAULT';
  C_CONTEXT_ACTIVE constant pit_util.ora_name_type := C_CONTEXT_PREFIX || 'ACTIVE';
  C_TOGGLE_PREFIX constant pit_util.ora_name_type := 'TOGGLE_';
  C_ALLOW_TOGGLE constant pit_util.ora_name_type := 'ALLOW_TOGGLE';
  C_BROADCAST_CONTEXT_SWITCH constant pit_util.ora_name_type := 'BROADCAST_CONTEXT_SWITCH';
  C_CTX_DEL constant pit_util.sign_type := '|';
  C_LIST_DEL constant pit_util.sign_type := ':';

  /** adapter constants */
  C_ADAPTER_PREFERENCE constant pit_util.ora_name_type := 'ADAPTER_PREFERENCE';
  C_ADAPTER_OK constant pit_util.flag_type := pit_util.C_TRUE;

  /** "events" */
  C_EVENT_FOCUS_ALL constant pit_util.ora_name_type := 'ALL';
  C_EVENT_FOCUS_ACTIVE constant pit_util.ora_name_type := 'ACTIVE';

  C_CONTEXT_EVENT constant integer := 1;
  C_LOG_EVENT constant integer := 2;
  C_PURGE_EVENT constant integer := 3;
  C_PRINT_EVENT constant integer := 4;
  C_ENTER_EVENT constant integer := 5;
  C_LEAVE_EVENT constant integer := 6;
  C_NOTIFY_EVENT constant integer := 7;
  C_LOG_STATE_EVENT constant integer := 8;

  /** package vars */
  /** List of all output modules that are installed */
  g_all_modules module_list_type;
  /** List of all modules which are available for logging (meaning: status = msg.MODULE_INSTANTIATED) */
  g_available_modules module_list_type;
  /** List of all modules which are available and actually registered for logging */
  g_active_modules module_list_type;
  /** Actual context settings */
  g_context pit_util.context_type;
  /** Actual message. Stored globally to allow for reuse of last raised message */
  g_active_message message_type;
  /** Global variable to store the call stack */
  g_call_stack call_stack_tab;
  /** Variabless to cache parameter settings */
  g_warn_if_unusable_modules boolean;
  g_active_adapter pit_default_adapter;
  g_user_name pit_util.ora_name_type;
  g_client_id client_info_t;
  /** Variables to store data in collect mode */
  g_collect_mode boolean;
  g_message_stack pit_message_table;
  /** Other globals */
  g_log_state_threshold pls_integer;


  /************************* FORWARD DECLARATION ******************************/
  procedure raise_event(
    p_event in pls_integer,
    p_event_focus in varchar2,
    p_call_stack in call_stack_type default null,
    p_params in msg_params default null,
    p_context in pit_util.context_type default null,
    p_date_before in date default null,
    p_severity_lower_equal in pls_integer default null);
    

  /************************** MODULE MAINTENANCE ******************************/
  /** Loads all output modules installed extending type PIT_MODULE
   * %usage  Loads and instantiates all output modules which are installed under PIT_MODULE
   *         All modules are availabe in G_ALL_MODULES
   *         All successfully instantiated modules are available in G_AVAILABLE_MODULES
   *         An error is thrown if no module could be made available
   */
  procedure load_modules
  as
    cursor installed_modules_cur is
      select to_char(type_name) type_name
        from all_types
       where supertype_name = C_BASE_MODULE
         and owner = C_PACKAGE_OWNER;
    C_STMT_TEMPLATE constant pit_util.small_char := 'begin :i := new #MODULE#(); end;';
    l_stmt pit_util.small_char;
    l_module_instance pit_module;
  begin
    g_all_modules.delete;
    
    for module in installed_modules_cur loop

      -- instantiate subtype with parameterless constructor method
      l_stmt := replace(C_STMT_TEMPLATE, '#MODULE#', module.type_name);
      begin
        execute immediate l_stmt using out l_module_instance;
      exception
        when others then
          -- PIT is not yet instantiated, no output modules available. Simply write to console
          dbms_output.put_line('Error when executing "' || l_stmt || '": ' || sqlerrm);
      end;

      -- persist reference to out module in module_list
      g_all_modules(module.type_name) := l_module_instance;
      if l_module_instance.status = C_MODULE_INSTANTIATED then
        -- persiste reference to out module in available_modules
        g_available_modules(module.type_name) := l_module_instance;
      end if;
    end loop;
    
    if g_all_modules.count = 0 then
      raise_application_error(-20000, 'No output modules instantiated.');
    end if;
    
  end load_modules;


  /** Reports all modules that have not been loaded succesfully if requested by parameter C_WARN_IF_UNUSABLE_MODULES
   * %usage  Is called after initialization of the output modules.
   *         Emits warnings for any module that has not been loaded succesfully if set to do so.
   */
  procedure report_module_status
  as
    l_idx pit_util.ora_name_type;
  begin
    if g_warn_if_unusable_modules then
      l_idx := g_all_modules.first;
      
      while l_idx is not null loop
         if g_all_modules(l_idx).status != C_MODULE_INSTANTIATED then
            log_event(C_LEVEL_WARN, C_FAIL_MODULE_INIT, msg_args(l_idx, g_all_modules(l_idx).stack));
         end if;
         l_idx := g_all_modules.next(l_idx);
      end loop;
      
    end if;
  end report_module_status;


  /** Copies all requested and available output module instances into a module list
   * %usage  Copies available modules as requested by the actual context into a list of modules. 
   *         These modules will then be used to log to.
   * %param  p_requested_modules  Colon-separated list of requested output modules
   * %return Collection of available and requested module instances
   */
  function get_modules_by_name(
    p_requested_modules in varchar2)
    return module_list_type
  as
    l_module_names args;
    l_module pit_util.ora_name_type;
    l_modules module_list_type;
  begin
  
    if p_requested_modules is not null then
      l_module_names := pit_util.string_to_table(p_requested_modules);
      for l_idx in 1 .. l_module_names.count loop
         l_module := l_module_names(l_idx);
         if g_available_modules.exists(l_module) then
            l_modules(l_module) := g_available_modules(l_module);
         end if;
      end loop;
    end if;
    
    return l_modules;
  end get_modules_by_name;


  /************************ CONTEXT MAINTENANCE ******************************/
  /** Method to read the actually chosen context from the global context
   * %usage  Is used to read the actual settings, as they may have
   *         changed based on settings in other sessions
   */
  function read_best_matching_context(
    p_args in args default null)
    return pit_util.context_type
  as
    l_args args;
    l_settings pit_util.max_sql_char;
    l_context pit_util.context_type;
  begin
    -- Initialisierung   
    if p_args is not null then
      l_args := p_args;
      l_args.extend();
      l_args(l_args.last) := C_CONTEXT_ACTIVE;
      l_args.extend();
      l_args(l_args.last) := C_CONTEXT_DEFAULT;
    else
     l_args := args(C_CONTEXT_ACTIVE, C_CONTEXT_DEFAULT); 
    end if;
    
    l_settings := utl_context.get_first_match(
                    p_context => C_GLOBAL_CONTEXT, 
                    p_attribute_list => l_args, 
                    p_with_name => true, 
                    p_client_id => g_client_id);
      
    if l_settings is null then
      raise_application_error(-20000, 'No context settings found for context ' || C_CONTEXT_DEFAULT);
    end if;
                    
    pit_util.string_to_context_type(
      p_context_values => l_settings, 
      p_context => l_context);
    
    -- copy global context settings
    l_context.allow_toggle := g_context.allow_toggle;
    l_context.broadcast_context_switch := g_context.broadcast_context_switch;
    
    return l_context;
  end read_best_matching_context;
  
  
  /** Reads actual context settings into G_CONTEXT and decide whether a change in the settings has occurred
   * %param [p_context_name] Optional context name. 
   * %usage  Is called to read the log settings from the globally accessed context.
   *         It tries to read the context in the following order: CONTEXT_FROM SESSION_ADAPTER, P_CONTEXT_NAME, C_ACTIVE_CONTEXT, C_DEFAULT_CONTEXT
   *         After having read the actual settings, it compares them to the settings known so far. If they differ,
   *         CTX_CHANGED is set to TRUE and to FALSE otherwise.
   * %return Session context, if required, named context if requested, active context if available, default context otherwise.
   */
  procedure copy_context_to_global(
    p_context_name in varchar2 default null)
  as
    l_args args;
    l_required_context pit_util.ora_name_type;
    l_actual_context pit_util.context_type;
  begin
  
    -- start by reading the actual session details 
    g_active_adapter.get_session_details(
      p_user_name => g_user_name, 
      p_session_id => g_client_id, 
      p_required_context => l_required_context);
    
    -- load settings from global context
    -- If session adapter mandates for a context, this has precedence over local settings
    g_context := read_best_matching_context(args(l_required_context, p_context_name));
    l_actual_context := read_best_matching_context;
      
    g_active_modules := get_modules_by_name(g_context.module_list);
    g_context.ctx_changed := g_context.settings != l_actual_context.settings;
  
  end copy_context_to_global;
  
  
  /** Sets new context settings for PIT at the context and raises CONTEXT_CHANGED event
   * %usage  Is called from <code>pit.SET_CONTEXT</code> to actually persist
   *         the required settings in the global context and raise a context switch event
   * %param  p_context   New context settings, instance of pit_util.context_type
   * %usage  This method examins whether a context change has happened by comparing 
   *         the context settings with the latest stored settings from G_CONTEXT.
   *         If a change has occurred, it stores the new values
   *         - at the globally accessed context to propagate the settings to other sessions
   *         - within global variable G_CONTEXT to allow for a comparison later
   *         It also loads the active output modules.
   */
  procedure set_context_if_changed(
    p_context in pit_util.context_type)
  as
    l_raise_focus pit_util.ora_name_type;
  begin
    
    -- If it has not been decided whether the new settings differ from actual settings, do so here
    if p_context.ctx_changed is null then
      g_context := read_best_matching_context;
    end if;
    
    -- set new settings if necessary
    if p_context.ctx_changed or p_context.settings != g_context.settings then
      utl_context.set_value(
        p_context => C_GLOBAL_CONTEXT, 
        p_attribute => C_CONTEXT_ACTIVE, 
        p_value => p_context.settings, 
        p_client_id => g_client_id);
      g_context.settings := p_context.settings;
      g_active_modules := get_modules_by_name(p_context.module_list);
      
      -- Raise event
      case 
        when g_context.broadcast_context_switch then
          l_raise_focus := C_EVENT_FOCUS_ALL;
        else 
          l_raise_focus := C_EVENT_FOCUS_ACTIVE;
      end case;
      raise_event(
        p_event => C_CONTEXT_EVENT, 
        p_event_focus => l_raise_focus, 
        p_context => p_context);
    end if;
    
  end set_context_if_changed;
  
  
  /** Helper to persist existings context settings in P_OLD_CONTEXT and set the active context according to the settings
   * %param  p_old_context    Instance of PIT_UTIL.context_type to hold the existing context settings and a flag on whether
   *                          the context was changed by this method
   * %param  p_new_context    partly filled new context (log_level and module_list may be filled)
   * %usage  Is used if for a single log activity a new context setting is required, such as with LOG_SPECIFIC or NOTIFY.
   *         In this environment, only output modules and log threshold can be changed, therefore all other settings are
   *         copied from the actually active context.
   */
  procedure set_context_temporarily(
    p_old_context out nocopy pit_util.context_type,
    p_new_context in pit_util.context_type)
  as
    l_new_context pit_util.context_type;
  begin
    -- initialize
    p_old_context := read_best_matching_context;
    l_new_context := p_old_context;
    l_new_context.context_name := C_CONTEXT_ACTIVE;
    
    -- Switch settings if present
    l_new_context.module_list := coalesce(p_new_context.module_list, p_old_context.module_list);
    l_new_context.log_level := coalesce(p_new_context.log_level, p_old_context.log_level);
    
    -- persist changes
    set_context_if_changed(l_new_context);

  end set_context_temporarily;
  
  
  /** Method to reset a temporarlily set context back to its original settings
   * %param  p_context  Context settings of the context before the temporarily shift
   * %usage  Is used to reset a temporarily context switch back. Used in conjunction with SET_CONTEXT_TEMPORARILY
   */
  procedure reset_temporarily_set_context(
    p_context in pit_util.context_type)
  as
  begin
    -- clean up after setting changes
    if p_context.context_name = C_CONTEXT_DEFAULT then
      reset_context;
    else
      set_context(p_context);
    end if;
  end reset_temporarily_set_context;


  /** Checks whether a toggle for a given package/method exists
   * %usage  A toggle controls whether PIT should log or not. Therefore it must be checked whether a toggle was defined for
   *         the actual package/method the call stack is at.
   *         If a setting is present, this method will set the new environment and return the settings at the same time
   *         to store them in the call stack. This is necessary to reset it if the call stack entry is popped.
   * %return Context with settings for PACKAGE.METHOD, PACKAGE, ACTIVE or DEFAULT CONTEXT
   */
  function get_toggle_context(
    p_module in pit_util.ora_name_type,
    p_method in pit_util.ora_name_type)
    return pit_util.context_type
  as
    l_args args;
    l_context pit_util.context_type;
  begin  
    if g_context.allow_toggle then
      -- Initialize. ARGS are filled with PACKAGE.METHOD, PACKAGE to find out whether settings exists
      l_args := args(
                  substr(upper(C_TOGGLE_PREFIX || p_module || '.' ||  p_method), 1, pit_util.c_max_length + 1),
                  upper(C_TOGGLE_PREFIX || p_module));
                  
      l_context := read_best_matching_context(l_args);
      set_context_if_changed(l_context);
    end if;
    
    return l_context;
  end get_toggle_context;


  /** Resets toggle context settings
   * %usage  If a toggle was found and the call stack pops that entry, the log settings outside the toggle must be restored.
   * %param  p_settings  Context settings to set the context to
   */
  procedure reset_toggle_context(
    p_settings in varchar2)
  as
    l_context pit_util.context_type;
  begin
    if g_context.allow_toggle then
      -- after raised event, check whether toggle context requires context switch
      if p_settings is not null then
        pit_util.string_to_context_type(
          p_context_values => p_settings, 
          p_context => l_context);
        reset_temporarily_set_context(l_context);
      end if;
    end if;
  end reset_toggle_context;


  /** Reads all predefined context and toggles from parameters and stores it in globally accessed context
   * %usage  Method is invoked during initialization to copy parameter settings 
   *         to the globally accessed context for access across sessions.
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
                and par_pgr_id = C_PARAM_GROUP),
             contexts as (
             select par_id ctx_name,
                    to_char(par_string_value) string_value
               from parameter_tab
              where par_id like C_CONTEXT_PREFIX || '%'
                and par_pgr_id = C_PARAM_GROUP
             )
      select to_char(tgl_name) name, c.string_value setting
        from toggles t
        join contexts c
          on t.ctx_name = c.ctx_name
      union all
      select ctx_name, string_value
        from contexts
       where ctx_name != C_CONTEXT_ACTIVE;
    l_context args;
  begin
    -- store information as a default setting without reference to a client id, unless context type requires to do so
    if param.get_string(
         p_par_id => C_CONTEXT_TYPE, 
         p_pgr_id => C_CONTEXT_GROUP) not in (
         utl_context.c_session,
         utl_context.c_force_client_id,
         utl_context.c_force_user_client_id)
    then g_client_id := utl_context.c_no_value;
    end if;

    for ctx in context_cur loop
      -- Switch between Toggles and Contextes
      if ctx.name like C_TOGGLE_PREFIX || '%' then
        l_context := pit_util.string_to_table(
                       p_string_value => ctx.name, 
                       p_delimiter => C_LIST_DEL);
        for i in 1 .. l_context.count loop
          utl_context.set_value(
            p_context => C_GLOBAL_CONTEXT, 
            p_attribute => l_context(i), 
            p_value => ctx.setting, 
            p_client_id => g_client_id);
        end loop;
      else
        utl_context.set_value(
          p_context => C_GLOBAL_CONTEXT, 
          p_attribute => ctx.name, 
          p_value => ctx.setting, 
          p_client_id => g_client_id);
      end if;
    end loop;
  end get_context_list;


  /************************* ADATPER MAINTENANCE ******************************/
  /** Loads and instantiates an adapter to read client information
   * %usage  procedure loads and instantiates adapters which are created
   *         under <code>PIT_DEFAULT_ADAPTER</code> plus <code>PIT_DEFAULT_ADAPTER</code> itself.<br>
   *         Which modules are instantiated depends on parameter <code>ADAPTER_PREFERENCE</code>
   *         <code>LOAD_ADAPTER</code> tries to instantiate the adpaters
   *         in the order specified in the parameter and stops upon first successful instantiation.<br>
   *         The instantiated module provides information about the actual environment.
   */
  procedure load_adapter
  as
    l_adapter_list args;
    l_adapter pit_default_adapter;
    l_idx pit_util.ora_name_type;
    C_STMT_TEMPLATE constant varchar2(200) := 'begin :a := new #ADAPTER#(); end;';
    l_stmt varchar2(200);
  begin
    l_adapter_list := pit_util.string_to_table(
                        p_string_value => param.get_string(
                                            p_par_id => C_ADAPTER_PREFERENCE, 
                                            p_pgr_id => C_PARAM_GROUP));
    
    l_idx := l_adapter_list.first;
    
    while l_idx is not null loop
      begin
        l_stmt := replace(C_STMT_TEMPLATE, '#ADAPTER#', l_adapter_list(l_idx));
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
      g_active_adapter := pit_default_adapter();
    end if;
    
  end load_adapter;


  /************************** CALL STACK MAINTENANCE **************************/
  /** Checks whether log settings have to be changed due to toggle settings
   * %param  p_trace_settings  Potentially new settings if a toggle exists
   * %param  p_last_entry      Reference to the last call stack entry from which the context settings are copied
   */
  function check_context_toggle(
    p_trace_settings in varchar2,
    p_last_entry in pls_integer)
    return pit_util.context_type
  as
    l_context pit_util.context_type;
  begin
    if g_context.allow_toggle then
      if p_last_entry = 0 then
        -- first entry on stack
        if p_trace_settings is not null then
          pit_util.string_to_context_type(
            p_context_values => p_trace_settings, 
            p_context => l_context);
          set_context_if_changed(l_context);
        end if;
      else
        -- get last trace settings from stack
          pit_util.string_to_context_type(
            p_context_values => g_call_stack(p_last_entry).trace_settings, 
            p_context => l_context);
        -- If a toggle is found, check whether trace settings differs from current setting
        if p_trace_settings != coalesce(l_context.settings, 'FOO') then
          -- Switch settings and persist new trace settings
          pit_util.string_to_context_type(
            p_context_values => p_trace_settings, 
            p_context => l_context);
          set_context_if_changed(l_context);
        end if;
      end if;
    end if;
    return l_context;
  end check_context_toggle;
  
  
  /** Helper to maintain Application Info
   * %usage  Called from PUSH-/POP_STACK methods
   * %param  p_module       Module that was called
   * %param  p_action       Method of the module that was called
   * %param  p_client_info  Client info passed in as optional parameter
   */
  procedure maintain_application_info(
    p_module in varchar2,
    p_action in varchar2,
    p_client_info in varchar2)
  as
  begin
    -- Administer application info
    dbms_application_info.set_module(substr(p_module, 1, 48), substr(p_action, 1, 32));
    dbms_application_info.set_client_info(substr(p_client_info, 1, 64));
  end maintain_application_info;
  
  
  /** Method to push an entrie to the call stack
   * %usage  Called from the ENTER method
   * %param  p_module          Module that was called
   * %param  p_action          Method of the module that was called
   * %param  p_client_info     Optional client info passed in as a pararameter to ENTER
   * %param  p_params          Parameter list of parameters passed to the method
   * %param  p_trace_level     Trace level of the entry
   * %param  p_trace_settings  In case of toggles trace settings may change. The new settings are passed in here
   */
  procedure push_stack(
    p_module in varchar2,
    p_action in varchar2,
    p_client_info in varchar2,
    p_params in msg_params,
    p_trace_level in pls_integer,
    p_trace_settings in varchar2)
  as
    l_last_entry pls_integer;
    l_next_entry pls_integer;
    l_call_stack_entry call_stack_type;
  begin
    -- Initialize
    l_last_entry := g_call_stack.count;
    l_next_entry := l_last_entry + 1;
    copy_context_to_global;

    -- maintain timing
    if l_last_entry > 0 then
      l_call_stack_entry := g_call_stack(l_last_entry);
      if g_context.trace_timing then
        l_call_stack_entry.pause();
      end if;
    end if;
    
    maintain_application_info(p_module, p_action, p_client_info);

    l_call_stack_entry := 
      call_stack_type(
        p_session_id => g_client_id,
        p_user_name => g_user_name,
        p_module_name => p_module,
        p_method_name => p_action,
        p_app_module => p_module,
        p_app_action => p_action,
        p_client_info => p_client_info,
        p_params => p_params,
        p_call_level => l_next_entry,
        p_trace_level => p_trace_level,
        p_trace_timing => pit_util.to_bool(g_context.trace_timing),
        p_trace_settings => pit_util.context_type_to_string(check_context_toggle(p_trace_settings, l_last_entry)));
    g_call_stack(l_next_entry) := l_call_stack_entry;
    
  end push_stack;


  /** Method to pop an entry from the call stack
   * %usage  Called from LEAVE-method.
   * %param  p_params              Parameter list of parameters passed to the method
   * %param  p_call_stack          Instance of call_stack_type to pop to the stack
   * %param  p_new_trace_settings  In case of toggles trace settings may change. The new settings are passed in here
   * %return Last entry found on the call stack. Used to maintain timing etc.
   */
  procedure pop_stack(
    p_params in msg_params,
    p_call_stack in out nocopy call_stack_type,
    p_new_trace_settings out nocopy varchar2)
  as
    l_last_entry pls_integer;
    l_predecessor call_stack_type;
    l_actual_entry call_stack_type;
  begin
    l_last_entry := g_call_stack.last;
    copy_context_to_global;
    
    if l_last_entry > 0 then
      -- persist last call stack entry in out parameter
      p_call_stack := g_call_stack(l_last_entry);
      p_call_stack.params := p_params;

      -- maintain timing for call stack entries
      if g_context.trace_timing then
        p_call_stack.leave;
      end if;

      if l_last_entry > 1 then
        l_predecessor := g_call_stack(l_last_entry - 1);
        -- Resume time measurement
        l_predecessor.resume();
        -- Restore last context settings
        case
        when p_call_stack.trace_settings is not null
         and l_predecessor.trace_settings is null then
          p_new_trace_settings := C_CONTEXT_DEFAULT;
        when p_call_stack.trace_settings != l_predecessor.trace_settings then
          p_new_trace_settings := l_predecessor.trace_settings;
        else
          null;
        end case;
        
        -- set application info to the predecessor
        maintain_application_info(l_predecessor.app_module, l_predecessor.app_action, l_predecessor.client_info);
      else
        -- Last entry is going to be popped, reset application info
        maintain_application_info(null, null, null);
      end if;
      
      g_call_stack.delete(l_last_entry);
    end if;
  end pop_stack;
  
  
  /** Helper method to clean stack after a fatal error has ocurred.
   * %param  p_params  Instance of msg_params, used to add output parameters to the leave message
   * %usage Called from method HANDLE_ERROR if level is C_LEVEL_FATAL. Pops all call stack entries
   */
  procedure clean_stack(
    p_params in msg_params)
  as
  begin                                                                    
    for i in reverse 1 .. g_call_stack.count loop
      if i = g_call_stack.count then
        leave(g_call_stack(i).trace_level, p_params);
      else
        if g_call_stack.exists(i) then
          leave(g_call_stack(i).trace_level, null);
        end if;
      end if;
    end loop;
  end clean_stack;
  
  
  /************************* GENERIC HELPER METHODS *************************/
  /** Pushes a method on the message stack if in message collection mode
   * %param  p_message  Message to push onto the stack
   */
  procedure push_message(
    p_message in out nocopy message_type)
  as
  begin
    p_message.error_code := coalesce(p_message.error_code, p_message.message_name);
    g_message_stack.extend;
    g_message_stack(g_message_stack.last) := p_message;
  end push_message;


  /************************** CENTRAL FUNCTIONALITY **************************/
  /** Central method to distribute any message to all actively parameterized output modules
   * %usage  Called internally as a generic helper to throw messages to output modules
   * %param  p_event Integer indicating the type of "event" (i.e. LOG|PRINT|ENTER etc.) thrown by PIT
   * %param  p_event_focus Flag to indicate whether the message is to be broadcasted to all
   *         available modules or only to active ones.
   * %param  p_call_stack Instance of the actual call stack in the event of ENTER|LEAVE
   * %param  p_date_before Date indicating the point in time, up to when the log is to be purged
   * %param  p_message Instance of the message to raise
   */
  procedure raise_event(
    p_event in pls_integer,
    p_event_focus in varchar2,
    p_call_stack in call_stack_type default null,
    p_params in msg_params default null,
    p_context in pit_util.context_type default null,
    p_date_before in date default null,
    p_severity_lower_equal in pls_integer default null)
  as
    pragma autonomous_transaction;
    l_idx pit_util.ora_name_type;
    l_context pit_context;
    l_modules module_list_type;
    l_trace_timing pit_util.flag_type;
  begin

    if p_event_focus = C_EVENT_FOCUS_ALL then
      l_modules := g_available_modules;
    else
      l_modules := g_active_modules;
    end if;

    -- propagate event to output modules
    l_idx := l_modules.first;
    while l_idx is not null loop
      case p_event
        when C_CONTEXT_EVENT then
          l_trace_timing := pit_util.to_bool(p_context.trace_timing);
          l_context := pit_context(p_context.log_level, p_context.trace_level, l_trace_timing, p_context.module_list);
          l_modules(l_idx).context_changed(l_context);
        when C_LOG_EVENT then
          l_modules(l_idx).log(g_active_message);
        when C_PURGE_EVENT then
          l_modules(l_idx).purge(p_date_before, p_severity_lower_equal);
        when C_PRINT_EVENT then
          l_modules(l_idx).print(g_active_message);
        when C_NOTIFY_EVENT then
          l_modules(l_idx).notify(g_active_message);
        when C_ENTER_EVENT then
          l_modules(l_idx).enter(p_call_stack);
        when C_LEAVE_EVENT then
          l_modules(l_idx).leave(p_call_stack);
        when C_LOG_STATE_EVENT then
          l_modules(l_idx).log(p_params);
        else
          null;
      end case;
      l_idx := l_modules.next(l_idx);
    end loop;
    
    commit;
  end raise_event;


  /** Deciders whether a message has to be logged.
   * %usage  Is called during logging to decide whether the actual settings allow for logging.<br>
   *         The decision is based on the requested log level as well as on settings in the global context
   * %param  p_severity  log_level for which a decision is requested
   * %return flag that indicates whether settings allow for logging.
   */
  function log_me(
    p_severity in pit_message.pms_pse_id%type)
    return boolean
  as
  begin
    copy_context_to_global;
    return p_severity <= greatest(g_context.log_level, C_LEVEL_ERROR);
  exception
    when no_data_found then
      return false;
  end log_me;


  /** Decides whether an entry or leave event has to be traced.
   * %usage  Is called during tracing to decide whether the actual settings allow for tracing.<br>
   *         The decision is based on the requested trace level as well as on settings in the global context
   * %param  p_severity  trace_level for which a decision is requested
   * %return flag that indicates whether settings allow for tracing.
   */
  function trace_me(
    p_trace_level in integer)
    return boolean
  as
  begin
    copy_context_to_global;
    return p_trace_level <= g_context.trace_level;
  end trace_me;
  
  
  /** Helper method to retrieve the actual session language
   * %return Language string as per oracle convention: AMERICAN|GERMN etc.
   */
  function get_language
    return varchar2
  as
    l_language pit_util.ora_name_type;
  begin
    l_language := sys_context('USERENV', 'LANGUAGE');
    l_language := substr(l_language, 1, instr(l_language, '_') - 1);
    
    return l_language;
  end get_language;
  
  
  /****************************** INTERFACE ***********************************/
  procedure initialize
  as
  begin
    -- Read static parameters
    g_context.allow_toggle := param.get_boolean(
                                p_par_id => C_ALLOW_TOGGLE, 
                                p_pgr_id => C_PARAM_GROUP);
    g_context.broadcast_context_switch := param.get_boolean(
                                            p_par_id => C_BROADCAST_CONTEXT_SWITCH, 
                                            p_pgr_id => C_PARAM_GROUP);
    g_warn_if_unusable_modules := param.get_boolean(
                                    p_par_id => C_WARN_IF_UNUSABLE_MODULES, 
                                    p_pgr_id => C_PARAM_GROUP);
                                    
    g_log_state_threshold := param.get_integer(
                               p_par_id => C_LOG_STATE_THRESHOLD,
                               p_pgr_id => C_PARAM_GROUP);
    g_collect_mode := false;
    
    -- Empty collections
    g_call_stack.delete;
    g_message_stack := pit_message_table();
    
    load_modules;
    load_adapter;
    get_context_list;

    -- starting here, PIT is initialized and prepared to create messages
    report_module_status;
  end initialize;
  

  /** CORE */
  procedure log_event(
    p_severity in pls_integer,
    p_message_name in pit_util.ora_name_type default null,
    p_msg_args in msg_args default null,
    p_affected_id in pit_util.max_sql_char default null,
    p_error_code in varchar2 default null)
  as
  begin
    if log_me(p_severity) then
      case when p_message_name is not null then
        -- instantiate message
        g_active_message := get_message(p_message_name, p_msg_args, p_affected_id, p_error_code);
        -- Persist severity of calling environment with message
        g_active_message.severity := p_severity;
      when g_active_message is not null then
        -- message has been raised as an error before, use g_active_message
        -- call stack is filled only after an error has been raised, so get it again
        g_active_message.stack := pit_util.get_call_stack;
        g_active_message.backtrace := pit_util.get_error_stack;
      when p_severity <= C_LEVEL_FATAL then
        -- fallback, is used if a SQL exception was raised outside of PIT
        g_active_message := get_message('SQL_ERROR', p_msg_args, p_affected_id, p_error_code);
      else 
        -- if used with SQL_EXCEPTION, code may re raise the exception explicitly
        null;
      end case;

      if g_collect_mode then
        push_message(g_active_message);
      else
        raise_event(
          p_event => C_LOG_EVENT,
          p_event_focus => C_EVENT_FOCUS_ACTIVE);
      end if;
    end if;
  end log_event;
  
  
  procedure log_state(
    p_params in msg_params)
  as
  begin
    if log_me(g_log_state_threshold) then
      raise_event(
        p_event => C_LOG_STATE_EVENT,
        p_params => p_params,
        p_event_focus => C_EVENT_FOCUS_ACTIVE);
    end if;
  end log_state;


  procedure log_specific(
    p_message_name in pit_util.ora_name_type,
    p_affected_id in pit_util.max_sql_char,
    p_error_code in varchar2,
    p_msg_args in msg_args,
    p_log_threshold in pit_message.pms_pse_id%type,
    p_log_modules in pit_util.max_sql_char)
  as
    l_new_context pit_util.context_type;
    l_old_context pit_util.context_type;
  begin
    -- initialize
    g_active_message := get_message(p_message_name, p_msg_args, p_affected_id, p_error_code);
    l_new_context.log_level := p_log_threshold;
    l_new_context.module_list := p_log_modules;
    
    if g_active_message.severity <= l_new_context.log_level then
      set_context_temporarily(
        p_old_context => l_old_context,
        p_new_context => l_new_context);
        
      raise_event(
        p_event => C_LOG_EVENT,
        p_event_focus => C_EVENT_FOCUS_ACTIVE);
        
      reset_temporarily_set_context(l_old_context);
    end if;
  end log_specific;


  procedure enter(
    p_action in pit_util.ora_name_type,
    p_module in pit_util.ora_name_type,
    p_params in msg_params,
    p_trace_level in pls_integer,
    p_client_info in varchar2)
  as
    l_module pit_util.ora_name_type;
    l_action pit_util.ora_name_type;
    l_trace_me boolean;
    l_context pit_util.context_type;
  begin
    
    -- Initialize
    l_trace_me := trace_me(p_trace_level);
    
    -- reset active message to null, as this is a "normal" PL/SQL call that requires resetting any exception
    g_active_message := null;
    
    -- Do minimal tracing if context toggle is active
    if g_context.allow_toggle or l_trace_me then
      if p_module is null or p_action is null then
        pit_util.get_module_and_action(
          p_module => l_module,
          p_action => l_action);
      end if;
      
      l_module := coalesce(p_module, l_module);
      l_action := coalesce(p_action, l_action);
      l_context := get_toggle_context(
                    p_module => l_module, 
                    p_method => l_action);
      
      push_stack(
        p_module => l_module,
        p_action => l_action,
        p_client_info => p_client_info,
        p_params => p_params,
        p_trace_level => p_trace_level,
        p_trace_settings => l_context.settings);
    end if;

    if l_trace_me then
      raise_event(
        p_event => C_ENTER_EVENT,
        p_event_focus => C_EVENT_FOCUS_ACTIVE,
        p_call_stack => g_call_stack(g_call_stack.last));
    end if;
    
  exception
    when others then
      handle_error(C_LEVEL_ERROR, C_FAIL_MESSAGE_CREATION, msg_args(sqlerrm));
  end enter;


  procedure leave(
    p_trace_level in pls_integer,
    p_params in msg_params,
    p_on_error in boolean default false)
  is
    l_call_stack call_stack_type;
    l_trace_me boolean;
    l_new_trace_settings pit_util.max_sql_char;
    l_module pit_util.ora_name_type;
    l_action pit_util.ora_name_type;
    l_entry_found pls_integer;
  begin
    l_trace_me := trace_me(p_trace_level);
    
    -- Do minimal tracing if context toggle is active
    if (g_context.allow_toggle or l_trace_me) and g_call_stack.last > 0 then
      $IF dbms_db_version.ver_le_11 $THEN
      l_entry_found := g_call_stack.last;
      $ELSE
      if p_on_error then
        -- it is not secured that the exception handler is at the same method as the method raising the exception.
        -- Therefore try to find the method handling the error by name and remove any entry up to this entry
        pit_util.get_module_and_action(
          p_module => l_module,
          p_action => l_action);
      
        l_entry_found := g_call_stack.last + 1; -- Set found to a value higher max to avoid deleting entries if nothing is found
        for i in reverse 1 .. g_call_stack.last loop
          if coalesce(lower(l_action), 'FOO') = coalesce(lower(g_call_stack(i).method_name), 'FOO')
          and coalesce(lower(l_module), 'FOO') = coalesce(lower(g_call_stack(i).module_name), 'FOO') then
            l_entry_found := i;
            exit;
          end if;
        end loop;
      else
        -- Normal tracing is assumed, including that a complete list of ENTER-LEAVE pairs is provided
        -- Not advisable to look for named methods, as their name might be wrong based on code inlining
        l_entry_found := g_call_stack.last;
      end if;
      $END
      
      for i in reverse l_entry_found .. g_call_stack.last loop
        -- finalize entry in call stack and pass to output modules
        pop_stack(p_params, l_call_stack, l_new_trace_settings);

        if l_trace_me and l_call_stack is not null then
          -- replace existing ID with new ID to allow for persistance
          l_call_stack.id := pit_log_seq.nextval;
          raise_event(
            p_event => C_LEAVE_EVENT,
            p_event_focus => C_EVENT_FOCUS_ACTIVE,
            p_call_stack => l_call_stack);
        end if;
    
        if g_context.allow_toggle then
          -- toggle may have set a new trace level, Check and set accordingly for higher entries on stack
          l_trace_me := trace_me(p_trace_level); 
        end if;
      end loop;
    end if;

    reset_toggle_context(l_new_trace_settings);
  exception
    when others then
      handle_error(C_LEVEL_ERROR, C_FAIL_MESSAGE_CREATION);
  end leave;
  
  
  procedure long_op(
    p_target in varchar2,
    p_sofar in number,
    p_total in number,
    p_units in varchar2,
    p_op_name in varchar2)
  as
    l_idx pls_integer;
    l_op_name client_info_t;
    l_sno pls_integer;
  begin
    $IF pit_admin.c_trace_le_all $THEN
    if g_call_stack.count > 0 then
      -- Tracing active, take details from there
    
      -- initialize
      l_op_name := substr(
                     coalesce(p_op_name, 
                              g_call_stack(g_call_stack.last).app_module || '.' || g_call_stack(g_call_stack.last).app_action
                     ), 1, 64);
      l_idx := coalesce(g_call_stack(g_call_stack.last).long_op_idx, dbms_application_info.set_session_longops_nohint);
      
      dbms_application_info.set_session_longops(
        rindex => l_idx,
        slno => g_call_stack(g_call_stack.last).long_op_sno,
        op_name => l_op_name,
        sofar => p_sofar,
        totalwork => p_total,
        target_desc => substr(p_target, 1, 32),
        units => substr(coalesce(p_units, 'iterations'), 1, 32)); 
      g_call_stack(g_call_stack.last).long_op_idx := l_idx;
    else
      -- if tracing is not active, call session_longops just like normal
      dbms_application_info.set_session_longops(
        rindex => l_idx,
        slno => l_sno,
        op_name => p_op_name,
        sofar => p_sofar,
        totalwork => p_total,
        target_desc => substr(p_target, 1, 32),
        units => substr(coalesce(p_units, 'iterations'), 1, 32)); 
    end if;
    $ELSE
    -- Tracing disabled, no support for longops possible
    null;
    $END
  end long_op;


  procedure print(
    p_message_name in pit_util.ora_name_type,
    p_msg_args msg_args)
  as
  begin
    if p_message_name is not null then
      g_active_message := get_message(p_message_name, p_msg_args, null, null);
      raise_event(
         p_event => C_PRINT_EVENT,
         p_event_focus => C_EVENT_FOCUS_ACTIVE);
    else
      log_event(C_LEVEL_WARN, C_FAIL_MESSAGE_CREATION, msg_args('NULL'));
    end if;
  exception
    when others then
      handle_error(C_LEVEL_ERROR, C_FAIL_MESSAGE_CREATION, msg_args(p_message_name));
  end print;
  
  
  procedure notify(
    p_message_name in pit_util.ora_name_type,
    p_affected_id in pit_util.max_sql_char,
    p_msg_args in msg_args,
    p_log_threshold in pit_message.pms_pse_id%type,
    p_log_modules in pit_util.max_sql_char)
  as
    l_new_context pit_util.context_type;
    l_old_context pit_util.context_type;
  begin
    -- initialize
    g_active_message := get_message(p_message_name, p_msg_args, p_affected_id, null);
    l_new_context.log_level := p_log_threshold;
    l_new_context.module_list := p_log_modules;

    if g_active_message.severity <= coalesce(p_log_threshold, C_LEVEL_ALL) then
    
      set_context_temporarily(
        p_old_context => l_old_context,
        p_new_context => l_new_context);

      raise_event(
        p_event => C_NOTIFY_EVENT,
        p_event_focus => C_EVENT_FOCUS_ACTIVE);
        
      reset_temporarily_set_context(l_old_context);
    end if;
  end notify;


  procedure raise_error(
    p_severity in pls_integer,
    p_message_name pit_util.ora_name_type,
    p_msg_args in msg_args,
    p_affected_id in pit_util.max_sql_char,
    p_error_code in varchar2)
  as
  begin
    -- P_MESSAGE_NAME could be NULL, we use G_ACTIVE_MESSAGE then
    if p_message_name is not null then
      g_active_message := get_message(p_message_name, p_msg_args, p_affected_id, p_error_code);
      g_active_message.severity := p_severity;
      g_active_message.error_number := coalesce(g_active_message.error_number, -20000);
    end if;

    if g_collect_mode then
      push_message(g_active_message);
    else
      raise_application_error(
        g_active_message.error_number,
        dbms_lob.substr(g_active_message.message_text, 2048, 1));
    end if;
  end raise_error;


  procedure handle_error(
    p_severity in pls_integer,
    p_message_name pit_util.ora_name_type,
    p_msg_args in msg_args,
    p_affected_id in pit_util.max_sql_char,
    p_error_code in varchar2,
    p_params in msg_params)
  as
  begin
    log_event(p_severity, p_message_name, p_msg_args, p_affected_id, p_error_code);
    
    if p_severity = C_LEVEL_FATAL then
      clean_stack(p_params);
      raise_error(C_LEVEL_FATAL, p_message_name, p_msg_args, p_affected_id, p_error_code);
    else
      leave(C_TRACE_MANDATORY, p_params);
      g_active_message := null;
    end if;
  end handle_error;


  procedure purge_log(
    p_date_before in date,
    p_severity_lower_equal in pls_integer)
  as
  begin
    raise_event(
          p_event => C_PURGE_EVENT,
          p_event_focus => C_EVENT_FOCUS_ACTIVE,
          p_date_before => p_date_before,
          p_severity_lower_equal => p_severity_lower_equal);
    exception
      when others then
        handle_error(C_LEVEL_ERROR, C_FAIL_MESSAGE_PURGE);
  end purge_log;


  /** MESSAGE related methods */
  function get_message(
    p_message_name in pit_util.ora_name_type,
    p_msg_args in msg_args,
    p_affected_id in pit_util.max_sql_char,
    p_error_code in varchar2)
   return message_type
  as
    -- use a local message here to prevent to overwrite g_active_message with messages that are never raised
    l_message message_type;
  begin
    l_message := message_type(
                   p_message_name => p_message_name,
                   p_message_language => get_language,
                   p_affected_id => p_affected_id,
                   p_error_code => p_error_code,
                   p_session_id => g_client_id,
                   p_user_name => g_user_name,
                   p_arg_list => p_msg_args);
    return l_message;
  exception
    when NO_DATA_FOUND then
      handle_error(C_LEVEL_FATAL, C_MSG_NOT_EXISTING, msg_args(p_message_name));
      return null;
  end get_message;
  
  
  function get_active_message
    return message_type
  as
  begin
    return g_active_message;
  end get_active_message;
  
  
  function check_datatype(
    p_value in varchar2,
    p_type in varchar2,
    p_format_mask in varchar2)
    return boolean
  as
    C_INTEGER_REGEXP constant pit_util.ora_name_type := '^[0-9]+$';
    l_result boolean := true;
    l_format_mask pit_util.ora_name_type;
    l_number number;
    l_date date;
    l_timestamp timestamp with time zone;
    l_xml xmltype;
  begin
    l_format_mask := p_format_mask;
    
    case p_type
    when C_TYPE_INTEGER then
      l_result := regexp_like(p_value, C_INTEGER_REGEXP);
    when C_TYPE_NUMBER then
      begin
        l_format_mask := coalesce(l_format_mask, '999999999999999999D999999999');
        l_number := to_number(p_value, l_format_mask);
      exception
        when others then
          l_result := false;
      end;
    when C_TYPE_DATE then
      begin
        l_format_mask := coalesce(l_format_mask, sys_context('USERENV', 'NLS_DATE_FORMAT'));
        l_date := to_date(p_value, p_format_mask);
      exception
        when others then
          l_result := false;
      end;
    when C_TYPE_TIMESTAMP then
      begin
        if l_format_mask is null then
          select value
            into l_format_mask
            from v$nls_parameters
           where parameter = 'NLS_TIMESTAMP_FORMAT';
        end if;
        l_timestamp := to_timestamp(p_value, l_format_mask);
      exception
        when others then
          l_result := false;
      end;
    when C_TYPE_XML then
      begin
        l_xml := xmltype(p_value);
      exception
        when others then
          l_result := false;
      end;
    else
      null;
    end case;
    return l_result;
  end check_datatype;


  function get_message_text(
    p_message_name in pit_util.ora_name_type,
    p_msg_args in msg_args)
    return clob
  as
  begin
    return get_message(
             p_message_name => p_message_name, 
             p_msg_args => p_msg_args, 
             p_affected_id => null, 
             p_error_code => null).message_text;
  end get_message_text;
  
  
  /** TRNALSATION ITEM methods */
  function get_trans_item(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_msg_args msg_args,
    p_pti_pml_name in pit_message_language.pml_name%type)
    return pit_util.translatable_item_rec
  as
    l_pti_rec pit_util.translatable_item_rec;
    l_pml_name pit_util.small_char;
  begin
    -- P_PTI_PML_NAME takes precedence over SYS_CONTEXT.LANGUAGE over default language of PIT
    l_pml_name := coalesce(p_pti_pml_name, get_language);
    select pti_name, pti_display_name, pti_description
      into l_pti_rec
      from (select pti_name, pti_display_name, pti_description,
                   rank() over (order by pml_default_order desc) ranking
              from pit_translatable_item
              join pit_message_language
                on pti_pml_name = pml_name
             where pti_id = p_pti_id
               and pti_pmg_name = p_pti_pmg_name
                   -- try to find available translation or fallback to default language
               and (pml_name = l_pml_name or pml_default_order = 10))
     where ranking = 1;
    
    if p_msg_args is not null then
      for i in p_msg_args.first .. p_msg_args.last loop
        l_pti_rec.pti_name := replace(l_pti_rec.pti_name, '#' || i || '#', p_msg_args(i));
        l_pti_rec.pti_display_name := replace(l_pti_rec.pti_display_name, '#' || i || '#', p_msg_args(i));
      end loop;
    end if;
    
    return l_pti_rec;
  end get_trans_item;


  /** CONTEXT MAINTENANCE */
  function get_context
    return pit_util.context_type
  is
  begin
    copy_context_to_global;
    return g_context;
  end get_context;


  procedure set_context(
    p_context in pit_util.context_type)
  as
    l_context pit_util.context_type;
  begin
    -- Initialize
    l_context := p_context;
    
    case when l_context.context_name is not null and l_context.settings is null then
      -- Context name passed in, this is the default behaviour
      l_context.context_name := pit_util.harmonize_name(C_CONTEXT_PREFIX, l_context.context_name);
      -- check whether named context exists
      select l_context.context_name
        into l_context.context_name
        from global_context
       where namespace = C_GLOBAL_CONTEXT
         and attribute = l_context.context_name;
      
      if l_context.context_name = C_CONTEXT_DEFAULT then
        reset_active_context;
      else
        copy_context_to_global(l_context.context_name);
        set_context_if_changed(g_context);
      end if;
    else
      -- Explicit context settings without a context name passed in.
      -- Don't try to read context settings from global context, leave context_name to NULL
      -- to force SET_CONTEXT_IF_CHANGED to check whether new settings apply
      l_context := p_context;
      l_context.settings := pit_util.context_type_to_string(l_context);
      set_context_if_changed(l_context);
    end case;
    
  exception
    when NO_DATA_FOUND then
      handle_error(C_LEVEL_FATAL, C_UNKNOWN_NAMED_CONTEXT, msg_args(l_context.context_name));
    when others then
      handle_error(C_LEVEL_FATAL);
  end set_context;


  procedure reset_active_context
  as
    l_raise_focus pit_util.ora_name_type;
    l_required_context pit_util.ora_name_type;
  begin
    g_active_adapter.get_session_details(g_user_name, g_client_id, l_required_context);

    utl_context.clear_value(C_GLOBAL_CONTEXT, C_CONTEXT_ACTIVE, g_client_id);
    copy_context_to_global;
    l_raise_focus := case when g_context.broadcast_context_switch then C_EVENT_FOCUS_ALL else C_EVENT_FOCUS_ACTIVE end;
    raise_event(C_CONTEXT_EVENT, l_raise_focus);
  end reset_active_context;


  procedure reset_context
  as
  begin
    utl_context.reset_context(C_GLOBAL_CONTEXT);
    initialize;
  end reset_context;
  
  
  /** COLLECT MODE methods */
  procedure set_collect_mode(
    p_mode in boolean)
  as
    l_min_severity pls_integer;
  begin
    -- initialize
    g_collect_mode := p_mode;
    l_min_severity := C_LEVEL_ALL;
    
    if g_collect_mode then
      g_message_stack.delete;
    else
      for i in 1 .. g_message_stack.count loop
        if l_min_severity > g_message_stack(i).severity then
          l_min_severity := g_message_stack(i).severity;
        end if;
      end loop;
      
      case l_min_severity
        when C_LEVEL_ERROR then
          raise_error(
            p_severity => C_LEVEL_ERROR,
            p_message_name => C_BULK_ERROR,
            p_msg_args => null,
            p_affected_id => null,
            p_error_code => null);
        when C_LEVEL_FATAL then
          raise_error(
            p_severity => C_LEVEL_FATAL,
            p_message_name => C_BULK_FATAL,
            p_msg_args => null,
            p_affected_id => null,
            p_error_code => null);
        else
          null;
      end case;
    end if;
  end set_collect_mode;
    
    
  function get_collect_mode
    return boolean
  as
  begin
    return g_collect_mode;
  end get_collect_mode;
    
  
  function get_message_collection
    return pit_message_table
  as
    l_message_stack pit_message_table;
  begin
    -- deep copy to allow for clean up of G_MESSAGE_STACK
    l_message_stack := g_message_stack;
    g_message_stack.delete;
    g_collect_mode := false;
    return l_message_stack;
  end get_message_collection;
  
  
  function get_actual_call_stack_depth
    return pls_integer
  as
  begin
    return g_call_stack.count;
  end get_actual_call_stack_depth;
  

  /** MODULE MAINTENANCE */
  function get_modules
    return pit_module_list
    pipelined
  as
    l_idx pit_util.ora_name_type;
    l_available pit_util.flag_type;
    l_active pit_util.flag_type;
    l_stack pit_util.max_sql_char;
    l_module pit_module;
  begin
    if g_all_modules.count > 0 then
      -- initialize
      copy_context_to_global;
      l_idx := g_all_modules.first;
      
      while l_idx is not null loop
        l_available := pit_util.to_bool(g_available_modules.exists(l_idx));
        l_active := pit_util.to_bool(g_active_modules.exists(l_idx));
        if pit_util.to_bool(l_available) then
          l_stack := 'OK';
        else
          l_module := g_all_modules(l_idx);
          l_stack := l_module.stack;
        end if;
        pipe row(pit_module_meta(l_idx, l_available, l_active, l_stack));
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
    -- initialize
    copy_context_to_global;
    l_idx := g_active_modules.first;
    
    while l_idx is not null loop
      pipe row(l_idx);
      l_idx := g_active_modules.next(l_idx);
    end loop;
    
    return;
  exception
    when NO_DATA_NEEDED then
       null;
    when others then
      handle_error(C_LEVEL_ERROR, C_FAIL_READ_MODULE_LIST);
      return;
  end get_active_modules;


  function get_available_modules
    return args
    pipelined
  as
    l_idx pit_util.ora_name_type;
  begin
    -- initialize
    copy_context_to_global;
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
      handle_error(C_LEVEL_ERROR, C_FAIL_READ_MODULE_LIST);
      return;
  end get_available_modules;
  
  
  function report_module_status
    return args pipelined
  as
    C_MESSAGE_TEMPLATE constant pit_util.max_sql_char := q'|Status of #IDX#: #STATUS#, Threshold: #THRESHOLD#|';
    l_idx pit_util.ora_name_type;
    l_message pit_util.max_sql_char;
  begin
    -- initialize
    l_idx := g_all_modules.first;
    
    while l_idx is not null loop
      l_message := pit_util.bulk_replace(
                     p_string => C_MESSAGE_TEMPLATE, 
                     p_chunks => char_table(
        '#IDX#', l_idx,
        '#STATUS#', g_all_modules(l_idx).status,
        '#THRESHOLD#', g_all_modules(l_idx).fire_threshold));
      pipe row (l_message);
      l_idx := g_all_modules.next(l_idx);
    end loop;
    
  end report_module_status;


begin
  initialize;
end pit_pkg;
/
