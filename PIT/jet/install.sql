define apex_dir=apex/

prompt &h2.Installation in Schema &REMOTE_USER.
prompt &h3.Grant OBJECT privileges and create local synonyms if necessary

-- Packages

-- Tables and Views

alter session set current_schema=&REMOTE_USER.;

prompt &h3.Create BL views
prompt &s1.View BL_OJ_MODULES
@&apex_dir.views/bl_oj_modules.vw

prompt &h3.Create UI views

prompt &h3.Create UI-MESSAGES and UI-TRANSLATABLES
@&apex_dir.messages/&DEFAULT_LANGUAGE./create_messages.sql
@&apex_dir.messages/&DEFAULT_LANGUAGE./create_translatables.sql


prompt &h3.Create UI-PACKAGES
prompt &s1.Package PIT_JET
@&apex_dir.packages/pit_jet.pks
show errors

prompt &s1.Package body PIT_JET
@&apex_dir.packages/pit_jet.pkb
show errors
