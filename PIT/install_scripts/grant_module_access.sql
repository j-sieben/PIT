@init/init_module_client.sql &1. &2. &3.
define module_dir=modules/&MODULE./

prompt
prompt &section.
prompt &h1.Granting access to PIT module &MODULE. for client &REMOTE_USER.

prompt
prompt &h2.Checking installation prerequisites
declare
  l_install_user_exists pls_integer;
  l_remote_user_exists pls_integer;
  l_pit_exists pls_integer;
begin
  select count(*)
    into l_install_user_exists
    from all_users
   where username = '&INSTALL_USER.';

  select count(*)
    into l_remote_user_exists
    from all_users
   where username = '&REMOTE_USER.';

  if l_install_user_exists = 0 then
    raise_application_error(-20000, 'User &INSTALL_USER. does not exist.');
  end if;

  if l_remote_user_exists = 0 then
    raise_application_error(-20000, 'User &REMOTE_USER. does not exist.');
  end if;

  select count(*)
    into l_pit_exists
    from all_objects
   where owner = '&INSTALL_USER.'
     and object_type = 'PACKAGE'
     and object_name = 'PIT';

  if l_pit_exists = 0 then
    raise_application_error(-20000, 'No PIT installation found in schema &INSTALL_USER..');
  end if;
end;
/

prompt
prompt &h2.Grant access to PIT module installation
@&module_dir.grant_client.sql

prompt
prompt &h1.Finished PIT-Grant for module &MODULE. to &REMOTE_USER.

exit
