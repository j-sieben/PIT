@init_uninstall.sql &1. &2.

alter session set current_schema=&INSTALL_USER.;

prompt &section.

prompt &h1.Deinstall OUTPUT-MODULES
prompt &h2.Module PIT_CONSOLE
@modules/pit_console/sql/clean_up.sql
prompt &h2.Module PIT_TABLE
@modules/pit_table/sql/clean_up.sql
prompt &h2.Module PIT_APEX
@modules/pit_apex/sql/clean_up.sql
prompt &h2.Module PIT_FILE
@modules/pit_file/sql/clean_up.sql
prompt &h2.Module PIT_MAIL
@modules/pit_mail/sql/clean_up.sql
prompt &h2.Module PIT_TEST
@modules/pit_test/sql/clean_up.sql

prompt &h1.PL/SQL INSTRUMENTATION TOOLKIT (PIT) Deinstallation
prompt &h1.Deinstall CORE Functionality
@core/clean_up_install.sql

prompt &h1.Deinstall CONTEXT Framework
@core/context/clean_up.sql

prompt &h1.Deinstall PARAMETER Framework
@core/parameters/clean_up_install.sql

exit;
