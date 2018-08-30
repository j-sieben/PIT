create or replace type body pit_apex as
   
   overriding member procedure log(
      p_message in message_type)
   as
   begin
      if p_message.severity <= fire_threshold then
         pit_apex_pkg.log(p_message);
      end if;
   end log;
   
   overriding member procedure print(
      p_message in message_type)
   as
   begin
      pit_apex_pkg.print(p_message);
   end print;
   
   overriding member procedure notify(
      p_message in message_type)
   as
   begin
      pit_apex_pkg.notify(p_message);
   end notify;
   
   overriding member procedure enter(
      p_call_stack in call_stack_type)
   as
   begin
      pit_apex_pkg.enter(p_call_stack);
   end enter;
   
   overriding member procedure leave(
      p_call_stack in call_stack_type)
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
