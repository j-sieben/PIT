/*
  Script to install PIT-CLIENT
  Usage:
  Call this script either directly or by using the bat/sh script files.
  
  Parameter:
  - REMOTE_USER:  database user who will be enabled to use PIT
*/

set termout off

@init/init_client.sql &1. &2.

prompt &s1.Checking whether PIT exists at user &PIT_USER.
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

@init/settings.sql

prompt
prompt &section.
prompt &h1.Registering PIT, found at &PIT_USER. at client &REMOTE_USER.

@parameters/register_client.sql

@core/register_client.sql

prompt
prompt &section.
prompt &h1.Registering PIT output modules
@modules/pit_console/register_client.sql
@modules/pit_table/register_client.sql
@modules/pit_apex/register_client.sql
--@modules/pit_test/register_client.sql
@modules/pit_file/register_client.sql
--@modules/pit_mail/register_client.sql

prompt &h1.Finished PIT client registration

exit

