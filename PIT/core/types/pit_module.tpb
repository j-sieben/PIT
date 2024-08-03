create or replace type body pit_module 
as
  /** Implementation of abstract output module. Implements stubs for all methods only */
  
  
  member procedure tweet(
    self in out nocopy pit_module,
    p_message in message_type)
  as
  begin
    null;
  end tweet;
  
  member procedure notify (
    self in out nocopy pit_module,
    p_message in message_type)
  as
  begin
    null;
  end notify;
  
  member procedure log_state (
    self in out nocopy pit_module,
    p_log_state in pit_log_state_type)
  as
  begin
    null;
  end log_state;
  
  member procedure log_validation (
    self in out nocopy pit_module,
    p_message in message_type)
  as
  begin
    null;
  end log_validation;
  
  member procedure log_exception (
    self in out nocopy pit_module,
    p_message in message_type)
  as
  begin
    null;
  end log_exception;  
  
  member procedure panic(
    self in out nocopy pit_module,
    p_message in message_type)
  as
  begin
    null;
  end panic;
  
  member procedure print (
    self in out nocopy pit_module,
    p_message in message_type)
  as
  begin
    null;
  end print;
  
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
  
  member procedure purge_log (
    self in out nocopy pit_module,
    p_purge_date in date := null,
    p_severity_greater_equal in integer := null)
  as
  begin
    null;
  end purge_log;
  
  member procedure context_changed(
    self in out nocopy pit_module,
    p_ctx in pit_context_type)
  as
  begin
    null;
  end context_changed;
  
end;
/
