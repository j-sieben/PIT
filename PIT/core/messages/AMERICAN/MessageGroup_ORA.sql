begin
  pit_admin.delete_message_group('ORA', true);
  
  pit_admin.merge_message_group(
    p_pmg_name => 'ORA',
    p_pmg_description => q'^Messages for Oracle exceptions^');

  pit_admin.merge_message(
    p_pms_name => 'ORA_CHILD_RECORD_FOUND',
    p_pms_pmg_name => 'ORA',
    p_pms_text => q'^The data record could not be deleted, dependent data records exist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -2292);

  pit_admin.merge_message(
    p_pms_name => 'ORA_CONVERSION_IMPOSSIBLE',
    p_pms_pmg_name => 'ORA',
    p_pms_text => q'^A conversion could not be carried out^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ORA_INVALID_DATE',
    p_pms_pmg_name => 'ORA',
    p_pms_text => q'^Invalid date: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1858);

  pit_admin.merge_message(
    p_pms_name => 'ORA_INVALID_DATE_FORMAT',
    p_pms_pmg_name => 'ORA',
    p_pms_text => q'^Invalid date format: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1821);

  pit_admin.merge_message(
    p_pms_name => 'ORA_INVALID_DATE_LENGTH',
    p_pms_pmg_name => 'ORA',
    p_pms_text => q'^Invalid length of the date: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1840);

  pit_admin.merge_message(
    p_pms_name => 'ORA_INVALID_DAY',
    p_pms_pmg_name => 'ORA',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1847);

  pit_admin.merge_message(
    p_pms_name => 'ORA_INVALID_DAY_FOR_MONTH',
    p_pms_pmg_name => 'ORA',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1839);

  pit_admin.merge_message(
    p_pms_name => 'ORA_INVALID_MONTH',
    p_pms_pmg_name => 'ORA',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1843);

  pit_admin.merge_message(
    p_pms_name => 'ORA_INVALID_NUMBER_FORMAT',
    p_pms_pmg_name => 'ORA',
    p_pms_text => q'^Ungültiges Zahlformat: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1481);

  pit_admin.merge_message(
    p_pms_name => 'ORA_INVALID_YEAR',
    p_pms_pmg_name => 'ORA',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1841);

  pit_admin.merge_message(
    p_pms_name => 'ORA_SQL_ACCESS_DENIED',
    p_pms_pmg_name => 'ORA',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -29471);

  commit;
  pit_admin.create_message_package;
end;
/
