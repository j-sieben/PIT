begin

  pit_admin.merge_message_group(
    p_pmg_name => 'PITA_UI',
    p_pmg_description => q'^Messages for the PITA_UI^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_message(
    p_pms_name => 'PAR_PGR_EXPORTED',
    p_pms_pmg_name => 'PITA_UI',
    p_pms_text => q'^Parameter group #1# exported.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_INVALID_INTEGER',
    p_pms_pmg_name => 'PITA_UI',
    p_pms_text => q'^An integer was expected, but #1# was entered.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_XLIFF_IMPORTED',
    p_pms_pmg_name => 'PITA_UI',
    p_pms_text => q'^Translation successfully imported.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PITA_INVALID_REQUEST',
    p_pms_pmg_name => 'PITA',
    p_pms_text => q'^No handler is stored for the request "#1#".^',
    p_pms_description => q'^No decision tree is stored for the current request value in a selection list. This request is therefore not processed.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PITA_PARAMETER_REQUIRED',
    p_pms_pmg_name => 'PITA',
    p_pms_text => q'^Parameter "#1#" must not be NULL.^',
    p_pms_description => q'^Obvious.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  commit;
  pit_admin.create_message_package;
end;
/