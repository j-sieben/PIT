define core_dir=core/
define sql_dir=&core_dir./sql/


prompt
prompt &h2.Granting access to PIT to &REMOTE_USER.
prompt &h3.Change current schema to &REMOTE_USER.
alter session set current_schema=&REMOTE_USER.;

prompt &h3.Clean up schema &REMOTE_USER.
@&core_dir.clean_up_client.sql

prompt &s1.Create synonym PIT for package PIT
@&sql_dir.synonyms/pit.syn

prompt &s1.Create synonym MSG for package MSG
@&sql_dir.synonyms/msg.syn

prompt &s1.Pre-create synonyms MSG_ARGS for type MSG_ARGS
@&sql_dir.synonyms/msg_args.syn

prompt &s1.Pre-create synonyms MSG_PARAM for type MSG_PARAM
@&sql_dir.synonyms/msg_param.syn

prompt &s1.Pre-create synonyms MSG_PARAMS for type MSG_PARAMS
@&sql_dir.synonyms/msg_params.syn

prompt &h3.Change current schema to &INSTALL_USER.
alter session set current_schema=&INSTALL_USER.;
