set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999

whenever sqlerror exit failure rollback
set termout off

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

-- PIT identifiers use an explicit byte limit, independent of NLS length semantics.
define ORA_NAME_TYPE="varchar2(128 byte)"
define ORA_MAX_LENGTH=128

set termout on
@init/settings.sql
