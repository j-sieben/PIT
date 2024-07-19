begin
    
  pit_admin.merge_message_group(
    p_pmg_name => 'PIT',
    p_pmg_description => q'^Core PIT messages and translatable items^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_ALL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^All^',
    p_pti_display_name => q'^All^',
    p_pti_description => q'^Further log information, detailed code messages^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_DEBUG',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Debug message^',
    p_pti_display_name => q'^Debug message^',
    p_pti_description => q'^Debug message with more technical background to track execution of the code^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_ERROR',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Error^',
    p_pti_display_name => q'^Error^',
    p_pti_description => q'^Error, is finally handled by PIT^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_FATAL',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Fatal error^',
    p_pti_display_name => q'^Fatal error^',
    p_pti_description => q'^Untreated error, is propagated to the calling environment^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_INFO',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Information^',
    p_pti_display_name => q'^Information^',
    p_pti_description => q'^Information, e.g. about successful registrations etc.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_OFF',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Logging off^',
    p_pti_display_name => q'^Logging off^',
    p_pti_description => q'^Switches logging off, errors and fatal errors are still logged^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_WARN',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Warning^',
    p_pti_display_name => q'^Warning^',
    p_pti_description => q'^Warning, can be suppressed, serves to inform about unusual occurrences^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'TRACE_ALL',
    p_pti_pml_name => 'AMERICAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'All',
    p_pti_display_name => 'All',
    p_pti_description => 'Transmits all method calls'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'TRACE_DETAILED',
    p_pti_pml_name => 'AMERICAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Detaillied',
    p_pti_display_name => 'Detaillied',
    p_pti_description => 'Transmits method calls via ENTER_DETAILED'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'TRACE_OPTIONAL',
    p_pti_pml_name => 'AMERICAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Optional',
    p_pti_display_name => 'Optional',
    p_pti_description => 'Transmits method calls via ENTER_OPTIONAL'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'TRACE_MANDATORY',
    p_pti_pml_name => 'AMERICAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Mandatory',
    p_pti_display_name => 'Mandatory',
    p_pti_description => 'Transmits method calls via ENTER_MANDATORY'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'TRACE_OFF',
    p_pti_pml_name => 'AMERICAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Tracing off',
    p_pti_display_name => 'Tracing off',
    p_pti_description => 'Suppresses the output of tracing information'
  );   

  pit_admin.merge_translatable_item(
    p_pti_id => 'BOOLEAN_' || replace(&true., ''''),
    p_pti_pml_name => 'AMERICAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => &true.,
    p_pti_display_name => 'Yes',
    p_pti_description => 'Boolean value for TRUE');

  pit_admin.merge_translatable_item(
    p_pti_id => 'BOOLEAN_' || replace(&false., ''''),
    p_pti_pml_name => 'AMERICAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => &false.,
    p_pti_display_name => 'No',
    p_pti_description => 'Boolean value for FALSE');
    

  commit;
end;
/