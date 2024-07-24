set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999


begin
  $IF dbms_db_version.ver_le_19 $THEN
  null;
  $ELSIF dbms_db_version.ver_le_21 $THEN
  null;
  $ELSE
  execute immediate 'alter session set plsql_implicit_conversion_bool = true';
  $END
end;
/

whenever sqlerror exit


define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "

set termout off

col pit_user new_val PIT_USER format a128
col remote_user new_val REMOTE_USER format a128

 
select case when instr('&1.', '[') > 0 
       then substr(upper('&1.'), instr('&1.', '[') + 1, length('&1.') - instr('&1.', '[') - 1)
       else coalesce(upper('&1.'), user) end pit_user, 
       case when instr('&2.', '[') > 0 
       then substr(upper('&2.'), instr('&2.', '[') + 1, length('&2.') - instr('&2.', '[') - 1)
       else coalesce(upper('&2.'), user) end remote_user
  from dual;
  
define INSTALL_USER = &PIT_USER.
 
-- Define length of ORA_NAME_TYPE according to oracle version
col ora_name_type new_val ORA_NAME_TYPE format a128
col ora_max_length new_val ORA_MAX_LENGTH format a128

select lower(data_type) || '(' || data_length || case char_used when 'B' then ' byte)' else ' char)' end ora_name_type, data_length ora_max_length
  from all_tab_columns
 where table_name = 'USER_TABLES'
   and column_name = 'TABLE_NAME';
set termout on