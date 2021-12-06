set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit
clear screen
set termout off

col default_language new_val DEFAULT_LANGUAGE format a128
col install_user new_val INSTALL_USER format a128

select value default_language, user install_user
  from V$NLS_VALID_VALUES
 where parameter = 'LANGUAGE'
   and value = upper('&1.');
  
set termout on


@init/settings.sql

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "

set termout on
   
begin
  if '&DEFAULT_LANGUAGE.' is null then
    raise_application_error(-20000, 'Language &1. does not exist, please use an existing Oracle language name like AMERICAN');
  end if;
end;
/