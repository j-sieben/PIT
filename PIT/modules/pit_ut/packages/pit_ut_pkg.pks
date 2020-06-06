create or replace package pit_ut_pkg
  authid definer
as
  
  /** Implementation package for type PIT_UT */
    
  procedure log (
    p_message in message_type);
    
  procedure print (
    p_message in message_type);
    
  procedure notify (
    p_message in message_type);

  procedure enter(
    p_call_stack in call_stack_type);

  procedure leave(
    p_call_stack in call_stack_type);
    
  procedure context_changed(
    p_ctx in pit_context);

  procedure initialize_module(
    self in out pit_ut);
end pit_ut_pkg;
/
