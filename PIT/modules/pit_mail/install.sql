define mail_dir=modules/pit_mail/
define table_dir=&mail_dir.tables/
define type_dir=&mail_dir.types/
define script_dir=&mail_dir.scripts/
define pkg_dir=&mail_dir.packages/
define msg_dir=&mail_dir.messages/&DEFAULT_LANGUAGE./

prompt
prompt &section.
prompt &h1.Module PIT_MAIL

@check_prerequisites.sql

prompt &h2.Delete existing types and packages
@&mail_dir.clean_up_install.sql

prompt &h2.Grant user rights to &INSTALL_USER.
@&mail_dir.scripts/user_grants.sql


prompt &h2.Create queue table for PIT_MAIL
@&table_dir.pit_mail_queue.tbl

prompt &h2.Create types and packages for PIT_MAIL

prompt &s1.Create PIT_MAIL parameters
@&script_dir.ParameterGroup_PIT.sql

prompt &s1.Create PIT_MAIL messages
@&sg_dir.MessageGroup_PIT.sql

prompt &s1.Create type PIT_mail
@&type_dir.pit_mail.tps
show errors

prompt &s1.Create package MAIL
@&pkg_dir.mail.pks
show errors

prompt &s1.Create package PIT_MAIL_PKG
@&pkg_dir.pit_mail_pkg.pks
show errors

prompt &s1.Create type body PIT_MAIL
@&type_dir.pit_mail.tpb
show errors

prompt &s1.Create package body MAIL
@&pkg_dir.mail.pkb
show errors

prompt &s1.Create package body PIT_MAIL_PKG
@&pkg_dir.pit_mail_pkg.pkb
show errors
