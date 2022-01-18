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
    Type: client_info_t
      Subtype of VARCHAR2, limited to 64 byte.
   */
  subtype client_info_t is varchar2(64 byte);

  /**
    Group: Private constants
   */
  /**
    Constants: Parameter constants
      C_PARAM_GROUP - Name of the parameter group for PIT
      C_BASE_MODULE - Typename of the abstract output module
      C_WARN_IF_UNUSABLE_MODULES - Parameter name that controls if PIT warns in case a module is unusable
      C_LOG_STATE_THRESHOLD - Parameter name that holds the default threshold for the <log_state> method
   */
  C_PARAM_GROUP constant pit_util.ora_name_type := 'PIT';
  C_LOG_STATE_THRESHOLD constant pit_util.ora_name_type := 'LOG_STATE_THRESHOLD';
  
  
  /**
    Message constants to avoid dependency from MSG package
   */
  C_FAIL_MODULE_INIT constant pit_util.ora_name_type := 'PIT_FAIL_MODULE_INIT';
  C_FAIL_MESSAGE_CREATION constant pit_util.ora_name_type := 'PIT_FAIL_MESSAGE_CREATION';
  C_FAIL_MESSAGE_PURGE constant pit_util.ora_name_type := 'PIT_FAIL_MESSAGE_PURGE';
  C_MSG_NOT_EXISTING constant pit_util.ora_name_type := 'PIT_MSG_NOT_EXISTING';
  C_BULK_ERROR constant pit_util.ora_name_type := 'PIT_BULK_ERROR';
  C_BULK_FATAL constant pit_util.ora_name_type := 'PIT_BULK_FATAL';
  C_STOP_BULK_ON_FATAL constant pit_util.ora_name_type := 'PIT_STOP_BULK_ON_FATAL';
  
  C_BROADCAST_CONTEXT_SWITCH constant pit_util.ora_name_type := 'BROADCAST_CONTEXT_SWITCH';

  /**
    Constants: Private adapter constants
      C_ADAPTER_PREFERENCE - Name of the parameter that stores the adapter preference
      C_ADAPTER_OK - Flag to indicate that the adapter is usable
   */
  C_ADAPTER_PREFERENCE constant pit_util.ora_name_type := 'ADAPTER_PREFERENCE';
  C_ADAPTER_OK constant pit_util.flag_type := pit_util.C_TRUE;

  /**
    Constants: "Event" constants
      C_CONTEXT_EVENT - Context changed event
      C_LOG_EVENT - Log event
      C_PURGE_EVENT - Purge event
      C_PRINT_EVENT - Print event
      C_ENTER_EVENT - Enter event
      C_LEAVE_EVENT - Leave event
      C_NOTIFY_EVENT - Notify event
      C_LOG_STATE_EVENT - Log state event
   */
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
      g_active_message - Actual message. Stored globally to allow for reuse of last raised message
      g_active_adapter - Adapter in use (Default Adapter or any other adapter as preferred by parameter <C_ADAPTER_PREFERENCE>
      g_user_name - Actual username to avoid roundtrips to SQL function USER
      g_client_info - Instance of <client_info_t> holding information about the actually connected client such as its session id. Used to filter a globally accessed context
      g_collect_mode - Flag to indicate whether PIT is in collect mode
      g_message_stack - List of messages raised since PIT is in collect mode
      g_collect_least_severity - Least severity so far (meaning the most severe message)
      g_stop_bulk_on_fatal - Flag to indicate whether collect mode has to be left if a fatal exception occurs
      g_log_state_threshold - Cache for parameter <C_LOG_STATE_THRESHOLD>
   */
  g_active_message message_type;
  
  g_active_adapter pit_default_adapter;
  g_user_name pit_util.ora_name_type;
  g_client_info client_info_t;
  
  g_collect_mode boolean;
  g_message_stack pit_message_table;
  g_collect_least_severity binary_integer;
  g_stop_bulk_on_fatal boolean;
  
  g_log_state_threshold pls_integer;
  g_broadcast_context_switch boolean;


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
    C_STMT_TEMPLATE constant varchar2(200) := 'begin :a := new #ADAPTER#(); end;';
    l_adapter_list pit_args;
    l_adapter pit_default_adapter;
    l_idx pit_util.ora_name_type;
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
    Procedure: raise_event
      Central method to distribute any message to all actively parameterized output modules.
      Called internally as a generic helper to throw messages to output modules
      
    Parameters:
      p_event - Integer indicating the type of "event" (i.e. <C_LOG_EVENT>|<C_PRINT_EVENT>|<C_ENTER_EVENT> etc.) thrown by PIT
      p_message - Instance of <MESSAGE_TYPE>, the message to pass to the output modules
      p_call_stack - Optional instance of the actual call stack in the event of <C_ENTER_EVENT>|<C_LEAVE_EVENT>
      p_log_state - Optional instance of <PIT_LOG_STATE_TYPE> with the key-value-pairs to pass to the output modules
      p_context - Optional iInstance of <PIT_CONTEXT_TYPE> with the actual context settings
      p_date_before - Optional date indicating the point in time, up to when the log is to be purged
      p_severity_lower_equal - Optional severity to limit the amount of log entries to purge
   */
  procedure raise_event(
    p_event in pls_integer,
    p_message in message_type default null,
    p_call_stack in pit_call_stack_type default null,
    p_log_state in pit_log_state_type default null,
    p_context in pit_context_type default null,
    p_date_before in date default null,
    p_severity_lower_equal in pls_integer default null)
  as
    pragma autonomous_transaction;
    l_idx pit_util.ora_name_type;
    l_modules pit_context.pit_module_tab;
  begin
  
    -- Adjust list of output modules
    if p_event = C_CONTEXT_EVENT and g_broadcast_context_switch then
      l_modules := pit_context.get_available_modules;
    else 
      l_modules := pit_context.get_active_modules;
    end if;
    
    -- propagate event to output modules
    l_idx := l_modules.first;
    while l_idx is not null loop
      case p_event
        when C_CONTEXT_EVENT then
          l_modules(l_idx).context_changed(p_context);
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
    Procedure: set_context
      Helper method to set the context and raise a changed event if required
      
    Parameters:
      p_context - Instance of <pit_context_type> with the context to set
   */
  procedure set_context(
    p_context in pit_context_type)
  as
    l_context_has_changed boolean;
  begin
    if p_context is not null then
      pit_context.set_context(
        p_context => p_context, 
        p_context_has_changed => l_context_has_changed);  
      if l_context_has_changed then
        raise_event(
          p_event => C_CONTEXT_EVENT,
          p_context => p_context);
      end if;
    end if;
  end set_context;  
  
  
  /**
    Group: Public methods
   */
  /**
    Procedure: initialize
      See <PIT_INTERNAL.initialize>
   */
  procedure initialize
  as
    l_unavailable_modules pit_module_list;
  begin
    -- Read static parameters
    g_log_state_threshold := param.get_integer(
                               p_par_id => C_LOG_STATE_THRESHOLD,
                               p_par_pgr_id => C_PARAM_GROUP);
                               
    g_stop_bulk_on_fatal := param.get_boolean(
                              p_par_id => C_STOP_BULK_ON_FATAL,
                              p_par_pgr_id => C_PARAM_GROUP);
                              
    g_broadcast_context_switch := param.get_boolean(
                                    p_par_id => C_BROADCAST_CONTEXT_SWITCH, 
                                    p_par_pgr_id => C_PARAM_GROUP);
                                    
    g_collect_mode := false;
    g_collect_least_severity := C_LEVEL_ALL;
    
    -- initialize helper packages
    pit_context.initialize;
    pit_call_stack.initialize;
    g_message_stack := pit_message_table();
    
    load_adapter;

    -- starting here, PIT is initialized and prepared to create messages
    -- report any unavailable modules if so parameterized
    l_unavailable_modules := pit_context.get_modules(pit_context.C_FOCUS_UNAVAILABLE_MODULES);
    for i in 1 .. l_unavailable_modules.count loop
      log_event(C_LEVEL_WARN, C_FAIL_MODULE_INIT, msg_args(l_unavailable_modules(i).module_name, l_unavailable_modules(i).module_stack));    
    end loop;
  end initialize;
  
  
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
    if pit_context.log_me(p_severity) then
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
    if pit_context.log_me(coalesce(p_severity, g_log_state_threshold)) then
      raise_event(
        p_event => C_LOG_STATE_EVENT,
        p_log_state => pit_log_state_type(p_severity, p_params));
    end if;
  end log_state;


  /**
    Procedure: log_explicit
      See <PIT_INTERNAL.log_explicit>
   */
  procedure log_explicit(
    p_message_name in pit_util.ora_name_type,
    p_affected_id in pit_util.max_sql_char,
    p_error_code in varchar2,
    p_msg_args in msg_args,
    p_log_threshold in pit_message.pms_pse_id%type,
    p_log_modules in pit_util.max_sql_char)
  as
    l_preset_context pit_context_type;
    l_context_has_changed boolean;
  begin
    -- initialize
    g_active_message := get_message(p_message_name, p_msg_args, p_affected_id, p_error_code);
    
    if g_active_message.severity <= coalesce(p_log_threshold, C_LEVEL_ALL) then
      -- temporarily set the new context without raising the context change event
      l_preset_context := pit_context.get_context;
      pit_context.set_context(
        p_log_level => p_log_threshold,
        p_trace_level => l_preset_context.trace_level,
        p_trace_timing => l_preset_context.trace_timing,
        p_log_modules => p_log_modules,
        p_context_has_changed => l_context_has_changed);
        
      raise_event(
        p_event => C_LOG_EVENT,
        p_message => g_active_message);
        
      pit_context.set_context(
        p_context => l_preset_context,
        p_context_has_changed => l_context_has_changed);
    end if;
  end log_explicit;


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
    l_allows_toggle boolean;
    l_context pit_context_type;
    l_call_stack pit_call_stack_type;
  begin
    
    -- Initialize
    l_trace_me := pit_context.trace_me(p_trace_level);
    l_allows_toggle := pit_context.allows_toggle;
    l_action := p_action;
    
    -- reset active message to null, as this is a "normal" PL/SQL call that requires resetting any exception
    g_active_message := null;
    
    -- Do minimal tracing if context toggle is active
    if l_allows_toggle or l_trace_me then
      pit_util.get_module_and_action(
        p_module => l_module,
        p_action => l_action);
        
      l_context := pit_context.get_toggle_context(
                     p_module => l_module, 
                     p_action => l_action);
      set_context(l_context);
      
      l_call_stack := pit_call_stack.push_stack(
        p_user_name => g_user_name,
        p_session_id => g_client_info,
        p_module => l_module,
        p_action => l_action,
        p_client_info => p_client_info,
        p_params => p_params,
        p_trace_level => p_trace_level,
        p_trace_context => l_context);

      raise_event(
        p_event => C_ENTER_EVENT,
        p_call_stack => l_call_stack);
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
    p_severity in binary_integer default null)
  is
    l_call_stack pit_call_stack.pit_call_stack_tab;
    l_context_has_changed boolean;
    l_trace_me boolean;
    l_allows_toggle boolean;
  begin
    -- Initialize
    l_trace_me := pit_context.trace_me(p_trace_level);
    l_allows_toggle := pit_context.allows_toggle;
    
    -- Do minimal tracing if context toggle is active
    if l_allows_toggle or l_trace_me or p_severity is not null then
      -- popping an entry from the call stack can lead to multiple call stack entries to be popped.
      -- Log any of these
      l_call_stack := pit_call_stack.pop_stack(p_params, p_severity);
      
      for i in 1 .. l_call_stack.count loop
        -- Restore last context settings
        set_context(l_call_stack(i).trace_context);
        
        raise_event(
          p_event => C_LEAVE_EVENT,
          p_call_stack => l_call_stack(i));
      end loop;
    end if;
    
  exception
    when others then
      handle_error(C_LEVEL_ERROR, C_FAIL_MESSAGE_CREATION);
  end leave;


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
    l_preset_context pit_context_type;
    l_context_has_changed boolean;
  begin
    -- initialize
    g_active_message := get_message(p_message_name, p_msg_args, p_affected_id, null);
    
    if g_active_message.severity <= coalesce(p_log_threshold, C_LEVEL_ALL) then
      -- temporarily set the new context without raising the context change event
      l_preset_context := pit_context.get_context;
      pit_context.set_context(
        p_log_level => p_log_threshold,
        p_trace_level => l_preset_context.trace_level,
        p_trace_timing => l_preset_context.trace_timing,
        p_log_modules => p_log_modules,
        p_context_has_changed => l_context_has_changed);

      raise_event(
        p_event => C_NOTIFY_EVENT,
        p_message => g_active_message);
        
      pit_context.set_context(
        p_context => l_preset_context,
        p_context_has_changed => l_context_has_changed);
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
      raise_error(C_LEVEL_FATAL, p_message_name, p_msg_args, p_affected_id, p_error_code);
    else
      g_active_message := null;
    end if;
    leave(C_TRACE_MANDATORY, p_params, p_severity);
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
                   p_session_id => g_client_info,
                   p_user_name => g_user_name,
                   p_msg_args => p_msg_args);
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
    Procedure: set_context
      See <PIT_INTERNAL.set_context>
   */
  procedure set_context(
    p_context_name in varchar2 default null,
    p_log_level in integer default null,
    p_trace_level in integer default null,
    p_trace_timing in boolean default null,
    p_log_modules in varchar2 default null)
  as
    l_settings pit_util.max_sql_char;
    l_required_context pit_util.ora_name_type;
    l_context_has_changed boolean;
  begin    
    -- start by reading the actual session details 
    g_active_adapter.get_session_details(
      p_user_name => g_user_name, 
      p_session_id => g_client_info, 
      p_required_context => l_required_context);
      
    l_required_context := coalesce(l_required_context, p_context_name);
    
    if l_required_context is not null then
      pit_context.set_context(
        p_context_name => l_required_context,
        p_context_has_changed => l_context_has_changed);    
    else
      pit_context.set_context(
        p_log_level => p_log_level,
        p_trace_level => p_trace_level,
        p_trace_timing => pit_util.to_bool(p_trace_timing),
        p_log_modules => p_log_modules,
        p_context_has_changed => l_context_has_changed);
    end if;
      
    if l_context_has_changed then
      raise_event(
        p_event => C_CONTEXT_EVENT,
        p_context => pit_context.get_context);
    end if;    
  exception
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
    g_active_adapter.get_session_details(g_user_name, g_client_info , l_required_context);
    
    if p_value is null then
      pit_context.set_value(p_name, null, g_client_info);
    else
      l_value := substrb(p_value, 1, 4000);
      pit_context.set_value(p_name, l_value, g_client_info);
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
    return pit_context.get_value(p_name);
  end get_context_value;
  
  
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


begin
  initialize;
end pit_internal;
/
