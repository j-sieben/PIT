@init/init_module_client.sql &1. &2. &3.
define module_dir=modules/&MODULE./

prompt
prompt &section.
prompt &h1.Registering PIT module &MODULE. at client &REMOTE_USER.

prompt
prompt &h2.Check whether PIT exists at user &PIT_USER.
declare
  l_pit_exists pls_integer;
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
prompt &h2.Register PIT module client
@&module_dir.register_client.sql

prompt
prompt &h1.Finished PIT client registration for module &MODULE.

exit
