
prompt &s1.Set Compiler-Flags
alter session set plsql_optimize_level = 3;
begin
  execute immediate q'^alter session set plsql_code_type='NATIVE^';
exception
  when others then
    null;
end;
/
alter session set plscope_settings='IDENTIFIERS:ALL';