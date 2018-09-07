create or replace package pit_table_pkg 
as
  /* Implementation package for type PIT_TABLE */
  
  
  procedure log(p_message in message_type);
  
  procedure purge(
    p_date_until in date,
    p_severity_greater_equal in number default null);
  
  procedure enter(
    p_call_stack in call_stack_type);
    
  procedure leave(
    p_call_stack in call_stack_type);

  procedure initialize_module(
    self in out pit_table);
end pit_table_pkg;
/
