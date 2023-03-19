begin

  pit_admin.merge_message_group(
    p_pmg_name => 'MAIL',
    p_pmg_description => 'Messages for MAIL package');

  pit_admin.merge_message(
    p_pms_name => 'MAIL_PKG_NOT_WORKING',
    p_pms_pmg_name => 'MAIL',
    p_pms_text => q'^Error when trying to initialize the MAIL package.^',
    p_pms_description => q'^Initialization errors indicate incorrect parameter values for the PIT_MAIL output module. Please check the parameters.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_ERROR',
    p_pms_pmg_name => 'MAIL',
    p_pms_text => q'^Error when sending an email: #1#, #2#^',
    p_pms_description => q'^Generic error message for errors when sending a mail.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_INVALID_MIME_TYPE',
    p_pms_pmg_name => 'MAIL',
    p_pms_text => q'^Invalid mime type:#1#^',
    p_pms_description => q'^The type of file to be transferred is a format that is not supported by MAIL.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_DELIVERY_FAILED',
    p_pms_pmg_name => 'MAIL',
    p_pms_text => q'^Error while sending the e-mail^',
    p_pms_description => q'^The shipment could not be executed for an unknown reason. Please contact the support.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_LOG',
    p_pms_pmg_name => 'MAIL',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_LOGIN_METHODS',
    p_pms_pmg_name => 'MAIL',
    p_pms_text => q'^Supported authentication methods: '#1#'.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_RECIPIENTS',
    p_pms_pmg_name => 'MAIL',
    p_pms_text => q'^Receiver: '#1#'.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SENDER',
    p_pms_pmg_name => 'MAIL',
    p_pms_text => q'^Absender: '#1#'^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SENT',
    p_pms_pmg_name => 'MAIL',
    p_pms_text => q'^Mail successfully sent.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_ACCESSIBLE',
    p_pms_pmg_name => 'MAIL',
    p_pms_text => q'^The mail server is accessible.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_ACCESS_DENIED',
    p_pms_pmg_name => 'MAIL',
    p_pms_text => q'^The database has denied access to the mail server.^',
    p_pms_description => q'^From version 11g Oracle requires a grant for access to a network resource. Make sure that the database is allowed to access this resource.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_ACCESS_GRANTED',
    p_pms_pmg_name => 'MAIL',
    p_pms_text => q'^The database has granted access to the mail server.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_CONNECTED',
    p_pms_pmg_name => 'MAIL',
    p_pms_text => q'^Connection to the mail server established.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_DISCONNECTED',
    p_pms_pmg_name => 'MAIL',
    p_pms_text => q'^Connection to the mail server terminated.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_UNAVAILABLE',
    p_pms_pmg_name => 'MAIL',
    p_pms_text => q'^Mail server unaccessible.^',
    p_pms_description => q'^The connection to the mail server is allowed, but technically not possible. The reason could be that the mail server is set up on a different port or switched off.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  commit;
  pit_admin.create_message_package;
end;
/