create or replace type body pit_module 
as
  member procedure context_changed(
    p_ctx in pit_context)
  as
  begin
    null;
  end context_changed;
  
  member procedure log (
    p_message in message_type)
  as
  begin
    null;
  end log;
  
  member procedure print (
    p_message in message_type)
  as
  begin
    null;
  end print;
  
  member procedure notify (
    p_message in message_type)
  as
  begin
    null;
  end notify;
  
  member procedure enter (
    p_call_stack call_stack_type)
  as
  begin
    null;
  end enter;
  
  member procedure leave (
    p_call_stack call_stack_type)
  as
  begin
    null;
  end leave;
  
  member procedure purge (
    p_purge_date in date := null,
    p_severity_greater_equal in integer := null)
  as
  begin
    null;
  end purge;
  
  member procedure context_changed
  as
  begin
    null;
  end context_changed;
  
end;
/
