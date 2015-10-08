prompt
prompt &section.
prompt &h1.Module PIT_MAIL
prompt &h2.Delete existing types and packages
@modules/pit_mail/sql/clean_up.sql

prompt &h2.Grant user rights to &INSTALL_USER.
@modules/pit_mail/sql/user_grants.sql

prompt &h2.Create types and packages for PIT_MAIL
prompt &s1.Create PIT_MAIL parameters
@modules/pit_mail/sql/create_parameters.sql

prompt &s1.Create type PIT_mail
@modules/pit_mail/sql/pit_mail.tps
show errors

prompt &s1.Create package PIT_MAIL_PKG
@modules/pit_mail/plsql/pit_mail_pkg.pks
show errors

prompt &s1.Create type body PIT_MAIL
@modules/pit_mail/sql/pit_mail.tpb
show errors

prompt &s1.Create package body PIT_MAIL_PKG
@modules/pit_mail/plsql/pit_mail_pkg.pkb
show errors
