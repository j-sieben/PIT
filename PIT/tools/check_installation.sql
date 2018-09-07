declare
  l_has_invalid_items pls_integer;
begin
  
  dbms_output.put_line('&s1.Recompiling schema &INSTALL_USER.');
  dbms_utility.compile_schema(schema => '&INSTALL_USER.');
  
  for i in 1 .. 3 loop
    select count(*)
      into l_has_invalid_items
    from dba_objects
     where owner = upper('&INSTALL_USER.')
       and status = 'INVALID';
    if l_has_invalid_items > 0 then
      dbms_output.put_line('&s1.compiling invalid components');
      dbms_utility.compile_schema(schema => '&INSTALL_USER.');
    else
      dbms_output.put_line('&s1.no invalid components found.');
      exit;
    end if;
  end loop;
  if '&INSTALL_USER.' != '&REMOTE_USER.' then
    dbms_output.put_line('&s1.Recompiling schema &REMOTE_USER.');
    dbms_utility.compile_schema(schema => '&REMOTE_USER.');
    dbms_session.reset_package;
  end if;
end;
/

alter session set current_schema=&REMOTE_USER.;

prompt &s1.Output of module PIT_CONSOLE
prompt 

begin
  --dbms_session.reset_package;
  pit.initialize;
  pit.set_context(70,50,true,'PIT_CONSOLE:PIT_TABLE');
  pit.enter('PIT_TEST', 'anyonymous block');
  pit.error(msg.sql_error, msg_args('Testfehler'));
  pit.leave;
exception
  when msg.sql_error_err then
    pit.sql_exception(msg.sql_error, msg_args('Test'));
  pit.reset_context;
end test_pit;
/


alter session set current_schema=&INSTALL_USER.;

prompt 
prompt &s1.Content of log table PIT_LOG from module PIT_TABLE
prompt 
column user_name format a15
column log_date format a25
column msg_text format a45
select log_id, user_name, log_date, msg_text
  from pit_log;
prompt .