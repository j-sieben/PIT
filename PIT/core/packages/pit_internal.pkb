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
  subtype severity_t is number(2,0);

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
  C_PIT_PANIC constant pit_util.ora_name_type := 'PIT_PANIC';
  
  
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
  C_TWEET_REALMS constant pit_util.ora_name_type := 'PIT_TWEET_REALMS';

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
      C_LOG_EXCEPTION_EVENT - Log event
      C_PURGE_EVENT - Purge event
      C_PRINT_EVENT - Print event
      C_ENTER_EVENT - Enter event
      C_LEAVE_EVENT - Leave event
      C_NOTIFY_EVENT - Notify event
      C_LOG_STATE_EVENT - Log state event
   */
  C_CONTEXT_EVENT constant integer := 1;
  C_LOG_VALIDATION_EVENT constant integer := 2;
  C_LOG_EXCEPTION_EVENT constant integer := 3;
  C_LOG_STATE_EVENT constant integer := 4;
  C_PURGE_EVENT constant integer := 5;
  C_PRINT_EVENT constant integer := 6;
  C_ENTER_EVENT constant integer := 7;
  C_LEAVE_EVENT constant integer := 8;
  C_NOTIFY_EVENT constant integer := 9;
  C_TWEET_EVENT constant integer := 10;
  C_PANIC_EVENT constant integer := 11;
  
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
  g_schema_name pit_util.ora_name_type;
  g_client_id pit_util.ora_name_type;
  g_client_info client_info_t;
  
  g_collect_mode boolean;
  g_message_stack pit_message_table;
  type least_severity_list is table of severity_t index by pit_util.ora_name_type;
  g_collect_least_severity least_severity_list;
  g_stop_bulk_on_fatal boolean;
  
  g_log_state_threshold pls_integer;
  g_broadcast_context_switch boolean;
  g_raise_tweet boolean;
  
  /**
    Group: Private adapter maintenance methods
   */
  /**
    Procedure: log_internal
      Method to log PIT-internal errors or warnings. Those messages are not passed
      to output modules but saved in PIT_INTERNAL_LOG, as an output module may not
      be available due to an internal error.
      
    Parameters:
      p_pil_msg_text - Message to log. Is not based on a PIT message but harcoded text
      p_pil_affected_id - Optional ID of an internal entity, May be the name of an output module
   */
  procedure log_internal(
    p_pil_msg_text in pit_internal_log.pil_msg_text%type,
    p_pil_affected_id in pit_internal_log.pil_affected_id%type)
  as
    pragma autonomous_transaction;
  begin
    insert into pit_internal_log(pil_msg_text, pil_affected_id, pil_msg_stack, pil_msg_backtrace)
    values (p_pil_msg_text, p_pil_affected_id, pit_util.get_call_stack, pit_util.get_error_stack);
    
    commit;
  exception
    when others then
      rollback;
      raise;
  end log_internal;
  
  
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
    
    -- find an set first available session adapter
    while l_idx is not null loop
      begin
        l_stmt := replace(C_STMT_TEMPLATE, '#ADAPTER#', l_adapter_list(l_idx));
        execute immediate l_stmt using out l_adapter;
      exception
        when others then
           log_internal('Error instantiating adapter."', l_adapter_list(l_idx));
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
    l_error_code pit_util.ora_name_type;
  begin
    l_error_code := coalesce(p_message.error_code, p_message.message_name);
    -- remember most severe severity per error code of that collection run
    if g_collect_least_severity.exists(l_error_code) then
      g_collect_least_severity(l_error_code) := least(g_collect_least_severity(l_error_code), p_message.severity);
    else
      g_collect_least_severity(l_error_code) := p_message.severity;
    end if;
    
    if g_stop_bulk_on_fatal and g_collect_least_severity(l_error_code) = C_LEVEL_FATAL then
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
      p_event - Integer indicating the type of "event" (i.e. <C_LOG_EXCEPTION_EVENT>|<C_PRINT_EVENT>|<C_ENTER_EVENT> etc.) thrown by PIT
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
    if (p_event = C_CONTEXT_EVENT and g_broadcast_context_switch )
       or (p_event = C_TWEET_EVENT) 
    then
      l_modules := pit_context.get_available_modules;
    else 
      l_modules := pit_context.get_active_modules;
    end if;
    
    -- propagate event to output modules
    l_idx := l_modules.last;
    while l_idx is not null loop
      begin
        case p_event
          when C_CONTEXT_EVENT then
            l_modules(l_idx).context_changed(p_context);
          when C_LOG_VALIDATION_EVENT then
            l_modules(l_idx).log_validation(p_message);
          when C_LOG_EXCEPTION_EVENT then
            l_modules(l_idx).log_exception(p_message);
          when C_LOG_STATE_EVENT then
            l_modules(l_idx).log_state(p_log_state);
          when C_PURGE_EVENT then
            l_modules(l_idx).purge_log(p_date_before, p_severity_lower_equal);
          when C_PRINT_EVENT then
            l_modules(l_idx).print(p_message);
          when C_NOTIFY_EVENT then
            l_modules(l_idx).notify(p_message);
          when C_ENTER_EVENT then
            l_modules(l_idx).enter(p_call_stack);
          when C_LEAVE_EVENT then
            l_modules(l_idx).leave(p_call_stack);
          when C_TWEET_EVENT then
            l_modules(l_idx).tweet(p_message);
          when C_PANIC_EVENT then
            l_modules(l_idx).panic(p_message);
          else
            null;
        end case;
      exception
        when others then
          log_internal('Error when raising an event to output module', l_idx);
      end;
      l_idx := l_modules.prior(l_idx);
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
    Function: get_error_for_message_name
      Method accepts a message name and a default error message name. It checks
      whether the message name passed in represents a message with an exception
      object. If so, it passes its name back and p_default_error otherwise.
      
    Parameters:
      p_message_name - Name of the message that is checked for an exception
      p_default_error - Name of the message that represents an error
      
    Returns:
      Name of the message that is thrown as an error
   */
  function get_error_for_message_name(
    p_message_name in pit_util.ora_name_type,
    p_default_error in pit_util.ora_name_type)
    return pit_util.ora_name_type
  as
    l_pms_name pit_message.pms_name%type;
  begin
    select pms_name
      into l_pms_name
      from pit_message
     where pms_id = p_message_name
       and pms_custom_error is not null;
       
    return l_pms_name;
  exception
    when NO_DATA_FOUND then
      return p_default_error;
  end get_error_for_message_name;
  
  
  /**
    Procedure: log_panic
      See <PIT_INTERNAL.log_panic>
   */
  procedure log_panic
  as
  begin
    g_active_message := get_message(
                          p_message_name => C_PIT_PANIC, 
                          p_msg_args => null, 
                          p_affected_id => null, 
                          p_error_code => null, 
                          p_read_only => false);
    raise_event(
      p_event => C_PANIC_EVENT,
      p_message => g_active_message);
  end log_panic;
  
  
  procedure initialize
  as
  begin
    if g_log_state_threshold is null then
      initialize_pit;
    end if;
  end initialize;
  
  
  /**
    Group: Public methods
   */
  /**
    Procedure: initialize_pit
      See <PIT_INTERNAL.initialize_pit>
   */
  procedure initialize_pit
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
    g_raise_tweet := instr(
                       param.get_string(C_TWEET_REALMS, C_PARAM_GROUP), 
                       param.get_string('REALM', C_PARAM_GROUP)) > 0;
                                    
    g_collect_mode := false;
    g_collect_least_severity.delete;
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
    
  end initialize_pit;
  
  
  /**
    Procedure: tweet
      See <PIT_INTERNAL.tweet>
   */
  procedure tweet(
    p_message in varchar2)
  as
    l_message message_type;
    l_affected_id pit_util.max_sql_char;
    l_error_code pit_util.max_sql_char;
  begin
    if g_raise_tweet then
      l_message := get_message(
                      p_message_name => msg.PIT_TWEET, 
                      p_msg_args => msg_args(p_message), 
                      p_affected_id => l_affected_id, 
                      p_error_code => l_error_code);
      raise_event(
        p_event => C_TWEET_EVENT,
        p_message => l_message);
    end if;
  end tweet;
  
  
  /**
    Procedure: log_event
      See <PIT_INTERNAL.log_event>
   */
  procedure log_event(
    p_severity in pls_integer,
    p_message_name in pit_util.ora_name_type default null,
    p_msg_args in msg_args default null,
    p_affected_id in pit_util.max_sql_char default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null)
  as
  begin
    if pit_context.log_me(p_severity) then
      case when p_message_name is not null then
        -- instantiate message
        g_active_message := get_message(
                              p_message_name => p_message_name, 
                              p_msg_args => p_msg_args, 
                              p_affected_id => p_affected_id, 
                              p_error_code => p_error_code, 
                              p_read_only => false);
        -- Persist severity of calling environment with message
        g_active_message.severity := least(p_severity, g_active_message.severity);
      when g_active_message is not null then
        -- message has been raised as an error before, use g_active_message
        -- call stack is filled only after an error has been raised, so get it again
        g_active_message.stack := pit_util.get_call_stack;
        g_active_message.backtrace := pit_util.get_error_stack;
      when p_severity <= C_LEVEL_ERROR then
        -- fallback, is used if a SQL exception was raised outside of PIT
        g_active_message := get_message(
                              p_message_name => 'PIT_SQL_ERROR', 
                              p_msg_args => p_msg_args, 
                              p_affected_id => p_affected_id, 
                              p_error_code => p_error_code, 
                              p_read_only => false);
      else 
        -- if used with HANDLE_EXCEPTION, code may re raise the exception explicitly
        null;
      end case;

      if g_collect_mode then
        push_message(g_active_message);
      else
        raise_event(
          p_event => C_LOG_EXCEPTION_EVENT,
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
    p_affected_ids in msg_params default null,
    p_error_code in varchar2,
    p_msg_args in msg_args,
    p_log_threshold in pit_message.pms_pse_id%type,
    p_log_modules in pit_util.max_sql_char)
  as
    l_preset_context pit_context_type;
    l_context_has_changed boolean;
    l_log_level binary_integer;
  begin
    -- initialize
    g_active_message := get_message(
                          p_message_name => 'PIT_SQL_ERROR', 
                          p_msg_args => p_msg_args, 
                          p_affected_id => p_affected_id, 
                          p_error_code => p_error_code, 
                          p_read_only => false);
    l_log_level := coalesce(p_log_threshold, C_LEVEL_ALL);
    
    if g_active_message.severity <= l_log_level then
      -- temporarily set the new context without raising the context change event
      l_preset_context := pit_context.get_context;
      pit_context.set_context(
        p_log_level => l_log_level,
        p_trace_level => l_preset_context.trace_level,
        p_trace_timing => l_preset_context.trace_timing,
        p_log_modules => coalesce(p_log_modules, pit_util.table_to_string(l_preset_context.log_modules)),
        p_context_has_changed => l_context_has_changed);
      
      raise_event(
        p_event => C_LOG_EXCEPTION_EVENT,
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
    l_required_context pit_util.ora_name_type;
  begin
    -- Initialize
    -- start by reading the actual session details 
    g_active_adapter.get_session_details(
      p_user_name => g_user_name, 
      p_session_id => g_client_info, 
      p_required_context => l_required_context);
    
    if l_required_context is not null then
      set_context(l_required_context);
    end if;
      
    l_trace_me := pit_context.trace_me(p_trace_level);
    l_allows_toggle := pit_context.allows_toggle;
    l_action := p_action;
    
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
      g_active_message := get_message(
                              p_message_name => 'PIT_SQL_ERROR', 
                              p_msg_args => p_msg_args, 
                              p_affected_id => null, 
                              p_error_code => null);
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
    p_affected_ids in msg_params default null,
    p_msg_args in msg_args,
    p_log_threshold in pit_message.pms_pse_id%type,
    p_log_modules in pit_util.max_sql_char)
  as
    l_preset_context pit_context_type;
    l_context_has_changed boolean;
  begin
    -- initialize
    g_active_message := get_message(
                              p_message_name => 'PIT_SQL_ERROR', 
                              p_msg_args => p_msg_args, 
                              p_affected_id => p_affected_id, 
                              p_affected_ids => p_affected_ids, 
                              p_error_code => null, 
                              p_read_only => false);
    
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
    Procedure: raise_validation_error
      See <PIT_INTERNAL.raise_validation_error>
   */
  procedure raise_validation_error(
    p_error_name pit_util.ora_name_type,
    p_message_name pit_util.ora_name_type,
    p_msg_args in msg_args,
    p_affected_id in pit_util.max_sql_char,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2)
  as
    l_error_message message_type;
  begin
    g_active_message := get_message(coalesce(p_message_name, p_error_name), p_msg_args, p_affected_id, p_affected_ids, p_error_code);
    l_error_message := get_message(p_error_name, null, null, null, null);
    
    if g_collect_mode then
      g_active_message.severity := least(
                                     l_error_message.severity, 
                                     coalesce(g_active_message.severity, l_error_message.severity)); 
      push_message(g_active_message);      
    else
      raise_application_error(
        l_error_message.error_number,
        dbms_lob.substr(g_active_message.message_text, 2048, 1));    
    end if;
  end raise_validation_error;


  /**
    Procedure: raise_error
      See <PIT_INTERNAL.raise_error>
   */
  procedure raise_error(
    p_severity in pls_integer,
    p_message_name pit_util.ora_name_type,
    p_msg_args in msg_args,
    p_affected_id in pit_util.max_sql_char,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2)
  as
  begin
    -- P_MESSAGE_NAME could be NULL, we use G_ACTIVE_MESSAGE then
    if p_message_name is not null then
      g_active_message := get_message(p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code, false);
      g_active_message.severity := p_severity;
      g_active_message.error_number := coalesce(g_active_message.error_number, -20000);
    end if;
    
    if p_severity <= C_LEVEL_SEVERE then
      -- Log severe or fatal errors immediately so they are monitored even if no exception handler is present
      raise_event(
        p_event => C_LOG_EXCEPTION_EVENT,
        p_message => g_active_message);
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
    Procedure: handle_validation
      See <PIT_INTERNAL.handle_validation>
   */
  procedure handle_validation
  as
  begin
    if g_collect_mode then
      push_message(g_active_message);
      g_collect_mode := false;
      g_message_stack := pit_message_table();
    else
      raise_event(
        p_event => C_LOG_VALIDATION_EVENT,
        p_message => g_active_message);
    end if;
    
    leave(C_TRACE_MANDATORY, null, g_active_message.severity);
  end handle_validation;    


  /**
    Procedure: handle_error
      See <PIT_INTERNAL.handle_error>
   */
  procedure handle_error(
    p_severity in pls_integer,
    p_message_name pit_util.ora_name_type,
    p_msg_args in msg_args,
    p_affected_id in pit_util.max_sql_char,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2,
    p_params in msg_params)
  as
  begin
    if g_collect_mode then
      g_collect_mode := false;
      g_message_stack := pit_message_table();
      g_active_message := null;
    end if;
    
    log_event(p_severity, p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code);
    
    if p_severity = C_LEVEL_FATAL then
      pit_call_stack.initialize;
      raise_error(C_LEVEL_FATAL, p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code);
    else
      g_active_message := null;
    end if;
    leave(C_TRACE_MANDATORY, p_params, p_severity);
  end handle_error;


  /**
    Procedure: handle_panic
      See <PIT_INTERNAL.handle_panic>
   */
  procedure handle_panic
  as
  begin
    log_panic;
    pit_call_stack.initialize;
    raise_error(C_LEVEL_FATAL, C_PIT_PANIC, null, null, null, C_PIT_PANIC);
  end handle_panic;


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
    p_affected_ids in msg_params default null,
    p_error_code in varchar2,
    p_read_only in boolean default true)
    return message_type
  as
    -- use a local message here to prevent to overwrite g_active_message with messages that are never raised
    l_message message_type;
    l_message_id number;
  begin
    if p_read_only then
      l_message_id := 0;
    end if;
    if p_affected_ids is not null then
      l_message := message_type(
                     p_message_id => l_message_id,
                     p_message_name => p_message_name,
                     p_message_language => get_language,
                     p_affected_ids => p_affected_ids,
                     p_error_code => p_error_code,
                     p_session_id => g_client_id,
                     p_schema_name => g_schema_name,
                     p_user_name => g_user_name,
                     p_msg_args => p_msg_args);
    else
      l_message := message_type(
                     p_message_id => l_message_id,
                     p_message_name => p_message_name,
                     p_message_language => get_language,
                     p_affected_id => p_affected_id,
                     p_error_code => p_error_code,
                     p_session_id => g_client_id,
                     p_schema_name => g_schema_name,
                     p_user_name => g_user_name,
                     p_msg_args => p_msg_args);
    end if;
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
    l_perform_check boolean;
  begin
    l_perform_check := p_value is not null or not p_accept_null;
    
    if l_perform_check then
      case p_type
      when C_TYPE_INTEGER then
        l_result := regexp_like(p_value, C_INTEGER_REGEXP);
      when C_TYPE_NUMBER then
        l_result := pit_util.check_number_datatype(p_value, p_format_mask);
      when C_TYPE_DATE then
        l_result := pit_util.check_date_datatype(p_value, p_format_mask);
      when C_TYPE_TIMESTAMP then
        l_result := pit_util.check_timestamp_datatype(p_value, p_format_mask);
      when C_TYPE_XML then
        l_result := pit_util.check_xml_datatype(p_value);
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
    Function: get_message_severity
      See <PIT_INTERNAL.get_message_severity>
   */
  function get_message_severity(
    p_message_name in pit_util.ora_name_type)
    return binary_integer
  as
    l_pse_id pit_message_severity.pse_id%type;
  begin
    select pms_pse_id
      into l_pse_id
      from pit_message
     where pms_id = p_message_name;
    return l_pse_id;
  exception
    when NO_DATA_FOUND then
      return null;
  end get_message_severity;
  
  
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
      g_collect_least_severity.delete;
    else
      case get_collect_least_severity(char_table())
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
  function get_collect_least_severity(
    p_error_code_list in char_table)
    return binary_integer
  as
    l_least_severity severity_t := C_LEVEL_ALL;
    l_error_code pit_util.ora_name_type;
  begin
    if p_error_code_list.count > 0 and p_error_code_list(1) is not null then
      for i in 1 .. p_error_code_list.count loop
        if g_collect_least_severity.exists(p_error_code_list(i)) then
          l_least_severity := least(l_least_severity, g_collect_least_severity(p_error_code_list(i)));
        end if;
      end loop;
    else
      l_error_code := g_collect_least_severity.first;
      while l_error_code is not null loop
        l_least_severity := least(l_least_severity, g_collect_least_severity(l_error_code));
        l_error_code := g_collect_least_severity.next(l_error_code);
      end loop;
    end if;
    return l_least_severity;
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
    Function: check_needs_assert
      See <PIT_INTERNAL.check_needs_assert>
   */
  function check_needs_assert(
    p_message_name in varchar2,
    p_error_code in varchar2)
    return boolean
  as
    l_result boolean := true;
    l_error_code pit_util.ora_name_type;
    l_severity binary_integer;
  begin
    if g_collect_mode then
      l_error_code := coalesce(p_error_code, p_message_name);
      if l_error_code is not null then
        if p_message_name is not null then
          select pms_pse_id
            into l_severity
            from pit_message
           where pms_id = p_message_name;
        end if;
        if g_collect_least_severity.exists(l_error_code) then
          l_result := l_severity < g_collect_least_severity(l_error_code);
        end if;
      end if;
    end if;
    return l_result;
  exception
    when NO_DATA_FOUND then
      return false;
  end check_needs_assert;
  
  
  /**
    Procedure: raise_assertion_finding
      See <PIT_INTERNAL.raise_assertion_finding>
   */    
  procedure raise_assertion_finding(
    p_default_error in varchar2,
    p_message_name in varchar2,
    p_msg_args msg_args,
    p_affected_id in varchar2,
    p_affected_ids in msg_params,
    p_error_code in varchar2)
  as
    l_severity binary_integer;
    l_error_name pit_util.ora_name_type;
  begin
    l_error_name := get_error_for_message_name(p_message_name, p_default_error);
    
    raise_validation_error(l_error_name, p_message_name, p_msg_args, p_affected_id, p_affected_ids, p_error_code);
    
  end raise_assertion_finding;
  
begin
  initialize;
end pit_internal;
/
