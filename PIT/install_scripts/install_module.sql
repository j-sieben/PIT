
@init/init_module.sql &1. &2. &3.

define module_dir = modules/&MODULE./

prompt
prompt &section.
prompt &h1.PL/SQL INSTRUMENTATION TOOLKIT (PIT) output module installation at user &INSTALL_USER.

prompt
prompt &section.
prompt &h1.Checking installation prerequisites
declare
  l_install_user_exists pls_integer;
  l_pit_exists pls_integer;
begin
  select count(*)
    into l_install_user_exists
    from all_users
   where username = '&INSTALL_USER.';

  if l_install_user_exists = 0 then
    raise_application_error(-20000, 'User &INSTALL_USER. does not exist.');
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

alter session set current_schema=&INSTALL_USER.;
prompt &s1.Set Compiler-Flags
alter session set plsql_ccflags = 'development:&INSTALL_ON_DEV., pit_installed:TRUE';
alter session set plsql_optimize_level = 3;
alter session set plsql_code_type='NATIVE';
alter session set plscope_settings='IDENTIFIERS:ALL';

prompt
prompt &section.
prompt &h1.Installing module &MODULE.
@&module_dir.install.sql


prompt
prompt &section.
prompt &h1.Finished installation of PIT module &MODULE.

exit
