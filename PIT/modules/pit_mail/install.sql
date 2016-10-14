define mail_dir=modules/pit_mail/
define sql_dir=&mail_dir.sql/
define plsql_dir=&mail_dir.plsql/

prompt
prompt &section.
prompt &h1.Module PIT_MAIL
prompt &h2.Clean up existing installation
@&mail_dir.clean_up_install.sql

prompt
prompt &section.
prompt &h1.Module PIT_MAIL
prompt &h2.Delete existing types and packages
@&mail_dir.clean_up.sql

prompt &h2.Grant user rights to &INSTALL_USER.
@&mail_dir.user_grants.sql

prompt &h2.Create types and packages for PIT_MAIL
prompt &s1.Create PIT_MAIL parameters
@&mail_dir.create_parameters.sql

prompt &s1.Create type PIT_mail
@&sql_dir.types/pit_mail.tps
show errors

prompt &s1.Create package PIT_MAIL_PKG
@&plsql_dir.pit_mail_pkg.pks
show errors

prompt &s1.Create type body PIT_MAIL
@&sql_dir.types/pit_mail.tpb
show errors

prompt &s1.Create package body PIT_MAIL_PKG
@&plsql_dir.pit_mail_pkg.pkb
show errors
