set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit
clear screen
set termout off
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

-- ADJUST THIS SETTING IF YOU WANT ANOTHER TYPE 
define FLAG_TYPE="char(1 byte)";
define C_TRUE="'Y'";
define C_FALSE="'N'";

--define FLAG_TYPE="number(1, 0)";
--define C_TRUE=1;
--define C_FALSE=0;
   
col ora_name_type new_val ORA_NAME_TYPE format a30
col ora_max_length new_val ORA_MAX_LENGTH format a30
select 'varchar2(' || data_length || ' byte)' ora_name_type, data_length ora_max_length
  from all_tab_columns
 where table_name = 'USER_TABLES'
   and column_name = 'TABLE_NAME';

define INSTALL_ON_DEV = false

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "

set termout on