create or replace type body pit_apex as

  /** Implementation of type PIT_APEX */
   
   overriding member procedure tweet(
    self in out nocopy pit_apex,
      p_message in message_type)
   as
   begin
      pit_apex_pkg.tweet(p_message);
   end tweet;
   
   overriding member procedure log(
    self in out nocopy pit_apex,
      p_message in message_type)
   as
   begin
      if p_message.severity <= fire_threshold then
         pit_apex_pkg.log(p_message);
      end if;
   end log;
   
   overriding member procedure log(
    self in out nocopy pit_apex,
      p_log_state in pit_log_state_type)
   as
   begin
      pit_apex_pkg.log(p_log_state);
   end log;
   
   overriding member procedure print(
    self in out nocopy pit_apex,
      p_message in message_type)
   as
   begin
      pit_apex_pkg.print(p_message);
   end print;
   
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
