  create or replace 
  type pit_test under pit_module(
  overriding member procedure log(
    p_message in message_type),
  overriding member procedure print(
    p_message in message_type),
  overriding member procedure enter(
    p_call_stack call_stack_type),
  overriding member procedure leave (
    p_call_stack call_stack_type),
  overriding member procedure purge (
    p_purge_date in date default null,
    p_severity_greater_equal in number default null),
  overriding member procedure context_changed(
    p_ctx in pit_context),
  constructor function pit_test (
    self in out nocopy pit_test)
    return self as result)
  final instantiable;
  /
