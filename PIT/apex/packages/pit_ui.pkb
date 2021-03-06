create or replace package body pit_ui 
as
  /** UI Package for the PIT APEX maintenance application */
  
  -- Global Variables
  g_page_prefix utl_apex.ora_name_type;
  g_page_values utl_apex.page_value_t;
  g_edit_pms_row pit_ui_edit_pms%rowtype;
  g_edit_pmg_row pit_ui_edit_pmg%rowtype;
  g_edit_pgr_row pit_ui_edit_pgr%rowtype;  
  g_edit_par_row pit_ui_edit_par%rowtype;  
  g_edit_realm_row pit_ui_edit_realm%rowtype;
  g_set_realm_row pit_ui_set_realm%rowtype;
  g_edit_par_realm_row pit_ui_edit_par_realm%rowtype;  
  g_edit_module_row pit_ui_edit_module%rowtype;
  g_edit_context_row pit_ui_edit_context%rowtype;
  g_edit_toggle_row pit_ui_edit_toggle%rowtype;
  
  type export_rec is record(
    pms_pmg_list char_table,
    pms_pml_name pit_message_language.pml_name%TYPE,
    pti_pmg_list char_table,
    pti_pml_name pit_message_language.pml_name%TYPE,
    par_pgr_list char_table
  );
  g_export_row export_rec;

  g_edit_pre_row parameter_realm%rowtype;
  
  /* INTERNALS */
  
  /* Helper method to copy session state values from an APEX page 
   * %usage  Is called to copy the actual session state of an APEX page into a PL/SQL table
   *         and then copy it to a record instance
   */
  procedure copy_edit_pms
  as
  begin
    pit.enter_detailed('copy_edit_pms');
    
    g_page_values := utl_apex.get_page_values('EDIT_PMS');
    g_edit_pms_row.pms_pmg_name := pit_util.harmonize_sql_name(utl_apex.get(g_page_values, 'pms_pmg_name'));
    g_edit_pms_row.pms_name := pit_util.harmonize_sql_name(utl_apex.get(g_page_values, 'pms_name'));
    g_edit_pms_row.pms_pml_name := pit_util.harmonize_sql_name(utl_apex.get(g_page_values, 'pms_pml_name'));
    g_edit_pms_row.pms_text := utl_apex.get(g_page_values, 'pms_text');
    g_edit_pms_row.pms_description := utl_apex.get(g_page_values, 'pms_description');
    g_edit_pms_row.pms_pse_id := to_number(utl_apex.get(g_page_values, 'pms_pse_id'), 'fm9999999999990d99999999');
    g_edit_pms_row.pms_custom_error := to_number(utl_apex.get(g_page_values, 'pms_custom_error'), 'fm9999999999990d99999999');
    
    pit.leave_detailed;
  end copy_edit_pms;
  
  
  procedure copy_edit_pmg
  as
  begin
    pit.enter_detailed('copy_edit_pmg');
    
    g_page_values := utl_apex.get_page_values('EDIT_PMG');
    g_edit_pmg_row.pmg_name := pit_util.harmonize_sql_name(utl_apex.get(g_page_values, 'pmg_name'));
    g_edit_pmg_row.pmg_description := utl_apex.get(g_page_values, 'pmg_description');
    
    pit.leave_detailed;
  end copy_edit_pmg;
  
  
  procedure copy_edit_pgr
  as
  begin
    pit.enter_detailed('copy_edit_pgr');
    
    g_page_values := utl_apex.get_page_values('EDIT_PGR');
    g_edit_pgr_row.pgr_id := pit_util.harmonize_sql_name(utl_apex.get(g_page_values, 'pgr_id'));
    g_edit_pgr_row.pgr_description := utl_apex.get(g_page_values, 'pgr_description');
    g_edit_pgr_row.pgr_is_modifiable := coalesce(utl_apex.get(g_page_values, 'pgr_is_modifiable'), utl_apex.C_TRUE);
    
    pit.leave_detailed;
  end copy_edit_pgr;

  
  procedure copy_edit_pre
  as
  begin
    pit.enter_detailed('copy_edit_pre');
    
    g_page_values := utl_apex.get_page_values('EDIT_PRE');
    g_edit_pre_row.pre_id := pit_util.harmonize_sql_name(utl_apex.get(g_page_values, 'pre_id'));
    g_edit_pre_row.pre_description := utl_apex.get(g_page_values, 'pre_description');
    g_edit_pre_row.pre_is_active := utl_apex.get(g_page_values, 'pre_is_active');
    
    pit.leave_detailed;
  end copy_edit_pre;
  

  procedure copy_edit_par
  as
  begin
    pit.enter_detailed('copy_edit_par');
    
    g_page_values := utl_apex.get_page_values('EDIT_PAR');
    g_edit_par_row.par_id := pit_util.harmonize_sql_name(utl_apex.get(g_page_values, 'par_id'));
    g_edit_par_row.par_pgr_id := pit_util.harmonize_sql_name(utl_apex.get(g_page_values, 'par_pgr_id'));
    g_edit_par_row.par_description := utl_apex.get(g_page_values, 'par_description');
    g_edit_par_row.par_pat_id := utl_apex.get(g_page_values, 'par_pat_id');
    g_edit_par_row.par_string_value := utl_apex.get(g_page_values, 'par_string_value');
    g_edit_par_row.par_integer_value := to_number(utl_apex.get(g_page_values, 'par_integer_value'), 'fm9999999999990d99999999');
    g_edit_par_row.par_float_value := to_number(utl_apex.get(g_page_values, 'par_float_value'), 'fm9999999999990d99999999');
    g_edit_par_row.par_date_value := to_date(utl_apex.get(g_page_values, 'par_date_value'), 'dd.mm.yyyy');
    g_edit_par_row.par_timestamp_value := utl_apex.get(g_page_values, 'par_timestamp_value');
    g_edit_par_row.par_boolean_value := utl_apex.get(g_page_values, 'par_boolean_value');
    g_edit_par_row.par_is_modifiable := utl_apex.get(g_page_values, 'par_is_modifiable');
    g_edit_par_row.par_validation_string := utl_apex.get(g_page_values, 'par_validation_string');
    g_edit_par_row.par_validation_message := utl_apex.get(g_page_values, 'par_validation_message');
    g_edit_par_row.par_xml_value := utl_apex.get(g_page_values, 'par_xml_value');
    
    pit.leave_detailed;
  end copy_edit_par;
  
    
  procedure copy_edit_par_realm
  as
  begin
    pit.enter_detailed('copy_edit_par_realm');
    
    g_page_values := utl_apex.get_page_values('EDIT_PAR_REALM');
    g_edit_par_realm_row.pre_par_id := utl_apex.get_value('P7_PAR_ID');
    g_edit_par_realm_row.pre_pgr_id := utl_apex.get_value('P7_PAR_PGR_ID');
    g_edit_par_realm_row.pre_id := utl_apex.get(g_page_values, 'pre_id');
    g_edit_par_realm_row.pre_string_value := utl_apex.get(g_page_values, 'pre_string_value');
    g_edit_par_realm_row.pre_integer_value := to_number(utl_apex.get(g_page_values, 'pre_integer_value'), 'fm9999999999990d99999999');
    g_edit_par_realm_row.pre_float_value := to_number(utl_apex.get(g_page_values, 'pre_float_value'), 'fm9999999999990d99999999');
    g_edit_par_realm_row.pre_date_value := to_date(utl_apex.get(g_page_values, 'pre_date_value'), 'dd.mm.yyyy');
    g_edit_par_realm_row.pre_timestamp_value := utl_apex.get(g_page_values, 'pre_timestamp_value');
    g_edit_par_realm_row.pre_boolean_value := utl_apex.get(g_page_values, 'pre_boolean_value');
    
    pit.leave_detailed;
  end copy_edit_par_realm;    
  
  
  procedure copy_edit_realm
  as
  begin
    pit.enter_detailed('copy_edit_realm');
    
    g_page_values := utl_apex.get_page_values('EDIT_REALM');
    g_edit_realm_row.pre_id := utl_apex.get(g_page_values, 'pre_id');
    g_edit_realm_row.pre_description := utl_apex.get(g_page_values, 'pre_description');
    g_edit_realm_row.pre_is_active := utl_apex.get(g_page_values, 'pre_is_active');
    
    pit.leave_detailed;
  end copy_edit_realm;
  
  
  procedure copy_set_realm
  as
  begin
    pit.enter_detailed('copy_set_realm');
    
    g_page_values := utl_apex.get_page_values('SET_REALM');
    g_set_realm_row.par_id := utl_apex.get(g_page_values, 'par_id');
    g_set_realm_row.par_pgr_id := utl_apex.get(g_page_values, 'par_pgr_id');
    g_set_realm_row.par_string_value := utl_apex.get(g_page_values, 'par_string_value');
    
    pit.leave_detailed;
  end copy_set_realm;
  
  
  procedure copy_export
  as
  begin
    pit.enter_detailed('copy_export');
    
    utl_text.string_to_table(utl_apex.get_value('pms_pmg_list'), g_export_row.pms_pmg_list);
    g_export_row.pms_pml_name := utl_apex.get_value('pms_pml_name');
    utl_text.string_to_table(utl_apex.get_value('pti_pmg_list'), g_export_row.pti_pmg_list);
    g_export_row.pti_pml_name := utl_apex.get_value('pti_pml_name');
    utl_text.string_to_table(utl_apex.get_value('par_pgr_list'), g_export_row.par_pgr_list);
    
    pit.leave_detailed;
  end copy_export;
  
  
  procedure copy_edit_module
  as
  begin
    pit.enter_detailed('copy_edit_module');
    
    g_page_values := utl_apex.get_page_values('EDIT_MODULE');
    g_edit_module_row.par_id := pit_util.harmonize_sql_name(utl_apex.get(g_page_values, 'par_id'));
    g_edit_module_row.par_pgr_id := pit_util.harmonize_sql_name(utl_apex.get(g_page_values, 'par_pgr_id'));
    g_edit_module_row.par_string_value := utl_apex.get(g_page_values, 'par_string_value');
    g_edit_module_row.par_date_value := to_date(utl_apex.get(g_page_values, 'par_date_value'), 'dd.mm.yyyy');
    g_edit_module_row.par_timestamp_value := to_timestamp(utl_apex.get(g_page_values, 'par_timestamp_value'), 'dd.mm.yyyy hh24:mi:ss');
    g_edit_module_row.par_boolean_value := utl_apex.get(g_page_values, 'par_boolean_value');
    g_edit_module_row.par_integer_value := to_number(utl_apex.get(g_page_values, 'par_integer_value'), '9999999999990');
    g_edit_module_row.par_float_value := to_number(utl_apex.get(g_page_values, 'par_float_value'), '9999999999990d99999999');
    
    pit.leave_detailed;
  end copy_edit_module;
  
  
  procedure copy_edit_context
  as
  begin
    pit.enter_detailed('copy_edit_context');
    
    g_page_values := utl_apex.get_page_values('EDIT_CONTEXT');
    g_edit_context_row.par_id := pit_util.harmonize_sql_name(utl_apex.get(g_page_values, 'PAR_ID'));
    g_edit_context_row.par_pgr_id := pit_util.harmonize_sql_name(utl_apex.get(g_page_values, 'par_pgr_id'));
    g_edit_context_row.pse_id := to_number(utl_apex.get(g_page_values, 'pse_id'), 'fm00');
    g_edit_context_row.ptl_id := to_number(utl_apex.get(g_page_values, 'ptl_id'), 'fm00');
    g_edit_context_row.par_string_value := utl_apex.get(g_page_values, 'par_string_value');
    g_edit_context_row.par_description := utl_apex.get(g_page_values, 'par_description');
    g_edit_context_row.ctx_output_modules := utl_apex.get(g_page_values, 'ctx_output_modules');
    g_edit_context_row.ctx_timing := utl_apex.get(g_page_values, 'ctx_timing');
    
    pit.leave_detailed;
  end copy_edit_context;
  
  
  procedure copy_edit_toggle
  as
  begin
    pit.enter_detailed('copy_edit_toggle');
    
    g_page_values := utl_apex.get_page_values('EDIT_TOGGLE');
    g_edit_toggle_row.par_id := pit_util.harmonize_sql_name(utl_apex.get(g_page_values, 'par_id'));
    g_edit_toggle_row.par_description := utl_apex.get(g_page_values, 'par_description');
    g_edit_toggle_row.toggle_context_name := utl_apex.get(g_page_values, 'toggle_context_name');
    g_edit_toggle_row.toggle_module_list := utl_apex.get(g_page_values, 'toggle_module_list');
    
    pit.leave_detailed;
  end copy_edit_toggle;
  
  
  /** Method to check whether a name conforms to the internal naming standards
   * %param  p_name       Name to check
   * %param  p_item_name  Name of the page item containing P_NAME
   * %param  p_region_id  Static ID of the region
   * %return Harmonized name if possible, entered name in case of error
   * %usage  Is used as a wrapper to reduce code on various validate methods
   */
  function check_name(
    p_name in pit_util.ora_name_type,
    p_item_name in pit_util.ora_name_type,
    p_region_id in pit_util.ora_name_type)
    return varchar2
  as
    l_harmonized_name pit_util.ora_name_type;
  begin
    pit.enter_detailed('check_name');
    
    utl_apex.assert_not_null(
        p_condition => p_name, 
        p_page_item => p_item_name,
        p_region_id => p_region_id);
        
    if p_name is not null then
      l_harmonized_name :=  pit_util.harmonize_sql_name(p_name);
    else
      l_harmonized_name := p_name;
    end if;
    
    pit.leave_detailed;
    return l_harmonized_name;
  exception
    when msg.INVALID_SQL_NAME_ERR then
      utl_apex.set_error(
        p_page_item => p_item_name,
        p_message => msg.INVALID_SQL_NAME,
        p_msg_args => null,
        p_region_id => p_region_id);
        
      pit.leave_detailed;
      return p_name;
  end check_name;
  
  
  /** Method to download a zip with export files for all selected groups of type P_TARGET
   * %param  p_target           Type of export items. One of PMS or PTI
   * %param  p_target_language  target language (Oracle name), to translate the messages to
   * %param  p_pmg_list         Colon separated list of message group names
   * %usage  Is used to create an XLIFF compatible list of files to translate the select target type.
   *         All selected groups are written to separate tranlsation files and downloaded as a zip file.
   */
  procedure translate_groups(
    p_target utl_apex.ora_name_type,
    p_target_language in pit_util.ora_name_type,
    p_pmg_list in char_table)
  as
    l_xliff xmltype;
    l_group_file_name utl_apex.ora_name_type;
    l_zip_file_name utl_apex.ora_name_type;
    l_zip_file blob;
  begin
    pit.enter_mandatory(
      p_action => 'translate_groups',
      p_params => msg_params(
                    msg_param('p_target', p_target),
                    msg_param('p_target_language', p_target_language)));
                    
    l_zip_file_name := 'Translation.zip';
    
    for i in 1 .. p_pmg_list.count loop
      pit_admin.create_translation_xml(
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
  
  
  /** Method to import a XLIFF translation file into the categorie defined by P_TARGET
   * %param  p_target           Type of export items. One of PMS or PTI
   * %usage  Is used to import an XLIFF compatible file into the database.
   */
  procedure import_translation(
    p_target utl_apex.ora_name_type)
  as
    l_xliff xmltype;
    l_page_item utl_apex.ora_name_type;
  begin
    pit.enter_mandatory(
      p_action => 'import_translation',
      p_params => msg_params(
                    msg_param('p_target', p_target)));
                    
    case p_target
      when pit_admin.C_TARGET_PMS then
        l_page_item := 'PMS_XLIFF';
      when pit_admin.C_TARGET_PTI then
        l_page_item := 'PTI_XLIFF';
      else
        pit.error(msg.UTL_INVALID_REQUEST);
    end case;
    
    select xmltype(blob_content, nls_charset_id('AL32UTF8'))
      into l_xliff
      from apex_application_temp_files
     order by created_on desc
     fetch first 1 row only;
    
    pit_admin.apply_translation(
      p_xliff => l_xliff,
      p_target => p_target);
        
    utl_apex.set_success_message(msg.PIT_XLIFF_IMPORTED);
    
    pit.leave_mandatory;
  exception
    when NO_DATA_FOUND then
      utl_apex.set_error(l_page_item, msg.PIT_PASS_MESSAGE, msg_args(SQLERRM));
    when msg.UTL_INVALID_REQUEST_ERR then
      utl_apex.set_error(
        p_page_item => null,
        p_message => msg.UTL_INVALID_REQUEST,
        p_msg_args => msg_args(utl_apex.get_request));
  end import_translation;
  
  
  /* Method to export groups
   * %param  p_target    Type of export items. One of PMS, PAR or PTI
   * %param  p_pmg_list  Colon separated list of translatable item group names.
   * %usage  Is used to combine all translatable items into separate files per group, wrap them in a ZIP and download it.
   */
  procedure export_groups(
    p_target pit_util.ora_name_type,
    p_pmg_list in char_table)
  as
    l_clob clob;
    l_xml xmltype;
    l_group_file_name utl_apex.ora_name_type;
    l_zip_file_name utl_apex.ora_name_type;
    l_zip_file blob;
  begin
    pit.enter_mandatory(
      p_action => 'expor_groups',
      p_params => msg_params(
                    msg_param('p_target', p_target)));
                    
    l_zip_file_name := 'Export.zip';
         
    for i in 1 .. p_pmg_list.count loop
      case 
        when p_target = pit_admin.C_TARGET_PMS or p_target = pit_admin.C_TARGET_PTI then
          pit_admin.create_installation_script(
            p_pmg_name => p_pmg_list(i),
            p_target => p_target,
            p_file_name => l_group_file_name,
            p_script => l_clob);
        when p_target = pit_admin.C_TARGET_PAR then
          l_clob := param_admin.export_parameter_group(p_pmg_list(i));
          l_group_file_name := 'ParameterGroup_' || p_pmg_list(i) || '.sql';
        else
          null;
      end case;
                   
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
      pit.handle_exception(msg.SQL_ERROR);
      raise;
  end export_groups;
  
  
  /* Method to export local parameters
   * %usage  Is used to export all locally overwritten or defined parameters.
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
  
  
  /* INTERFACE */
  function get_default_language
    return varchar2
  as
  begin
    return pit.get_default_language;
  end get_default_language;
  
  
  function get_help_websheet_id
    return pls_integer
  as
  begin
    return utl_apex.get_help_websheet_id;
  end get_help_websheet_id;
  
  
  function get_active_context
    return varchar2
  as
    l_context pit_util.context_type;
    l_stmt utl_apex.max_char;
    l_context_template constant utl_apex.max_sql_char := q'^with params as (
       select '#DEBUG_LEVEL#' debug_level,
              '#TRACE_LEVEL#' trace_level,
              '#TRACE_TIMING#' trace_timing,
              '#LOG_MODULES#' log_modules
         from dual),
     trace_settings as(
       select ptl_display_name
         from pit_trace_level_v
         join params
           on ptl_id = trace_level),
     trace_timing as(
       select pti_display_name
         from pit_translatable_item_v
         join params
           on pti_pmg_name = 'PIT'
          and pti_id = 'BOOLEAN_' || trace_timing),
     debug_settings as(
       select pse_display_name
         from pit_message_severity_v
         join params
           on pse_id = debug_level)
