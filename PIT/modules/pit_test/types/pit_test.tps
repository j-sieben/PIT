create or replace type pit_test under pit_module(
  overriding member procedure log(
    p_message in message_type),
  overriding member procedure purge(
    p_purge_date in date,
    p_severity_greater_equal in integer default null),
  overriding member procedure enter(
    p_call_stack in call_stack_type),
  overriding member procedure leave(
    p_call_stack in call_stack_type),
  constructor function pit_test(
    self in out nocopy pit_test)
    return self as result)
  final instantiable;
/
