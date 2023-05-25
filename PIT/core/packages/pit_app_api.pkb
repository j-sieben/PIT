create or replace package body pit_app_api
as

  /** 
    Package: PIT_APP_API Body
      Package to support the PIT administration application.
   
    Author:: 
      Juergen Sieben, ConDeS GmbH
      
      Published under MIT licence
   */
   
  C_MIN_ERROR constant number := -20999;
  C_MAX_ERROR constant number := -20000;
  C_DEFAULT_LANGUAGE constant number := 10;
  
  type pmg_allowed_length_t is table of binary_integer index by pit_util.ora_name_type;
  g_pmg_allowed_length pmg_allowed_length_t;
  
  /**
    Group: Helper Methods
   */
  /**
    Procedure: initialize
      Initialization method of the package
   */
  procedure initialize
  as
    cursor pmg_length_cur is
      with ora_name_length as (
             select data_length
               from all_tab_columns
              where table_name = 'USER_TABLES'
                and column_name = 'TABLE_NAME')
      select pmg_name, 
             data_length - 
             (case when pmg_error_prefix is not null then length(pmg_error_prefix) + 1 else 0 end + 
             case when pmg_error_postfix is not null then length(pmg_error_postfix) + 1 else 0 end) allowed_length
        from pit_message_group
       cross join ora_name_length;
  begin
    for pmg in pmg_length_cur loop
      g_pmg_allowed_length(pmg.pmg_name) := pmg.allowed_length;
    end loop;
  end initialize;
  
  
  /**
    Group: Data access methods
   */
  /**
    Function: get_parameter_type_table
      See <pit_app_api.get_parameter_type_table>
   */
  function get_parameter_type_table
    return parameter_type_table
    pipelined
  as
    cursor parameter_type_cur is
      select *
        from parameter_type;
  begin
    for r in parameter_type_cur loop
      pipe row (r);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
      null;
  end get_parameter_type_table;
  
  
  /**
    Function: get_parameter_realm_table
      See <pit_app_api.get_parameter_realm_table>
   */
  function get_parameter_realm_table
    return parameter_realm_table
    pipelined
  as
    cursor parameter_realm_cur is
      select *
        from parameter_realm;
  begin
    for r in parameter_realm_cur loop
      pipe row (r);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
      null;
  end get_parameter_realm_table;
  
  
  /**
    Function: get_parameter_realm_view
      See <pit_app_api.get_parameter_realm_view>
   */
  function get_parameter_realm_view
    return parameter_realm_v_table
    pipelined
  as
    cursor parameter_realm_v_cur is
      select *
        from parameter_realm_v;
  begin
    for r in parameter_realm_v_cur loop
      pipe row (r);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
      null;
  end get_parameter_realm_view;
      
    
  /**
    Function: get_parameter_table
      See <pit_app_api.get_parameter_table>
   */
  function get_parameter_table
    return parameter_table
    pipelined
  as
    cursor parameter_cur is
      select *
        from parameter_v;
  begin
    for r in parameter_cur loop
      pipe row (r);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
      null;
  end get_parameter_table;
  
  
  /**
    Function: get_pit_message_severity_table
      See <pit_app_api.get_pit_message_severity_table>
   */
  function get_pit_message_severity_table
    return pit_message_severity_table
    pipelined
  as
    cursor pit_message_severity_cur is
      select *
        from pit_message_severity_v;
  begin
    for r in pit_message_severity_cur loop
      pipe row (r);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
      null;
  end get_pit_message_severity_table;
  
  
  /**
    Function: get_pit_message_group_table
      See <pit_app_api.get_pit_message_group_table>
   */
  function get_pit_message_group_table
    return pit_message_group_table
    pipelined
  as
    cursor pit_message_group_cur is
      select *
        from pit_message_group;
  begin
    for r in pit_message_group_cur loop
      pipe row (r);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
      null;
  end get_pit_message_group_table;
  
  
  /**
    Function: get_pit_message_language_table
      See <pit_app_api.get_pit_message_language_table>
   */
  function get_pit_message_language_table
    return pit_message_language_table
    pipelined
  as
    cursor pit_message_language_cur is
      select *
        from pit_message_language_v;
  begin
    for r in pit_message_language_cur loop
      pipe row (r);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
      null;
  end get_pit_message_language_table;
  
  
  /**
    Function: get_pit_trace_level_table
      See <pit_app_api.get_pit_trace_level_table>
   */
  function get_pit_trace_level_table
    return pit_trace_level_table
    pipelined
  as
    cursor pit_trace_level_cur is
      select *
        from pit_trace_level_v;
  begin
    for r in pit_trace_level_cur loop
      pipe row (r);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
      null;
  end get_pit_trace_level_table;
  
  /**
    Group: Public Methods
   */
  /**
    Procedure: allows_toggles
      See <pit_app_api.allows_toggles>
   */
  function allows_toggles
  return boolean
  as
    l_flag pit_util.flag_type;
  begin
    select par_boolean_value
      into l_flag
      from parameter_v
     where par_pgr_id = 'PIT'
       and par_id = 'ALLOW_TOGGLE';
       
    return l_flag = pit_util.C_TRUE;
  end allows_toggles;
  
  
  /**
    Procedure: apply_translation
      See <pit_app_api.apply_translation>
   */
  procedure apply_translation(
    p_xliff in xmltype,
    p_target in varchar2)
  as
  begin
    pit_admin.apply_translation(
      p_xliff => p_xliff,
      p_target => p_target);
  end apply_translation;
  
  
  /**
    Procedure: check_name
      See <pit_app_api.check_name>
   */
  function check_name(
    p_name in pit_util.ora_name_type,
    p_prefix in varchar2 default null)
    return varchar2
  as
    l_harmonized_name pit_util.ora_name_type;
    l_max_length binary_integer;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_name', p_name)));
    
    l_max_length := pit_util.c_max_length  - length(p_prefix);
    
    pit.assert_not_null(
      p_condition => p_name,
      p_message_name => msg.PIT_PARAM_MISSING,
      p_error_code => p_prefix || 'NAME_MISSING');
        
    l_harmonized_name := pit_util.harmonize_sql_name(p_name, p_prefix);
    
    pit.leave_detailed;
    return l_harmonized_name;
  exception
    when dbms_assert.INVALID_SQL_NAME then
      pit.error(
        p_message_name => msg.PIT_INVALID_SQL_NAME,
        p_msg_args => msg_args(p_name));
      return p_name;
    when others then
      if SQLCODE = -20000 then
        -- pit_util.harmonize_sql_name may throw this if the name is too long
        pit.error(
          p_message_name => msg.PIT_NAME_TOO_LONG,
          p_msg_args => msg_args(to_char(l_max_length)),
          p_error_code => p_prefix || 'NAME_TOO_LONG');
        return p_name;
      else
        raise;
      end if;
  end check_name;
  
  
  /**
    Function: has_translatable_items
      See <pit_app_api.has_translatable_items>
   */
  function has_translatable_items
    return boolean
  as
  begin
    return true;
  end has_translatable_items; 
  
  
  /**
    Function: has_local_parameters
      See <pit_app_api.has_local_parameters>
   */
  function has_local_parameters
    return boolean
  as
  begin
    return true;
  end has_local_parameters;   
  
  
  /**
    Function: parameter_group_is_modifiable
      See <pit_app_api.parameter_group_is_modifiable>
   */
  function parameter_group_is_modifiable(
    p_pgr_id in pit_name_type)
    return pit_flag_type
  as
  begin
    return pit_util.C_TRUE;
  end parameter_group_is_modifiable;   
  
  
  /**
    Procedure: create_named_context
      See <pit_app_api.create_named_context>
   */
  procedure create_named_context(
    p_context_name in varchar2,
    p_log_level in number,
    p_trace_level in number,
    p_trace_timing in boolean,
    p_module_list in varchar2,
    p_comment in varchar2 default null)
  as
  begin
    pit_admin.create_named_context(
      p_context_name => p_context_name,
      p_log_level => p_log_level,
      p_trace_level => p_trace_level,
      p_trace_timing => p_trace_timing,
      p_module_list => p_module_list,
      p_comment => p_comment);
  end create_named_context;
  
  
  /**
    Function: get_realm
      See <pit_app_api.get_realm>
   */
  function get_realm
    return varchar2
  as
  begin
    return param.get_string('REALM', 'PIT');
  end get_realm;
  
  
  /**
    Procedure: delete_context_toggle
      See <pit_app_api.delete_context_toggle>
   */
  procedure delete_context_toggle(
    p_toggle_name in varchar2)
  as
  begin
    pit_admin.delete_context_toggle(p_toggle_name);
  end delete_context_toggle;
      
    
  /**
    Function: get_pit_message_table
      See <pit_app_api.get_pit_message_table>
   */
  function get_pit_message_table
    return pit_message_table
    pipelined
  as
    cursor pit_message_cur is
      select *
        from pit_message;
  begin
    for r in pit_message_cur loop
      pipe row (r);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
      null;
  end get_pit_message_table;
    
    
  /**
    Procedure: delete_pit_message
      See <pit_app_api.delete_pit_message>
   */
  procedure delete_pit_message(
    p_pms_name in pit_message.pms_name%type,
    p_pms_pml_name in pit_message_language.pml_name%type default null)
  as
  begin
    pit_admin.delete_message(
      p_pms_name => p_pms_name,
      p_pms_pml_name => p_pms_pml_name);
  end delete_pit_message;
  
  
  /**
    Procedure: delete_pit_message_group
      See <pit_app_api.delete_pit_message_group>
   */
  procedure delete_pit_message_group(
    p_pmg_name in pit_message_group.pmg_name%type,
    p_force in boolean default false)
  as
  begin
    pit_admin.delete_message_group(
      p_pmg_name => p_pmg_name,
      p_force => p_force);
  end delete_pit_message_group;
  
  
  /**
    Procedure: delete_named_context
      See <pit_app_api.delete_named_context>
   */
  procedure delete_named_context(
    p_context_name in varchar2)
  as
  begin
    pit_admin.delete_named_context(p_context_name);
  end delete_named_context;
  
  
  /**
    Procedure: delete_parameter
      See <pit_app_api.delete_parameter>
   */
  procedure delete_parameter(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_v.par_pgr_id%type)
  as
  begin
    param_admin.delete_parameter(
      p_par_id => p_par_id,
      p_par_pgr_id => p_par_pgr_id);
  end delete_parameter;
      
    
  /**
    Function: get_parameter_group_table
      See <pit_app_api.get_parameter_group_table>
   */
  function get_parameter_group_table
    return parameter_group_table
    pipelined
  as
    cursor parameter_group_cur is
      select *
        from parameter_group;
  begin
    for r in parameter_group_cur loop
      pipe row (r);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
      null;
  end get_parameter_group_table;
  
  
  /**
    Procedure: delete_parameter_group
      See <pit_app_api.delete_parameter_group>
   */
  procedure delete_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type,
    p_force in boolean default false)
  as
  begin
    param_admin.delete_parameter_group(
      p_pgr_id => p_pgr_id,
      p_force => p_force);
  end delete_parameter_group;
  
  
  /**
    Procedure: delete_parameter_realm
      See <pit_app_api.delete_parameter_realm>
   */
  procedure delete_parameter_realm(
    p_pre_id in parameter_realm.pre_id%type,
    p_force in boolean default false)
  as
  begin
    param_admin.delete_parameter_realm(
      p_pre_id => p_pre_id,
      p_force => p_force);
  end delete_parameter_realm;
  
  
  /**
    Procedure: delete_realm_parameter
      See <pit_app_api.delete_realm_parameter>
   */
  procedure delete_realm_parameter(
    p_par_id parameter_v.par_id%type,
    p_par_pgr_id parameter_v.par_pgr_id%type,
    p_par_pre_id in parameter_realm.pre_id%type)
  as
  begin
    param_admin.delete_realm_parameter(
        p_par_id => p_par_id,
        p_par_pgr_id => p_par_pgr_id,
        p_par_pre_id => p_par_pre_id);
  end delete_realm_parameter;
  
  
  /**
    Procedure: export_group
      See <pit_app_api.export_group>
   */
  procedure export_group(
    p_target pit_util.ora_name_type,
    p_group_name in pit_util.ora_name_type,
    p_target_language in pit_util.ora_name_type,
    p_script out nocopy clob)
  as
  begin
    pit_admin.create_installation_script(
      p_pmg_name => p_group_name,
      p_target => p_target,
      p_target_language => p_target_language,
      p_script => p_script);
  end export_group;
  
  
  /**
    Procedure: merge_context_toggle
      See <pit_app_api.merge_context_toggle>
   */
  procedure merge_context_toggle(
    p_toggle_name in varchar2,
    p_module_list in varchar2,
    p_context_name in varchar2,
    p_comment in varchar2 default null)
  as
  begin
    pit_admin.create_context_toggle(
      p_toggle_name => p_toggle_name,
      p_module_list => p_module_list,
      p_context_name => p_context_name,
      p_comment => p_comment);
  end merge_context_toggle;
  
  
  /**
    Procedure: merge_message
      See <pit_app_api.merge_message>
   */
  procedure merge_message(
    p_row in out nocopy pit_message_rowtype)
  as
  begin
    pit_admin.merge_message(p_row);
  end merge_message;
  
  
  /**
    Procedure: delete_message
      See <pit_app_api.delete_message>
   */
  procedure delete_message(
    p_row in out nocopy pit_message_rowtype)
  as
  begin
    pit_admin.delete_message(p_row.pms_name);
  end delete_message;
  
  
  /**
    Procedure: merge_message_group
      See <pit_app_api.merge_message_group>
   */
  procedure merge_message_group(
    p_row in out nocopy pit_message_group_rowtype)
  as
  begin
    pit_admin.merge_message_group(p_row);
  end merge_message_group;
  
  
  /**
    Procedure: delete_message_group
      See <pit_app_api.delete_message_group>
   */
  procedure delete_message_group(
    p_row in pit_message_group_rowtype,
    p_force in boolean)
  as
  begin
    pit_admin.delete_message_group(
      p_pmg_name => p_row.pmg_name, 
      p_force => false);
  end delete_message_group;
  
  
  /**
    Procedure: merge_parameter
      See <pit_app_api.merge_parameter>
   */
  procedure merge_parameter(
    p_row in parameter_v_rowtype)
  as
  begin
    param_admin.edit_parameter(p_row);
  end merge_parameter;
  
  
  /**
    Procedure: merge_parameter_group
      See <pit_app_api.merge_parameter_group>
   */
  procedure merge_parameter_group(
    p_row in parameter_group_rowtype)
  as
  begin
    param_admin.edit_parameter_group(p_row);
  end merge_parameter_group;
  
  
  /**
    Procedure: merge_parameter_realm
      See <pit_app_api.merge_parameter_realm>
   */
  procedure merge_parameter_realm(
    p_row in parameter_realm_rowtype)
  as
  begin
    param_admin.edit_parameter_realm(p_row);
  end merge_parameter_realm;
  
  
  /**
    Procedure: merge_realm_parameter
      See <pit_app_api.merge_realm_parameter>
   */
  procedure merge_realm_parameter(
    p_row in parameter_v_rowtype)
  as
  begin
    param_admin.edit_realm_parameter(p_row);
  end merge_realm_parameter;
  
  
  /**
    Procedure: set_allow_toggles
      See <pit_app_api.set_allow_toggles>
   */
  procedure set_allow_toggles(
    p_allowed in boolean)
  as
  begin
    
    param_admin.edit_parameter(
      p_par_id => 'ALLOW_TOGGLE', 
      p_par_pgr_id => 'PIT', 
      p_par_boolean_value => p_allowed);
    
  end set_allow_toggles;
  
  
  /**
    Procedure: set_language_settings
      See <pit_app_api.set_language_settings>
   */
  procedure set_language_settings(
    p_pml_list in pit_util.max_sql_char)
  as
  begin
    pit_admin.set_language_settings(
      p_pml_list => p_pml_list);
  end set_language_settings;
  
  
  /**
    Procedure: translate_group
      See <pit_app_api.translate_group>
   */
  procedure translate_group(
    p_target_language in pit_message_language.pml_name%type,
    p_pmg_name in pit_message_group.pmg_name%type default null,
    p_target in varchar2,
    p_file_name in pit_util.ora_name_type,
    p_xliff out nocopy xmltype)
  as
  begin
    pit_admin.create_translation_xml(
      p_target_language => p_target_language,
      p_pmg_name => p_pmg_name,
      p_target => p_target,
      p_file_name => p_file_name,
      p_xliff => p_xliff);
  end translate_group;
  
  
  /**
    Procedure: validate_context_toggle
      See <pit_app_api.validate_context_toggle>
   */
  procedure validate_context_toggle(
    p_toggle_name in out nocopy pit_util.ora_name_type,
    p_context_name in out nocopy pit_util.ora_name_type,
    p_module_list in pit_util.max_sql_char)
  as
  begin

    p_toggle_name := check_name(p_toggle_name, pit_util.C_TOGGLE_PREFIX);
    p_context_name := check_name(p_context_name, pit_util.C_CONTEXT_PREFIX);
    
    if pit.has_no_bulk_error then
      pit_util.check_toggle_settings(
        p_toggle_name => p_toggle_name,
        p_context_name => p_context_name,
        p_module_list => p_module_list);
    end if;
        
  exception
    when pit_util.context_missing then
      pit.error(
        p_message_name => msg.PIT_CONTEXT_MISSING,
        p_msg_args => msg_args(p_context_name));
  end validate_context_toggle;
    
  
  
  /**
    Procedure: validate_data_type
      See <pit_app_api.validate_data_type>
   */
  procedure validate_data_type(
    p_row parameter_v_rowtype)
  as
  begin
    pit.enter_mandatory;
    
    pit.assert_datatype(
      p_value => p_row.par_integer_value, 
      p_type => pit.type_integer,
      p_error_code => 'DATAYPE_MISMATCH_INTEGER');
    
    pit.assert_datatype(
      p_value => p_row.par_integer_value, 
      p_type => pit.type_number,
      p_error_code => 'DATAYPE_MISMATCH_FLOAT');
    
    pit.assert_datatype(
      p_value => p_row.par_date_value, 
      p_type => pit.type_date,
      p_error_code => 'DATAYPE_MISMATCH_DATE');
    
    pit.assert_datatype(
      p_value => p_row.par_timestamp_value, 
      p_type => pit.type_timestamp,
      p_error_code => 'DATAYPE_MISMATCH_TIMESTAMP');
      
    pit.leave_mandatory;
  end validate_data_type;
  
  
  /**
    Procedure: validate_message_group
      See <pit_app_api.validate_message_group>
   */
  procedure validate_message_group(
    p_row in out nocopy pit_message_group_rowtype)
  as
    l_prefix_length binary_integer;
  begin
    pit.enter_mandatory;
    
    p_row.pmg_name := check_name(p_row.pmg_name);
    
    pit.assert_not_null(
      p_condition => p_row.pmg_error_prefix || p_row.pmg_error_postfix,
      p_message_name => msg.PIT_PMG_ERROR_MARKER_MISSING);
    
    if pit.has_no_bulk_error then
      l_prefix_length := coalesce(length(p_row.pmg_error_prefix || p_row.pmg_error_postfix), 0);
      pit.assert(
        p_condition => l_prefix_length between 1 and 12,
        p_message_name => msg.PIT_PMG_ERROR_MARKER_INVALID);
    end if;
      
    pit.leave_mandatory;
  end validate_message_group;
  
  
  /**
    Procedure: validate_message
      See <pit_app_api.validate_message>
   */
  procedure validate_message(
    p_row in out nocopy pit_message_rowtype)
  as
    l_predefined_error pit_util.predefined_error_rec;
  begin
    pit.enter_mandatory;
      
    p_row.pms_name := check_name(p_row.pms_name);
    
    pit.assert_not_null(
      p_condition => p_row.pms_PMG_NAME,  
      p_message_name => msg.PIT_PARAM_MISSING,
      p_error_code => 'PMS_PMG_NAME_MISSING');    
    pit.assert_not_null(
      p_condition => p_row.pms_text,  
      p_message_name => msg.PIT_PARAM_MISSING,
      p_error_code => 'PMS_TEXT_MISSING');
    pit.assert_not_null(
      p_condition => p_row.pms_pse_id,  
      p_message_name => msg.PIT_PARAM_MISSING,
      p_error_code => 'PMS_PSE_ID_MISSING');
    
    case
    -- In case of Oracle error numbers it is mandatory to check for already named errors
    when p_row.pms_pse_id in (pit.LEVEL_FATAL, pit.LEVEL_ERROR) 
         and p_row.pms_custom_error not between C_MIN_ERROR and C_MAX_ERROR then
      l_predefined_error := pit_util.check_error_number_exists(
                              p_pms_name => p_row.pms_name, 
                              p_pms_custom_error => p_row.pms_custom_error);
      pit.assert_is_null(
        p_condition => l_predefined_error.error_name,
        p_message_name => msg.PIT_PMS_PREDEFINED_ERROR,
        p_msg_args => msg_args(
                        to_char(p_row.pms_custom_error), 
                        l_predefined_error.error_name, 
                        l_predefined_error.owner, 
                        l_predefined_error.package_name));
    -- normal errors are set to C_MAX_ERROR upfront. The actual error number
    -- is calculated when creating the MSG package
    when p_row.pms_pse_id in (pit.LEVEL_FATAL, pit.LEVEL_ERROR) then
      p_row.pms_custom_error := C_MAX_ERROR;
    else
      null;
    end case;
      
    pit.leave_mandatory;
  end validate_message;
  
  
  /**
    Procedure: validate_parameter
      See <pit_app_api.validate_parameter>
   */
  procedure validate_parameter(
    p_row in out nocopy parameter_v_rowtype)
  as
  begin
    
    p_row.par_id := check_name(p_row.par_id);
    
    pit.assert_datatype(
      p_value => p_row.par_integer_value, 
      p_type => pit.type_integer,
      p_error_code => 'DATAYPE_MISMATCH_INTEGER');
    
    pit.assert_datatype(
      p_value => p_row.par_integer_value, 
      p_type => pit.type_number,
      p_error_code => 'DATAYPE_MISMATCH_FLOAT');
    
    pit.assert_datatype(
      p_value => p_row.par_date_value, 
      p_type => pit.type_date,
      p_error_code => 'DATAYPE_MISMATCH_DATE');
    
    pit.assert_datatype(
      p_value => p_row.par_timestamp_value, 
      p_type => pit.type_timestamp,
      p_error_code => 'DATAYPE_MISMATCH_TIMESTAMP');
    
    pit.assert_not_null(
      p_condition => p_row.par_pgr_id, 
      p_message_name => msg.PIT_PARAM_MISSING,
      p_error_code => 'PAR_PGR_ID_MISSING');
      
  end validate_parameter;
  
  
  /**
    Procedure: validate_parameter_group
      See <pit_app_api.validate_parameter_group>
   */
  procedure validate_parameter_group(
    p_row in out nocopy parameter_group_rowtype)
  as
  begin
    
    p_row.pgr_id := check_name(p_row.pgr_id);
    
    pit.assert_not_null(
      p_condition => p_row.pgr_description,
      p_message_name => msg.PIT_PARAM_MISSING,
      p_error_code => 'PGR_DESCRIPTION_MISSING');
      
  end validate_parameter_group;
  
  
  /**
    Procedure: validate_realm_parameter
      See <pit_app_api.validate_realm_parameter>
   */
  procedure validate_realm_parameter(
    p_row in out nocopy parameter_v_rowtype)
  as
    l_par_id parameter_v.par_id%type;
    l_is_modifiable boolean;
  begin
    
    l_par_id := p_row.par_id;
    p_row := param_admin.get_parameter_settings(
               p_par_id => p_row.par_id,
               p_pgr_id => p_row.par_pgr_id);
    
    l_is_modifiable := p_row.par_id is not null and p_row.par_is_modifiable = pit_util.C_TRUE;
    
    if l_is_modifiable then
      validate_parameter(p_row);
    else
      pit.assert_not_null(
        p_condition => p_row.par_id,
        p_message_name => msg.PARAM_IS_NULL,
        p_msg_args => msg_args(l_par_id));
      pit.assert(
        p_condition => l_is_modifiable,
        p_message_name => msg.PARAM_NOT_MODIFIABLE,
        p_msg_args => msg_args(p_row.par_id));
    end if;
  end validate_realm_parameter;
  
begin
  initialize;
end pit_app_api;
/