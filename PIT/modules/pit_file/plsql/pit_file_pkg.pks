create or replace package pit_file_pkg
as
  
  /* Implementation package for type PIT_FILE */
  
  
  procedure log (
    p_message in message_type);
    
  procedure purge;
  
  procedure enter(
    p_call_stack in call_stack_type);
  
  procedure leave(
    p_call_stack in call_stack_type);
  
  procedure initialize_module(self in out pit_file);
end pit_file_pkg;
/

show errors
