
prompt
prompt &section.
prompt &h1.Registering PIT, found at &PIT_USER. at client &REMOTE_USER.
prompt &section.

@init/init_client.sql &1. &2.

prompt &h2.Check whether PIT exists at user &PIT_USER.
set termout off
col default_tablespace new_val DEFAULT_TABLESPACE format a128
select default_tablespace
  from user_users;

declare
  l_pit_exists binary_integer;
begin
  select count(*)
    into l_pit_exists
    from all_objects
   where object_type = 'PACKAGE'
     and object_name = 'PIT'
     and owner = '&PIT_USER.';
     
  if l_pit_exists = 0 then
    raise_application_error(-20000, 'No PIT installation found. Check whether the grants have been set.');
  end if;
end;
/
set termout on

@init/settings.sql

prompt &h2.Register Parameter Client
@parameters/register_client.sql

prompt &h2.Register PIT Client
@core/register_client.sql

prompt
prompt &h1.Registering PIT output modules
@modules/pit_console/register_client.sql
@modules/pit_table/register_client.sql
@modules/pit_apex/register_client.sql
--@modules/pit_test/register_client.sql
@modules/pit_file/register_client.sql
--@modules/pit_mail/register_client.sql

prompt &section.
prompt &h1.Finished PIT client registration
prompt &section.

exit

