begin

  pit_admin.merge_message_group(
    p_pmg_name => 'PARAM',
    p_pmg_description => q'^Core PARAM messages and translatable items^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_message(
    p_pms_name => 'PARAM_ADMIN_MODE_REQUIRED',
    p_pms_pmg_name => 'PARAM',
    p_pms_text => q'^Requested change requires admin mode.^',
    p_pms_description => q'^To make changes, you must be logged in as administrator.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_IS_NULL',
    p_pms_pmg_name => 'PARAM',
    p_pms_text => q'^The requested parameter #1# doesn't exist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_EXTENDABLE',
    p_pms_pmg_name => 'PARAM',
    p_pms_text => q'^Parameter-Group does not allow for new parameters.^',
    p_pms_description => q'^Parameter groups can prohibit changes by the end user. This is the case here, the parameters cannot be changed.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_FOUND',
    p_pms_pmg_name => 'PARAM',
    p_pms_text => q'^Parameter #1# does not exist.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_MODIFIABLE',
    p_pms_pmg_name => 'PARAM',
    p_pms_text => q'^Parameter #1# is not allowed to be changed.^',
    p_pms_description => q'^A parameter can be defined as not changeable, in contrast to the settings of the parameter group. This is the case here.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  commit;
  pit_admin.create_message_package;
end;
/