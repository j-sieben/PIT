create or replace type pit_ut under pit_module(
  overriding member procedure log(
    p_message in message_type),
  overriding member procedure print(
    p_message in message_type),
  overriding member procedure notify(
    p_message in message_type),
  overriding member procedure enter(
    p_call_stack call_stack_type),
  overriding member procedure leave (
    p_call_stack call_stack_type),
  overriding member procedure context_changed(
    p_ctx in pit_context),
  constructor function pit_ut (
    self in out nocopy pit_ut)
    return self as result)
final instantiable;
/
