create or replace package body pit_internal
as
  /** 
    Package: PIT_INTERNAL Body
      Implements the core PIT logic.
   
    Author:: 
      Juergen Sieben, ConDeS GmbH
      
      Published under MIT licence
   */
   
  /**
    Group: Private type declarations
   */
  /**
    Type: module_list_type
      List of output modules of type <PIT_MODULE>, indexed by <pit_util.ora_name_type>.
   */
  type module_list_type is table of pit_module index by pit_util.ora_name_type;

  /** 
    Type: call_stack_tab
      Type to store a list of <call_stack_type> instances. Indexed by pls_integer.
   */
  type call_stack_tab is table of call_stack_type index by pls_integer;
  
  /**
    Type: client_info_t
      Subtype of VARCHAR2, limited to 64 byte.
   */
  subtype client_info_t is varchar2(64 byte);

  /**
    Group: Private constants
   */
  /**
    Constants: Private constants
      C_PARAM_GROUP - Name of the parameter group for PIT
      C_BASE_MODULE - Typename of the abstract output module
      C_WARN_IF_UNUSABLE_MODULES - Parameter name that controls if PIT warns in case a module is unusable
      C_LOG_STATE_THRESHOLD - Parameter name that holds the default threshold for the <log_state> method
   */
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
  C_STOP_BULK_ON_FATAL constant pit_util.ora_name_type := 'PIT_STOP_BULK_ON_FATAL';
  C_FAIL_READ_MODULE_LIST constant pit_util.ora_name_type := 'PIT_FAIL_READ_MODULE_LIST';
  C_NO_CONTEXT_SETTINGS constant pit_util.ora_name_type := 'PIT_NO_CONTEXT_SETTINGS';

  /**
    Constants: Private context constants
      C_GLOBAL_CONTEXT - Name of the global context name for PIT
      C_CONTEXT_TYPE - Paramter that holds the type of the global context
      C_CONTEXT_DEFAULT - Name of the default context
      C_CONTEXT_ACTIVE - Name of the active context
      C_ALLOW_TOGGLE - Name of the parameter that holds the allow toggle flag
   */
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

  /**
    Constants: Private adapter constants
      C_ADAPTER_PREFERENCE - Name of the parameter that stores the adapter preference
      C_ADAPTER_OK - Flag to indicate that the adapter is usable
   */
  C_ADAPTER_PREFERENCE constant pit_util.ora_name_type := 'ADAPTER_PREFERENCE';
  C_ADAPTER_OK constant pit_util.flag_type := pit_util.C_TRUE;

  /**
    Constants: "event"" constants
      C_CONTEXT_EVENT - Context changed event
      C_LOG_EVENT - Log event
      C_PURGE_EVENT - Purge event
      C_PRINT_EVENT - Print event
      C_ENTER_EVENT - Enter event
      C_LEAVE_EVENT - Leave event
      C_NOTIFY_EVENT - Notify event
      C_LOG_STATE_EVENT - Log state event
   */
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

  
  /**
    Group: Private global variable declarations
   */
  /**
    Variables: Package variables
      g_all_modules - List of all output modules that are installed
      g_available_modules - List of all modules which are available for logging (meaning: status = msg.MODULE_INSTANTIATED)
      g_active_modules - List of all modules which are available and actually registered for logging
      g_context - Actual context settings
      g_active_message - Actual message. Stored globally to allow for reuse of last raised message
      g_call_stack - Global variable to store the call stack
      g_warn_if_unusable_modules - Cache parameter <C_WARN_IF_UNUSABLE_MODULES>
      g_active_adapter - Adapter in use (Default Adapter or any other adapter as preferred by parameter <C_ADAPTER_PREFERENCE>
      g_user_name - Actual username to avoid roundtrips to SQL function USER
      g_client_id - Instance of <client_info_t> holding information about the actually connencted client
      g_collect_mode - Flag to indicate whether PIT is in collect mode
      g_message_stack - List of messages raised since PIT is in collect mode
      g_collect_least_severity - Least severity so far (meaning the most severe message)
      g_stop_bulk_on_fatal - Flag to indicate whether collect mode has to be left if a fatal exception occurs
      g_log_state_threshold - Cache for parameter <C_LOG_STATE_THRESHOLD>
   */
  g_all_modules module_list_type;
  g_available_modules module_list_type;
  g_active_modules module_list_type;
  
  g_context pit_util.context_type;
  
  g_active_message message_type;
  
  g_call_stack call_stack_tab;
  
  g_warn_if_unusable_modules boolean;
  g_active_adapter pit_default_adapter;
  g_user_name pit_util.ora_name_type;
  g_client_id client_info_t;
  
  g_collect_mode boolean;
  g_message_stack pit_message_table;
  g_collect_least_severity binary_integer;
  g_stop_bulk_on_fatal boolean;
  
  g_log_state_threshold pls_integer;


  /************************* FORWARD DECLARATION ******************************/
  procedure raise_event(
    p_event in pls_integer,
    p_message in message_type default null,
    p_call_stack in call_stack_type default null,
    p_log_state in log_state_type default null,
    p_context in pit_util.context_type default null,
    p_date_before in date default null,
    p_severity_lower_equal in pls_integer default null);
    

  /**
    Group: Private module maintenance methods
   */
  /**
    Procedure:load_modules
      Loads all output modules installed extending type <PIT_MODULE>
      
      - All modules are availabe in <G_ALL_MODULES>
      - All successfully instantiated modules are available in <G_AVAILABLE_MODULES>
      - An error is thrown if no module could be made available
   */
  procedure load_modules
  as
    cursor installed_modules_cur is
      select type_name
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


  /** 
    Procedure: report_module_status
      Reports all modules that have not been loaded succesfully if requested by parameter <C_WARN_IF_UNUSABLE_MODULES>
      
      Is called after initialization of the output modules.
      Emits warnings for any module that has not been loaded succesfully if set to do so.
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


  /** 
    Function: get_modules_by_name
      Copies all requested and available output module instances into a module list. These modules will then be used to log to.
      
    Parameter:
      p_requested_modules - Colon-separated list of requested output modules
      
    Returns:
      Collection of type <MODULE_LIST_TYPE> with all available and requested module instances
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


  /**
    Group: Private context maintenance methods
   */
  /** 
    Function: read_best_matching_context
      Method to read the actually chosen context from the global context. Is used to read the actual settings, 
      as they may have changed based on settings in other sessions.
      
      Context are stored under their name in the global context. This method tries to read the context values
      of the passed in context name. If it can't find any, it falls back to the active context and 
      if no active context exists, to the default context.
      
    Parameter:
      p_args - Optional (list of) context name(s). If NULL, ACTIVE and DEFAULT contexts are searched in that order,
               otherwise the passed in (list of) context name has highest priority.
               
    Returns:
      Actual context settings.
    
    Errors:
      -20000 - if no context settings were found.
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
  
  
  /** 
    Procedure: copy_context_to_global
      Reads actual context settings into <G_CONTEXT> and decides whether a change in the settings has occurred.
      
      Is called to read the log settings from the globally accessed context. It tries to read the context
      in the following order: 
      
      - CONTEXT_FROM SESSION_ADAPTER, 
      - P_CONTEXT_NAME, 
      - C_ACTIVE_CONTEXT, 
      - C_DEFAULT_CONTEXT
      
      After having read the actual settings, it compares them to the settings known so far. 
      If they differ, <pit_util.context_type.CTX_CHANGED> is set to TRUE and to FALSE otherwise.
      
    Parameter:
      p_context_name - Optional context name. 
      
    Returns:
      Session context, if required, named context if requested, active context if available, default context otherwise.
   */
  procedure copy_context_to_global(
    p_context_name in varchar2 default null)
  as
    l_args args;
    l_actual_context pit_util.context_type;
  begin
    -- load settings from global context
    -- If session adapter mandates for a context, this has precedence over local settings
    g_context := read_best_matching_context(args(p_context_name));        
    g_active_modules := get_modules_by_name(g_context.module_list);
    
    l_actual_context := read_best_matching_context;
    g_context.ctx_changed := g_context.settings != l_actual_context.settings;
      
  end copy_context_to_global;
  
  
  /** 
    Procedure: copy_actual_context_to_global
      Retrieves the actually valid context settings and copies it to <G_CONTEXT>.
      
      Is used as a wrapper around <COPY_CONTEXT_TO_GLOBAL>. This method reads the actual context first 
      to find out whether the session adapter requires a context change. If yes, this context is read.
   */
  procedure copy_actual_context_to_global
  as
    l_required_context pit_util.ora_name_type;
  begin
    -- get the actually required context from the session adapter
    g_active_adapter.get_session_details(
      p_user_name => g_user_name, 
      p_session_id => g_client_id, 
      p_required_context => l_required_context);
      
    copy_context_to_global(l_required_context);
  end copy_actual_context_to_global;
  
  
  /** 
    Procedure: set_context_if_changed
      Stores new context settings for PIT at the global context and raises <C_CONTEXT_EVENT> event.
      
      Is called from <pit.SET_CONTEXT> to actually persist the required settings
      in the global context and raise a context switch event.
      
      This method examines whether a context change has happened by comparing  the context settings with 
      the latest stored settings from <G_CONTEXT>. If a change has occurred, it stores the new values
      
      - at the globally accessed context to propagate the settings to other sessions
      - within global variable G_CONTEXT to allow for a comparison later
      
      It also loads the active output modules.
      
    Parameter:
      p_context - New context settings, instance of pit_util.context_type
   */
  procedure set_context_if_changed(
    p_context in pit_util.context_type)
  as
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
      raise_event(
        p_event => C_CONTEXT_EVENT,  
        p_context => p_context);
    end if;
    
  end set_context_if_changed;
  
  
  /** 
    Procedure: set_context_temporarily
      Method to persist existings context settings in <P_OLD_CONTEXT> and set the active context according to the settings.
      
      Is used if for a single log activity a new context setting is required, such as with <pit.LOG_SPECIFIC> or <pit.NOTIFY>.
      In this environment, only output modules and log threshold can be changed, therefore all other settings are
      copied from the actually active context. Used in conjunction with <RESET_TEMPORARILY_SET_CONTEXT>
      
    Parameters:
      p_old_context - Instance of PIT_UTIL.context_type to hold the existing context settings and a flag on whether
                      the context was changed by this method
      p_new_context - partly filled new context (log_level and module_list may be filled)
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
  
  
  /** 
    Procedure: reset_temporarily_set_context
      Method to reset a temporarlily set context back to its original settings.
      Is used to reset a temporarily context switch back. Used in conjunction with <SET_CONTEXT_TEMPORARILY>
      
    Parameter:
      p_context - Context settings of the context before the temporarily shift
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


  /** 
    Function: get_toggle_context
      Checks whether a toggle for a given package/method exists.
      
      A toggle controls whether PIT should log or not. Therefore it must be checked whether a toggle was defined for
      the actual package/method the call stack is at. If a setting is present, this method will set the new environment 
      and return the settings at the same time to store them in the call stack.
      This is necessary to reset it if the call stack entry is popped.
      
    Parameters:
      p_module - Name of the package that toggles log settings
      p_method - Name of the method that toggles log settings. If NULL, any method within <P_MODULE> will toggle.
      
    Returns:
      Context with settings for PACKAGE.METHOD, PACKAGE, ACTIVE or DEFAULT CONTEXT
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


  /** 
    Procedure: reset_toggle_context
      Resets toggle context settings. If a toggle was found and the call stack pops that entry, 
      the log settings outside the toggle must be restored.
      
    Parameter:
      p_settings - Context settings to set the context to
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
  
  
  /**
    Function: check_context_toggle
      Checks whether log settings have to be changed due to toggle settings
      
    Parameters:
      p_trace_settings - Potentially new settings if a toggle exists
      p_last_entry - Reference to the last call stack entry from which the context settings are copied
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


  /** 
    Procedure: get_context_list
      Reads all predefined context and toggles from parameters and stores it in globally accessed context.
      Method is invoked during initialization to copy parameter settings for access across sessions.
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
         p_par_pgr_id => C_CONTEXT_GROUP) not in (
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


  /**
    Group: Private adapter maintenance methods
   */
  /**
    Procedure: load_adapter
      Loads and instantiates an adapter to read client information.
      
      Procedure loads and instantiates adapters which are created under <PIT_DEFAULT_ADAPTER> plus 
      <PIT_DEFAULT_ADAPTER> itself.
      
      Which modules are instantiated depends on parameter <C_ADAPTER_PREFERENCE>.
      
      <LOAD_ADAPTER> tries to instantiate the adpaters in the order specified in the parameter 
      and stops upon first successful instantiation.
      
      The instantiated module provides information about the actual environment.
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
                                            p_par_pgr_id => C_PARAM_GROUP));
    
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


  /**
    Group: Private call stack maintenance methods
   */
  /** 
    Procedure: maintain_application_info
      Helper to maintain Application Info. Called from <PUSH_STACK>/<POP_STACK> methods.
      
    Parameters:
      p_module - Module that was called
      p_action - Method of the module that was called
      p_client_info - Client info passed in as optional parameter
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
  
  
  /** 
    Procedure: push_stack
      Method to push an entrie to the call stack. Called from the <ENTER> method.
      
    Parameters:
      p_module - Module that was called
      p_action - Method of the module that was called
      p_client_info - Optional client info passed in as a pararameter to <ENTER>
      p_params - Parameter list of parameters passed to the method
      p_trace_level - Trace level of the entry
      p_trace_settings - In case of toggles trace settings may change. The new settings are passed in here
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
    copy_actual_context_to_global;

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


  /** 
    Procedure: pop_stack
      Method to pop an entry from the call stack. Called from <LEAVE>-method.
      
    Parameters:
      p_params - Parameter list of parameters passed to the method
      p_call_stack - Instance of <call_stack_type> to pop from the stack
      p_new_trace_settings - In case of toggles trace settings may change. The new settings are passed in here
      
    Returns:
      Last entry found on the call stack. Used to maintain timing etc.
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
    copy_actual_context_to_global;
    
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
  
  
  /** 
    Procedure: clean_stack
      Helper method to clean stack after a fatal error has ocurred. Called from method 
      <HANDLE_ERROR> if level is <C_LEVEL_FATAL>. Pops all call stack entries.
      
    Parameter:
      p_params - Instance of <msg_params>, used to add output parameters to the leave message
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
  
  
  /**
    Group: Private methods
   */  
  /** 
    Function: get_language
      Helper method to retrieve the actual session language
      
    Returns:
      Language string as per oracle convention: AMERICAN|GERMN etc.
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
  
  
  /** 
    Procedure: push_message
      Pushes a method on the message stack if in message collection mode.
      
    Parameter:
      p_message - Message to push onto the stack
   */
  procedure push_message(
    p_message in out nocopy message_type)
  as
  begin
    g_collect_least_severity := least(g_collect_least_severity, p_message.severity);
    if g_stop_bulk_on_fatal and g_collect_least_severity = C_LEVEL_FATAL then
      raise_error(C_LEVEL_FATAL, C_BULK_FATAL, null, null, null);
    else
      p_message.error_code := coalesce(p_message.error_code, p_message.message_name);
      g_message_stack.extend;
      g_message_stack(g_message_stack.last) := p_message;
    end if;
  end push_message;


  /**
    Group: Core functionality private methods
   */
  /** 
    Procedure: raise_event
      Central method to distribute any message to all actively parameterized output modules.
      Called internally as a generic helper to throw messages to output modules
      
    Parameters:
      p_event - Integer indicating the type of "event" (i.e. <C_LOG_EVENT>|<C_PRINT_EVENT>|<C_ENTER_EVENT> etc.) thrown by PIT
      p_call_stack - Instance of the actual call stack in the event of <C_ENTER_EVENT>|<C_LEAVE_EVENT>
      p_date_before - Date indicating the point in time, up to when the log is to be purged
      p_message - Instance of type <MESSAGE_TYPE>: the message to raise
   */
  procedure raise_event(
    p_event in pls_integer,
    p_message in message_type default null,
    p_call_stack in call_stack_type default null,
    p_log_state in log_state_type default null,
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
  
    -- Adjust list of output modules
    if p_event = C_CONTEXT_EVENT and g_context.broadcast_context_switch then
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
          l_modules(l_idx).log(p_message);
        when C_PURGE_EVENT then
          l_modules(l_idx).purge(p_date_before, p_severity_lower_equal);
        when C_PRINT_EVENT then
          l_modules(l_idx).print(p_message);
        when C_NOTIFY_EVENT then
          l_modules(l_idx).notify(p_message);
        when C_ENTER_EVENT then
          l_modules(l_idx).enter(p_call_stack);
        when C_LEAVE_EVENT then
          l_modules(l_idx).leave(p_call_stack);
        when C_LOG_STATE_EVENT then
          l_modules(l_idx).log(p_log_state);
        else
          null;
      end case;
      l_idx := l_modules.next(l_idx);
    end loop;
    
    commit;
  end raise_event;


  /** 
    Function: log_me
      Decides whether a message has to be logged. 
      
      Is called during logging to decide whether the actual settings allow for logging.
      The decision is based on the requested log level as well as on settings in the global context.
      
    Parameter:
      p_severity - log_level for which a decision is requested
      
    Returns:
      Flag that indicates whether settings allow for logging (TRUE) or not (FALSE).
   */
  function log_me(
    p_severity in pit_message.pms_pse_id%type)
    return boolean
  as
  begin
    copy_actual_context_to_global;
    return p_severity <= greatest(g_context.log_level, C_LEVEL_ERROR);
  exception
    when no_data_found then
      return false;
  end log_me;


  /** 
    Function: trace_me
      Decides whether a message has to be traced. 
      
      Is called during logging to decide whether the actual settings allow for tracing.
      The decision is based on the requested trace level as well as on settings in the global context.
      
    Parameter:
      p_trace_level - trace_level for which a decision is requested
      
    Returns:
      Flag that indicates whether settings allow for tracing (TRUE) or not (FALSE).
   */
  function trace_me(
    p_trace_level in integer)
    return boolean
  as
  begin
    copy_actual_context_to_global;
    return p_trace_level <= g_context.trace_level;
  end trace_me;
  
  
  /**
    Group: Public methods
   */
  /**
    Procedure: initialize
      See <PIT_INTERNAL.initialize>
   */
  procedure initialize
  as
  begin
    -- Read static parameters
    g_context.allow_toggle := param.get_boolean(
                                p_par_id => C_ALLOW_TOGGLE, 
                                p_par_pgr_id => C_PARAM_GROUP);
    g_context.broadcast_context_switch := param.get_boolean(
                                            p_par_id => C_BROADCAST_CONTEXT_SWITCH, 
                                            p_par_pgr_id => C_PARAM_GROUP);
    g_warn_if_unusable_modules := param.get_boolean(
                                    p_par_id => C_WARN_IF_UNUSABLE_MODULES, 
                                    p_par_pgr_id => C_PARAM_GROUP);
                                    
    g_log_state_threshold := param.get_integer(
                               p_par_id => C_LOG_STATE_THRESHOLD,
                               p_par_pgr_id => C_PARAM_GROUP);
                               
    g_stop_bulk_on_fatal := param.get_boolean(
                              p_par_id => C_STOP_BULK_ON_FATAL,
                              p_par_pgr_id => C_PARAM_GROUP);
    g_collect_mode := false;
    g_collect_least_severity := C_LEVEL_ALL;
    
    -- Empty collections
    g_call_stack.delete;
    g_message_stack := pit_message_table();
    
    load_modules;
    load_adapter;
    get_context_list;

    -- starting here, PIT is initialized and prepared to create messages
    report_module_status;
  end initialize;
  

  /**
    Function: check_log_level_greater_equal
      See <PIT_INTERNAL.check_log_level_greater_equal>
   */
  function check_log_level_greater_equal(
    p_log_level in pls_integer)
    return boolean
  as
  begin
    return log_me(p_log_level);
  end check_log_level_greater_equal;
  
  
  /**
    Function: check_trace_level_greater_equal
      See <PIT_INTERNAL.check_trace_level_greater_equal>
   */
  function check_trace_level_greater_equal(
    p_trace_level in pls_integer)
    return boolean
  as
  begin
    return trace_me(p_trace_level);
  end check_trace_level_greater_equal;
  
  
  /**
    Procedure: log_event
      See <PIT_INTERNAL.log_event>
   */
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
          p_message => g_active_message);
      end if;
    end if;
  end log_event;
  
  
  /**
    Procedure: log_state
      See <PIT_INTERNAL.log_state>
   */
  procedure log_state(
    p_params in msg_params,
    p_severity in pit_message_severity.pse_id%type default null)
  as
  begin
    if log_me(coalesce(p_severity, g_log_state_threshold)) then
      raise_event(
        p_event => C_LOG_STATE_EVENT,
        p_log_state => log_state_type(p_severity, p_params));
    end if;
  end log_state;


  /**
    Procedure: log_specific
      See <PIT_INTERNAL.log_specific>
   */
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
        p_message => g_active_message);
        
      reset_temporarily_set_context(l_old_context);
    end if;
  end log_specific;


  /**
    Procedure: enter
      See <PIT_INTERNAL.enter>
   */
  procedure enter(
    p_action in pit_util.ora_name_type,
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
    l_action := p_action;
    
    -- reset active message to null, as this is a "normal" PL/SQL call that requires resetting any exception
    g_active_message := null;
    
    -- Do minimal tracing if context toggle is active
    if g_context.allow_toggle or l_trace_me then
      pit_util.get_module_and_action(
        p_module => l_module,
        p_action => l_action);
      
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
        p_call_stack => g_call_stack(g_call_stack.last));
    end if;
    
  exception
    when others then
      handle_error(C_LEVEL_ERROR, C_FAIL_MESSAGE_CREATION, msg_args(sqlerrm));
  end enter;


  /**
    Procedure: leave
      See <PIT_INTERNAL.leave>
   */
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
      
      for i in reverse l_entry_found .. g_call_stack.last loop
        -- finalize entry in call stack and pass to output modules
        pop_stack(p_params, l_call_stack, l_new_trace_settings);

        if l_trace_me and l_call_stack is not null then
          -- replace existing ID with new ID to allow for persistance
          l_call_stack.id := pit_log_seq.nextval;
          raise_event(
            p_event => C_LEAVE_EVENT,
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
  
  
  /**
    Procedure: long_op
      See <PIT_INTERNAL.long_op>
   */
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


  /**
    Procedure: print
      See <PIT_INTERNAL.print>
   */
  procedure print(
    p_message_name in pit_util.ora_name_type,
    p_msg_args msg_args)
  as
  begin
    if p_message_name is not null then
      g_active_message := get_message(p_message_name, p_msg_args, null, null);
      raise_event(
        p_event => C_PRINT_EVENT,
        p_message => g_active_message);
    else
      log_event(C_LEVEL_WARN, C_FAIL_MESSAGE_CREATION, msg_args('NULL'));
    end if;
  exception
    when others then
      handle_error(C_LEVEL_ERROR, C_FAIL_MESSAGE_CREATION, msg_args(p_message_name));
  end print;
  
  
  /**
    Procedure: notify
      See <PIT_INTERNAL.notify>
   */
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
        p_message => g_active_message);
        
      reset_temporarily_set_context(l_old_context);
    end if;
  end notify;


  /**
    Procedure: raise_error
      See <PIT_INTERNAL.raise_error>
   */
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
    
    if g_collect_mode and not (p_severity = C_LEVEL_FATAL and g_stop_bulk_on_fatal) then
      push_message(g_active_message);      
    else
      raise_application_error(
        g_active_message.error_number,
        dbms_lob.substr(g_active_message.message_text, 2048, 1));    
    end if;
  end raise_error;


  /**
    Procedure: handle_error
      See <PIT_INTERNAL.handle_error>
   */
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


  /**
    Procedure: purge_log
      See <PIT_INTERNAL.purge_log>
   */
  procedure purge_log(
    p_date_before in date,
    p_severity_lower_equal in pls_integer)
  as
  begin
    raise_event(
          p_event => C_PURGE_EVENT,
          p_date_before => p_date_before,
          p_severity_lower_equal => p_severity_lower_equal);
    exception
      when others then
        handle_error(C_LEVEL_ERROR, C_FAIL_MESSAGE_PURGE);
  end purge_log;


  /**
    Function: get_message
      See <PIT_INTERNAL.get_message>
   */
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
  
  
  /**
    Function: get_active_message
      See <PIT_INTERNAL.get_active_message>
   */
  function get_active_message
    return message_type
  as
  begin
    return g_active_message;
  end get_active_message;
  
  
  /**
    Function: check_datatype
      See <PIT_INTERNAL.check_datatype>
   */
  function check_datatype(
    p_value in varchar2,
    p_type in varchar2,
    p_format_mask in varchar2,
    p_accept_null in boolean)
    return boolean
  as
    C_INTEGER_REGEXP constant pit_util.ora_name_type := '^[0-9]+$';
    l_result boolean := true;
    l_format_mask pit_util.ora_name_type;
    l_number number;
    l_date date;
    l_timestamp timestamp with time zone;
    l_xml xmltype;
    l_perform_check boolean;
  begin
    l_format_mask := p_format_mask;
    
    l_perform_check := p_value is not null or not p_accept_null;
    
    if l_perform_check then
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
    end if;
    
    return l_result;
  end check_datatype;


  /**
    Function: get_message_text
      See <PIT_INTERNAL.get_message_text>
   */
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
  
  
  /**
    Function: get_trans_item
      See <PIT_INTERNAL.get_trans_item>
   */
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


  /**
    Function: get_context
      See <PIT_INTERNAL.get_context>
   */
  function get_context
    return pit_util.context_type
  as
  begin
    copy_actual_context_to_global;
    return g_context;
  end get_context;


  /**
    Procedure: set_context
      See <PIT_INTERNAL.set_context>
   */
  procedure set_context(
    p_context in pit_util.context_type)
  as
    l_context pit_util.context_type;
    l_required_context pit_util.ora_name_type;
  begin
    -- Initialize
    l_context := p_context;
    
    -- start by reading the actual session details 
    g_active_adapter.get_session_details(
      p_user_name => g_user_name, 
      p_session_id => g_client_id, 
      p_required_context => l_required_context);
    
    case when l_context.context_name is not null and l_context.settings is null then
      -- Context name passed in, this is the default behaviour
      l_context.context_name := pit_util.harmonize_name(C_CONTEXT_PREFIX, l_context.context_name);
      -- check whether named context exists
      select l_context.context_name
        into l_context.context_name
        from global_context
       where namespace = C_GLOBAL_CONTEXT
         and attribute = l_context.context_name;
    else
      -- Explicit context settings without a context name passed in.
      -- Don't try to read context settings from global context, leave context_name to NULL
      -- to force SET_CONTEXT_IF_CHANGED to check whether new settings apply
      l_context.settings := pit_util.context_type_to_string(l_context);
    end case;
    
    case when l_context.context_name = C_CONTEXT_DEFAULT then
      reset_active_context;
    when l_context.context_name is not null then
      copy_context_to_global(coalesce(l_required_context, l_context.context_name));
      set_context_if_changed(g_context);
    else
      set_context_if_changed(l_context);
    end case;
    
  exception
    when NO_DATA_FOUND then
      handle_error(C_LEVEL_FATAL, C_UNKNOWN_NAMED_CONTEXT, msg_args(l_context.context_name));
    when others then
      handle_error(C_LEVEL_FATAL);
  end set_context;
  
  
  /**
    Procedure: set_context_value
      See <PIT_INTERNAL.set_context_value>
   */
  procedure set_context_value(
    p_name in varchar2,
    p_value in varchar2)
  as
    l_value pit_util.max_sql_char;
    l_required_context pit_util.ora_name_type;
  begin
    g_active_adapter.get_session_details(g_user_name, g_client_id , l_required_context);
    
    if p_value is null then
      utl_context.clear_value(C_GLOBAL_CONTEXT, p_name, g_client_id);
    else
      l_value := substrb(p_value, 1, 4000);
      utl_context.set_value(C_GLOBAL_CONTEXT, p_name, l_value, g_client_id);
    end if;
  end set_context_value;
  
  
  /**
    Function: get_context_value
      See <PIT_INTERNAL.get_context_value>
   */
  function get_context_value(
    p_name in varchar2)
    return varchar2
  as
  begin
    return sys_context(C_GLOBAL_CONTEXT, p_name);
  end get_context_value;
  

  /**
    Procedure: reset_active_context
      See <PIT_INTERNAL.reset_active_context>
   */
  procedure reset_active_context
  as
    l_required_context pit_util.ora_name_type;
  begin
    g_active_adapter.get_session_details(g_user_name, g_client_id, l_required_context);

    utl_context.clear_value(C_GLOBAL_CONTEXT, C_CONTEXT_ACTIVE, g_client_id);
    copy_context_to_global;
    raise_event(
      p_event => C_CONTEXT_EVENT,
      p_context => g_context);
  end reset_active_context;


  /**
    Procedure: reset_context
      See <PIT_INTERNAL.reset_context>
   */
  procedure reset_context
  as
  begin
    utl_context.reset_context(C_GLOBAL_CONTEXT);
    initialize;
  end reset_context;
  
  
  /**
    Procedure: set_collect_mode
      See <PIT_INTERNAL.set_collect_mode>
   */
  procedure set_collect_mode(
    p_mode in boolean)
  as
  begin
    -- initialize
    g_collect_mode := p_mode;
    
    if g_collect_mode then
      g_message_stack.delete;
      g_collect_least_severity := C_LEVEL_ALL;
    else
      case g_collect_least_severity
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
    
    
  /**
    Function: get_collect_mode
      See <PIT_INTERNAL.get_collect_mode>
   */
  function get_collect_mode
    return boolean
  as
  begin
    return g_collect_mode;
  end get_collect_mode;
    
    
  /**
    Function: get_collect_least_severity
      See <PIT_INTERNAL.get_collect_least_severity>
   */
  function get_collect_least_severity
    return binary_integer
  as
  begin
    return g_collect_least_severity;
  end get_collect_least_severity; 
  
  
  /**
    Function: get_message_collection
      See <PIT_INTERNAL.get_message_collection>
   */
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
  
  
  /**
    Function: get_actual_call_stack_depth
      See <PIT_INTERNAL.get_actual_call_stack_depth>
   */
  function get_actual_call_stack_depth
    return pls_integer
  as
  begin
    return g_call_stack.count;
  end get_actual_call_stack_depth;
  
  
  /**
    Function: get_modules
      See <PIT_INTERNAL.get_modules>
   */
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
      copy_actual_context_to_global;
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
  
  
  /**
    Function: get_active_modules
      See <PIT_INTERNAL.get_active_modules>
   */
  function get_active_modules
    return args
    pipelined
  as
    l_idx pit_util.ora_name_type;
  begin
    -- initialize
    copy_actual_context_to_global;
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


  /**
    Function: get_available_modules
      See <PIT_INTERNAL.get_available_modules>
   */
  function get_available_modules
    return args
    pipelined
  as
    l_idx pit_util.ora_name_type;
  begin
    -- initialize
    copy_actual_context_to_global;
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
  
  
  /**
    Function: report_module_status
      See <PIT_INTERNAL.report_module_status>
   */
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
end pit_internal;
/
