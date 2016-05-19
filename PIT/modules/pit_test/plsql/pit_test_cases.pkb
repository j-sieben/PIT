create or replace package body pit_test_cases 
as

  c_pkg constant varchar2(30) := $$PLSQL_UNIT;
  c_ctx_full constant varchar2(30) := 'CONTEXT_TEST_FULL';
  c_ctx_log constant varchar2(30) := 'CONTEXT_TEST_LOG_ONLY';
  c_ctx_off constant varchar2(30) := 'CONTEXT_TEST_OFF';
  c_toggle_module constant varchar2(30) := 'TEST';
  c_toggle_on_action constant varchar2(30) := 'MY_PROC';
  c_toggle_off_action constant varchar2(30) := 'MY_OTHER_PROC';
  
  
  procedure toggle_off
  as
  begin
    pit.enter_mandatory(c_toggle_off_action, c_toggle_module);
    pit.leave_mandatory;
  end toggle_off;
  
  
  procedure toggle_on(
    p_proceed in boolean)
  as
  begin
    pit.enter_mandatory(c_toggle_on_action, c_toggle_module);
    if p_proceed then
      toggle_off;
    end if;
    pit.leave_mandatory;
  end toggle_on;
  

  procedure set_context(
    p_context_name in varchar2)
  as
  begin
    pit.reset_context(false);
    pit.set_context(p_context_name);
  end set_context;
  
  
  procedure toggle_context_1
  as
  begin
    pit.enter_mandatory('toggle_context_1', c_pkg);
    toggle_on(false);
    pit.leave_mandatory;
  end toggle_context_1;
  
  
  procedure set_ctx
  as
  begin
    pit.set_context(c_ctx_log);
    pit.enter_mandatory('set_ctx', c_pkg);
    toggle_on(false);
    pit.leave_mandatory;
  end set_ctx;
  
  
  procedure toggle_context_2
  as
  begin
    pit.enter_mandatory('toggle_context_2', c_pkg);
    set_ctx;
    pit.leave_mandatory;
  end toggle_context_2;
  
  
  procedure toggle_context_3
  as
  begin
    pit.enter_mandatory('toggle_context_3', c_pkg);
    toggle_on(true);
    pit.leave_mandatory;
  end toggle_context_3;
  
  
  procedure catch_error_anyway 
  as
  begin
    set_context(c_ctx_off);
    pit.error(msg.SQL_ERROR, msg_args('Test error'), '123');
  exception
    when msg.SQL_ERROR_ERR then
      pit.sql_exception;
  end catch_error_anyway;
  
  
  procedure catch_fatal_and_stop
  as
  begin
    set_context(c_ctx_off);
    pit.error(msg.SQL_ERROR, msg_args('Test error'), '123');
  exception
    when msg.SQL_ERROR_ERR then
      pit.stop;
  end catch_fatal_and_stop;
  

end pit_test_cases;
/