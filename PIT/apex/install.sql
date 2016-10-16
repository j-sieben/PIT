define apex_dir=apex/
define sql_dir=&apex_dir.sql/
define plsql_dir=&apex_dir.plsql/

prompt &h2.Create UI-VIEWS
prompt &s1.View UI_LOV_PIT_MESSAGE_SEVERITY
@sql_dir.views/ui_lov_pit_message_severity.vw

prompt &s1.View UI_LOV_PIT_TRACE_LEVEL
@sql_dir.views/ui_lov_pit_trace_level.vw

prompt &h2.Create UI-PACKAGES
prompt &s1.Package UI_PIT_PKG
@&plsql_dir.ui_pit_pkg.pks

prompt &s1.Package body UI_PIT_PKG
@&plsql_dir.ui_pit_pkg.pkb