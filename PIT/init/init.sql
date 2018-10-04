set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit
clear screen

col sys_user new_val SYS_USER format a30
col install_user new_val INSTALL_USER format a30
col remote_user new_val REMOTE_USER format a30
col default_language new_val DEFAULT_LANGUAGE format a30
col apex_ws new_val APEX_WS format a30

select user sys_user,
       upper('&1.') install_user,
       null remote_user,
       value default_language
  from V$NLS_VALID_VALUES
 where parameter = 'LANGUAGE'
   and value = upper('&2.');

col ora_name_type new_val ORA_NAME_TYPE format a30
select 'varchar2(' || data_length || ' byte)' ora_name_type
  from all_tab_columns
 where table_name = 'USER_TABLES'
   and column_name = 'TABLE_NAME';

define INSTALL_ON_DEV = false

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "
