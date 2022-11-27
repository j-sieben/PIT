create or replace type body pit_console 
as
  /** Implementation of PIT CONSOLE output module */
  
  
  overriding member procedure log(
    self in out nocopy pit_console,
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
       pit_console_pkg.log(p_message);
    end if;
  end log;
  
  
  overriding member procedure log(
    self in out nocopy pit_console,
    p_log_state pit_log_state_type)
  as
  begin
    pit_console_pkg.log(p_log_state);
  end log;
  
  
  overriding member procedure print(
    self in out nocopy pit_console,
    p_message in message_type)
  as
  begin
    pit_console_pkg.log(p_message);
  end print;
  
  
  overriding member procedure notify(
    self in out nocopy pit_console,
    p_message in message_type)
  as
  begin
    pit_console_pkg.log(p_message);
  end notify;
  
  
  overriding member procedure enter(
    self in out nocopy pit_console,
    p_call_stack pit_call_stack_type)
  as
  begin
    pit_console_pkg.enter(p_call_stack);
  end enter;
  
  
  overriding member procedure leave (
    self in out nocopy pit_console,
    p_call_stack pit_call_stack_type)
  as
  begin
    pit_console_pkg.leave(p_call_stack);
  end leave;
  
  overriding member procedure context_changed(
    self in out nocopy pit_console,
    p_ctx in pit_context_type)
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
