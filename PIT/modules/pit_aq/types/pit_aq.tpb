create or replace type body pit_aq
as
  overriding member procedure log(
    self in out nocopy pit_aq,
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
      pit_aq_pkg.log(p_message);
    end if;
  end log;
  
  
  overriding member procedure print(
    self in out nocopy pit_aq,
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
      pit_aq_pkg.print(p_message);
    end if;
  end print;
  
  
  overriding member procedure notify(
    self in out nocopy pit_aq,
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
      pit_aq_pkg.notify(p_message);
    end if;
  end notify;
  

  overriding member procedure purge(
    self in out nocopy pit_aq,
    p_purge_date in date,
    p_severity_greater_equal in integer default null)
  as
  begin
    pit_aq_pkg.purge_log(
      p_purge_date => p_purge_date,
      p_severity_greater_equal => p_severity_greater_equal);
  end purge;
  
  
  overriding member procedure enter(
    self in out nocopy pit_aq,
    p_call_stack in call_stack_type)
  as
  begin
    pit_aq_pkg.enter(p_call_stack);
  end enter;
  
  
  overriding member procedure leave(
    self in out nocopy pit_aq,
    p_call_stack in call_stack_type)
  as
  begin
    pit_aq_pkg.leave(p_call_stack);
  end leave;
  

  constructor function pit_aq (
    self in out nocopy pit_aq)
    return self as result
  as
  begin
    pit_aq_pkg.initialize_module(self);
    return;
  end pit_aq;
end;
/
