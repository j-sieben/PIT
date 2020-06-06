create or replace package pit_apex_pkg
  authid definer
as
  /* Implementation package for type PIT_APEX */
  function get_apex_triggered_context
    return varchar2;
  
  procedure log(p_message in message_type);
  
  procedure print(p_message in message_type);
  
  procedure notify(p_message in message_type);
  
  procedure enter(
    p_call_stack in call_stack_type);
    
  procedure leave(
    p_call_stack in call_stack_type);
    
  procedure initialize_module(
    self in out nocopy pit_apex);
end pit_apex_pkg;
/
