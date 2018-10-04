
declare
  l_is_installed pls_integer;
begin
  select count(*)
    into l_is_installed
	  from dba_objects
   where owner = '&INSTALL_USER.'
     and object_type = 'PACKAGE'
	   and object_name in ('UTL_CONTEXT', 'PARAM', 'PARAM_ADMIN');
  if l_is_installed < 3 then
    raise_application_error(-20000, 'Installation of PARAM/PARAM_ADMIN/UTL_CONTEXT is required to install PIT. Please make sure that these packages are installed.');
  else
    dbms_output.put_line('&s1.Installation prerequisites checked succesfully.');
  end if;
end;
/
