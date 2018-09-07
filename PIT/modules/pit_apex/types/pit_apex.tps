create type pit_apex under pit_module
(
   overriding member procedure log(
      p_message in message_type),
   overriding member procedure print(
      p_message in message_type),
   overriding member procedure notify(
      p_message in message_type),
   overriding member procedure enter (
      p_call_stack in call_stack_type),
   overriding member procedure leave (
      p_call_stack in call_stack_type),
   constructor function pit_apex(
      self in out nocopy pit_apex) 
      return self as result
)
final instantiable;
/
