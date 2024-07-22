begin

  pit_admin.merge_message_group(
    p_pmg_name => 'PARAM',
    p_pmg_description => q'^Core PARAM messages and translatable items^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_message(
    p_pms_name => 'PARAM_ADMIN_MODE_REQUIRED',
    p_pms_pmg_name => 'PARAM',
    p_pms_text => q'^Diese Änderung ist nur im ADMIN-Modus möglich.^',
    p_pms_description => q'^Um Änderungen vorzunehmen, müssen Sie als Administrator angemeldet sein.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_IS_NULL',
    p_pms_pmg_name => 'PARAM',
    p_pms_text => q'^Der angeforderte Parameter "#1#" existiert nicht.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_WARN,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_EXTENDABLE',
    p_pms_pmg_name => 'PARAM',
    p_pms_text => q'^Die Erweiterung dieser Parametergruppe ist nicht erlaubt.^',
    p_pms_description => q'^Parametergruppen können die Änderungen durch den Endanwender untersagen. Dies ist hier der Fall, die Parameter sind nicht änderbar.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_FOUND',
    p_pms_pmg_name => 'PARAM',
    p_pms_text => q'^Der Parameter #1# existiert nicht.^',
    p_pms_description => q'^Offensichtlich.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_MODIFIABLE',
    p_pms_pmg_name => 'PARAM',
    p_pms_text => q'^Die Änderung des Parameters #1# ist nicht erlaubt.^',
    p_pms_description => q'^Ein Parameter kann, abweichend von den Einstellungen der Parametergruppe, als nicht änderbar festgelegt werden. Dies ist hier der Fall.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  commit;
  pit_admin.create_message_package;
end;
/