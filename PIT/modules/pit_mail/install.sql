@init/set_folders modules/pit_mail
prompt
prompt &section.
prompt &h1.Module PIT_MAIL

@&install_dir.check_prerequisites.sql

prompt &h2.Grant user rights to &PIT_USER.
@&tools.run_script user_grants

prompt &h2.Create queue table for PIT_MAIL
@&tools.check_has_table pit_mail_queue

prompt &s1.Create parameters and messages
@&tools.run_script ParameterGroup_PIT
@&tools.run_script ParameterGroup_MAIL

@&tools.run_language_script MessageGroup_PIT
@&tools.run_language_script MessageGroup_MAIL

prompt &h2.Create types and packages for PIT_MAIL
@&tools.install_type_spec pit_mail
@&tools.install_package_spec mail
@&tools.install_package_spec mail_cram
@&tools.install_package_spec mail_ntlm
@&tools.install_package_spec pit_mail_pkg

@&tools.install_type_body pit_mail
@&tools.install_package_body mail
@&tools.install_package_body mail_cram
@&tools.install_package_body mail_ntlm
@&tools.install_package_body pit_mail_pkg

prompt ### CAVE ###
prompt Before using PIT_MAIL, set your mail server credentials by calling MAIL.SET_CREDENTIALS
prompt If you require a secure connection, wrap your settings in a SMTP relay and provide this package
prompt with the connection data to the relay.
prompt Remember also to create an ACL entry for the mail server.
