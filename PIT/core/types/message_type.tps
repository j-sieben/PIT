create or replace type message_type force is object(
  /** 
    Type: message_type
      Core message type. Is used to collect the message, severity and other useful information around messages 
    
    Properties:
      id - Technical key
      message_name - Name of the message
      affected_id - Subject ID to which the message relates
      error_code - Error code of the entry. May be used to divide several occurences of the same message name.
      session_id - ID of the session as delivered by the adapter in use
      schema_name - Name of the schema
      module - Name of the package where the message was raised
      action - Name of the package method the message was raised
      user_name - Name of the user as delivered by the adapter in use
      message_text - Tect of the message in the actually valid translation
      message_description - Optional descriptive text, mostly used ot explain what to do in case of errors
      severity - Severity of the message
      stack - In case of error: Call stack
      backtrace - in case of error: Error stack
      error_number - Either an Oracle error code or one of the range -20999 .. -20000. Only applicable if level is error or fatal
      message_args - List of arguments passed into the message.
   */
  id number,
  message_name varchar2(128 byte),
  affected_id varchar2(4000 byte),       
  affected_ids msg_params,             
  error_code varchar2(30 char),
  session_id varchar2(64 byte),
  schema_name varchar2(128 byte),
  module varchar2(128 byte),
  action varchar2(128 byte),
  user_name varchar2(128 byte),
  message_text clob,
  message_description clob,
  severity number(2,0),
  stack varchar2(2000 byte),
  backtrace varchar2(2000 byte),
  error_number number (5,0),
  message_args msg_args,
  /**
    Function: message_type
      Constructor function
      
    Parameters:
      p_message_name - Name of the message
      p_message_language - Language of the message
      p_affected_id - Error code of the entry. May be used to divide several occurences of the same message name.
      p_error_code - Error code of the entry. May be used to divide several occurences of the same message name.
      p_session_id - ID of the session as delivered by the adapter in use
      p_user_name - Name of the user as delivered by the adapter in use
      p_msg_args - List of arguments passed into the message.
   */
  constructor function message_type(
    self in out nocopy message_type,
    p_message_name in varchar2,
    p_message_language in varchar2,
    p_affected_id in varchar2,
    p_error_code in varchar2,
    p_session_id in varchar2,
    p_schema_name in varchar2,        
    p_user_name in varchar2,
    p_msg_args msg_args)
    return self as result,
  constructor function message_type(       
    self in out nocopy message_type,
    p_message_name in varchar2,
    p_message_language in varchar2,
    p_affected_ids in msg_params,
    p_error_code in varchar2,
    p_session_id in varchar2,
    p_schema_name in varchar2,
    p_user_name in varchar2,
    p_msg_args msg_args)
    return self as result)
final instantiable;
/