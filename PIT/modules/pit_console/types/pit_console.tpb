create or replace type body pit_console 
as
  overriding member procedure log(
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
       pit_console_pkg.log(p_message);
    end if;
  end log;
  
  
  overriding member procedure print(
    p_message in message_type)
  as
  begin
    pit_console_pkg.log(p_message);
  end print;
  
  
  overriding member procedure notify(
    p_message in message_type)
  as
  begin
    pit_console_pkg.log(p_message);
  end notify;
  
  
  overriding member procedure enter(
    p_call_stack call_stack_type)
  as
  begin
    pit_console_pkg.enter(p_call_stack);
  end enter;
  
  
  overriding member procedure leave (
    p_call_stack call_stack_type)
  as
  begin
    pit_console_pkg.leave(p_call_stack);
  end leave;
  
  overriding member procedure context_changed(
    p_ctx in pit_context)
  as
  begin
    pit_console_pkg.context_changed(p_ctx);
  end context_changed;
  
  
  constructor function pit_console (
    self in out nocopy pit_console)
    return self as result
  as
  begin
    pit_console_pkg.initialize_module(self);
    return;
  end pit_console;
end;
/
