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
  message_name &ORA_NAME_TYPE.,
  affected_id varchar2(50 char),
  error_code varchar2(30 char),
  session_id varchar2(64 byte),
  user_name &ORA_NAME_TYPE.,
  message_text clob,
  message_description clob,
  severity number(2,0),
  stack varchar2(2000 byte),
  backtrace varchar2(2000 byte),
  error_number number (5,0),
  message_args msg_args,
  /**
    Function: format_icu
      Method that is called if the message is formatted by the ICU functionality.
      Implemented in Java
      
    Parameters:
      p_msg - Message text to format
      p_params - Parameter values, either in JSON format or as a key-value list
      p_locale - Language of the message
      l_status - Status message,
      l_error_message - Formatted message
   */
  static function format_icu(
    p_msg in varchar2,
    p_params in varchar2,
    p_locale in varchar2,
    l_status out number,
    l_error_message out varchar2)
    return varchar2
  as language java name
    'icu.ICU.format(java.lang.String, java.lang.String, java.lang.String, int[], java.lang.String[]) return java.lang.String',
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
    p_user_name in varchar2,
    p_msg_args msg_args)
    return self as result)
final instantiable;
/