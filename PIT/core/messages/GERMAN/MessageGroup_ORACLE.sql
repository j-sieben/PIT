begin

  pit_admin.delete_message_group(
    p_pmg_name => 'ORACLE'
  );
  
  pit_admin.merge_message_group(
    p_pmg_name => 'ORACLE',
    p_pmg_description => q'^Meldungen für Oracle-Fehler^'
  );

  pit_admin.merge_message(
    p_pms_name => 'CHILD_RECORD_FOUND',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^Der Datensatz konnte nicht gelöscht werden, es existieren abhängige Datensätze.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_custom_error => -2292
  );

  pit_admin.merge_message(
    p_pms_name => 'CONVERSION_IMPOSSIBLE',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^Eine Umwandlung konnte nicht ausgeführt werden^',
    p_pms_description => q'^^',
    p_pms_pse_id => 20,
    p_pms_pml_name => 'GERMAN',
    p_pms_custom_error => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'INVALID_DATE',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^Ungültiges Datum: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_custom_error => -1858
  );

  pit_admin.merge_message(
    p_pms_name => 'INVALID_DATE_FORMAT',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^Ungültiges Datumsformat: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_custom_error => -1861
  );

  pit_admin.merge_message(
    p_pms_name => 'INVALID_DATE_LENGTH',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^Ungültige Länge des Datums: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_custom_error => -1840
  );

  pit_admin.merge_message(
    p_pms_name => 'INVALID_DAY',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_custom_error => -1847
  );

  pit_admin.merge_message(
    p_pms_name => 'INVALID_DAY_FOR_MONTH',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_custom_error => -1839
  );

  pit_admin.merge_message(
    p_pms_name => 'INVALID_MONTH',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_custom_error => -1843
  );

  pit_admin.merge_message(
    p_pms_name => 'INVALID_NUMBER_FORMAT',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^Ungültiges Zahlformat: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_custom_error => -1481
  );

  pit_admin.merge_message(
    p_pms_name => 'INVALID_YEAR',
    p_pms_pmg_name => 'ORACLE',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_custom_error => -1841
  );

  commit;
  pit_admin.create_message_package;
end;
/