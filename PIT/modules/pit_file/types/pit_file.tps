create or replace type pit_file under pit_module(
  overriding member procedure log(
    self in out nocopy pit_file,
    p_message in message_type),
  overriding member procedure purge(
    self in out nocopy pit_file,
    p_purge_date in date,
    p_severity_greater_equal in integer default null),
  overriding member procedure enter(
    self in out nocopy pit_file,
    p_call_stack in call_stack_type),
  overriding member procedure leave(
    self in out nocopy pit_file,
    p_call_stack in call_stack_type),
  constructor function pit_file(
    self in out nocopy pit_file)
    return self as result)
  final instantiable;
/
