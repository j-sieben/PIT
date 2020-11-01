begin

  pit_admin.merge_message(
    p_pms_name => 'PIT_MAIL_SALUTATION',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Dear Sir or Madam^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MAIL_SALUTATION_FEMALE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Dear Madam #1##2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MAIL_SALUTATION_MALE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Dear Sir #1##2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MAIL_MESSAGE_TEMPLATE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^<tr><td>#SEVERITY#</td><td>#AMOUNT#</td><td>#FIRST_DATE#</td><td>#LAST_DATE#</td><td>#MESSAGE#</td><td>#STACK#</td><td>#BACKTRACE#</td></tr>^',
    p_pms_description => q'^Template that determines how a message should be prepared for sending. Should contain SEVERITY, AMOUNT, FIRST_DATE, LAST_DATE, MESSAGE, STACK and BACKTRACE replacement anchors^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'PIT_MAIL_MAIL_TEMPLATE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^<p>The following errors were reported: <p>
   <table><thead><tr><td>Severity</td><td>Amount</td><td>First occurence</td><td>Last occurence</td><td>Text</td><td>Error number</td><td>Call Stack</td></tr></thead><tbody>#MESSAGES#</tbody></table>^',
    p_pms_description => q'^Email template of the module PIT_MAIL. Must contain at least a MESSAGES anchor into which the messages are inserted.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN');

  pit_admin.merge_message(
    p_pms_name => 'PIT_MAIL_ATTACHMENT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Please find the error report attached.^',
    p_pms_description => q'^Message is used if the error message is too long to be incorporated into a normal mail.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN');


  commit;
  pit_admin.create_message_package;
end;
/