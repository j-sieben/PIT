prompt &s1.Execution rights for PIT_FILE
prompt &s1.Grant execute on UTL_FILE to &INSTALL_USER.
@tools/check_has_object_privilege execute utl_file

prompt &s1.Grant create any directory to &INSTALL_USER.
@tolls/check_has_system_privilege "create any directory"