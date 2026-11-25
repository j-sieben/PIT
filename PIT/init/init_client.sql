set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "

set termout off
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
define s1=".   - "

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
 
-- PIT identifiers use an explicit byte limit, independent of NLS length semantics.
define ORA_NAME_TYPE="varchar2(128 byte)"
define ORA_MAX_LENGTH=128
   
set termout on