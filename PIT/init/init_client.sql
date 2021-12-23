set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit
set termout off

-- make parameter 1 optional
col 1 new_val 1
col pit_user new_val PIT_USER format a128
col remote_user new_val REMOTE_USER format a128

select '' "1"
  from dual
 where null is not null;

select user pit_user, coalesce(upper('&1.'), user) remote_user
  from all_users
 where username = coalesce(upper('&1.'), user);
 
-- Define length of ORA_NAME_TYPE according to oracle version
col ora_name_type new_val ORA_NAME_TYPE format a128
col ora_max_length new_val ORA_MAX_LENGTH format a128

select lower(data_type) || '(' || data_length || case char_used when 'B' then ' byte)' else ' char)' end ora_name_type, data_length ora_max_length
  from all_tab_columns
 where table_name = 'USER_TABLES'
   and column_name = 'TABLE_NAME';

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "
set termout on