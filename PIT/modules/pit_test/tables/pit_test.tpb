  create or replace 
  type body pit_test 
  as
  overriding member procedure context_changed(
    p_ctx in pit_context)
  as
  begin
    pit_test_pkg.context_changed(p_ctx);
  end context_changed;
  
  overriding member procedure log (
    p_message in message_type)
  as
  begin
    pit_test_pkg.log(p_message);
  end log;
  
  overriding member procedure print (
    p_message in message_type)
  as
  begin
    pit_test_pkg.print(p_message);
  end print;
  
  overriding member procedure enter (
    p_call_stack call_stack_type)
  as
  begin
    pit_test_pkg.enter(p_call_stack);
  end enter;
  
  overriding member procedure leave (
    p_call_stack call_stack_type)
  as
  begin
    pit_test_pkg.leave(p_call_stack);
  end leave;
  
  overriding member procedure purge (
    p_purge_date in date := null,
    p_severity_greater_equal in number default null)
  as
  begin
    pit_test_pkg.purge_log(
      p_purge_date => p_purge_date,
      p_severity_greater_equal => p_severity_greater_equal);
  end purge;
  
  constructor function pit_test (
    self in out nocopy pit_test)
    return self as result
  as
  begin
    pit_test_pkg.initialize_module(self);
    return;
  end pit_test;
  
  end;
  /