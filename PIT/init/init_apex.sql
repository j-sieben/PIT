set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999

whenever sqlerror exit
set termout on

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".   - "

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

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "

col install_user new_val INSTALL_USER format a30
col remote_user new_val REMOTE_USER format a30
col default_language new_val DEFAULT_LANGUAGE format a30

define APEX_ALIAS = PITA
define APP_ID = &4.


select case when instr('&1.', '[') > 0 
       then substr(upper('&1.'), instr('&1.', '[') + 1, length('&1.') - instr('&1.', '[') - 1)
       else coalesce(upper('&1.'), user) end install_user,
       case when instr('&2.', '[') > 0 
       then substr(upper('&2.'), instr('&2.', '[') + 1, length('&2.') - instr('&2.', '[') - 1)
       else coalesce(upper('&2.'), user) end remote_user
  from dual;
  
define PIT_USER = &INSTALL_USER.
   
declare
  l_ws_exists binary_integer;
begin
  
  select count(*)
    into l_ws_exists
    from apex_workspaces
   where workspace = upper('&3.');
 
  if l_ws_exists = 0 then
    raise_application_error(-20000, 'Workspace &3. does not exist. Please choose an existing workspace');
  end if;
end;
/
 
select pml_name default_language
  from pit_message_language_v
 where pml_default_order in (10, 100)
 order by pml_default_order
 fetch first 1 row only;
 
col apex_version new_val APEX_VERSION format a30
col apex_ws new_val APEX_WS format a30

select case 
         when utl_apex.get_apex_version between 19 and 22.1 then '20_2'
         when utl_apex.get_apex_version between 22.2 and 23.1 then '22_2'
         else '23_2' end apex_version, upper('&3.') apex_ws
  from dual;
 
-- Define length of ORA_NAME_TYPE according to oracle version
col ora_name_type new_val ORA_NAME_TYPE format a128
col ora_max_length new_val ORA_MAX_LENGTH format a128

select lower(data_type) || '(' || data_length || case char_used when 'B' then ' byte)' else ' char)' end ora_name_type, data_length ora_max_length
  from all_tab_columns
 where table_name = 'USER_TABLES'
   and column_name = 'TABLE_NAME';
set termout on