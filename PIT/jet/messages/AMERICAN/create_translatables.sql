begin
  
  pit_admin.merge_message_group(
    p_pmg_name => 'PIT',
    p_pmg_description => 'Vore PIT messages and translatables');
    
  pit_admin.merge_translatable_item(
    p_pti_id => 'PAGE_HOME',
    p_pti_pml_name => 'AMERICAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Home',
    p_pti_display_name => null,
    p_pti_description => null);
    
  pit_admin.merge_translatable_item(
    p_pti_id => 'PAGE_MESSAGES',
    p_pti_pml_name => 'AMERICAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Messages',
    p_pti_display_name => null,
    p_pti_description => null);
    
  pit_admin.merge_translatable_item(
    p_pti_id => 'PAGE_PARAMETERS',
    p_pti_pml_name => 'AMERICAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Parameters',
    p_pti_display_name => null,
    p_pti_description => null);
    
  pit_admin.merge_translatable_item(
    p_pti_id => 'PAGE_TRANSLATABLES',
    p_pti_pml_name => 'AMERICAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Translatables',
    p_pti_display_name => null,
    p_pti_description => null);
    
  pit_admin.merge_translatable_item(
    p_pti_id => 'PAGE_ADMINISTRATION',
    p_pti_pml_name => 'AMERICAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Administration',
    p_pti_display_name => null,
    p_pti_description => null);
    
  commit;

end;
/