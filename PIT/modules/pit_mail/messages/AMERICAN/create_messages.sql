begin
  
  pit_admin.merge_message_group(
    p_pmg_name => 'PIT_MAIL',
    p_pmg_description => q'^Message for Outputmodule PIT_MAIL^'
  );
  
  pit_admin.merge_message(
    p_pms_name => 'PIT_MAIL_ERROR',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Error sending mail: #1#, #2#^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN');
    
 
  pit_admin.merge_message(
    p_pms_name => 'INVALID_MIME_TYPE',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Invalid mime type: #1#^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );


  pit_admin.merge_message(
    p_pms_name => 'MAIL_DELIVERY_FAILED',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Mail couldn't be sent.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_ERROR',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Error during creation of mail.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_LOG',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^#1#^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_LOGIN',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Trying to log in using method '#1#' with credentials '#2#'^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_LOGIN_METHODS',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Authentication methods supported: '#1#'^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_PKG_NOT_WORKING',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Error while trying to initialize the MAIL package^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_RECIPIENTS',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Recipients: '#1#'^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SALUTATION',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^To whom it may concern^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SALUTATION_FEMALE',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Dear Mrs. #2#^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SALUTATION_MALE',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Dear Mr. #2#^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SENDER',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Sender: '#1#'^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SENT',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Mail succesfully sent.^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );
  
  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_ACCESS_DENIED',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Database has denied access to mail server^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_ACCESS_GRANTED',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Database has granted access to mail server^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_ACCESSIBLE',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Mail server is accessible^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_CONNECTED',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Mail Server connected.^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_DISCONNECTED',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Mail Server disconnected^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_SERVER_UNAVAILABLE',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^Mail Server is unavailable.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'MAIL_TEST',
    p_pms_pmg_name => 'PIT_MAIL',
    p_pms_text => q'^This is a test mail to prove that the mail connection is working.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );
    
  pit_admin.create_message_package;
  
end;
/
