create or replace type message_type force is object(
  id number,
  message_name varchar2(30 char),
  affected_id varchar2(50 char),
  error_code varchar2(30 char),
  session_id varchar2(30 char),
  user_name varchar2(30 char),
  message_text clob,
  message_description clob,
  severity number(2,0),
  stack varchar2(2000),
  backtrace varchar2(2000),
  error_number number (5,0),
  message_args msg_args,
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