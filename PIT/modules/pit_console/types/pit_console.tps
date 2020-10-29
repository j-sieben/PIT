create or replace type pit_console force under pit_module(
  overriding member procedure log(
    self in out nocopy pit_console,
    p_message in message_type),
  overriding member procedure log(
    self in out nocopy pit_console,
    p_params in msg_params),
  overriding member procedure print(
    self in out nocopy pit_console,
    p_message in message_type),
  overriding member procedure notify(
    self in out nocopy pit_console,
    p_message in message_type),
  overriding member procedure enter(
    self in out nocopy pit_console,
    p_call_stack call_stack_type),
  overriding member procedure leave (
    self in out nocopy pit_console,
    p_call_stack call_stack_type),
  overriding member procedure context_changed(
    self in out nocopy pit_console,
    p_ctx in pit_context),
  constructor function pit_console (
    self in out nocopy pit_console)
    return self as result)
final instantiable;
/
