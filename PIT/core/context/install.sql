define ctx_dir=core/context/

prompt &h3.Checking installation prerequisites
@&ctx_dir.check_prerequisites.sql

prompt &h3.Remove existing installation
@&ctx_dir.clean_up.sql

prompt &h3.Installing context parameters
@&ctx_dir.create_parameters.sql

prompt &h3.Installing packages
@&plsql_dir.utl_context.pks
@&plsql_dir.utl_context.pkb

-- ONLY REQUIRED IF USED STANDALONE
--prompt &h3.Granting object privileges on utl_context
--@&ctx_dir.grant_rights.sql