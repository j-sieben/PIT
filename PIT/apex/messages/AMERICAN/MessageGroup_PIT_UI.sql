begin

  pit_admin.merge_message_group(
    p_pmg_name => 'PIT_UI',
    p_pmg_description => q'^Messages for the PIT_UI^');

  pit_admin.merge_message(
    p_pms_name => 'PAR_PGR_EXPORTED',
    p_pms_pmg_name => 'PIT_UI',
    p_pms_text => q'^Parameter group #1# exported.^',
    p_pms_description => q'^^',
    p_pms_pse_id => #pms_pse_id#,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_INVALID_INTEGER',
    p_pms_pmg_name => 'PIT_UI',
    p_pms_text => q'^An integer was expected, but #1# was entered.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => #pms_pse_id#,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_XLIFF_IMPORTED',
    p_pms_pmg_name => 'PIT_UI',
    p_pms_text => q'^Translation successfully imported.^',
    p_pms_description => q'^^',
    p_pms_pse_id => #pms_pse_id#,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_UI_INVALID_REQUEST',
    p_pms_pmg_name => 'PIT_UI',
    p_pms_text => q'^No handler is stored for the request "#1#".^',
    p_pms_description => q'^In a selection list, no decision tree is stored for the current request value. Therefore, this request is not handled.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_UI_PARAMETER_REQUIRED',
    p_pms_pmg_name => 'PIT_UI',
    p_pms_text => q'^Parameter "#1#" must not be NULL.^',
    p_pms_description => q'^Obviously.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  commit;
  pit_admin.create_message_package;
end;
/
