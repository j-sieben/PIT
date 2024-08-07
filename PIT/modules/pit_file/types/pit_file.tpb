create or replace type body pit_file
as
  /** Implementation of output module PIT_FILE */
  
  
  overriding member procedure log_exception(
    self in out nocopy pit_file,
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
      pit_file_pkg.log_exception(self, p_message);
    end if;
  end log_exception;
  
  overriding member procedure log_state(
    self in out nocopy pit_file,
    p_log_state in pit_log_state_type)
  as
  begin
    pit_file_pkg.log_state(self, p_log_state);
  end log_state;
  
  overriding member procedure panic(
    self in out nocopy pit_file,
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
      pit_file_pkg.panic(self, p_message);
    end if;
  end panic;

  overriding member procedure purge_log(
    self in out nocopy pit_file,
    p_purge_date in date,
    p_severity_greater_equal in integer default null)
  as
  begin
    pit_file_pkg.purge_log(self, p_purge_date, p_severity_greater_equal);
  end purge_log;
  
  overriding member procedure enter(
    self in out nocopy pit_file,
    p_call_stack in pit_call_stack_type)
  as
  begin
    pit_file_pkg.enter(self, p_call_stack);
  end enter;
  
  overriding member procedure leave(
    self in out nocopy pit_file,
    p_call_stack in pit_call_stack_type)
  as
  begin
    pit_file_pkg.leave(self, p_call_stack);
  end leave;

  constructor function pit_file (
    self in out nocopy pit_file)
    return self as result
  as
  begin
    pit_file_pkg.initialize_module(self);
    return;
  end pit_file;
end;
/
