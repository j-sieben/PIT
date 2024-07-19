create or replace type body pit_apex as

  /** Implementation of type PIT_APEX */
  overriding member procedure log_validation(
  self in out nocopy pit_apex,
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
       pit_apex_pkg.log_validation(p_message);
    end if;
  end log_validation;
  
  overriding member procedure log_exception(
  self in out nocopy pit_apex,
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
       pit_apex_pkg.log_exception(p_message);
    end if;
  end log_exception;
  
  overriding member procedure panic(
  self in out nocopy pit_apex,
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
       pit_apex_pkg.panic(p_message);
    end if;
  end panic;
  
  overriding member procedure log_state(
  self in out nocopy pit_apex,
    p_log_state in pit_log_state_type)
  as
  begin
    pit_apex_pkg.log_state(p_log_state);
  end log_state;
  
  overriding member procedure print(
   self in out nocopy pit_apex,
   p_message in message_type)
  as
  begin
    pit_apex_pkg.print(p_message);
  end print;
  
  overriding member procedure tweet(
   self in out nocopy pit_apex,
   p_message in message_type)
  as
  begin
    pit_apex_pkg.tweet(p_message);
  end tweet;
  
  overriding member procedure notify(
  self in out nocopy pit_apex,
    p_message in message_type)
  as
  begin
    pit_apex_pkg.notify(p_message);
  end notify;
  
  overriding member procedure enter(
  self in out nocopy pit_apex,
    p_call_stack in pit_call_stack_type)
  as
  begin
    pit_apex_pkg.enter(p_call_stack);
  end enter;
  
  overriding member procedure leave(
  self in out nocopy pit_apex,
    p_call_stack in pit_call_stack_type)
  as
  begin
    pit_apex_pkg.leave(p_call_stack);
  end leave;
  
  constructor function pit_apex (
    self in out nocopy pit_apex)
    return self as result
  as
  begin
    pit_apex_pkg.initialize_module(self);
    return;
  end pit_apex;
end;
/
