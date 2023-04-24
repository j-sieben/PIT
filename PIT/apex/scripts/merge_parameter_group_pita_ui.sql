set define ~
    
begin

  param_admin.set_import_mode(true);
  
  param_admin.edit_parameter_group(
    p_pgr_id => 'PITA_UI',
    p_pgr_description => 'Parameter for PIT administration application',
    p_pgr_is_modifiable => true
  );

  param_admin.edit_parameter(
    p_par_id => 'PTI_EXPORT_ZIP_FILE_NAME',
    p_par_pgr_id => 'PITA_UI',
    p_par_description => 'File name of the export zip file for translatable items',
    p_par_string_value => q'^export_translatable_item_groups.zip^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PTI_EXPORT_FILE_NAME',
    p_par_pgr_id => 'PITA_UI',
    p_par_description => 'File name of the translatable item group export file. Replacement anchor #PMG# for the group name',
    p_par_string_value => q'^translatable_item_group_#pmg#.sql^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PAR_EXPORT_ZIP_FILE_NAME',
    p_par_pgr_id => 'PITA_UI',
    p_par_description => 'File name of the export zip file for translatable items',
    p_par_string_value => q'^export_parameter_groups.zip^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PAR_EXPORT_FILE_NAME',
    p_par_pgr_id => 'PITA_UI',
    p_par_description => 'File name of the translatable item group export file. Replacement anchor #PMG# for the group name',
    p_par_string_value => q'^parameter_group_#pmg#.sql^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PMS_EXPORT_ZIP_FILE_NAME',
    p_par_pgr_id => 'PITA_UI',
    p_par_description => 'File name of the export zip file for messages',
    p_par_string_value => q'^export_message_groups.zip^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PMS_EXPORT_FILE_NAME',
    p_par_pgr_id => 'PITA_UI',
    p_par_description => 'File name of the message group export file. Replacement anchor #PMG# for the group name',
    p_par_string_value => q'^merge_pit_message_#pmg#.sql^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PTI_TRANSLATE_ZIP_FILE_NAME',
    p_par_pgr_id => 'PITA_UI',
    p_par_description => 'File name of the translate zip file for translatable items. Replacement anchors #TARGET# and #LANGUAGE#.',
    p_par_string_value => q'^translate_translatable_item_#LANGUAGE#.zip^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PTI_TRANSLATE_FILE_NAME',
    p_par_pgr_id => 'PITA_UI',
    p_par_description => 'File name of the translatable item group export file. Replacement anchors #TARGET#, #LANGUAGE# and #PMG#',
    p_par_string_value => q'^translate_translatable_item_group_#PMG#_#LANGUAGE#.xlf^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PMS_TRANSLATE_ZIP_FILE_NAME',
    p_par_pgr_id => 'PITA_UI',
    p_par_description => 'File name of the translate zip file for translatable items. Replacement anchors #TARGET# and #LANGUAGE#.',
    p_par_string_value => q'^translate_message_#LANGUAGE#.zip^'
  );

  param_admin.edit_parameter(
    p_par_id => 'PMS_TRANSLATE_FILE_NAME',
    p_par_pgr_id => 'PITA_UI',
    p_par_description => 'File name of the translatable item group export file. Replacement anchors #TARGET#, #LANGUAGE# and #PMG#',
    p_par_string_value => q'^translate_message_group_#PMG#_#LANGUAGE#.xlf^'
  );

  param_admin.edit_parameter(
    p_par_id => 'TEXT_TEMPLATES_ZIP_FILE_NAME',
    p_par_pgr_id => 'PITA_UI',
    p_par_description => 'File name of the translate zip file for translatable items.',
    p_par_string_value => q'^export_text_templates.zip^'
  );

  param_admin.edit_parameter(
    p_par_id => 'TEXT_TEMPLATES_FILE_NAME',
    p_par_pgr_id => 'PITA_UI',
    p_par_description => 'File name of the translatable item group export file. Replacement anchors #TARGET#, #LANGUAGE# and #PMG#',
    p_par_string_value => q'^export_textp_template_group_#pmg#.sql^'
  );

  param_admin.harmonize_parameter_group('PITA_UI');
  
  param_admin.set_import_mode(false);
  
  commit;
end;
/
set define &
