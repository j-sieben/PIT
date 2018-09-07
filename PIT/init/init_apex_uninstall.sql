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
col apex_ws new_val APEX_WS format a30
col apex_alias new_val APEX_ALIAS format a30
col app_id new_val APP_ID format a30

select user sys_user,
       upper('&1.') install_user,
       upper('&2.') remote_user,
       upper('&3.') apex_ws,
       upper('&4.') apex_alias
  from dual;       
       
select application_id app_id
  from apex_applications
 where workspace_display_name = '&APEX_WS.'
   and alias = '&APEX_ALIAS.';

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "

set termout on