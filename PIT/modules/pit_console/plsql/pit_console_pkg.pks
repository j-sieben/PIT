create or replace package pit_console_pkg
as
  
  /** Implementation package for type PIT_CONSOLE */
    
  procedure log (
    p_message in message_type);

  procedure enter(
    p_call_stack in call_stack_type);

  procedure leave(
    p_call_stack in call_stack_type);
    
  procedure context_changed(
    p_ctx in pit_context);

  procedure initialize_module(
    self in out pit_console);
end pit_console_pkg;
/
