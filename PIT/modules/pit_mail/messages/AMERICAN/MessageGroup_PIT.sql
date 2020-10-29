begin

  pit_admin.merge_message(
    p_pms_name => 'INVALID_MIME_TYPE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Invalid mime type:#1#^',
    p_pms_description => q'^The type of file to be transferred is a format that is not supported by PIT_MAIL.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_DELIVERY_FAILED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Error while sending the e-mail^',
    p_pms_description => q'^The shipment could not be executed for an unknown reason. Please contact the support.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Error when generating an e-mail.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_LOG',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_LOGIN',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Log in using '#1#' procedure and access data '#2#'.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_LOGIN_METHODS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Supported authentication methods: '#1#'.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_PKG_NOT_WORKING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Error when trying to initialize the MAIL package.^',
    p_pms_description => q'^Initialization errors indicate incorrect parameter values for the PIT_MAIL output module. Please check the parameters.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_RECIPIENTS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Receiver: '#1#'.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SALUTATION',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Dear Sir or Madam^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SALUTATION_FEMALE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Dear Madam #1##2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SALUTATION_MALE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Dear Sir #1##2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SENDER',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Absender: '#1#'^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SENT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Mail successfully sent.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_ACCESSIBLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The mail server is accessible.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_ACCESS_DENIED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The database has denied access to the mail server.^',
    p_pms_description => q'^From version 11g Oracle requires a grant for access to a network resource. Make sure that the database is allowed to access this resource.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_ACCESS_GRANTED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The database has granted access to the mail server.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_CONNECTED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Connection to the mail server established.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_DISCONNECTED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Connection to the mail server terminated.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_UNAVAILABLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Mail server unaccessible.^',
    p_pms_description => q'^The connection to the mail server is allowed, but technically not possible. The reason could be that the mail server is set up on a different port or switched off.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_TEST',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^This is a test mail to prove that the connection works.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Error when sending an email: #1#, #2#^',
    p_pms_description => q'^Generic error message for errors when sending a mail.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'MAIL_MESSAGE_TEMPLATE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^<tr><td>#SEVERITY#</td><td>#AMOUNT#</td><td>#FIRST_DATE#</td><td>#LAST_DATE#</td><td>#MESSAGE#</td><td>#STACK#</td><td>#BACKTRACE#</td></tr>^',
    p_pms_description => q'^Template that determines how a message should be prepared for sending. Should contain SEVERITY, AMOUNT, FIRST_DATE, LAST_DATE, MESSAGE, STACK and BACKTRACE replacement anchors^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'MAIL_MAIL_TEMPLATE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^<p>The following errors were reported: <p>
   <table><thead><tr><td>Severity</td><td>Amount</td><td>First occurence</td><td>Last occurence</td><td>Text</td><td>Error number</td><td>Call Stack</td></tr></thead><tbody>#MESSAGES#</tbody></table>^',
    p_pms_description => q'^Email template of the module PIT_MAIL. Must contain at least a MESSAGES anchor into which the messages are inserted.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'MAIL_ATTACHMENT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Please find the error report attached.^',
    p_pms_description => q'^Message is used if the error message is too long to be incorporated into a normal mail.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN');


  commit;
  pit_admin.create_message_package;
end;
/