create or replace package body pit_test_cases 
as

  C_PKG constant pit_util.ora_name_type := $$PLSQL_UNIT;
  C_CTX_FULL constant pit_util.ora_name_type := 'CONTEXT_TEST_FULL';
  C_CTX_LOG constant pit_util.ora_name_type := 'CONTEXT_TEST_LOG_ONLY';
  C_CTX_OFF constant pit_util.ora_name_type := 'CONTEXT_TEST_OFF';
  C_TOGGLE_MODULE constant pit_util.ora_name_type := 'TEST';
  C_TOGGLE_ON_ACTION constant pit_util.ora_name_type := 'MY_PROC';
  C_TOGGLE_OFF_ACTION constant pit_util.ora_name_type := 'MY_OTHER_PROC';
  
  
  procedure toggle_off
  as
  begin
    pit.enter_mandatory(C_TOGGLE_OFF_ACTION, C_TOGGLE_MODULE);
    pit.leave_mandatory;
  end toggle_off;
  
  
  procedure toggle_on(
    p_proceed in boolean)
  as
  begin
    pit.enter_mandatory(C_TOGGLE_ON_ACTION, C_TOGGLE_MODULE);
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
    pit.enter_mandatory('toggle_context_1', C_PKG);
    toggle_on(false);
    pit.leave_mandatory;
  end toggle_context_1;
  
  
  procedure set_ctx
  as
  begin
    pit.set_context(C_CTX_LOG);
    pit.enter_mandatory('set_ctx', C_PKG);
    toggle_on(false);
    pit.leave_mandatory;
  end set_ctx;
  
  
  procedure toggle_context_2
  as
  begin
    pit.enter_mandatory('toggle_context_2', C_PKG);
    set_ctx;
    pit.leave_mandatory;
  end toggle_context_2;
  
  
  procedure toggle_context_3
  as
  begin
    pit.enter_mandatory('toggle_context_3', C_PKG);
    toggle_on(true);
    pit.leave_mandatory;
  end toggle_context_3;
  
  
  procedure catch_error_anyway 
  as
  begin
    set_context(C_CTX_OFF);
    pit.error(msg.SQL_ERROR, msg_args('Test error'), '123');
  exception
    when msg.SQL_ERROR_ERR then
      pit.sql_exception;
  end catch_error_anyway;
  
  
  procedure catch_fatal_and_stop
  as
  begin
    set_context(C_CTX_OFF);
    pit.error(msg.SQL_ERROR, msg_args('Test error'), '123');
  exception
    when msg.SQL_ERROR_ERR then
      pit.stop;
  end catch_fatal_and_stop;
  

end pit_test_cases;
/