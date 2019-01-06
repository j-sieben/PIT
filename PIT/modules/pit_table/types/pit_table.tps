create type pit_table under pit_module(
  overriding member procedure log(
    p_message in message_type),
  overriding member procedure enter (
    p_call_stack call_stack_type),
  overriding member procedure leave (
    p_call_stack call_stack_type),
  overriding member procedure purge(
    p_purge_date in date,
    p_severity_greater_equal in integer default null),
  constructor function pit_table (
    self in out nocopy pit_table)
    return self as result
  )
  final instantiable;
/