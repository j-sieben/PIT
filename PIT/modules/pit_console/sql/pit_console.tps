create type pit_console under pit_module(
   overriding member procedure log(
      p_message in message_type),
   overriding member procedure print(
      p_message in message_type),
   overriding member procedure enter(
      p_call_stack call_stack_type),
   overriding member procedure leave (
      p_call_stack call_stack_type),
   constructor function pit_console (
      self in out nocopy pit_console)
      return self as result)
   final instantiable;
/
