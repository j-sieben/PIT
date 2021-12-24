set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit
set termout off

col pit_user new_val PIT_USER format a30
col install_user new_val INSTALL_USER format a30
col remote_user new_val REMOTE_USER format a30
col default_language new_val DEFAULT_LANGUAGE format a30
col apex_ws new_val APEX_WS format a30
col apex_alias new_val APEX_ALIAS format a30
col app_id new_val APP_ID format a30
col apex_version new_val APEX_VERSION format a30


select owner install_user, owner pit_user, user remote_user
  from all_objects
 where object_name = 'PIT'
   and object_type = 'PACKAGE';
   
select workspace apex_ws, 
       upper('&2.') apex_alias, 
       '&3.' app_id
  from apex_workspaces
 where workspace = upper('&1.');
 
select pml_name default_language
  from &PIT_USER..pit_message_language_v
 where pml_default_order = 10;
 
select case when utl_apex.get_apex_version between 5 and 18.5 then '05_1'
            when utl_apex.get_apex_version between 19 and 20.1 then '19_1'
            else '20_2' end apex_version
  from dual;

@init/settings.sql

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "
set termout on