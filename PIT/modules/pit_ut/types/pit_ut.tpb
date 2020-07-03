create or replace type body pit_ut 
as
  overriding member procedure log(
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
       pit_ut_pkg.log(p_message);
    end if;
  end log;
  
  
  overriding member procedure print(
    p_message in message_type)
  as
  begin
    pit_ut_pkg.print(p_message);
  end print;
  
  
  overriding member procedure notify(
    p_message in message_type)
  as
  begin
    pit_ut_pkg.notify(p_message);
  end notify;
  
  
  overriding member procedure enter(
    p_call_stack call_stack_type)
  as
  begin
    pit_ut_pkg.enter(p_call_stack);
  end enter;
  
  
  overriding member procedure leave (
    p_call_stack call_stack_type)
  as
  begin
    pit_ut_pkg.leave(p_call_stack);
  end leave;
  
  overriding member procedure context_changed(
    p_ctx in pit_context)
  as
  begin
    pit_ut_pkg.context_changed(p_ctx);
  end context_changed;
  
  
  constructor function pit_ut (
    self in out nocopy pit_ut)
    return self as result
  as
  begin
    pit_ut_pkg.initialize_module(self);
    return;
  end pit_ut;
end;
/
