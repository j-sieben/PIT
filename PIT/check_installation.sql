declare
  l_has_invalid_items pls_integer;
begin
  select count(*)
    into l_has_invalid_items
	from dba_objects
   where owner = upper('&INSTALL_USER.')
     and status = 'INVALID';
  if l_has_invalid_items > 0 then
    dbms_output.put_line('&s1.compiling invalid components');
    dbms_utility.compile_schema(schema => '&INSTALL_USER.');
  else
    dbms_output.put_line('&s1.no invlaid components found.');
  end if;
end;
/

alter session set current_schema=&REMOTE_USER.;

begin
  pit.set_context(70, 70, true, 'PIT_CONSOLE:PIT_TABLE');
  begin
    pit.enter('PIT_TEST', 'anyonymous block');
    pit.error(msg.sql_error, msg_args('Testfehler'));
    pit.leave;
  exception
    when msg.sql_error_err then
      pit.sql_exception(msg.sql_error, msg_args('Test'));
	  pit.reset_context;
  end;
end;
/


alter session set current_schema=&INSTALL_USER.;

prompt Content of log table PIT_LOG from PIT_TABLE output module:
column log_id format a10
column user_name format a10
column log_date format a25
column msg_text format a45
select log_id, user_name, log_date, msg_text
  from pit_log;