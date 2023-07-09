create or replace package body pit_context
as
  /** 
    Package: PIT_CONTEXT Body
      Implementation of generic utitilies for PIT.
   
    Author:: 
      Juergen Sieben, ConDeS GmbH
      
      Published under MIT licence
   */
   
  type context_list_tab is table of pit_context_type index by pit_util.ora_name_type;
  type local_context_tab is table of pit_util.max_sql_char index by pit_util.ora_name_type;
     
   
  /**
    Group: Private constants
   */
  /**
    Constants: Private context constants
      C_GLOBAL_CONTEXT - Name of the global context name for PIT
      C_CONTEXT_TYPE - Paramter that holds the type of the global context
      C_CONTEXT_DEFAULT - Name of the default context
      C_CONTEXT_ACTIVE - Name of the active context
      C_CONTEXT_GROUP - Name of the parameter group for context parameters
   */
  C_PACKAGE_OWNER constant pit_util.ora_name_type := $$PLSQL_UNIT_OWNER;
  C_GLOBAL_CONTEXT constant pit_util.ora_name_type := substr('PIT_CTX_' || C_PACKAGE_OWNER, 1, 128);
  C_CONTEXT_TYPE constant pit_util.ora_name_type := C_GLOBAL_CONTEXT || '_TYPE';
  C_CONTEXT_ACTIVE constant pit_util.ora_name_type := C_CONTEXT_PREFIX || 'ACTIVE';
  C_BASE_MODULE constant pit_util.ora_name_type := 'PIT_MODULE';
  
  C_PARAM_GROUP constant pit_util.ora_name_type := 'PIT';
  C_DELIMITER constant pit_util.sign_type := '|';
  C_LIST_DELIMITER constant pit_util.sign_type := ':';
  C_TOGGLE_PREFIX constant pit_util.ora_name_type := 'TOGGLE_';
  C_ALLOW_TOGGLE constant pit_util.ora_name_type := 'ALLOW_TOGGLE';
  
  C_UNKNOWN_NAMED_CONTEXT constant pit_util.ora_name_type := 'PIT_UNKNOWN_NAMED_CONTEXT';
  C_MODULE_INSTANTIATED constant pit_util.ora_name_type := 'PIT_MODULE_INSTANTIATED';
  C_WARN_IF_UNUSABLE_MODULES constant pit_util.ora_name_type := 'WARN_IF_UNUSABLE_MODULES';
  
  
  /**
    Group: Private Global Variables
   */
  /**
    Variables: Context related variables
      g_client_id - ID of the actually connected client, is necessary for the context to work
      g_context_list - List of avaialable contexts. Is initialized with all existing context upon first usage
      g_local_context - Locale memory structure used as a replacement for a globally accessed context if this does not exist
      g_toggle_list - List of avaialable toggles. Is initialized with the requested context upon first usage
      g_context - Context instance actually in use
      g_all_modules - List of all output modules that are installed
      g_available_modules - List of all modules which are available for logging (meaning: status = msg.MODULE_INSTANTIATED)
      g_active_modules - List of all modules which are available and actually registered for logging
   */
  g_client_id pit_util.ora_name_type;
  g_context_list context_list_tab;
  g_local_context local_context_tab;
  g_context pit_context_type;
  g_all_modules pit_module_tab;
  g_available_modules pit_module_tab;
  g_active_modules pit_module_tab;
  

  /**
    Group: Private Helper Methods
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
      select /*+ result_chache*/ type_name
        from user_types
       where supertype_name = C_BASE_MODULE;
    C_STMT_TEMPLATE constant pit_util.small_char := 'begin :i := new #MODULE#(); end;';
    l_stmt pit_util.small_char;
    l_module_instance pit_module;
  begin
    
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
        -- persist reference to out module in available_modules
        g_available_modules(module.type_name) := l_module_instance;
      end if;
    end loop;
    
    if g_all_modules.count = 0 then
      raise_application_error(-20000, 'No output modules instantiated.');
    end if;    
  end load_modules;
  
  
  /** 
    Function: module_to_meta
      Method to instantiate an instance of <pit_module_meta> from a given module.
      Is used to present an overview of the module status for the installed modules
    
    Returns:
      Instance of <pit_module_meta> with information about the module status.
   */
  function module_to_meta(
    p_module in pit_util.ora_name_type)
    return pit_module_meta
  as
    l_module_meta pit_module_meta;
  begin
    l_module_meta := pit_module_meta(
                       p_module,
                       case when g_available_modules.exists(p_module) then pit_util.C_TRUE else pit_util.C_FALSE end,
                       case when g_active_modules.exists(p_module) then pit_util.C_TRUE else pit_util.C_FALSE end,
                       g_all_modules(p_module).stack
                       );
    return l_module_meta;
  end module_to_meta;


  /** 
    Function: set_active_modules
      Copies all requested and available output module instances into g_active_modules.
      These modules will then be used to log to.
   */
  procedure set_active_modules
  as
    l_module pit_util.ora_name_type;
  begin
    g_active_modules.delete;
    for i in 1 .. g_context.log_modules.count loop
      l_module := g_context.log_modules(i);
      if g_available_modules.exists(l_module) then
        g_active_modules(l_module) := g_available_modules(l_module);
      end if;
    end loop;
  end set_active_modules;


  /** 
    Procedure: read_context_list
      Reads all predefined context and toggles from parameters and stores it in globally accessed context.
      Method is invoked during initialization to copy parameter settings for access across sessions.
   */
  procedure read_context_list
  as
    cursor context_cur is
      with toggles as (
             select C_TOGGLE_PREFIX ||
                    replace(to_char(substr(par_string_value, 1,
                            instr(par_string_value, C_DELIMITER) - 1)), C_LIST_DELIMITER, C_LIST_DELIMITER || C_TOGGLE_PREFIX) tgl_name,
                    C_CONTEXT_PREFIX || to_char(substr(par_string_value, instr(par_string_value, C_DELIMITER) + 1)) ctx_name
               from parameter_v
              where par_id like C_TOGGLE_PREFIX || '%'
                and par_pgr_id = C_PARAM_GROUP),
           contexts as (
             select par_id ctx_name,
                    to_char(par_string_value) string_value
               from parameter_v
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
    l_toggles pit_args;
  begin    
    for ctx in context_cur loop
      -- Switch between Toggles and Contextes
      if ctx.name like C_TOGGLE_PREFIX || '%' then
        l_toggles := pit_util.string_to_table(
                       p_string_value => ctx.name, 
                       p_delimiter => C_LIST_DELIMITER);
        for i in 1 .. l_toggles.count loop
          g_context_list(l_toggles(i)) := pit_context_type(
                                            p_context_name => ctx.name, 
                                            p_settings => ctx.setting);
        end loop;
      else
        g_context_list(ctx.name) := pit_context_type( 
                                      p_context_name => ctx.name,
                                      p_settings => ctx.setting);
      end if;
    end loop;
  end read_context_list;
  
  
  /** 
    Procedure: read_active_context
      Method to read the actually chosen context from the global context. Is used to read the actual settings, 
      as they may have changed based on settings in other sessions.
      
      If the context does not differ from the default settings, the global context is empty. In this case,
      g_context is reset to the default context to detect when a different session reset the logging settings.
   */
  procedure read_active_context
  as
    l_settings pit_util.max_sql_char;
  begin
    $IF pit_admin.C_HAS_GLOBAL_CONTEXT $THEN
    -- Initialize
    l_settings := 
      utl_context.get_value(
        p_context => C_GLOBAL_CONTEXT,
        p_attribute => C_CONTEXT_ACTIVE, 
        p_client_id => g_client_id);
        
    case when l_settings is null then
      g_context := g_context_list(C_CONTEXT_DEFAULT);
    when g_context.trace_settings != l_settings then
      g_context := pit_context_type(
                     p_context_name => C_CONTEXT_ACTIVE,
                     p_settings => l_settings);
    else
      -- no change, existing g_context is active. Ignore
      null;
    end case;
    $ELSE
    -- on initialization, g_context is null, get default context;
    if g_context.context_name is null then
      g_context := g_context_list(C_CONTEXT_DEFAULT);
    end if;
    $END
    set_active_modules;
  end read_active_context;
  
  /**
    Group: Public Methods
   */
  /**
    Function: initialize
      See <pit_context.initialize>
   */
  procedure initialize
  as
    l_context_has_changed boolean;
  begin
    -- instantiate required collections
    g_context := pit_context_type();
    g_context.log_modules := pit_args();
    g_local_context.delete;
    g_all_modules.delete;
    g_available_modules.delete;
    g_active_modules.delete;
    g_context_list.delete;
    
    -- First, load all available output modules, contexts and toggles
    load_modules;
    read_context_list;
    
    -- Set default context or take it from global context
    set_context(
      p_context => null, -- if NULL, set context settings are taken from global context or from default
      p_context_has_changed => l_context_has_changed);
    
    -- Add default context settings
    g_context.allow_toggle := 
      pit_util.to_bool(
        param.get_boolean(
          p_par_id => C_ALLOW_TOGGLE, 
          p_par_pgr_id => C_PARAM_GROUP));                          
    
    $IF pit_admin.C_HAS_GLOBAL_CONTEXT $THEN
    -- Examine whether context settings mandates for client id information
    if param.get_string(
         p_par_id => C_CONTEXT_TYPE, 
         p_par_pgr_id => C_CONTEXT_GROUP) not in (
           utl_context.c_session,
           utl_context.c_force_client_id,
           utl_context.c_force_user_client_id)
    then 
      g_client_id := utl_context.c_no_value;
    end if;
    $END
  end initialize;
  
  
  /**
    Function: get_context
      See <pit_context.get_context>
   */
  function get_context(
    p_context_name in pit_util.ora_name_type default null)
  return pit_context_type
  as
    l_context pit_context_type;
  begin
    read_active_context;
    if p_context_name is not null then
      l_context := g_context_list(p_context_name);
    else
      l_context := g_context;
    end if;
    return l_context;
  end get_context;


  /** 
    Function: get_toggle_context
      See <pit_context.get_toggle_context>
   */
  function get_toggle_context(
    p_module in pit_util.ora_name_type,
    p_action in pit_util.ora_name_type)
  return pit_context_type
  as
    l_toggle_name pit_util.ora_name_type;
    l_context pit_context_type;
  begin  
    if g_context.allow_toggle = pit_util.C_TRUE then
      l_toggle_name := substr(upper(C_TOGGLE_PREFIX || p_module || '.' ||  p_action), 1, pit_util.c_max_length + 1);
      if g_context_list.exists(l_toggle_name) then
        l_context := g_context_list(l_toggle_name);
      else        
        l_toggle_name := upper(C_TOGGLE_PREFIX || p_module);
        if g_context_list.exists(l_toggle_name) then
          l_context := g_context_list(l_toggle_name);
        end if;
      end if;
    else
      l_context := g_context;
    end if;
    
    return l_context;
  end get_toggle_context;
  
  
  /**
    Procedure: set_context
      See <pit_context.set_context>
   */
  procedure set_context(
    p_context_name in varchar2,
    p_context_has_changed out boolean)
  as
   l_context pit_context_type;
  begin
    l_context := g_context_list(pit_util.harmonize_name(C_CONTEXT_PREFIX, p_context_name));
    set_context(l_context, p_context_has_changed);
  exception
    when NO_DATA_FOUND then
      pit_internal.handle_error(pit_internal.C_LEVEL_WARN, C_UNKNOWN_NAMED_CONTEXT, msg_args(p_context_name));
      g_context := g_context_list(C_CONTEXT_DEFAULT);
  end set_context;
  
  
  /**
    Procedure: set_context
      See <pit_context.set_context>
   */
  procedure set_context(
    p_log_level in integer,
    p_trace_level in integer,
    p_trace_timing in pit_util.flag_type,
    p_log_modules in varchar2,
    p_context_has_changed out boolean)
  as
   l_settings pit_util.max_sql_char;
   l_context pit_context_type;
  begin
    l_settings := p_log_level || C_DELIMITER || p_trace_level || C_DELIMITER || p_trace_timing || C_DELIMITER || p_log_modules;
    l_context := pit_context_type(
                   p_context_name => C_CONTEXT_ACTIVE,
                   p_settings => l_settings);
    set_context(l_context, p_context_has_changed);
  end set_context;
  
  
  /**
    Procedure: set_context
      See <pit_context.set_context>
   */
  procedure set_context(
    p_settings in varchar2,
    p_context_has_changed out boolean)
  as
   l_context pit_context_type;
  begin
    l_context := pit_context_type(
                   p_context_name => C_CONTEXT_ACTIVE,
                   p_settings => p_settings);
    set_context(l_context, p_context_has_changed);
  end set_context;
  
  
  /**
    Procedure: set_context
      See <pit_context.set_context>
   */
  procedure set_context(
    p_context in pit_context_type,
    p_context_has_changed out boolean)
  as
  begin
    read_active_context;
    case when p_context is null then
      -- initialization, keep settings from read_active_context
      p_context_has_changed := false;
    when g_context.trace_settings != p_context.trace_settings then
      g_context := p_context;
      set_active_modules;
      p_context_has_changed := true;
    
      $IF pit_admin.C_HAS_GLOBAL_CONTEXT $THEN
      -- Persist changes in context
      if p_context.context_name = C_CONTEXT_DEFAULT then
        utl_context.clear_value(
          p_context => C_GLOBAL_CONTEXT, 
          p_attribute => C_CONTEXT_ACTIVE);
      else
        utl_context.set_value(
          p_context => C_GLOBAL_CONTEXT, 
          p_attribute => C_CONTEXT_ACTIVE, 
          p_value => g_context.trace_settings);
      end if;
      $END
    else
      -- no change detected, use context passed in to maintain its name
      g_context := p_context;
      p_context_has_changed := false;
    end case;
  end set_context;


  /**
    Procedure: get_value
      See <pit_context.get_value>
   */
  function get_value(
    p_attribute in varchar2,
    p_client_id varchar2 default null)
  return varchar2
  as
    l_value pit_util.max_sql_char;
  begin
    $IF pit_admin.C_HAS_GLOBAL_CONTEXT $THEN
    l_value := utl_context.get_value(
                 p_context => C_GLOBAL_CONTEXT,
                 p_attribute => p_attribute,
                 p_client_id => p_client_id);
    $ELSE
    l_value := g_local_context(p_attribute);
    $END
    return l_value;
  exception
    when NO_DATA_FOUND then
      return null;
  end get_value;
  
  
  /**
    Procedure: set_value
      See <pit_context.set_value>
   */
  procedure set_value(
    p_attribute in varchar2,
    p_value in varchar2,
    p_client_id varchar2 default null)
  as
  begin
    $IF pit_admin.C_HAS_GLOBAL_CONTEXT $THEN
    if p_value is not null then
      utl_context.set_value(
        p_context => C_GLOBAL_CONTEXT,
        p_attribute => p_attribute,
        p_value => p_value,
        p_client_id => p_client_id);
    else
      utl_context.clear_value(
        p_context => C_GLOBAL_CONTEXT,
        p_attribute => p_attribute,
        p_client_id => p_client_id);
    end if;
    $ELSE
    if p_value is not null then
      g_local_context(p_attribute) := p_value;
    else
      if g_local_context.exists(p_attribute) then
        g_local_context.delete(p_attribute);
      end if;
    end if;
    $END
  end set_value;
  
  
  /**
    Procedure: log_me
      See <pit_context.log_me>
   */
  function log_me(
    p_severity in pit_message.pms_pse_id%type)
  return boolean
  as
  begin
    read_active_context;
    return p_severity <= greatest(g_context.log_level, pit_internal.C_LEVEL_ERROR);
  end log_me;
  
  
  /**
    Procedure: trace_me
      See <pit_context.trace_me>
   */
  function trace_me(
    p_trace_level in integer)
  return boolean
  as
  begin
    read_active_context;
    return p_trace_level <= g_context.trace_level;
  end trace_me;
  
  
  /**
    Procedure: trace_timing
      See <pit_context.trace_timing>
   */
  function trace_timing
  return boolean
  as
  begin
    read_active_context;
    return pit_util.to_bool(g_context.trace_timing);
  end trace_timing;
  
  
  /**
    Procedure: allows_toggle
      See <pit_context.allows_toggle>
   */
  function allows_toggle
  return boolean
  as
  begin
    return pit_util.to_bool(g_context.allow_toggle);
  end allows_toggle;
  
  
  /**
    Function: get_log_level
      See <PIT_CONTEXT.get_log_level>
   */
  function get_log_level
  return binary_integer
  as
  begin
    read_active_context;
    return greatest(g_context.log_level, pit_internal.C_LEVEL_ERROR);
  end get_log_level;
  
  
  /**
    Function: get_trace_level
      See <PIT_CONTEXT.get_trace_level>
   */
  function get_trace_level
  return binary_integer
  as
  begin
    read_active_context;
    return g_context.trace_level;
  end get_trace_level;
  
  
  /**
    Procedure: get_modules
      See <pit_context.get_modules>
   */
  function get_modules(
    p_focus in binary_integer)
  return pit_module_list
  as
    l_module_list pit_module_list;
    l_module pit_util.ora_name_type;
    l_module_available pit_util.flag_type;
    l_module_active pit_util.flag_type;
    l_module_stack pit_util.max_char;
  begin
    -- initialize
    l_module_list := pit_module_list();
    read_active_context;    
    
    case p_focus
    when C_FOCUS_ALL_MODULES then
      l_module := g_all_modules.first;
      while l_module is not null loop
        l_module_list.extend();
        l_module_list(l_module_list.count) := module_to_meta(l_module);
        l_module := g_all_modules.next(l_module);
      end loop;
    when C_FOCUS_AVAILABLE_MODULES then
      l_module := g_available_modules.first;
      while l_module is not null loop
        l_module_list.extend();
        l_module_list(l_module_list.count) := module_to_meta(l_module);
        l_module := g_available_modules.next(l_module);
      end loop;
    when C_FOCUS_ACTIVE_MODULES then
      l_module := g_active_modules.first;
      while l_module is not null loop
        l_module_list.extend();
        l_module_list(l_module_list.count) := module_to_meta(l_module);
        l_module := g_active_modules.next(l_module);
      end loop;
    when C_FOCUS_UNAVAILABLE_MODULES then
      l_module := g_all_modules.first;
      while l_module is not null loop
        if g_all_modules(l_module).status != C_MODULE_INSTANTIATED then
          l_module_list.extend();
          l_module_list(l_module_list.count) := module_to_meta(l_module);
        end if;
        l_module := g_all_modules.next(l_module);
      end loop;
    else
      null;
    end case;
    return l_module_list;
  end get_modules;
  
  /**
    Function: get_available_modules
      See <PIT_INTERNAL.get_available_modules>
   */
  function get_available_modules
  return pit_module_tab
  as
  begin
    return g_available_modules;
  end get_available_modules;
  
  /**
    Function: get_active_modules
      See <PIT_INTERNAL.get_active_modules>
   */
  function get_active_modules
  return pit_module_tab
  as
  begin
    return g_active_modules;
  end get_active_modules;
  
  
  /**
    Function: get_active_module_list
      See <PIT_INTERNAL.get_active_module_list>
   */
  function get_active_module_list
  return varchar2
  as
    l_module pit_util.ora_name_type;
    l_module_list pit_util.max_char;
  begin
    l_module := g_active_modules.FIRST;
    l_module_list := l_module;
    l_module := g_active_modules.NEXT(l_module);
    while l_module is not null loop
      l_module_list := l_module_list || ',' || l_module;
      l_module := g_active_modules.NEXT(l_module);
    end loop;
    return l_module_list;
  end get_active_module_list;
  
  /**
    Function: report_module_status
      See <PIT_INTERNAL.report_module_status>
   */
  function report_module_status
  return pit_args pipelined
  as
    C_MESSAGE_TEMPLATE constant pit_util.max_sql_char := q'|Status of #IDX#: #STATUS#, Threshold: #THRESHOLD#|';
    l_idx binary_integer;
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
  
  
  /**
    Procedure: validate_context
      See <PIT_INTERNAL.validate_context>
   */
  procedure validate_context(
    p_settings in varchar2)
  as
    l_args pit_args;
    l_log_modules pit_args;
  begin
    if p_settings is null then
      raise_application_error(-20004, 'Settings missing');
    end if;
    if p_settings not like '__|__|_|%' then      
      raise_application_error(-20004, p_settings || ': Settings format invalid.');
    end if;
    
    l_args := pit_util.string_to_table(
                p_string_value => p_settings,
                p_delimiter => C_DELIMITER);
                
    if to_number(l_args(1)) not in (10, 20, 30, 40, 50, 60, 70) then
      raise invalid_log_level;
    end if;
    if to_number(l_args(2)) not in (10, 20, 30, 40, 50) then
      raise invalid_trace_level;
    end if;
    if l_args(3) not in (pit_util.C_TRUE, pit_util.C_FALSE) then
      raise invalid_trace_flag;
    end if;
    if l_args(4) is not null then
      if instr(l_args(4), ',') > 0 then
        l_log_modules := pit_util.string_to_table(l_args(4), ',');
      else
        l_log_modules := pit_util.string_to_table(l_args(4));
      end if;
      for i in 1 .. l_log_modules.count loop
        if not g_all_modules.exists(l_log_modules(i)) then
          raise_application_error(-20003, 'Unknown log module ' || l_log_modules(i));
        end if;
      end loop;
    end if;
  end validate_context;
  
  
  /**
    Procedure: instantiate_pit_context_type
      See <pit_context.instantiate_pit_context_type>
   */
  procedure instantiate_pit_context_type(
    p_self in out nocopy pit_context_type,
    p_settings in varchar2,
    p_context_name in varchar2 default null)
  as
    l_args pit_args;
  begin
    validate_context(p_settings);
    l_args := pit_util.string_to_table(
                p_string_value => p_settings,
                p_delimiter => C_DELIMITER);
    
    p_self.context_name := pit_util.harmonize_name(C_CONTEXT_PREFIX, coalesce(p_context_name, C_CONTEXT_ACTIVE));
    p_self.log_level := to_number(l_args(1));
    p_self.trace_level := to_number(l_args(2));
    p_self.trace_timing := l_args(3);
    p_self.log_modules := pit_util.string_to_table(l_args(4));
    p_self.trace_settings := p_settings;
  exception
    when others then
      dbms_output.put_line('Unknown error at ' || p_settings || ': ' || substr(sqlerrm, 12));
      raise;
  end instantiate_pit_context_type;
  
begin
  initialize;
end pit_context;
/