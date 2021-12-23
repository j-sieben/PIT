declare
  l_has_invalid_items pls_integer;
begin
  
  dbms_output.put_line('&s1.Recompiling schema ' || user);
  dbms_utility.compile_schema(schema => user);
  
  for i in 1 .. 3 loop
    select count(*)
      into l_has_invalid_items
      from user_objects
     where status = 'INVALID';
    if l_has_invalid_items > 0 then
      dbms_output.put_line('&s1.compiling invalid components');
      dbms_utility.compile_schema(schema => user);
    else
      dbms_output.put_line('&s1.no invalid components found.');
      exit;
    end if;
  end loop;
  if user != '&REMOTE_USER.' then
    dbms_output.put_line('&s1.Recompiling schema &REMOTE_USER.');
    dbms_utility.compile_schema(schema => '&REMOTE_USER.');
    dbms_session.reset_package;
  end if;
end;
/

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
    pit.handle_exception(msg.sql_error, msg_args('Test'));
  pit.reset_context;
end test_pit;
/


prompt 
prompt &s1.Content of log table PIT_TABLE_LOG from module PIT_TABLE
prompt 
column user_name format a15
column log_date format a25
column msg_text format a45
select log_id, user_name, log_date, msg_text
  from pit_table_log;
prompt .