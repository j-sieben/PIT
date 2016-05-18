create or replace package body pit_test_cases 
as

  c_ctx_full constant varchar2(30) := 'CONTEXT_TEST_FULL';
  c_ctx_off constant varchar2(30) := 'CONTEXT_TEST_OFF';

  procedure set_context(
    p_context_name in varchar2)
  as
  begin
    pit.reset_context(false);
    pit.set_context(p_context_name);
  end set_context;
  
  
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