select pse_display_name debug_level, ptl_display_name trace_level, pti_display_name trace_timing, log_modules
  from params
 cross join trace_settings
 cross join debug_settings
 cross join trace_timing;^';
  begin
    pit.enter_mandatory;
    
    l_context := pit.get_context;
    
    l_stmt := utl_text.bulk_replace(l_context_template, char_table(
                'DEBUG_LEVEL', l_context.log_level,
                'TRACE_LEVEL', l_context.trace_level,
                'TRACE_TIMING', utl_apex.get_bool(l_context.trace_timing),
                'LOG_MODULES', l_context.module_list));
    
    pit.leave_mandatory;
    return l_stmt;
  end get_active_context;
  
  
  procedure harmonize_sql_name(
    p_item_name in varchar2,
    p_prefix in varchar2 default null)
  as
    l_name pit_util.max_sql_char;
  begin
    pit.enter_mandatory(
      p_params => msg_params(msg_param('p_item_name', p_item_name)));
    
    l_name := utl_apex.get_value(p_item_name);
    l_name := pit_util.harmonize_sql_name(l_name, p_prefix);
    utl_apex.set_value(p_item_name, l_name);
    
    pit.leave_mandatory(
      p_params => msg_params(msg_param('Result', l_name)));
  exception
    when others then
      -- leave the error display for the page validation, as an interactive grid does not support dynamic validation
      null;
  end harmonize_sql_name;
  
  
  function has_translatable_items
    return boolean
  as
    l_result number;
  begin
    pit.enter_mandatory;
    
    select count(*)
      into l_result
      from pit_translatable_item
     where rownum = 1;
           
    pit.leave_mandatory;
    return l_result = 1;
  end has_translatable_items;
  
  
  function has_local_parameters
    return boolean
  as
    l_result number;
  begin
    pit.enter_mandatory;
    
    select count(*)
      into l_result
      from parameter_local
     where rownum = 1;
    
    pit.leave_mandatory;
    return l_result = 1;
  end has_local_parameters;
  
  
  procedure set_allow_toggles
  as
  begin
    pit.enter_mandatory;
    
    param_admin.edit_parameter(
      p_par_id => 'ALLOW_TOGGLE', 
      p_par_pgr_id => 'PIT', 
      p_par_boolean_value => utl_apex.get_value('ALLOW_TOGGLE') = utl_apex.C_TRUE);
    
    pit.leave_mandatory;
  end set_allow_toggles;
  
  
  function is_default_context
    return boolean
  as
    l_result boolean;
  begin
    pit.enter_mandatory;
    
    l_result := utl_apex.get_value('PAR_ID') = pit_util.C_DEFAULT_CONTEXT;
    
    pit.leave_mandatory;
    return l_result;
  end is_default_context;
  
  
  function allows_toggles
    return utl_apex.flag_type
  as
    l_flag utl_apex.flag_type;
  begin
    pit.enter_mandatory;
    
    l_flag := utl_apex.get_bool(param.get_boolean('ALLOW_TOGGLE', 'PIT'));
    
    pit.leave_mandatory(
      p_params => msg_params(msg_param('Result', l_flag)));
    return l_flag;
  end allows_toggles;
    
  
  procedure set_language_settings(
    p_pml_list in pit_util.max_sql_char)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_pml_list', p_pml_list)));
    
    pit_admin.set_language_settings(p_pml_list);
    
    pit.leave_mandatory;
  end set_language_settings;
  
  
  function validate_edit_pmg
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_pmg;
    
    g_edit_pmg_row.pmg_name := check_name(g_edit_pmg_row.pmg_name, 'PMG_NAME', 'EDIT_PMG');
    
    pit.leave_mandatory;
    return true;
  end validate_edit_pmg;
  
  
  procedure process_edit_pmg
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_pmg;
    
    case when utl_apex.inserting or utl_apex.updating then
      pit_admin.merge_message_group(
        p_pmg_name => g_edit_pmg_row.pmg_name,
        p_pmg_description => g_edit_pmg_row.pmg_description);
    else
      pit_admin.delete_message_group(
        p_pmg_name => g_edit_pmg_row.pmg_name, 
        p_force => false);
    end case;
    
    pit.leave_mandatory;
  end process_edit_pmg;
  
  
  function validate_edit_pms
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_pms;
    
    g_edit_pms_row.pms_name := check_name(g_edit_pms_row.pms_name, 'PMS_NAME', 'EDIT_PMS');
    
    utl_apex.assert_not_null(
      p_condition => g_edit_pms_row.pms_pmg_name, 
      p_page_item => 'PMS_PMG_NAME');
    utl_apex.assert_not_null(
      p_condition => g_edit_pms_row.pms_text,  
      p_page_item => 'PMS_TEXT');
    utl_apex.assert_not_null(
      p_condition => g_edit_pms_row.pms_pse_id,  
      p_page_item => 'PMS_PSE_ID');
        
    pit.leave_mandatory;
    return true;
  end validate_edit_pms;
  
  
  procedure process_edit_pms
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_pms;
    case when utl_apex.inserting or utl_apex.updating then
      pit_admin.merge_message(
        p_pms_name => g_edit_pms_row.pms_name,
        p_pms_text => g_edit_pms_row.pms_text,
        p_pms_pse_id => g_edit_pms_row.pms_pse_id,
        p_pms_description => g_edit_pms_row.pms_description,
        p_pms_pmg_name => g_edit_pms_row.pms_pmg_name,
        p_pms_pml_name => g_edit_pms_row.pms_pml_name,
        p_error_number => g_edit_pms_row.pms_custom_error);
    else
      pit_admin.delete_message(g_edit_pms_row.pms_name);
    end case;
    
    pit.leave_mandatory;
  end process_edit_pms;
  
  
  function validate_edit_pgr
    return boolean
  as
    C_REGION_ID constant utl_apex.ora_name_type := 'EDIT_PGR';
  begin
    pit.enter_mandatory;
    
    copy_edit_pgr;
    
    g_edit_pgr_row.pgr_id := check_name(g_edit_pgr_row.pgr_id, 'PGR_ID', C_REGION_ID);
    
    utl_apex.assert_not_null(
      p_condition => g_edit_pgr_row.pgr_description,
      p_page_item => 'PGR_DESCRIPTION',
      p_region_id => C_REGION_ID);
      
    pit.leave_mandatory;
    return true;
  end validate_edit_pgr;
  
  
  procedure process_edit_pgr
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_pgr;
    
    case when utl_apex.inserting or utl_apex.updating then
      param_admin.edit_parameter_group(
        p_pgr_id => g_edit_pgr_row.pgr_id,
        p_pgr_description => g_edit_pgr_row.pgr_description,
        p_pgr_is_modifiable => g_edit_pgr_row.pgr_is_modifiable = utl_apex.C_TRUE);
    else
      param_admin.delete_parameter_group(g_edit_pgr_row.pgr_id, true);
    end case;
    
    pit.leave_mandatory;
  end process_edit_pgr;

  function validate_edit_pre
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    -- copy_edit_pre;
    -- validation logic goes here. If it exists, uncomment COPY function
    
    pit.leave_mandatory;
    return true;
  end validate_edit_pre;
  
  
  procedure process_edit_pre
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_pre;
    case when utl_apex.inserting or utl_apex.updating then
      param_admin.edit_parameter_realm(g_edit_pre_row);
    else
      param_admin.delete_parameter_realm(g_edit_pre_row.pre_id);
    end case;
    
    pit.leave_mandatory;
  end process_edit_pre;
  
  
  procedure initialize_edit_par
  as
    l_pgr_id parameter_group.pgr_id%type;
    l_pgr_is_modifiable parameter_group.pgr_is_modifiable%type;
  begin
    pit.enter_mandatory;
    
    l_pgr_id := v('P6_PGR_ID');
    
    select pgr_is_modifiable
      into l_pgr_is_modifiable
      from parameter_group
     where pgr_id = l_pgr_id;
    
    utl_apex.set_value('P7_PAR_PGR_ID', l_pgr_id);
    utl_apex.set_value('P7_PGR_IS_MODIFIABLE', l_pgr_is_modifiable);
    
    pit.leave_mandatory;
  end initialize_edit_par;
  
  
  function validate_edit_par
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_par;
    
    g_edit_par_row.par_id := check_name(g_edit_par_row.par_id, 'PAR_ID', 'EDIT_PAR');
    
    utl_apex.assert_datatype(
      p_value => g_edit_par_row.par_integer_value, 
      p_type => pit.type_integer,
      p_page_item => 'PAR_INTEGER_VALUE');
    
    utl_apex.assert_datatype(
      p_value => g_edit_par_row.par_integer_value, 
      p_type => pit.type_number,
      p_page_item => 'PAR_FLOAT_VALUE');
    
    utl_apex.assert_datatype(
      p_value => g_edit_par_row.par_date_value, 
      p_type => pit.type_date,
      p_page_item => 'PAR_DATE_VALUE');
    
    utl_apex.assert_datatype(
      p_value => g_edit_par_row.par_timestamp_value, 
      p_type => pit.type_timestamp,
      p_page_item => 'PAR_TIMESTAMP_VALUE');
    
    utl_apex.assert_datatype(
      p_value => g_edit_par_row.par_xml_value, 
      p_type => pit.type_xml,
      p_page_item => 'PAR_XML_VALUE');
    
    utl_apex.assert_not_null(
      p_condition => g_edit_par_row.par_pgr_id, 
      p_page_item => 'PAR_PGR_ID');
      
    pit.leave_mandatory;
    return true;
  end validate_edit_par;
  
  
  procedure process_edit_par
  as
    l_par_xml_value parameter_tab.par_xml_value%type;
  begin
    pit.enter_mandatory;
    
    copy_edit_par;
    
    if g_edit_par_row.par_xml_value is not null then
      l_par_xml_value := xmltype(g_edit_par_row.par_xml_value);
    end if;
    
    case when utl_apex.inserting or utl_apex.updating then
      param_admin.edit_parameter(
        p_par_id => g_edit_par_row.par_id,
        p_par_pgr_id => g_edit_par_row.par_pgr_id,
        p_par_description => g_edit_par_row.par_description,
        p_par_string_value => g_edit_par_row.par_string_value,
        p_par_xml_value => l_par_xml_value,
        p_par_integer_value => g_edit_par_row.par_integer_value,
        p_par_float_value => g_edit_par_row.par_float_value,
        p_par_date_value => g_edit_par_row.par_date_value,
        p_par_timestamp_value => g_edit_par_row.par_timestamp_value,
        p_par_boolean_value => g_edit_par_row.par_boolean_value = utl_apex.C_TRUE,
        p_par_is_modifiable => g_edit_par_row.par_is_modifiable = utl_apex.C_TRUE,
        p_par_pat_id => g_edit_par_row.par_pat_id,
        p_par_validation_string => g_edit_par_row.par_validation_string,
        p_par_validation_message => g_edit_par_row.par_validation_message);
    else
      param_admin.delete_parameter(
        p_par_id => g_edit_par_row.par_id,
        p_par_pgr_id => g_edit_par_row.par_pgr_id);
    end case;
    
    pit.leave_mandatory;
  end process_edit_par;
  
  
  function validate_edit_realm
    return boolean
  as
  begin
    pit.enter_mandatory;
  
    -- copy_edit_realm;
    -- validation logic goes here. If it exists, uncomment COPY function
  
    pit.leave_mandatory;
    return true;
  end validate_edit_realm;
  
  
  procedure process_edit_realm
  as
  begin
    pit.enter_mandatory;
  
    copy_edit_realm;
    case when utl_apex.inserting or utl_apex.updating then
      param_admin.edit_parameter_realm(g_edit_realm_row);
    when utl_apex.deleting then
      param_admin.delete_parameter_realm(g_edit_realm_row.pre_id);
    else
      null;
    end case;
  
    pit.leave_mandatory;
  end process_edit_realm;
  
    
  function validate_set_realm
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    -- copy_set_realm;
    -- validation logic goes here. If it exists, uncomment COPY function
    
    pit.leave_mandatory;
    return true;
  end validate_set_realm;
  
  
  procedure process_set_realm
  as
  begin
    pit.enter_mandatory;
    
    copy_set_realm;
    case when utl_apex.updating then
      param_admin.edit_parameter(
        p_par_id => g_set_realm_row.par_id,
        p_par_pgr_id => g_set_realm_row.par_pgr_id,
        p_par_string_value => g_set_realm_row.par_string_value);
    else
      null;
    end case;
    
    pit.leave_mandatory;
  end process_set_realm;
  
  
  function validate_edit_par_realm
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_par_realm;
    
    pit.start_message_collection;
    param_admin.validate_realm_parameter(
      p_par_id => g_edit_par_realm_row.pre_par_id,
      p_par_pgr_id => g_edit_par_realm_row.pre_pgr_id,
      p_par_string_value => g_edit_par_realm_row.pre_string_value,
      p_par_integer_value => g_edit_par_realm_row.pre_integer_value,
      p_par_float_value => g_edit_par_realm_row.pre_float_value,
      p_par_date_value => g_edit_par_realm_row.pre_date_value,
      p_par_timestamp_value => g_edit_par_realm_row.pre_timestamp_value,
      p_par_boolean_value => g_edit_par_realm_row.pre_boolean_value = utl_apex.C_TRUE);
    pit.stop_message_collection;
  
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      utl_apex.handle_bulk_errors(char_table());
      
      pit.leave_mandatory;
      return true;
  end validate_edit_par_realm;
  
  
  procedure process_edit_par_realm
  as
    
  begin
    pit.enter_mandatory;
    
    copy_edit_par_realm;
    
    if utl_apex.inserting or utl_apex.updating then
      param_admin.edit_realm_parameter(
        p_par_id => g_edit_par_realm_row.pre_par_id,
        p_par_pgr_id => g_edit_par_realm_row.pre_pgr_id,
        p_par_pre_id => g_edit_par_realm_row.pre_id,
        p_par_string_value => g_edit_par_realm_row.pre_string_value,
        p_par_integer_value => g_edit_par_realm_row.pre_integer_value,
        p_par_float_value => g_edit_par_realm_row.pre_float_value,
        p_par_date_value => g_edit_par_realm_row.pre_date_value,
        p_par_timestamp_value => g_edit_par_realm_row.pre_timestamp_value,
        p_par_boolean_value => g_edit_par_realm_row.pre_boolean_value = utl_apex.C_TRUE);
    else
      param_admin.delete_realm_parameter(
        p_par_id => g_edit_par_realm_row.pre_par_id,
        p_par_pgr_id => g_edit_par_realm_row.pre_pgr_id,
        p_par_pre_id => g_edit_par_realm_row.pre_id);
    end if;
    
    pit.leave_mandatory;
  end process_edit_par_realm;
  
  
  function validate_export
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    copy_export;
    
    case utl_apex.get_request
      when 'TRANSLATE_PMS' then
        utl_apex.assert(
          p_condition => g_export_row.pms_pmg_list.count > 0,
          p_message_name => msg.UTL_PARAMETER_REQUIRED,
          p_page_item => 'PMS_PMG_LIST');
        utl_apex.assert_not_null(
          p_condition => g_export_row.pms_pml_name, 
          p_message_name => msg.UTL_PARAMETER_REQUIRED,
          p_page_item => 'PMS_PML_NAME');
      when 'IMPORT_PMS' then
        null;
      when 'EXPORT_PMS' then
        utl_apex.assert(
          p_condition => g_export_row.pms_pmg_list.count > 0, 
          p_message_name => msg.UTL_PARAMETER_REQUIRED,
          p_page_item => 'PMS_PMG_LIST');
      when 'TRANSLATE_PTI' then
        utl_apex.assert(
          p_condition => g_export_row.pti_pmg_list.count > 0, 
          p_message_name => msg.UTL_PARAMETER_REQUIRED,
          p_page_item => 'PTI_PGR_LIST');
        utl_apex.assert_not_null(
          p_condition => g_export_row.pti_pml_name, 
          p_message_name => msg.UTL_PARAMETER_REQUIRED,
          p_page_item => 'PTI_PML_NAME');
      when 'IMPORT_PTI' then
        null;
      when 'EXPORT_PTI' then
        utl_apex.assert(
          p_condition => g_export_row.pti_pmg_list.count > 0, 
          p_message_name => msg.UTL_PARAMETER_REQUIRED,
          p_page_item => 'PTI_PGR_LIST');
      when 'EXPORT_PAR' then
        utl_apex.assert(
          p_condition => g_export_row.par_pgr_list.count > 0, 
          p_message_name => msg.UTL_PARAMETER_REQUIRED,
          p_page_item => 'PAR_PGR_LIST');
      when 'EXPORT_LOCAL_PAR' then
        null;
      else
        utl_apex.set_error(
          p_page_item => null,
          p_message => msg.UTL_INVALID_REQUEST,
          p_msg_args => msg_args(utl_apex.get_request));
    end case;
    
    pit.leave_mandatory;
    return true;
  end validate_export;
  
  
  procedure process_export
  as
  begin
    pit.enter_mandatory;
    
    copy_export;
    
    case utl_apex.get_request
      when 'TRANSLATE_PMS' then
        translate_groups(
          p_target => pit_admin.C_TARGET_PMS,
          p_target_language => g_export_row.pms_pml_name,
          p_pmg_list => g_export_row.pms_pmg_list);
      when 'IMPORT_PMS' then
        import_translation(
          p_target => pit_admin.C_TARGET_PMS);
      when 'EXPORT_PMS' then
        export_groups(
          p_target => pit_admin.C_TARGET_PMS, 
          p_pmg_list => g_export_row.pms_pmg_list);
      when 'TRANSLATE_PTI' then
        translate_groups(
          p_target => pit_admin.C_TARGET_PTI,
          p_target_language => g_export_row.pti_pml_name,
          p_pmg_list => g_export_row.pti_pmg_list);
      when 'IMPORT_PTI' then
        import_translation(
          p_target => pit_admin.C_TARGET_PTI);
      when 'EXPORT_PTI' then
        export_groups(
          p_target => pit_admin.C_TARGET_PTI, 
          p_pmg_list => g_export_row.pti_pmg_list);
      when 'EXPORT_PAR' then
        export_groups(
          p_target => pit_admin.C_TARGET_PAR, 
          p_pmg_list => g_export_row.par_pgr_list);
      when 'EXPORT_LOCAL_PAR' then
        export_local_parameters;
      else
        utl_apex.set_error(
          p_page_item => null,
          p_message => msg.UTL_INVALID_REQUEST,
          p_msg_args => msg_args(utl_apex.get_request));
    end case;
    
    pit.leave_mandatory;
  end process_export;
  
  
  function validate_edit_module
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_module;
    
    utl_apex.assert_datatype(
      p_value => g_edit_module_row.par_integer_value, 
      p_type => pit.type_integer,
      p_page_item => 'PAR_INTEGER_VALUE');
    
    utl_apex.assert_datatype(
      p_value => g_edit_module_row.par_integer_value, 
      p_type => pit.type_number,
      p_page_item => 'PAR_FLOAT_VALUE');
    
    utl_apex.assert_datatype(
      p_value => g_edit_module_row.par_date_value, 
      p_type => pit.type_date,
      p_page_item => 'PAR_DATE_VALUE');
    
    utl_apex.assert_datatype(
      p_value => g_edit_module_row.par_timestamp_value, 
      p_type => pit.type_timestamp,
      p_page_item => 'PAR_TIMESTAMP_VALUE');
    
    pit.leave_mandatory;
    return true;
  end validate_edit_module;
  
  
  procedure process_edit_module
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_module;
    
    case 
      when utl_apex.updating then
        param_admin.edit_parameter(
          p_par_id => g_edit_module_row.par_id, 
          p_par_pgr_id => g_edit_module_row.par_pgr_id,
          p_par_string_value => g_edit_module_row.par_string_value,
          p_par_date_value => g_edit_module_row.par_date_value,
          p_par_timestamp_value => g_edit_module_row.par_timestamp_value,
          p_par_boolean_value => utl_apex.get_bool(g_edit_module_row.par_boolean_value),
          p_par_integer_value => g_edit_module_row.par_integer_value,
          p_par_float_value => g_edit_module_row.par_float_value);
      when utl_apex.deleting then
        param_admin.delete_parameter(
          p_par_id => g_edit_module_row.par_id, 
          p_par_pgr_id => g_edit_module_row.par_pgr_id);
      else
        utl_apex.set_error(
          p_page_item => null,
          p_message => msg.UTL_INVALID_REQUEST,
          p_msg_args => msg_args(utl_apex.get_request));
    end case;
    
    pit.leave_mandatory;
  end process_edit_module;
  
    
  function validate_edit_context
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    -- copy_edit_context;
    -- validation logic goes here. If it exists, uncomment COPY function
    
    pit.leave_mandatory;
    return true;
  end validate_edit_context;
  
  
  procedure process_edit_context
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_context;
    
    case when utl_apex.inserting or utl_apex.updating then
      pit_admin.create_named_context(
        p_context_name => g_edit_context_row.par_id,
        p_log_level => g_edit_context_row.pse_id,
        p_trace_level => g_edit_context_row.ptl_id,
        p_trace_timing => g_edit_context_row.ctx_timing = pit_util.C_TRUE,
        p_module_list => g_edit_context_row.ctx_output_modules,
        p_comment => g_edit_context_row.par_description);
        
      -- Propagate changed settings to all sessions
      pit.reset_context(false);
    else
      pit_admin.remove_named_context(g_edit_context_row.par_id);
    end case;
    
    pit.leave_mandatory;
  end process_edit_context;
  
  
  function validate_edit_toggle
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_toggle;

    pit_util.check_toggle_settings(
        p_toggle_name => g_edit_toggle_row.par_id,
        p_module_list => g_edit_toggle_row.toggle_module_list,
        p_context_name => g_edit_toggle_row.toggle_context_name);
    
    pit.leave_mandatory;
    return true;
  exception
    when msg.INVALID_SQL_NAME_ERR then
      utl_apex.set_error('PAR_ID', msg.INVALID_SQL_NAME);
      pit.leave_mandatory;
      return true;
    when pit_util.context_missing then
      utl_apex.set_error('TOGGLE_CONTEXT_NAME', msg.PIT_CONTEXT_MISSING, msg_args(g_edit_toggle_row.toggle_context_name));
      pit.leave_mandatory;
      return true;
    when pit_util.name_too_long then
      utl_apex.set_error('PAR_ID', msg.PIT_NAME_TOO_LONG, msg_args(to_char(pit_util.C_MAX_LENGTH)));
      pit.leave_mandatory;
      return true;
    when others then
      raise;
  end validate_edit_toggle;
  
  
  procedure process_edit_toggle
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_toggle;
    case when utl_apex.inserting or utl_apex.updating then
      pit_admin.create_context_toggle(
        p_toggle_name => g_edit_toggle_row.par_id,
        p_module_list => g_edit_toggle_row.toggle_module_list,
        p_context_name => g_edit_toggle_row.toggle_context_name,
        p_comment => g_edit_toggle_row.par_description);
    else
      pit_admin.delete_context_toggle(
        p_toggle_name => g_edit_toggle_row.par_id);
    end case;
    
    pit.leave_mandatory;
  end process_edit_toggle;
  
end pit_ui;
/