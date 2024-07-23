begin

  pit_admin.merge_message_group(
    p_pmg_name => 'PITA',
    p_pmg_description => 'Messages for the PITA application',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_translatable_item(
    p_pti_id => 'PMET_NONE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PITA^',
    p_pti_name => q'^No error object^',
    p_pti_display_name => q'^No error object^',
    p_pti_description => q'^Message should not receive an error constant in PL/SQL^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'PMET_CUSTOM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PITA^',
    p_pti_name => q'^Application Error^',
    p_pti_display_name => q'^Application Error^',
    p_pti_description => q'^Error code from the number range -21000 - -20000^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'PMET_ORACLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PITA^',
    p_pti_name => q'^Oracle Error^',
    p_pti_display_name => q'^Oracle Error^',
    p_pti_description => q'^Unnamed error code defined by Oracle^'
  );

  commit;
end;
/