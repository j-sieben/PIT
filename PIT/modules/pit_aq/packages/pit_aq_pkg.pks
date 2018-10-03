create or replace package pit_aq_pkg
  authid definer
as
  /* Implementation package for type pit_aq */
  
  procedure log (
    p_message in message_type);

  procedure print(
    p_message in message_type);

  procedure notify(
    p_message in message_type);

  procedure enter(
    p_call_stack in call_stack_type);

  procedure leave(
    p_call_stack in call_stack_type);

  procedure purge_log(
    p_purge_date in date,
    p_severity_greater_equal in number default null);

  procedure context_changed(
    p_ctx in pit_context);

  procedure initialize_module(
    self in out nocopy pit_aq);
    
end pit_aq_pkg;
/