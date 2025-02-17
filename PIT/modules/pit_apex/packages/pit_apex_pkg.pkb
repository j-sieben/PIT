create or replace package body pit_apex_pkg
as

  /**
    Package: Output Modules.PIT_APEX.PIT_APEX_PKG Body
      Implements PIT_APEX output module methods

    Author::
      Juergen Sieben, ConDeS GmbH

      Published under MIT licence
   */
  /**
    Group: Package Constants
   */
  /**    
    Constants: Parameter Constants
      C_PARAM_GROUP - Parameter group of <PIT>
      C_APEX_CONTEXT - Parameter name for the log context to switch to when APEX is in debug mode
      C_FIRE_THRESHOLD - Parameter name for the generic fire threshold
      C_TRG_FIRE_THRESHOLD - Parameter name for the APEX context fire threshold
      C_TRG_TRACE_THRESHOLD - Parameter name for the APEX context trace threshold
      C_TRG_TRACE_TIMING - Parameter name for the context trace timing flag
      C_TRG_LOG_MODULES - Parameter name for the context log module list
      C_WEB_SOCKET_SERVER - Parameter name for the websocket server (not yet functional!)
   */
  C_PARAM_GROUP constant pit_util.ora_name_type := 'PIT';
  C_APEX_CONTEXT constant pit_util.ora_name_type := 'CONTEXT_APEX';
  C_DEFAULT_CONTEXT constant pit_util.ora_name_type := 'CONTEXT_DEFAULT';
  C_FIRE_THRESHOLD constant pit_util.ora_name_type := 'PIT_APEX_FIRE_THRESHOLD';
  C_TRG_FIRE_THRESHOLD constant pit_util.ora_name_type := 'PIT_APEX_TRG_FIRE_THRESHOLD';
  C_TRG_TRACE_THRESHOLD constant pit_util.ora_name_type := 'PIT_APEX_TRG_TRACE_THRESHOLD';
  C_TRG_TRACE_TIMING constant pit_util.ora_name_type := 'PIT_APEX_TRG_TRACE_TIMING';
  C_TRG_LOG_MODULES constant pit_util.ora_name_type := 'PIT_APEX_TRG_LOG_MODULES';
  C_WEB_SOCKET_SERVER constant pit_util.ora_name_type := 'PIT_WEB_SOCKET_SERVER';
  C_YES constant varchar2(3 byte) := 'YES';
  C_CHUNK_SIZE constant integer := 8192;

  g_apex_triggered_context pit_context_type;
  g_fire_threshold number;
  g_ws_url varchar2(1000 byte);

  /**
    Group: Helper methods
   */
  /** 
    Procedure: initialize
      Helper method to read parameter values into global package variables. Is called from <INITIALIZE_MODULE> method.
   */
  procedure initialize
  as
  begin
    if g_fire_threshold is null then
      g_apex_triggered_context := pit_context_type();
      g_fire_threshold := param.get_integer(C_FIRE_THRESHOLD, C_PARAM_GROUP);
      g_apex_triggered_context.log_level := param.get_integer(C_TRG_FIRE_THRESHOLD, C_PARAM_GROUP);
      g_apex_triggered_context.trace_level := param.get_integer(C_TRG_TRACE_THRESHOLD, C_PARAM_GROUP);
      $IF dbms_db_version.ver_le_19 $THEN
      g_apex_triggered_context.trace_timing := pit_util.to_bool(param.get_boolean(C_TRG_TRACE_TIMING, C_PARAM_GROUP));
      $ELSIF dbms_db_version.ver_le_21 $THEN
      g_apex_triggered_context.trace_timing := pit_util.to_bool(param.get_boolean(C_TRG_TRACE_TIMING, C_PARAM_GROUP));
      $ELSE
      g_apex_triggered_context.trace_timing := param.get_boolean(C_TRG_TRACE_TIMING, C_PARAM_GROUP);
      $END
      g_apex_triggered_context.log_modules := pit_util.string_to_table(param.get_string(C_TRG_LOG_MODULES, C_PARAM_GROUP));
    end if;
  end initialize;


  /**
    Function: valid_environment
      Method checks whether module is called within a valid APEX session environment.
      Is called from any public method to prevent useless execution of no APEX environment is available.
      
    Returns:
      Flag to indicate whether a valid APEX session environment exists (TRUE) or not (FALSE)
   */
  function valid_environment
    return boolean
  as
  begin
    return apex_application.g_instance is not null;
  end valid_environment;


  /** 
    Funciton: get_msg_param
      Method converts <MSG_PARAMS> into NAME-VALUE-Pairs as used by <APEX_DEBUG.ENTER>.
     
    Parameters:
      p_call_stack - Instance of <PIT_CALL_STACK_TYPE> with parameter information
      p_position - Index of the nth parameter to read
      
    Returns:
      Odd position number returns name, even position number returns value of the parameter.
   */
  function get_msg_param(
    p_call_stack in pit_call_stack_type,
    p_position in binary_integer)
    return varchar2
  as
    l_position binary_integer;
  begin
    l_position := round((p_position)/2);
    if p_call_stack.params.exists(l_position) then
      if mod(p_position, 2) = 1 then
        return p_call_stack.params(l_position).p_param;
      else
        return p_call_stack.params(l_position).p_value;
      end if;
    else
      return null;
    end if;
  end get_msg_param;


  /** 
    Procedure: debug_message
      Method forwards messages to the APEX debug stack. 
      PIT severity is mapped to APEX severity and message transformed into plain string.
      Emits data, if ...
   
      - Valid APEX environment exists
      - log_level PIT_APEX_FIRE_THRESHOLD is reached
      - APEX logging is activated
      
    Parameter:
      p_message - Instance of <MESSAGE_TYPE>
   */
  procedure debug_message(
    p_message in message_type)
  as
    l_severity binary_integer range 1..7;
    l_message pit_util.max_char;
  begin
    l_severity := round(p_message.severity/10);
    if p_message.stack is not null then
      l_message := dbms_lob.substr(p_message.message_text, 30000, 1)
                || chr(10)
                || substr(p_message.stack, 1, 200)
                || chr(10)
                || substr(p_message.backtrace, 1, 2550);
    else
      l_message := dbms_lob.substr(p_message.message_text, 32760, 1);
    end if;

    apex_debug.log_long_message(
      p_message => l_message,
      p_level => l_severity);
  end debug_message;
  
  
  /**
    Function: format_message
      Method to convert a message_type message into a JSON instance for notifications.
      Conventions used: Notification messages have three reserved message args:
      
      1 - Room, defines the room the message is assigned to
      2 - Event, defines the event that caused the message to be sent
      3 - action, optional definition of a method that is to be executed client side
          to handle the message
          
      Normal message args have to be passed as argument 4 - 50.
   */
  function format_message(
    p_message in message_type)
    return clob
  as
    l_message json_object_t;
  begin
    l_message.put('id', p_message.id);
    l_message.put('room', to_char(p_message.message_args(1)));
    l_message.put('affected_id', p_message.affected_id);
    l_message.put('event', to_char(p_message.message_args(2)));
    l_message.put('action', to_char(p_message.message_args(3)));
    l_message.put('session_id', p_message.session_id);
    l_message.put('user_name', p_message.user_name);
    l_message.put('message_text', to_char(p_message.message_text));
    l_message.put('message_description', to_char(p_message.message_description));
    l_message.put('severity', to_char(p_message.severity));
    l_message.put('stack', p_message.stack);
    l_message.put('backtrace', p_message.backtrace);
    l_message.put('error_number', to_char(p_message.error_number));
    
    return l_message.stringify;
  end format_message;
  
  
  /**
    Procedure: check_http_status
      Method checks the response of the REST call.
   */
  procedure check_http_status 
  as
    l_status_code pit_util.ora_name_type;
    l_message_text clob;
    C_STATUS_OK constant pit_util.ora_name_type := '2%';
  begin
    for i in 1 .. apex_web_service.g_headers.count loop
      l_status_code := apex_web_service.g_status_code;
      
      if l_status_code not like C_STATUS_OK then
        l_message_text := 'Response HTTP Status NOT OK' || chr(10) || 
                          'Name: ' || apex_web_service.g_headers(i).name || chr(10) || 
                          'Value: ' || apex_web_service.g_headers(i).value || chr(10) ||
                          'Status Code: ' || l_status_code;
        apex_error.add_error(
          p_message => l_message_text,
          p_display_location => apex_error.c_inline_with_field_and_notif);
      end if;
    end loop;
  end check_http_status;


  /**
    Procedure: log_error
      Method adds error messages to the apex error stack. 
      It tries to find the item label and replaces the anchor with the actual label and shows the exception with reference to the affected id.
      Emits data, if ...
   
      - Valid APEX environment exists
      - <P_MESSAGE.AFFECTED_ID> is set and the message contains anchor #ITEM_LABEL#
      - log_level <PIT_APEX_FIRE_THRESHOLD> is reached
      - APEX logging is activated
      
    Parameter:
      p_message - Instance of <MESSAGE_TYPE>
   */
  procedure log_error(
    p_message in message_type)
  as
    C_ITEM_LABEL pit_util.ora_name_type := '#ITEMLABEL#';
    l_label varchar2(100);
    l_message varchar2(1000);
  begin
    if instr(p_message.message_text, C_ITEM_LABEL) > 0 and p_message.affected_id is not null and regexp_like(p_message.affected_id, '^P[0-9]+_') then
      -- Get item label to include it into the message
      begin
           with params as(
                select /*+ no_merge */ 
                       apex_application.g_flow_id application_id,
                       apex_application.g_flow_step_id page_id,
                       p_message.affected_id item_name
                  from dual)
         select label
           into l_label
           from apex_application_page_items
        natural join params p;
        l_message := replace(p_message.message_text, C_ITEM_LABEL, l_label);
      exception
        when NO_DATA_FOUND then
          l_message := replace(p_message.message_text, C_ITEM_LABEL, p_message.affected_id);
      end;

      apex_error.add_error(
        p_message => l_message,
        p_additional_info => p_message.message_description,
        p_page_item_name => p_message.affected_id,
        p_display_location => apex_error.c_inline_with_field_and_notif);
    else
      apex_error.add_error(
        p_message => p_message.message_text,
        p_additional_info => p_message.message_description,
        p_display_location => apex_error.c_inline_with_field_and_notif);
    end if;
  end log_error;


  /**
    Procedure: print_clob
      Method passes a CLOB text to APEX, using HTP.P.
      CLOB is splitted into chunks of <C_CHUNK_SIZE> bytes to circumvent the limitation of http streams of 32 KByte.
      
    Parameter:
      p_text - CLOB instance to pass to APEX
   */
  procedure print_clob(
    p_text in clob)
  as
    l_offset binary_integer := 1;
    l_amount binary_integer := C_CHUNK_SIZE;
    l_chunk pit_util.max_char;
    l_length binary_integer := dbms_lob.getlength(p_text);
  begin
    while l_length > 0 and p_text is not null loop
      dbms_lob.read(
        lob_loc => p_text,
        amount => l_amount,
        offset => l_offset,
        buffer => l_chunk);
      l_offset := l_offset + l_amount;
      l_length := l_length - l_amount;
      sys.htp.p(l_chunk);
    end loop;
  end print_clob;
  

  /**
    Group: Interfacce
   */
  /**
    Function: get_apex_triggered_context
      see <PIT_APEX_PKG.get_apex_triggered_context>
   */
  function get_apex_triggered_context
    return varchar2
  as
    l_context pit_util.ora_name_type;
  begin
    if valid_environment then
      if apex_application.g_debug then
        l_context := C_APEX_CONTEXT;
      else
        l_context := C_DEFAULT_CONTEXT;
      end if;
    end if;
    return l_context;
  end get_apex_triggered_context;


  /**
    Function: log_validation
      see <PIT_APEX_PKG.log_validation
   */
  procedure log_validation(
    p_message in message_type)
  as
  begin
    if valid_environment then
      -- Decision tree for the output of the individual severity levels
      case p_message.severity
      when pit.level_info then
        apex_debug.info(p_message.message_text);
      when pit.level_warn then
        apex_debug.warn(p_message.message_text);
      when pit.level_error then
        log_error(p_message);
      else
        -- Level off
        null;
      end case;
    end if;
  end log_validation;


  /**
    Function: log_exception
      see <PIT_APEX_PKG.log_exception
   */
  procedure log_exception(
    p_message in message_type)
  as
  begin
    if valid_environment then
      -- Decision tree for the output of the individual severity levels
      case p_message.severity
      when pit.level_all then
        apex_debug.trace(p_message.message_text);
      when pit.level_debug then
        apex_debug.info(p_message.message_text);
      when pit.level_info then
        apex_debug.info(p_message.message_text);
      when pit.level_warn then
        apex_debug.warn(p_message.message_text);
      when pit.level_error then
        log_error(p_message);
      when pit.level_fatal then
        apex_debug.warn(p_message.message_text);
        log_error(p_message);
      else
        -- Level off
        null;
      end case;
    end if;
  end log_exception;


  /**
    Function: panic
      see <PIT_APEX_PKG.panic
   */
  procedure panic(
    p_message in message_type)
  as
  begin
    if valid_environment then
      apex_debug.error(p_message.message_text);
      log_error(p_message);
      apex_application.stop_apex_engine;
    end if;
  end panic;


  /**
    Function: log_state
      see <PIT_APEX_PKG.log_state>
   */
  procedure log_state(
    p_log_state in pit_log_state_type)
  as
  begin
    if valid_environment and p_log_state.params.count > 0 then
      apex_debug.info('-> State');
      for i in 1 .. p_log_state.params.count loop
        apex_debug.info('...' || p_log_state.params(i).p_param || ': ' || p_log_state.params(i).p_value);
      end loop;
      apex_debug.info('<- State');
    end if;
  end log_state;


  /**
    Function: print
      see <PIT_APEX_PKG.print>
   */
  procedure print(
    p_message in message_type)
  as
  begin
    if valid_environment then
      print_clob(p_message.message_text);
    end if;
  end print;
  
  
  /**
     Procedure: tweet
       See <pit_apex_pkg.tweet>
   */
  PROCEDURE tweet (
    p_message IN message_type)
  AS
  BEGIN
    apex_debug.info('Tweet => ' || p_message.message_text);
  END tweet;


  /**
    Function: notify
      see <PIT_APEX_PKG.notify>
   */
  procedure notify(
    p_message in message_type)
  as
    C_HTTP_METHOD constant pit_util.ora_name_type := 'POST';
    C_CONTENT_TYPE constant pit_util.ora_name_type := 'application/json';
    C_USER_AGENT constant pit_util.ora_name_type := 'APEX';
    l_message clob;
    l_response clob;
  begin
    null;
    g_ws_url := coalesce(g_ws_url, param.get_string('PIT_WEB_SOCKET_SERVER', 'PIT'));
    
    apex_web_service.set_request_headers (
      p_name_01 => 'Content-Type',
      p_value_01 => C_CONTENT_TYPE,
      p_name_02 => 'User-Agent',
      p_value_02 => C_USER_AGENT);
    
    l_message := format_message(p_message);
      
    l_response := apex_web_service.make_rest_request(
                    p_url => g_ws_url,
                    p_http_method => C_HTTP_METHOD,
                    p_body => l_message);
                    
    check_http_status;
  end notify;


  /**
    Function: enter
      see <PIT_APEX_PKG.enter>
   */
  procedure enter(
    p_call_stack in pit_call_stack_type)
  is
    l_message message_type;
    l_message_language varchar2(64);
    l_param_list varchar2(32767);
    l_next_param varchar2(32767);
  begin
    if valid_environment then
      apex_debug.enter(
        p_routine_name => p_call_stack.module_name || '.' || p_call_stack.method_name,
        p_name01 => get_msg_param(p_call_stack, 1),
        p_value01 => get_msg_param(p_call_stack, 2),
        p_name02 => get_msg_param(p_call_stack, 3),
        p_value02 => get_msg_param(p_call_stack, 4),
        p_name03 => get_msg_param(p_call_stack, 5),
        p_value03 => get_msg_param(p_call_stack, 6),
        p_name04 => get_msg_param(p_call_stack, 7),
        p_value04 => get_msg_param(p_call_stack, 8),
        p_name05 => get_msg_param(p_call_stack, 9),
        p_value05 => get_msg_param(p_call_stack, 10),
        p_name06 => get_msg_param(p_call_stack, 11),
        p_value06 => get_msg_param(p_call_stack, 12),
        p_name07 => get_msg_param(p_call_stack, 13),
        p_value07 => get_msg_param(p_call_stack, 14),
        p_name08 => get_msg_param(p_call_stack, 15),
        p_value08 => get_msg_param(p_call_stack, 16),
        p_name09 => get_msg_param(p_call_stack, 17),
        p_value09 => get_msg_param(p_call_stack, 18),
        p_name10 => get_msg_param(p_call_stack, 19),
        p_value10 => get_msg_param(p_call_stack, 20));
      debug_message(l_message);
    end if;
  end enter;


  /**
    Function: leave
      see <PIT_APEX_PKG.leave>
   */
  procedure leave(
    p_call_stack in pit_call_stack_type)
  as
    l_message message_type;
  begin
    if valid_environment then
      apex_debug.enter(
        p_routine_name => '< ' || p_call_stack.module_name || '.' || p_call_stack.method_name,
        p_name01 => get_msg_param(p_call_stack, 1),
        p_value01 => get_msg_param(p_call_stack, 2),
        p_name02 => get_msg_param(p_call_stack, 3),
        p_value02 => get_msg_param(p_call_stack, 4),
        p_name03 => get_msg_param(p_call_stack, 5),
        p_value03 => get_msg_param(p_call_stack, 6),
        p_name04 => get_msg_param(p_call_stack, 7),
        p_value04 => get_msg_param(p_call_stack, 8),
        p_name05 => get_msg_param(p_call_stack, 9),
        p_value05 => get_msg_param(p_call_stack, 10),
        p_name06 => get_msg_param(p_call_stack, 11),
        p_value06 => get_msg_param(p_call_stack, 12),
        p_name07 => get_msg_param(p_call_stack, 13),
        p_value07 => get_msg_param(p_call_stack, 14),
        p_name08 => get_msg_param(p_call_stack, 15),
        p_value08 => get_msg_param(p_call_stack, 16),
        p_name09 => get_msg_param(p_call_stack, 17),
        p_value09 => get_msg_param(p_call_stack, 18),
        p_name10 => get_msg_param(p_call_stack, 19),
        p_value10 => get_msg_param(p_call_stack, 20));
      debug_message(l_message);
    end if;
  end leave;


  /**
    Function: initialize_module
      see <PIT_APEX_PKG.initialize_module>
   */
  procedure initialize_module(
    self in out nocopy pit_apex)
  as
  begin
    -- Do not check for valid environment here, as it is possible to use
    -- method notify even from the business layer outside a request response cycle
    self.fire_threshold := g_fire_threshold;
    self.status := msg.pit_module_instantiated;
  exception
    when others then
      self.status := msg.pit_fail_module_init;
      self.stack := substr(sqlerrm, 12);
  end initialize_module;

begin
   initialize;
end pit_apex_pkg;
/