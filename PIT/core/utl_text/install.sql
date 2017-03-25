define utl_text_dir=core/utl_text/
define sql_dir=&utl_text_dir.sql/
define plsql_dir=&utl_text_dir.plsql/

prompt
prompt &h1.Installing UTL_TEXT utility

prompt &h2.Create type declarations
prompt &s1.Create type CHAR_TABLE
@&sql_dir.types/char_table.tps
show errors

prompt &h2.Create package declarations
prompt &s1.Create package UTL_TEXT
@&plsql_dir.utl_text.pks
show errors

prompt &h2.Create package bodies
prompt &s1.Create package body UTL_TEXT
@&plsql_dir.utl_text.pkb
show errors
