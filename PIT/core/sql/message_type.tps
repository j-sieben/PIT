create or replace type message_type force is object(
  message_name varchar2(30 char),
  affected_id varchar2(50 char),
  session_id varchar2(30 char),
  user_name varchar2(30 char),
  message_text clob,
  severity number(2,0),
  stack varchar2(2000),
  backtrace varchar2(2000),
  constructor function message_type(
    self in out nocopy message_type,
    message_name in varchar2,
    message_language in varchar2,
    affected_id in varchar2,
    session_id in varchar2,
    user_name in varchar2,
    arg_list msg_args)
    return self as result)
  final instantiable;
/