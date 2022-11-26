create or replace package body pita_ui 
as
  /** 
    Package: PITA_UI Body
      UI Package for the PIT APEX maintenance application.
   
    Author:: 
      Juergen Sieben, ConDeS GmbH
      
      Published under MIT licence
   */
  
  /**
    Group: Public Methods
   */
   
  -- Global Variables
  g_page_values utl_apex.page_value_t;
  
  type export_rec is record(
    pms_pmg_list char_table,
    pms_pml_name pit_app_api.pit_name_type,
    pti_pmg_list char_table,
    pti_pml_name pit_app_api.pit_name_type,
    par_pgr_list char_table,
    uttm_type_list char_table
  );
  g_export_row export_rec;

  
  /**
    Group: Helper Methods
   */
  
  /**
    Procedures: Helper methods to copy session state values from an APEX page 
      Is called to copy the actual session state of an APEX page into a PL/SQL table and then copy it to a record instance
      
      copy_edit_pms - For page EDIT_PMS
      copy_edit_pmg - For page EDIT_PMG
      copy_edit_pgr - For page EDIT_PGR
      copy_edit_pre - For page EDIT_PRE
      copy_edit_par - For page EDIT_PAR
      copy_edit_par_realm - For page EDIT_PAR_REALM
      copy_edit_realm - For page EDIT_REALM
      copy_set_realm - For page SET_REALM
      copy_export - For page EXPORT
      copy_edit_module - For page EDIT_MODULE
      copy_edit_context - For page EDIT_CONTEXT
      copy_edit_toggle - For page EDIT_TOGGLE
   */
  procedure copy_edit_pms(
    p_row in out nocopy pit_app_api.pit_message_rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_pms');
    
    p_row.pms_pmg_name := utl_apex.get_string('pms_pmg_name');
    p_row.pms_name := utl_apex.get_string('pms_name');
    p_row.pms_pml_name := utl_apex.get_string('pms_pml_name');
    p_row.pms_text := utl_apex.get_string('pms_text');
    p_row.pms_description := utl_apex.get_string('pms_description');
    p_row.pms_pse_id := utl_apex.get_number('pms_pse_id');
    p_row.pms_custom_error := utl_apex.get_number('pms_custom_error');
    
    pit.leave_detailed;
  end copy_edit_pms;
  
  
  procedure copy_edit_pmg(
    p_row in out nocopy pit_app_api.pit_message_group_rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_pmg');
    
    p_row.pmg_name := utl_apex.get_string('pmg_name');
    p_row.pmg_description := utl_apex.get_string('pmg_description');
    p_row.pmg_error_prefix := utl_apex.get_string('pmg_error_prefix');
    p_row.pmg_error_postfix := utl_apex.get_string('pmg_error_postfix');
    
    pit.leave_detailed;
  end copy_edit_pmg;
  
  
  procedure copy_edit_pgr(
    p_row in out nocopy pit_app_api.parameter_group_rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_pgr');
    
    p_row.pgr_id := utl_apex.get_string('pgr_id');
    p_row.pgr_description := utl_apex.get_string('pgr_description');
    p_row.pgr_is_modifiable := coalesce(utl_apex.get_string('pgr_is_modifiable'), utl_apex.C_TRUE);
    
    pit.leave_detailed;
  end copy_edit_pgr;

  
  procedure copy_edit_pre(
    p_row in out nocopy pit_app_api.parameter_realm_rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_pre');
    
    p_row.pre_id := utl_apex.get_string('pre_id');
    p_row.pre_description := utl_apex.get_string('pre_description');
    p_row.pre_is_active := utl_apex.get_string('pre_is_active');
    
    pit.leave_detailed;
  end copy_edit_pre;
  

  procedure copy_edit_par(
    p_row in out nocopy pit_app_api.parameter_v_rowtype)
  as
    l_par_xml_string pit_util.max_char;
  begin
    pit.enter_detailed('copy_edit_par');
    
    p_row.par_id := utl_apex.get_string('par_id');
    p_row.par_pgr_id := utl_apex.get_string('par_pgr_id');
    p_row.par_description := utl_apex.get_string('par_description');
    p_row.par_pat_id := utl_apex.get_string('par_pat_id');
    p_row.par_string_value := utl_apex.get_string('par_string_value');
    p_row.par_integer_value := utl_apex.get_number('par_integer_value');
    p_row.par_float_value := utl_apex.get_number('par_float_value');
    p_row.par_date_value := utl_apex.get_date('par_date_value');
    p_row.par_timestamp_value := utl_apex.get_string('par_timestamp_value');
    p_row.par_boolean_value := utl_apex.get_string('par_boolean_value');
    p_row.par_is_modifiable := utl_apex.get_string('par_is_modifiable');
    p_row.par_validation_string := utl_apex.get_string('par_validation_string');
    p_row.par_validation_message := utl_apex.get_string('par_validation_message');
    
    -- assert parameter type XML here already to allow for xml conversion
    l_par_xml_string := utl_apex.get_string('par_xml_value');
    if l_par_xml_string is not null then
      utl_apex.assert_datatype(
        p_value => l_par_xml_string, 
        p_type => pit.type_xml,
        p_page_item => 'PAR_XML_VALUE');        
      p_row.par_xml_value := xmltype(l_par_xml_string);
    end if;
    
    pit.leave_detailed;
  end copy_edit_par;
  
    
  procedure copy_edit_par_realm(
    p_row in out nocopy pit_app_api.parameter_v_rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_par_realm');
    
    p_row.par_id := utl_apex.get_string('par_id');
    p_row.par_pgr_id := utl_apex.get_string('par_pgr_id');
    p_row.par_pre_id := utl_apex.get_string('pre_id');
    p_row.par_string_value := utl_apex.get_string('pre_string_value');
    p_row.par_integer_value := utl_apex.get_number('pre_integer_value');
    p_row.par_float_value := utl_apex.get_number('pre_float_value');
    p_row.par_date_value := utl_apex.get_date('pre_date_value');
    p_row.par_timestamp_value := utl_apex.get_string('pre_timestamp_value');
    p_row.par_boolean_value := utl_apex.get_string('pre_boolean_value');
    
    pit.leave_detailed;
  end copy_edit_par_realm;    
  
  
  procedure copy_edit_realm(
    p_row in out nocopy pit_app_api.parameter_realm_rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_realm');
    
    p_row.pre_id := utl_apex.get_string('pre_id');
    p_row.pre_description := utl_apex.get_string('pre_description');
    p_row.pre_is_active := utl_apex.get_string('pre_is_active');
    
    pit.leave_detailed;
  end copy_edit_realm;
  
  
  procedure copy_set_realm(
    p_row in out nocopy pit_app_api.parameter_v_rowtype)
  as
  begin
    pit.enter_detailed('copy_set_realm');
    
    p_row.par_id := 'REALM';
    p_row.par_pgr_id := 'PIT';
    p_row.par_string_value := utl_apex.get_string('pre_id');
    
    pit.leave_detailed;
  end copy_set_realm;
  
  
  procedure copy_export
  as
  begin
    pit.enter_detailed('copy_export');
    
    utl_text.string_to_table(utl_apex.get_string('pms_pmg_list'), g_export_row.pms_pmg_list);
    g_export_row.pms_pml_name := utl_apex.get_string('pms_pml_name');
    utl_text.string_to_table(utl_apex.get_string('pti_pmg_list'), g_export_row.pti_pmg_list);
    g_export_row.pti_pml_name := utl_apex.get_string('pti_pml_name');
    utl_text.string_to_table(utl_apex.get_string('par_pgr_list'), g_export_row.par_pgr_list);
    utl_text.string_to_table(utl_apex.get_string('uttm_type_list'), g_export_row.uttm_type_list);
    
    pit.leave_detailed;
  end copy_export;
  
  
  procedure copy_edit_module(
    p_row in out nocopy pit_app_api.parameter_v_rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_module');
    
    p_row.par_id := utl_apex.get_string('par_id');
    p_row.par_pgr_id := utl_apex.get_string('par_pgr_id');
    p_row.par_string_value := utl_apex.get_string('par_string_value');
    p_row.par_date_value := utl_apex.get_date('par_date_value');
    p_row.par_timestamp_value := utl_apex.get_date('par_timestamp_value');
    p_row.par_boolean_value := utl_apex.get_string('par_boolean_value');
    p_row.par_integer_value := utl_apex.get_number('par_integer_value');
    p_row.par_float_value := utl_apex.get_number('par_float_value');
    
    pit.leave_detailed;
  end copy_edit_module;
  
  
  procedure copy_edit_context(
    p_row in out nocopy pita_ui_edit_context%rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_context');
    
    p_row.par_id := utl_apex.get_string('par_id');
    p_row.par_pgr_id := utl_apex.get_string('par_pgr_id');
    p_row.pse_id := utl_apex.get_number('pse_id');
    p_row.ptl_id := utl_apex.get_number('ptl_id');
    p_row.par_string_value := utl_apex.get_string('par_string_value');
    p_row.par_description := utl_apex.get_string('par_description');
    p_row.ctx_output_modules := utl_apex.get_string('ctx_output_modules');
    p_row.ctx_timing := utl_apex.get_string('ctx_timing');
    
    pit.leave_detailed;
  end copy_edit_context;
  
  
  procedure copy_edit_toggle(
    p_row in out nocopy pita_ui_edit_toggle%rowtype)
  as
  begin
    pit.enter_detailed('copy_edit_toggle');
    
    p_row.par_id := utl_apex.get_string('par_id');
    p_row.par_description := utl_apex.get_string('par_description');
    p_row.toggle_context_name := utl_apex.get_string('toggle_context_name');
    p_row.toggle_module_list := utl_apex.get_string('toggle_module_list');
    
    pit.leave_detailed;
  end copy_edit_toggle;
  
  
  /**
    Procedure: translate_groups
      Method to download a zip with export files for all selected groups of type P_TARGET.
      
      Is used to create an XLIFF compatible list of files to translate the select target type.
      All selected groups are written to separate tranlsation files and downloaded as a zip file.
      
    Parameters:
      p_target - Type of export items. One of PMS or PTI
      p_target_language - target language (Oracle name), to translate the messages to
      p_pmg_list - Colon separated list of message group names
   */
  procedure translate_groups(
    p_target pit_util.ora_name_type,
    p_target_language in pit_util.ora_name_type,
    p_pmg_list in char_table)
  as
    l_xliff xmltype;
    l_group_file_name pit_util.ora_name_type;
    l_zip_file_name pit_util.ora_name_type;
    l_zip_file blob;
  begin
    pit.enter_mandatory(
      p_action => 'translate_groups',
      p_params => msg_params(
                    msg_param('p_target', p_target),
                    msg_param('p_target_language', p_target_language)));
                    
    l_zip_file_name := 'Translation.zip';
    
    for i in 1 .. p_pmg_list.count loop
      pit_app_api.translate_group(
        p_target_language => p_target_language,
        p_pmg_name => p_pmg_list(i),
        p_target => p_target,
        p_file_name => l_group_file_name,
        p_xliff => l_xliff);
                     
      apex_zip.add_file(
        p_zipped_blob => l_zip_file,
        p_file_name => l_group_file_name,
        p_content => utl_text.clob_to_blob(l_xliff.getClobVal()));
    end loop;
      
    apex_zip.finish(l_zip_file);
                 
    utl_apex.download_blob(
      p_blob => l_zip_file,
      p_file_name => l_zip_file_name);
    
    pit.leave_mandatory;
  end translate_groups;
  
  
  /**
    Procedure: import_translation
      Method to import a XLIFF translation file into the categorie defined by P_TARGET.
      
    Parameter:
      p_target - Type of export items. One of PMS or PTI
   */
  procedure import_translation(
    p_target pit_util.ora_name_type)
  as
    l_xliff xmltype;
    l_page_item pit_util.ora_name_type;
  begin
    pit.enter_mandatory(
      p_action => 'import_translation',
      p_params => msg_params(
                    msg_param('p_target', p_target)));
                    
    case p_target
      when pit_app_api.C_TARGET_PMS then
        l_page_item := 'PMS_XLIFF';
      when pit_app_api.C_TARGET_PTI then
        l_page_item := 'PTI_XLIFF';
      else
        pit.error(msg.PITA_UI_INVALID_REQUEST);
    end case;
    
    select xmltype(blob_content, nls_charset_id('AL32UTF8'))
      into l_xliff
      from apex_application_temp_files
     order by created_on desc
     fetch first 1 row only;
    
    pit_app_api.apply_translation(
      p_xliff => l_xliff,
      p_target => p_target);
        
    utl_apex.set_success_message(msg.PITA_UI_XLIFF_IMPORTED);
    
    pit.leave_mandatory;
  exception
    when NO_DATA_FOUND then
      utl_apex.set_error(l_page_item, msg.PIT_PASS_MESSAGE, msg_args(SQLERRM));
    when msg.PITA_UI_INVALID_REQUEST_ERR then
      utl_apex.set_error(
        p_page_item => null,
        p_message => msg.PITA_UI_INVALID_REQUEST,
        p_msg_args => msg_args(utl_apex.get_request));
  end import_translation;
  
  
  /**
    Procedure: export_groups
      Method to export groups. Is used to combine all translatable items into separate files per group, wrap them in a ZIP and download it.
      
    Parameters:
      p_target - Type of export items. One of PMS, PAR or PTI
      p_pmg_list - Colon separated list of translatable item group names.
   */
  procedure export_groups(
    p_target pit_util.ora_name_type,
    p_pmg_list in char_table)
  as
    l_clob clob;
    l_group_file_name pit_util.ora_name_type;
    l_zip_file_name pit_util.ora_name_type;
    l_zip_file blob;
  begin
    pit.enter_mandatory(
      p_action => 'export_groups',
      p_params => msg_params(
                    msg_param('p_target', p_target)));
                    
    l_zip_file_name := 'Export.zip';
         
    for i in 1 .. p_pmg_list.count loop
      pit_app_api.export_group(
        p_target => p_target,
        p_group_name => p_pmg_list(i),
        p_group_file_name => l_group_file_name,
        p_script => l_clob);
                   
      apex_zip.add_file(
        p_zipped_blob => l_zip_file,
        p_file_name => l_group_file_name,
        p_content => utl_text.clob_to_blob(l_clob));
    end loop;
      
    apex_zip.finish(l_zip_file);
                 
    utl_apex.download_blob(
      p_blob => l_zip_file,
      p_file_name => l_zip_file_name);
    
    pit.leave_mandatory;
  exception
    when others then
      pit.handle_exception(msg.PIT_SQL_ERROR);
      raise;
  end export_groups;
  
  
  /**
    Procedure: export_local_parameters
      Method to export local parameters. Is used to export all locally overwritten or defined parameters.
   */
  procedure export_local_parameters
  as
  begin
    pit.enter_mandatory('export_local_parameters');
                 
    utl_apex.download_clob(
      p_clob => param.get_parameters,
      p_file_name => 'ExportLocalParameters.sql');
    
    pit.leave_mandatory;
  end export_local_parameters;
  
  
  /**
    Procedure: export_utl_text_templates
      Method to export UTL_TEXT templates. Is used to export all as defined in the list of UTTM_TYPES.
   */
  procedure export_utl_text_templates(
    p_uttm_list in char_table)
  as
    l_clob clob;
    l_group_file_name pit_util.ora_name_type;
    l_zip_file_name pit_util.ora_name_type;
    l_zip_file blob;
  begin
    pit.enter_mandatory(
      p_action => 'export_utl_text_templates');
                    
    l_zip_file_name := 'ExportUTTM.zip';
         
    for i in 1 .. p_uttm_list.count loop
      l_group_file_name := 'utl_text_templates_' || p_uttm_list(i) || '.sql';
      l_clob := utl_text_admin.get_templates(char_table(p_uttm_list(i)));
                   
      apex_zip.add_file(
        p_zipped_blob => l_zip_file,
        p_file_name => l_group_file_name,
        p_content => utl_text.clob_to_blob(l_clob));
    end loop;
      
    apex_zip.finish(l_zip_file);
                 
    utl_apex.download_blob(
      p_blob => l_zip_file,
      p_file_name => l_zip_file_name);
    
    pit.leave_mandatory;
  exception
    when others then
      pit.handle_exception(msg.PIT_SQL_ERROR);
      raise;
  end export_utl_text_templates;
  
  
  /**
    Group: Public Methods
   */
  /**
    Function: get_default_language
      See <pita_ui.get_default_language>
   */
  function get_default_language
    return varchar2
  as
  begin
    return pit.get_default_language;
  end get_default_language;
  
  
  /**
    Function: harmonize_sql_name
      See <pita_ui.harmonize_sql_name>
   */
  procedure harmonize_sql_name(
    p_item_name in varchar2,
    p_prefix in varchar2 default null)
  as
    l_name pit_util.max_sql_char;
  begin
    pit.enter_mandatory(
      p_params => msg_params(msg_param('p_item_name', p_item_name)));
    
    l_name := utl_apex.get_string(p_item_name);
    
    l_name := pit_app_api.check_name(l_name, p_prefix);
    
    utl_apex.set_value(p_item_name, l_name);
    
    pit.leave_mandatory(
      p_params => msg_params(msg_param('Result', l_name)));
  exception
    when dbms_assert.INVALID_SQL_NAME then
      -- leave the error display for the page validation, as an interactive grid does not support dynamic validation
      null;
  end harmonize_sql_name;
  
  
  /**
    Function: has_translatable_items
      See <pita_ui.has_translatable_items>
   */
  function has_translatable_items
    return boolean
  as
  begin
    return pit_app_api.has_translatable_items;
  end has_translatable_items;
  
  
  /**
    Function: has_local_parameters
      See <pita_ui.has_local_parameters>
   */
  function has_local_parameters
    return boolean
  as
  begin
    return pit_app_api.has_local_parameters;
  end has_local_parameters;
  
  
  /**
    Procedure: set_allow_toggles
      See <pita_ui.set_allow_toggles>
   */
  procedure set_allow_toggles
  as
  begin
    pit.enter_mandatory;
    
    pit_app_api.set_allow_toggles(
      p_allowed => utl_apex.get_string('allow_toggle') = utl_apex.C_TRUE);
      
    commit;
      
    pit.leave_mandatory;
  end set_allow_toggles;
  
  
  /**
    Function: is_default_context
      See <pita_ui.is_default_context>
   */
  function is_default_context
    return boolean
  as
    l_result boolean;
  begin
    pit.enter_mandatory;
    
    l_result := utl_apex.get_string('PAR_ID') = pit_util.C_DEFAULT_CONTEXT;
    
    pit.leave_mandatory;
    return l_result;
  end is_default_context;
  
  
  /**
    Function: pgr_is_modifiable
      See <pita_ui.pgr_is_modifiable>
   */
  function pgr_is_modifiable(
    p_pgr_id in pit_util.ora_name_type)
    return pit_util.flag_type
  as
    l_result pit_util.flag_type;
  begin
    pit.enter_mandatory(
      p_params => msg_params(msg_param('p_pgr_id', p_pgr_id)));
      
    l_result := pit_app_api.parameter_group_is_modifiable(p_pgr_id);
    
    pit.leave_mandatory;
    return l_result;
  end pgr_is_modifiable;
  
  
  /**
    Function: allows_toggles
      See <pita_ui.allows_toggles>
   */
  function allows_toggles
    return boolean
  as
    l_flag boolean;
  begin
    pit.enter_mandatory;
    
    l_flag := pit_app_api.allows_toggles;
    
    pit.leave_mandatory(
      p_params => msg_params(msg_param('Result', utl_apex.get_bool(l_flag))));
    return l_flag;
  end allows_toggles;
    
  
  /**
    Procedure: set_language_settings
      See <pita_ui.set_language_settings>
   */
  procedure set_language_settings(
    p_pml_list in pit_util.max_sql_char)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_pml_list', p_pml_list)));
    
    pit_app_api.set_language_settings(p_pml_list);
    
    pit.leave_mandatory;
  end set_language_settings;
  
  
  /**
    Function: edit_pmg_validate
      See <pita_ui.edit_pmg_validate>
   */
  function edit_pmg_validate
    return boolean
  as
    l_row pit_app_api.pit_message_group_rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_pmg(l_row);
    
    pit.start_message_collection;
    pit_app_api.validate_message_group(l_row);
    pit.stop_message_collection;
      
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      -- Map error codes to page item names
      utl_apex.handle_bulk_errors(char_table(
        'NAME_MISSING', 'PMG_NAME',
        msg.PIT_INVALID_SQL_NAME, 'PMG_NAME',
        msg.PIT_PMG_ERROR_MARKER_INVALID, 'PMG_PREFIX'));
      
      pit.leave_mandatory;
      return true;
  end edit_pmg_validate;
  
  
  /**
    Function: edit_pmg_process
      See <pita_ui.edit_pmg_process>
   */
  procedure edit_pmg_process
  as
    l_row pit_app_api.pit_message_group_rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_pmg(l_row);
    
    case when utl_apex.inserting or utl_apex.updating then
      pit_app_api.merge_message_group(l_row);
    else
      pit_app_api.delete_message_group(
        p_row => l_row, 
        p_force => false);
    end case;
    
    pit.leave_mandatory;
  end edit_pmg_process;
  
  
  /**
    Function: edit_pms_validate
      See <pita_ui.edit_pms_validate>
   */
  function edit_pms_validate
    return boolean
  as
    l_row pit_app_api.pit_message_rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_pms(l_row);
    
    pit.start_message_collection;
    pit_app_api.validate_message(l_row);
    pit.stop_message_collection;
        
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      -- Map error codes to page item names
      utl_apex.handle_bulk_errors(char_table(
        'NAME_MISSING', 'PMS_NAME',
        msg.PIT_INVALID_SQL_NAME, 'PMS_NAME',
        'PMS_PMG_NAME_MISSING', 'PMS_PMG_NAME',
        'PMS_TEXT_MISSING', 'PMS_TEXT',
        'PMS_PSE_ID_MISSING', 'PMS_PSE_ID',
        msg.PIT_PMS_PREDEFINED_ERROR, 'PMS_CUSTOM_ERROR'));
      
      pit.leave_mandatory;
      return true;
  end edit_pms_validate;
  
  
  /**
    Procedure: edit_pms_process
      See <pita_ui.edit_pms_process>
   */
  procedure edit_pms_process
  as
    l_row pit_app_api.pit_message_rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_pms(l_row);
    
    case when utl_apex.inserting or utl_apex.updating then
      pit_app_api.merge_message(l_row);
    else
      pit_app_api.delete_message(l_row);
    end case;
    
    pit.leave_mandatory;
  end edit_pms_process;
  
  
  /**
    Function: edit_pgr_validate
      See <pita_ui.edit_pgr_validate>
   */
  function edit_pgr_validate
    return boolean
  as
    C_REGION_ID constant pit_util.ora_name_type := 'EDIT_PGR';
    l_row pit_app_api.parameter_group_rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_pgr(l_row);
    
    pit.start_message_collection;
    pit_app_api.validate_parameter_group(l_row);
    pit.stop_message_collection;
        
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      -- Map error codes to page item names
      utl_apex.handle_bulk_errors(char_table(
        'NAME_MISSING', 'PMS_NAME',
        msg.PIT_INVALID_SQL_NAME, 'PMS_NAME',
        'PGR_DESCRIPTION_MISSING', 'PGR_DESCRIPTION'));
      
      pit.leave_mandatory;
      return true;
  end edit_pgr_validate;
  
  
  /**
    Procedure: edit_pgr_process
      See <pita_ui.edit_pgr_process>
   */
  procedure edit_pgr_process
  as
    l_row pit_app_api.parameter_group_rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_pgr(l_row);
    
    case when utl_apex.inserting or utl_apex.updating then
      pit_app_api.merge_parameter_group(l_row);
    else
      pit_app_api.delete_parameter_group(l_row.pgr_id, true);
    end case;
    
    pit.leave_mandatory;
  end edit_pgr_process;


  /**
    Function: edit_pre_validate
      See <pita_ui.edit_pre_validate>
   */
  function edit_pre_validate
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    -- copy_edit_pre;
    -- validation logic goes here. If it exists, uncomment COPY function
    
    pit.leave_mandatory;
    return true;
  end edit_pre_validate;
  
  
  /**
    Procedure: edit_pre_process
      See <pita_ui.edit_pre_process>
   */
  procedure edit_pre_process
  as
    l_row pit_app_api.parameter_realm_rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_pre(l_row);
    case when utl_apex.inserting or utl_apex.updating then
      pit_app_api.merge_parameter_realm(l_row);
    else
      pit_app_api.delete_parameter_realm(l_row.pre_id);
    end case;
    
    pit.leave_mandatory;
  end edit_pre_process;
  
  
  /**
    Function: edit_par_initialize
      See <pita_ui.edit_par_initialize>
   */
  procedure edit_par_initialize
  as
    l_pgr_id pit_app_api.pit_name_type;
    l_pgr_is_modifiable pit_app_api.pit_flag_type;
  begin
    pit.enter_mandatory;
    
    l_pgr_id := v('P6_PGR_ID');
    l_pgr_is_modifiable := pit_app_api.parameter_group_is_modifiable(l_pgr_id);
    
    utl_apex.set_value('P7_PAR_PGR_ID', l_pgr_id);
    utl_apex.set_value('P7_PGR_IS_MODIFIABLE', l_pgr_is_modifiable);
    
    pit.leave_mandatory;
  end edit_par_initialize;
  
  
  /**
    Function: edit_par_validate
      See <pita_ui.edit_par_validate>
   */
  function edit_par_validate
    return boolean
  as
    l_row pit_app_api.parameter_v_rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_par(l_row);
    
    pit.start_message_collection;
    pit_app_api.validate_parameter(l_row);
    pit.stop_message_collection;
    
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      -- Map error codes to page item names
      utl_apex.handle_bulk_errors(char_table(
        'DATAYPE_MISMATCH_INTEGER', 'PAR_INTEGER_VALUE',
        'DATAYPE_MISMATCH_FLOAT', 'PAR_FLOAT_VALUE',
        'DATAYPE_MISMATCH_DATE', 'PAR_DATE_VALUE',
        'DATAYPE_MISMATCH_TIMESTAMP', 'PAR_TIMESTAMP_VALUE'));
      
      pit.leave_mandatory;
      return true;
  end edit_par_validate;
  
  
  /**
    Procedure: edit_par_process
      See <pita_ui.edit_par_process>
   */
  procedure edit_par_process
  as
    l_par_xml_value xmltype;
    l_row pit_app_api.parameter_v_rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_par(l_row);
    
    case when utl_apex.inserting or utl_apex.updating then
      pit_app_api.merge_parameter(l_row);
    else
      pit_app_api.delete_parameter(
        p_par_id => l_row.par_id,
        p_par_pgr_id => l_row.par_pgr_id);
    end case;
    
    pit.leave_mandatory;
  end edit_par_process;
  
  
  /**
    Function: edit_realm_validate
      See <pita_ui.edit_realm_validate>
   */
  function edit_realm_validate
    return boolean
  as
    l_row pit_app_api.parameter_realm_rowtype;
  begin
    pit.enter_mandatory;
  
    -- copy_edit_realm(l_row);
    -- validation logic goes here. If it exists, uncomment COPY function
  
    pit.leave_mandatory;
    return true;
  end edit_realm_validate;
  
  
  /**
    Procedure: edit_realm_process
      See <pita_ui.edit_realm_process>
   */
  procedure edit_realm_process
  as
    l_row pit_app_api.parameter_realm_rowtype;
  begin
    pit.enter_mandatory;
  
    copy_edit_realm(l_row);
    case when utl_apex.inserting or utl_apex.updating then
      pit_app_api.merge_parameter_realm(l_row);
    when utl_apex.deleting then
      pit_app_api.delete_parameter_realm(l_row.pre_id);
    else
      null;
    end case;
  
    pit.leave_mandatory;
  end edit_realm_process;
  
    
  /**
    Function: set_realm_validate
      See <pita_ui.set_realm_validate>
   */
  function set_realm_validate
    return boolean
  as
    l_row pit_app_api.parameter_v_rowtype;
  begin
    pit.enter_mandatory;
    
    -- copy_set_realm(l_row);
    -- validation logic goes here. If it exists, uncomment COPY function
    
    pit.leave_mandatory;
    return true;
  end set_realm_validate;
  
  
  /**
    Procedure: set_realm_process
      See <pita_ui.set_realm_process>
   */
  procedure set_realm_process
  as
    l_row pit_app_api.parameter_v_rowtype;
  begin
    pit.enter_mandatory;
    
    copy_set_realm(l_row);
    case when utl_apex.updating then
      pit_app_api.merge_parameter(l_row);
    else
      null;
    end case;
    
    pit.leave_mandatory;
  end set_realm_process;
  
  
  /**
    Function: edit_par_realm_validate
      See <pita_ui.edit_par_realm_validate>
   */
  function edit_par_realm_validate
    return boolean
  as
    l_row pit_app_api.parameter_v_rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_par_realm(l_row);
    
    pit.start_message_collection;
    pit_app_api.validate_realm_parameter(l_row);
    pit.stop_message_collection;
  
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      -- Map error codes to page item names
      utl_apex.handle_bulk_errors(char_table(
        'NAME_MISSING', 'PAR_ID',
        msg.PIT_INVALID_SQL_NAME, 'PAR_ID',
        'DATAYPE_MISMATCH_INTEGER', 'PAR_INTEGER_VALUE',
        'DATAYPE_MISMATCH_FLOAT', 'PAR_FLOAT_VALUE',
        'DATAYPE_MISMATCH_DATE', 'PAR_DATE_VALUE',
        'DATAYPE_MISMATCH_TIMESTAMP', 'PAR_TIMESTAMP_VALUE',
        msg.PIT_PARAM_IS_NULL, 'PAR_ID',
        msg.PIT_PARAM_NOT_MODIFIABLE, 'PAR_ID'));
      
      pit.leave_mandatory;
      return true;
  end edit_par_realm_validate;
  
  
  /**
    Procedure: edit_par_realm_process
      See <pita_ui.edit_par_realm_process>
   */
  procedure edit_par_realm_process
  as
    l_row pit_app_api.parameter_v_rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_par_realm(l_row);
    
    if utl_apex.inserting or utl_apex.updating then
      pit_app_api.merge_realm_parameter(l_row);
    else
      pit_app_api.delete_realm_parameter(
        p_par_id => l_row.par_id,
        p_par_pgr_id => l_row.par_pgr_id,
        p_par_pre_id => l_row.par_pre_id);
    end if;
    
    pit.leave_mandatory;
  end edit_par_realm_process;
  
  
  /**
    Function: export_validate
      See <pita_ui.export_validate>
   */
  function export_validate
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    copy_export;
    
    case utl_apex.get_request
      when 'TRANSLATE_PMS' then
        utl_apex.assert(
          p_condition => g_export_row.pms_pmg_list.count > 0,
          p_message_name => msg.PITA_UI_PARAMETER_REQUIRED,
          p_page_item => 'PMS_PMG_LIST');
        utl_apex.assert(
          p_condition => g_export_row.pms_pml_name is not null, 
          p_message_name => msg.PITA_UI_PARAMETER_REQUIRED,
          p_page_item => 'PMS_PML_NAME');
      when 'IMPORT_PMS' then
        null;
      when 'EXPORT_PMS' then
        utl_apex.assert(
          p_condition => g_export_row.pms_pmg_list.count > 0, 
          p_message_name => msg.PITA_UI_PARAMETER_REQUIRED,
          p_page_item => 'PMS_PMG_LIST');
      when 'TRANSLATE_PTI' then
        utl_apex.assert(
          p_condition => g_export_row.pti_pmg_list.count > 0, 
          p_message_name => msg.PITA_UI_PARAMETER_REQUIRED,
          p_page_item => 'PTI_PGR_LIST');
        utl_apex.assert(
          p_condition => g_export_row.pti_pml_name is not null, 
          p_message_name => msg.PITA_UI_PARAMETER_REQUIRED,
          p_page_item => 'PTI_PML_NAME');
      when 'IMPORT_PTI' then
        null;
      when 'EXPORT_PTI' then
        utl_apex.assert(
          p_condition => g_export_row.pti_pmg_list.count > 0, 
          p_message_name => msg.PITA_UI_PARAMETER_REQUIRED,
          p_page_item => 'PTI_PGR_LIST');
      when 'EXPORT_PAR' then
        utl_apex.assert(
          p_condition => g_export_row.par_pgr_list.count > 0, 
          p_message_name => msg.PITA_UI_PARAMETER_REQUIRED,
          p_page_item => 'PAR_PGR_LIST');
      when 'EXPORT_LOCAL_PAR' then
        null;
      when 'EXPORT_UTTM' then
        utl_apex.assert(
          p_condition => g_export_row.uttm_type_list.count > 0, 
          p_message_name => msg.PITA_UI_PARAMETER_REQUIRED,
          p_page_item => 'PTI_UTTM_LIST');
      else
        utl_apex.set_error(
          p_page_item => null,
          p_message => msg.PITA_UI_INVALID_REQUEST,
          p_msg_args => msg_args(utl_apex.get_request));
    end case;
    
    pit.leave_mandatory;
    return true;
  end export_validate;
  
  
  /**
    Procedure: export_process
      See <pita_ui.export_process>
   */
  procedure export_process
  as
  begin
    pit.enter_mandatory;
    
    copy_export;
    
    case utl_apex.get_request
      when 'TRANSLATE_PMS' then
        translate_groups(
          p_target => pit_app_api.C_TARGET_PMS,
          p_target_language => g_export_row.pms_pml_name,
          p_pmg_list => g_export_row.pms_pmg_list);
      when 'IMPORT_PMS' then
        import_translation(
          p_target => pit_app_api.C_TARGET_PMS);
      when 'EXPORT_PMS' then
        export_groups(
          p_target => pit_app_api.C_TARGET_PMS, 
          p_pmg_list => g_export_row.pms_pmg_list);
      when 'TRANSLATE_PTI' then
        translate_groups(
          p_target => pit_app_api.C_TARGET_PTI,
          p_target_language => g_export_row.pti_pml_name,
          p_pmg_list => g_export_row.pti_pmg_list);
      when 'IMPORT_PTI' then
        import_translation(
          p_target => pit_app_api.C_TARGET_PTI);
      when 'EXPORT_PTI' then
        export_groups(
          p_target => pit_app_api.C_TARGET_PTI, 
          p_pmg_list => g_export_row.pti_pmg_list);
      when 'EXPORT_PAR' then
        export_groups(
          p_target => pit_app_api.C_TARGET_PAR, 
          p_pmg_list => g_export_row.par_pgr_list);
      when 'EXPORT_LOCAL_PAR' then
        export_local_parameters;
      when 'EXPORT_UTTM' then
        export_utl_text_templates(g_export_row.uttm_type_list);
      else
        utl_apex.set_error(
          p_page_item => null,
          p_message => msg.PITA_UI_INVALID_REQUEST,
          p_msg_args => msg_args(utl_apex.get_request));
    end case;
    
    pit.leave_mandatory;
  end export_process;
  
  
  /**
    Function: edit_module_validate
      See <pita_ui.edit_module_validate>
   */
  function edit_module_validate
    return boolean
  as
    l_row pit_app_api.parameter_v_rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_module(l_row);
    
    pit.start_message_collection;
    pit_app_api.validate_data_type(l_row);
    pit.stop_message_collection;
    
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      -- Map error codes to page item names
      utl_apex.handle_bulk_errors(char_table(
        'DATAYPE_MISMATCH_INTEGER', 'PAR_INTEGER_VALUE',
        'DATAYPE_MISMATCH_FLOAT', 'PAR_FLOAT_VALUE',
        'DATAYPE_MISMATCH_DATE', 'PAR_DATE_VALUE',
        'DATAYPE_MISMATCH_TIMESTAMP', 'PAR_TIMESTAMP_VALUE'));
      
      pit.leave_mandatory;
      return true;
  end edit_module_validate;
  
  
  /**
    Procedure: edit_module_process
      See <pita_ui.edit_module_process>
   */
  procedure edit_module_process
  as
    l_row pit_app_api.parameter_v_rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_module(l_row);
    
    case 
      when utl_apex.updating then
        pit_app_api.merge_parameter(l_row);
      when utl_apex.deleting then
        pit_app_api.delete_parameter(
          p_par_id => l_row.par_id, 
          p_par_pgr_id => l_row.par_pgr_id);
      else
        utl_apex.set_error(
          p_page_item => null,
          p_message => msg.PITA_UI_INVALID_REQUEST,
          p_msg_args => msg_args(utl_apex.get_request));
    end case;
    
    pit.leave_mandatory;
  end edit_module_process;
  
    
  /**
    Function: edit_context_validate
      See <pita_ui.edit_context_validate>
   */
  function edit_context_validate
    return boolean
  as
    l_row pita_ui_edit_context%rowtype;
  begin
    pit.enter_mandatory;
    
    -- copy_edit_context(l_row);
    -- validation logic goes here. If it exists, uncomment COPY function
    
    pit.leave_mandatory;
    return true;
  end edit_context_validate;
  
  
  /**
    Procedure: edit_context_process
      See <pita_ui.edit_context_process>
   */
  procedure edit_context_process
  as
    l_row pita_ui_edit_context%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_context(l_row);
    
    case when utl_apex.inserting or utl_apex.updating then
      pit_app_api.create_named_context(
        p_context_name => l_row.par_id,
        p_log_level => l_row.pse_id,
        p_trace_level => l_row.ptl_id,
        p_trace_timing => l_row.ctx_timing = pit_util.C_TRUE,
        p_module_list => l_row.ctx_output_modules,
        p_comment => l_row.par_description);
        
      -- Propagate changed settings to all sessions
      pit.reset_context(false);
    else
      pit_app_api.delete_named_context(l_row.par_id);
    end case;
    
    pit.leave_mandatory;
  end edit_context_process;
  
  
  /**
    Function: edit_toggle_validate
      See <pita_ui.edit_toggle_validate>
   */
  function edit_toggle_validate
    return boolean
  as
    l_row pita_ui_edit_toggle%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_toggle(l_row);
    
    pit.start_message_collection;
    pit_app_api.validate_context_toggle(
      p_toggle_name => l_row.par_id,
      p_module_list => l_row.toggle_module_list,
      p_context_name => l_row.toggle_context_name);
    pit.stop_message_collection;
    
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      -- Map error codes to page item names
      utl_apex.handle_bulk_errors(char_table(
        msg.PIT_INVALID_SQL_NAME, 'PAR_ID',
        'TOGGLE_NAME_MISSING', 'PAR_ID',
        'TOGGLE_NAME_TOO_LONG', 'PAR_ID',
        'CONTEXT_NAME_MISSING', 'TOGGLE_CONTEXT_NAME',
        'CONTEXT_NAME_MTOO_LONG', 'TOGGLE_CONTEXT_NAME',
        msg.PIT_CONTEXT_MISSING, 'TOGGLE_CONTEXT_NAME'));
      
      pit.leave_mandatory;
      return true;
  end edit_toggle_validate;
  
  
  /**
    Procedure: edit_toggle_process
      See <pita_ui.edit_toggle_process>
   */
  procedure edit_toggle_process
  as
    l_row pita_ui_edit_toggle%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_toggle(l_row);
    case when utl_apex.inserting or utl_apex.updating then
      pit_app_api.merge_context_toggle(
        p_toggle_name => l_row.par_id,
        p_module_list => l_row.toggle_module_list,
        p_context_name => l_row.toggle_context_name,
        p_comment => l_row.par_description);
    else
      pit_app_api.delete_context_toggle(
        p_toggle_name => l_row.par_id);
    end case;
    
    pit.leave_mandatory;
  end edit_toggle_process;
  
end pita_ui;
/