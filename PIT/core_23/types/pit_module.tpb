create or replace type body pit_module 
as
  /** Implementation of abstract output module. Implements stubs for all methods only */
  
  
  member procedure context_changed(
    self in out nocopy pit_module,
    p_ctx in pit_context_type)
  as
  begin
    null;
  end context_changed;
  
  member procedure tweet(
    self in out nocopy pit_module,
    p_message in message_type)
  as
  begin
    null;
  end tweet;
  
  member procedure log (
    self in out nocopy pit_module,
    p_message in message_type)
  as
  begin
    null;
  end log;
  
  member procedure log (
    self in out nocopy pit_module,
    p_log_state in pit_log_state_type)
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
    p_call_stack pit_call_stack_type)
  as
  begin
    null;
  end enter;
  
  member procedure leave (
    self in out nocopy pit_module,
    p_call_stack pit_call_stack_type)
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
