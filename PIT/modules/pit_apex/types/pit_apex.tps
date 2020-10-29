create type pit_apex under pit_module
(
  overriding member procedure log(
    self in out nocopy pit_apex,
    p_message in message_type),
  overriding member procedure print(
    self in out nocopy pit_apex,
    p_message in message_type),
  overriding member procedure notify(
    self in out nocopy pit_apex,
    p_message in message_type),
  overriding member procedure enter (
    self in out nocopy pit_apex,
    p_call_stack in call_stack_type),
  overriding member procedure leave (
    self in out nocopy pit_apex,
    p_call_stack in call_stack_type),
  constructor function pit_apex(
    self in out nocopy pit_apex) 
    return self as result
)
final instantiable;
/
