create or replace type message_type force is object(
  /** Core message type. Is used to collect the message, severity and other useful information around messages */
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
  static function format_icu(
    p_msg in varchar2,
    p_params in varchar2,
    p_locale in varchar2,
    l_status out number,
    l_error_message out varchar2)
    return varchar2
  as language java name
    'icu.ICU.format(java.lang.String, java.lang.String, java.lang.String, int[], java.lang.String[]) return java.lang.String',
  constructor function message_type(
    self in out nocopy message_type,
    p_message_name in varchar2,
    p_message_language in varchar2,
    p_affected_id in varchar2,
    p_error_code in varchar2,
    p_session_id in varchar2,
    p_user_name in varchar2,
    p_arg_list msg_args)
    return self as result)
final instantiable;
/