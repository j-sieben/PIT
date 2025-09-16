create or replace type body pit_table as

  /** Implementation of PIT_TABLE output module functionality */
  
  
  overriding member procedure log_exception(
    self in out nocopy pit_table,
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
       pit_table_pkg.log_exception(p_message);
    end if;
  end log_exception;
  
  overriding member procedure panic(
    self in out nocopy pit_table,
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
       pit_table_pkg.panic(p_message);
    end if;
  end panic;
  
  overriding member procedure tweet(
    self in out nocopy pit_table,
    p_message in message_type)
  as
  begin
    pit_table_pkg.tweet(p_message);
  end tweet;
    
  overriding member procedure log_state(
    self in out nocopy pit_table,
    p_log_state in pit_log_state_type)
  as
  begin
    if p_log_state.severity <= fire_threshold then
       pit_table_pkg.log_state(p_log_state);
    end if;
  end log_state;
  
  overriding member procedure enter(
    self in out nocopy pit_table,
    p_call_stack pit_call_stack_type)
  as
  begin
    pit_table_pkg.enter(p_call_stack);
  end enter;
  
  overriding member procedure leave(
    self in out nocopy pit_table,
    p_call_stack pit_call_stack_type)
  as
  begin
    pit_table_pkg.leave(p_call_stack);
  end leave;
  
  overriding member procedure purge_log(
    self in out nocopy pit_table,
    p_purge_date in date,
    p_severity_greater_equal in integer default null)
  as
  begin
    pit_table_pkg.purge_log(p_purge_date, p_severity_greater_equal);
  end purge_log;
  
  constructor function pit_table (
    self in out nocopy pit_table)
    return self as result
  as
  begin
    pit_table_pkg.initialize_module(self);
    return;
  end pit_table;
end;
/