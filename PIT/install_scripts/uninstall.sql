/*
  Script to uninstall PIT
  
*/
set termout off

col default_language new_val DEFAULT_LANGUAGE format a128
select pit.get_default_language default_language
  from dual;
  
col with_context new_val WITH_CONTEXT format a10
select case count(*) when 1 then 'true' else 'false' end with_context
  from user_objects
 where object_type = 'PACKAGE'
   and object_name = 'UTL_CONTEXT';
set termout on

@init/init.sql &DEFAULT_LANGUAGE.

prompt &section.
prompt &h1.PL/SQL INSTRUMENTATION TOOLKIT (PIT) Deinstallation

prompt &h1.Deinstall OUTPUT-MODULES
prompt &h2.Module PIT_CONSOLE
@modules/pit_console/clean_up_install.sql
prompt &h2.Module PIT_TABLE
@modules/pit_table/clean_up_install.sql
prompt &h2.Module PIT_APEX
@modules/pit_apex/clean_up_install.sql
prompt &h2.Module PIT_FILE
@modules/pit_file/clean_up_install.sql
prompt &h2.Module PIT_MAIL
@modules/pit_mail/clean_up_install.sql

prompt &h2.Module PIT_TEST
@tests/pit_ut/clean_up_install.sql

prompt &h1.Deinstall CORE Functionality
@core/clean_up_install.sql

prompt &h1.Deinstall CONTEXT Framework
@context/clean_up.sql

prompt &h1.Deinstall PARAMETER Framework
@parameters/clean_up_install.sql

prompt &h1.Finished PIT De-Installation

exit