create or replace type body pit_table as
  overriding member procedure log(
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
       pit_table_pkg.log(p_message);
    end if;
  end log;
  
  overriding member procedure enter(
    p_call_stack call_stack_type)
  as
  begin
    pit_table_pkg.enter(p_call_stack);
  end enter;
  
  overriding member procedure leave(
    p_call_stack call_stack_type)
  as
  begin
    pit_table_pkg.leave(p_call_stack);
  end leave;
  
  overriding member procedure purge(
    p_purge_date in date,
    p_severity_greater_equal in integer default null)
  as
  begin
    pit_table_pkg.purge(p_purge_date, p_severity_greater_equal);
  end purge;
  
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
