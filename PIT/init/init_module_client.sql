set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit
clear screen

col install_user new_val INSTALL_USER format a128
col remote_user new_val REMOTE_USER format a128
col module new_val MODULE format a128


select upper('&1.') install_user,
       upper('&2.') remote_user,
       lower('&3.') module
  from dual;
 
@init/settings.sql

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "
