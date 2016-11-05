set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit
clear screen

col install_user new_val INSTALL_USER format a30
col remote_user new_val REMOTE_USER format a30
col default_language new_val DEFAULT_LANGUAGE format a30
col apex_ws new_val APEX_WS format a30


select upper('&1.') install_user,
       upper('&2.') remote_user,
       upper('&3.') default_language
  from V$NLS_VALID_VALUES
 where parameter = 'LANGUAGE'
   and (value = upper('&3.') or '&3.' is null);
   
select upper('&4.') apex_ws
  from apex_workspaces
 where workspace = upper('&4.');
 
define INSTALL_ON_DEV = false

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "
