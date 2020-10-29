create or replace type body pit_module 
as
  member procedure context_changed(
    self in out nocopy pit_module,
    p_ctx in pit_context)
  as
  begin
    null;
  end context_changed;
  
  member procedure log (
    self in out nocopy pit_module,
    p_message in message_type)
  as
  begin
    null;
  end log;
  
  member procedure log (
    self in out nocopy pit_module,
    p_params in msg_params)
  as
  begin
    null;
  end log;
  
  member procedure print (
    self in out nocopy pit_module,
    p_message in message_type)
  as
  begin
    null;
  end print;
  
  member procedure notify (
    self in out nocopy pit_module,
    p_message in message_type)
  as
  begin
    null;
  end notify;
  
  member procedure enter (
    self in out nocopy pit_module,
    p_call_stack call_stack_type)
  as
  begin
    null;
  end enter;
  
  member procedure leave (
    self in out nocopy pit_module,
    p_call_stack call_stack_type)
  as
  begin
    null;
  end leave;
  
  member procedure purge (
    self in out nocopy pit_module,
    p_purge_date in date := null,
    p_severity_greater_equal in integer := null)
  as
  begin
    null;
  end purge;
  
end;
/
