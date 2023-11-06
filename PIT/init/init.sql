set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999

whenever sqlerror continue
alter session set plsql_implicit_conversion_bool = true;

whenever sqlerror exit
set termout off

-- Check default language
col default_language new_val DEFAULT_LANGUAGE format a128
col pit_user new_val PIT_USER format a128

select value default_language, user pit_user
  from V$NLS_VALID_VALUES
 where parameter = 'LANGUAGE'
   and value = upper('&1.')
   and value in ('GERMAN', 'AMERICAN');
   
set termout on
begin
  if '&DEFAULT_LANGUAGE.' is null then
    raise_application_error(-20000, 'Language &1. is not supported, please use a provided Oracle language (GERMAN|AMERICAN)');
  end if;
end;
/

set termout off

-- Define length of ORA_NAME_TYPE according to oracle version
col ora_name_type new_val ORA_NAME_TYPE format a128
col ora_max_length new_val ORA_MAX_LENGTH format a128

select lower(data_type) || '(' || data_length || case char_used when 'B' then ' byte)' else ' char)' end ora_name_type, data_length ora_max_length
  from all_tab_columns
 where table_name = 'USER_TABLES'
   and column_name = 'TABLE_NAME';
   
set termout on
@init/settings.sql

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "
