define mail_dir=modules/pit_mail/

prompt
prompt &section.
prompt &h1.Module PIT_MAIL
prompt &h2.Delete existing types and packages
@&mail_dir.clean_up_install.sql

prompt &h2.Grant user rights to &INSTALL_USER.
@&mail_dir.scripts/user_grants.sql

prompt &h2.Create types and packages for PIT_MAIL
prompt &s1.Create PIT_MAIL parameters
@&mail_dir.scripts/create_parameters.sql
prompt &s1.Create PIT_MAIL messages
@&mail_dir.messages/&DEFAULT_LANGUAGE./create_messages.sql
prompt &s1.Create type PIT_mail
@&mail_dir.types/pit_mail.tps
show errors

prompt &s1.Create package MAIL
@&mail_dir.packages/mail.pks
show errors

prompt &s1.Create package PIT_MAIL_PKG
@&mail_dir.packages/pit_mail_pkg.pks
show errors

prompt &s1.Create type body PIT_MAIL
@&mail_dir.types/pit_mail.tpb
show errors

prompt &s1.Create package body MAIL
@&mail_dir.packages/mail.pkb
show errors

prompt &s1.Create package body PIT_MAIL_PKG
@&mail_dir.packages/pit_mail_pkg.pkb
show errors
