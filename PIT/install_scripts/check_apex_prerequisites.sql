declare
  c_required_utl_apex_version varchar2(8 byte) := '01.00.00';
  l_utl_text_exists number;
  l_installed_utl_apex_version c_required_utl_apex_version%TYPE;
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
  
  dbms_output.put_line('Check whether UTL_APEX is accessible');
  begin
    execute immediate 'begin :x := utl_apex.utl_apex_version; end;' using out l_installed_utl_apex_version;
    if l_installed_utl_apex_version != c_required_utl_apex_version then
      dbms_output.put_line('&s1.Your version of UTL_APEX is outdated. Please update your version first');
      l_requirements_given := false;
    end if;
  exception
    when x_does_not_exist then
      dbms_output.put_line('&s1.UTL_APEX is required by this package. You can get it from GitHub as well.');
      l_requirements_given := false;
  end;
  
  if not l_requirements_given then
    raise_application_error(-20000, 'Installation prerequisites not given, please sort the reported issues out.');
  end if;
end;
/
