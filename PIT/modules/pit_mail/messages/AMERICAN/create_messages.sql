begin
  
  pit_admin.merge_message(
    p_pms_name => 'PIT_MAIL_ERROR',
    p_pms_text => 'Error sending mail: #1#, #2#',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN');
    
  pit_admin.create_message_package;
  
end;
/