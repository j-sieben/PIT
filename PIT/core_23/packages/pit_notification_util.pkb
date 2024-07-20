create or replace package body pit_notification_util
as
  /**
    Package: PIT_NOTIFICATION_UTIL Body
      Implements functionality to pass a message to a websocket server.

    Author::
      Juergen Sieben, ConDeS GmbH

      Published under MIT licence
   */
  g_ws_url pit_util.small_char;
   
  /**
    Group: Helper Methods
   */
  /**
    Function: format_message
      Method to convert a message_type message into a clob.
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
    Group: Interface
   */
  /**
    Procedure: notify
      See: <PIT_NOTIFICATION_UTIL.notify>
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

end pit_notification_util;
/