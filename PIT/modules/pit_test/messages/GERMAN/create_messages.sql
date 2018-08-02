begin

  pit_admin.merge_message_group(
    p_pmg_name => 'PIT_TEST',
    p_pmg_description => 'Message for output module PIT_TEST'
  );
  
  pit_admin.merge_message(
    p_pms_name => 'PIT_TEST', 
    p_pms_pmg_name => 'PIT',
    p_pms_text => 'GERMAN: #1#', 
    p_pms_description => q'^^',
    p_pms_pse_id => 30, 
    p_pms_pml_name => 'GERMAN', 
    p_error_number => null);
    
  commit;
  
  pit_admin.create_message_package;
end;
/


