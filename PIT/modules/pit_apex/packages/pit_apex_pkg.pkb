create or replace package body pit_apex_pkg
as
  /**
    Author       : $Author: juergen $
    Created      : 03.05.2010
    Last Changed : $LastChangedDate: 2014-05-04 18:39:38 +0200 (So, 04 Mai 2014) $
    Revision     : $Revision: 1008 $
    HeadURL      : $HeadURL: svn+ssh://juergen@176.9.99.236/home/svn/repos/src/kismon/plsql/param_admin.pks $
    ID           : $Id: param_admin.pks 1008 2014-05-04 16:39:38Z juergen $
    Purpose      : PIT-Modul zur Ausgabe innerhalb von APEX-Anwendungen
  */

  /* CONSTANTS AND VARIABLES */
  C_PARAM_GROUP constant varchar2(20 char) := 'PIT';
  C_FIRE_THRESHOLD constant pit_util.ora_name_type := 'PIT_APEX_FIRE_THRESHOLD';
  C_TRG_FIRE_THRESHOLD constant pit_util.ora_name_type := 'PIT_APEX_TRG_FIRE_THRESHOLD';
  C_TRG_TRACE_THRESHOLD constant pit_util.ora_name_type := 'PIT_APEX_TRG_TRACE_THRESHOLD';
  C_TRG_TRACE_TIMING constant pit_util.ora_name_type := 'PIT_APEX_TRG_TRACE_TIMING';
  C_TRG_LOG_MODULES constant pit_util.ora_name_type := 'PIT_APEX_TRG_LOG_MODULES';
  C_WEB_SOCKET_SERVER constant pit_util.ora_name_type := 'PIT_WEB_SOCKET_SERVER';
  C_YES constant varchar2(3 byte) := 'YES';
  C_CHUNK_SIZE constant integer := 8192;
  
  g_apex_triggered_context pit_pkg.context_type;
  g_fire_threshold number;
  g_websocket_server varchar2(1000 byte);

  /* HELPER */
  procedure initialize
  as
  begin
    g_fire_threshold := param.get_integer(C_FIRE_THRESHOLD, C_PARAM_GROUP);
    g_apex_triggered_context.log_level := param.get_integer(C_TRG_FIRE_THRESHOLD, C_PARAM_GROUP);
    g_apex_triggered_context.trace_level := param.get_integer(C_TRG_TRACE_THRESHOLD, C_PARAM_GROUP);
    g_apex_triggered_context.trace_timing := param.get_boolean(C_TRG_TRACE_TIMING, C_PARAM_GROUP);
    g_apex_triggered_context.log_modules := param.get_string(C_TRG_LOG_MODULES, C_PARAM_GROUP);
    g_websocket_server := param.get_string(C_WEB_SOCKET_SERVER, C_PARAM_GROUP);
  end initialize;
  

  /* valid_environment checks whether module is called within a valid APEX
   * session environment
   */
  function valid_environment
    return boolean
  as
  begin
    return apex_application.get_session_id is not null;
  end valid_environment;
  
  
  /* helper function to convert MSG_PARAMS into NAME-VALUE-Pairs
   * odd position number returns name of the parameter
   * even position number returns value of the parameter
   */
  function get_msg_param(
    p_call_stack in call_stack_type,
    p_position in binary_integer)
    return varchar2
  as
    l_position binary_integer;
  begin
    l_position := round((p_position - 0.25)/2);
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


  /* debug_message forwards messages to the APEX debug stack, if
   * - log_level PIT_APEX_FIRE_THRESHOLD is reached
   * - APEX-logging is activated
   */
  procedure debug_message(
    p_message in message_type)
  as
    l_severity binary_integer range 1..7;
    l_message pit_util.max_char;
  begin
    if valid_environment then
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
    end if;
  end debug_message;
  
  
  /* helper to add error messages to the apex error stack
   */
  procedure log_error(
    p_message in message_type)
  as
    l_label varchar2(100);
    l_message varchar2(1000);
  begin
    if valid_environment then
      if p_message.affected_id is not null and regexp_like(p_message.affected_id, '^P[0-9]+_') then
        -- Get item label to include it into the message
        begin 
             with params as(
                  select to_number(v('APP_ID')) application_id,
                         to_number(v('APP_PAGE_ID')) page_id,
                         p_message.affected_id item_name
                    from dual)
           select /*+ no_merge (params) */ label
             into l_label
             from apex_application_page_items
          natural join params;
          l_message := replace(p_message.message_text, '#ITEM_LABEL#', l_label);
        exception
          when NO_DATA_FOUND then
            l_message := replace(p_message.message_text, '#ITEM_LABEL#', p_message.affected_id);
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
    end if;
  end log_error;
  

  /* helper procedure to pass clob to APEX, using htp.p
   * clob is splitted into chunks of C_CHUNK_SIZE bytes to circumvent the limitation
   * of http-streams of 32 KByte
   */
  procedure print_clob(
    p_text in clob)
  as
    l_offset binary_integer := 1;
    l_amount binary_integer := C_CHUNK_SIZE;
    l_chunk pit_util.max_char;
    l_length binary_integer := dbms_lob.getlength(p_text);
  begin
    if valid_environment then
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
    end if;
  end print_clob;


  /* INTERFACE */
  procedure log(
    p_message in message_type)
  as
    error_count binary_integer;
  begin
    if valid_environment then
      -- Entscheidungsbaum zur Ausgabe der einzelnen Schweregrade
      case p_message.severity
      when pit.level_all then
        debug_message(p_message);
      when pit.level_debug then
        debug_message(p_message);
      when pit.level_info then
        debug_message(p_message);
      when pit.level_warn then
        debug_message(p_message);
        apex_application.g_notification := p_message.message_text;
        apex_application.g_print_success_message := null;
      when pit.level_error then
        log_error(p_message);
      when pit.level_fatal then
        debug_message(p_message);
        log_error(p_message);
        apex_application.stop_apex_engine;
      else
        -- Level off
        null;
      end case;
    end if;
  end log;


  procedure print(
    p_message in message_type)
  as
  begin
    print_clob(p_message.message_text);
  end print;


  procedure notify(
    p_message in message_type)
  as
    l_clob clob;
    l_message json_object_t := json_object_t('{}');
  begin
    l_message.put('id', p_message.id);
    l_message.put('message_name', p_message.message_name);
    l_message.put('affected_id', p_message.affected_id);
    l_message.put('session_id', p_message.session_id);
    l_message.put('user_name', p_message.user_name);
    l_message.put('message_text', to_char(p_message.message_text));
    l_message.put('message_description', to_char(p_message.message_description));
    l_message.put('severity', to_char(p_message.severity));
    l_message.put('stack', p_message.stack);
    l_message.put('backtrace', p_message.backtrace);
    l_message.put('error_number', to_char(p_message.error_number));
    
    pit.verbose(msg.WEBSOCKET_MESSAGE, msg_args(g_websocket_server, l_message.stringify));
    l_clob := apex_web_service.make_rest_request( 
                p_url => g_websocket_server,
                p_http_method => 'POST',
                p_body   => l_message.stringify()
              );
  end notify;


  procedure enter(
    p_call_stack in call_stack_type)
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


  procedure leave(
    p_call_stack in call_stack_type)
  as
    l_message message_type;
  begin
    null;
  end leave;
  
  
  procedure set_apex_triggered_context
  as
  begin
    if valid_environment then
      if apex_application.g_debug then
        pit_pkg.set_context(g_apex_triggered_context);
      else
        pit.reset_context;
      end if;
    end if;
  end set_apex_triggered_context;


  procedure initialize_module(
    self in out nocopy pit_apex)
  as
  begin
    if valid_environment then
      self.fire_threshold := g_fire_threshold;
      self.status := msg.pit_module_instantiated;
    else
      self.status := msg.pit_fail_module_init;
      self.stack  := 'Invalid APEX environment';
    end if;
  exception
    when others then
      self.status := msg.pit_fail_module_init;
      self.stack := pit_util.get_error_stack;
  end initialize_module;

begin
   initialize;
end pit_apex_pkg;
/