declare
  l_utl_text_exists number;
  l_requirements_given boolean := true;
  x_does_not_exist exception;
  pragma exception_init(x_does_not_exist, -6550);
begin
  dbms_output.put_line('Check whether UTL_TEXT is accessible');
  select count(*)
    into l_utl_text_exists
    from dual
   where exists(
         select null
           from all_objects
          where object_name = 'UTL_TEXT');
            
  if l_utl_text_exists = 0 then
    dbms_output.put_line('&s1.UTL_TEXT is required by this package. You can get it from GitHub as well.');
    l_requirements_given := false;
  end if;
  
  if not l_requirements_given then
    raise_application_error(-20000, 'Installation prerequisites not given, please sort the reported issues out.');
  end if;
end;
/
