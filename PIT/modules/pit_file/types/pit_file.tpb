create or replace type body pit_file
as
  overriding member procedure log(
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
      pit_file_pkg.log(p_message);
    end if;
  end log;

  overriding member procedure purge(
    p_purge_date in date,
    p_severity_greater_equal in integer default null)
  as
  begin
    pit_file_pkg.purge;
  end purge;
  
  overriding member procedure enter(
    p_call_stack in call_stack_type)
  as
  begin
    pit_file_pkg.enter(p_call_stack);
  end enter;
  
  overriding member procedure leave(
    p_call_stack in call_stack_type)
  as
  begin
    pit_file_pkg.leave(p_call_stack);
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
