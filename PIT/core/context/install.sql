define ctx_dir=core/context/
define plsql_dir=&ctx_dir.plsql/

prompt &h3.Checking installation prerequisites
@&ctx_dir.check_prerequisites.sql

prompt &h3.Remove existing installation
@&ctx_dir.clean_up.sql

prompt &h3.Installing context parameters
@&ctx_dir.create_parameters.sql

prompt &h3.Create type declarations
prompt &s1.Create type ARGS
@&ctx_dir.types/args.tps
show errors

prompt &h3.Installing packages
prompt &s1.Create package UTL_CONTEXT
@&ctx_dir.packages/utl_context.pks
show errors

prompt &s1.Create package body UTL_CONTEXT
@&ctx_dir.packages/utl_context.pkb
show errors

-- ONLY REQUIRED IF USED STANDALONE
--prompt &h3.Granting object privileges on utl_context
--@&ctx_dir.grant_rights.sql