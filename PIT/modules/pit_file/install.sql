prompt
prompt &section.
prompt &h1.Module PIT_FILE
prompt &h2.Delete existing types and packages
@modules/pit_file/sql/clean_up.sql

prompt
prompt &h2.Grant user rights for PIT_FILE
prompt &h3.Grant user rights to &INSTALL_USER.
@modules/pit_file/sql/user_grants.sql

prompt &h2.Create types adn packages
prompt &s1.Create type PIT_FILE
@modules/pit_file/sql/pit_file.tps
show errors

prompt &s1.Create package PIT_FILE_PKG
@modules/pit_file/plsql/pit_file_pkg.pks
show errors

prompt &s1.Create type body PIT_FILE
@modules/pit_file/sql/pit_file.tpb
show errors

prompt &s1.Create package body PIT_FILE_PKG
@modules/pit_file/plsql/pit_file_pkg.pkb
show errors

prompt &s1.Create PIT_FILE parameters
@modules/pit_file/sql/create_parameters.sql

prompt ### CAVE ###
prompt Please remember to create a directory called PIT_FILE_DIR before use.
prompt This directory is required to enable PIT to store files.
prompt 