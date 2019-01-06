create or replace package body pit_ui_pkg 
as

  C_PKG constant pit_util.ora_name_type := $$PLSQL_UNIT;
  
  /* Hilfsfunktionen */
  -- TODO: Auslagern in UTIL-Package
  function clob_to_blob(
    p_clob in clob)
    return blob
  as
    l_blob blob;
    l_lang_context binary_integer := dbms_lob.DEFAULT_LANG_CTX;
    l_warning binary_integer := dbms_lob.WARN_INCONVERTIBLE_CHAR;
    l_dest_offset binary_integer := 1;
    l_source_offset binary_integer := 1;
  begin
    pit.enter_detailed('clob_to_blob', C_PKG);
    
    dbms_lob.createtemporary(l_blob, true, dbms_lob.call);
      dbms_lob.converttoblob (
        dest_lob => l_blob,
        src_clob => p_clob,
        amount => dbms_lob.LOBMAXSIZE,
        dest_offset => l_dest_offset,
        src_offset => l_source_offset,
        blob_csid => dbms_lob.DEFAULT_CSID,
        lang_context => l_lang_context,
        warning => l_warning
      );
      
    pit.leave_detailed;
    return l_blob;
  end clob_to_blob;
  

  procedure download_blob(
    p_blob in out nocopy blob,
    p_file_name in varchar2)
  as
  begin
    pit.enter_optional(
      p_action => 'download_blob', 
      p_module => C_PKG,
      p_params => msg_params(msg_param('p_file_name', p_file_name)));
    
    htp.init;
    owa_util.mime_header('application/octet-stream', FALSE, 'UTF-8');
    htp.p('Content-length: ' || dbms_lob.getlength(p_blob));
    htp.p('Content-Disposition: inline; filename="' || p_file_name || '"');
    owa_util.http_header_close;
    wpg_docload.download_file(p_blob);
    apex_application.stop_apex_engine;

    pit.leave_optional;
  exception when others then
    htp.p('error: ' || sqlerrm);
    apex_application.stop_apex_engine;
    pit.leave_optional;
  end download_blob;


  procedure download_clob(
    p_clob in clob,
    p_file_name in varchar2)
  as
    l_blob blob;
  begin
    pit.enter_optional(
      p_action => 'download_clob', 
      p_module => C_PKG,
      p_params => msg_params(msg_param('p_file_name', p_file_name)));
    
    l_blob := clob_to_blob(p_clob);
    download_blob(l_blob, p_file_name);
    
    pit.leave_optional;
  end download_clob;
  
  
  /* INTERFACE */
  procedure set_language_settings(
    p_pml_list in pit_util.max_sql_char)
  as
  begin
    pit.enter_mandatory(
      p_action => 'set_language_settings',
      p_module => C_PKG,
      p_params => msg_params(
                    msg_param('p_pml_list', p_pml_list)));
    
    pit_admin.set_language_settings(p_pml_list);
    
    pit.leave_mandatory;
  end set_language_settings;
  

  procedure merge_message(
    p_pms_name in pit_util.ora_name_type,
    p_pms_pml_name in pit_util.ora_name_type,
    p_pms_text in clob,
    p_pms_pse_id in binary_integer,
    p_pms_custom_error binary_integer) as
  begin
    pit.enter_mandatory(
      p_action => 'merge_message',
      p_module => C_PKG,
      p_params => msg_params(
                    msg_param('p_pms_name', p_pms_name),
                    msg_param('p_pms_pml_name', p_pms_pml_name),
                    msg_param('p_pms_text', p_pms_text),
                    msg_param('p_pms_pse_id', to_char(p_pms_pse_id)),
                    msg_param('p_pms_custom_error', to_char(p_pms_custom_error))));
                    
    pit_admin.merge_message(
      p_pms_name => p_pms_name,
      p_pms_text => p_pms_text,
      p_pms_pse_id => p_pms_pse_id,
      p_pms_pml_name => p_pms_pml_name,
      p_error_number => p_pms_custom_error);
    pit_admin.create_message_package;
    
    pit.leave_mandatory;
  end merge_message;
  

  procedure delete_message(
    p_pms_name in pit_util.ora_name_type,
    p_pms_pml_name in pit_util.ora_name_type) as
  begin
    pit.enter_mandatory(
      p_action => 'delete_message',
      p_module => C_PKG,
      p_params => msg_params(
                    msg_param('p_pms_name', p_pms_name),
                    msg_param('p_pms_pml_name', p_pms_pml_name)));
                    
    pit_admin.remove_message(
      p_pms_name => p_pms_name,
      p_pms_pml_name => p_pms_pml_name);
    
    pit.leave_mandatory;
  end delete_message;
  
    
  procedure export_messages(
    p_message_pattern in pit_util.max_sql_char)
  as
    l_messages clob;
    l_file_name varchar2(100);
  begin
    pit.enter_mandatory(
      p_action => 'export_messages',
      p_module => C_PKG,
      p_params => msg_params(msg_param('p_message_pattern', p_message_pattern)));
      
    l_messages := pit_admin.get_messages(
                    p_message_pattern => upper(p_message_pattern));
    
    case when p_message_pattern is not null then
      l_file_name := 'Messages_' || replace(upper(p_message_pattern), '%') || '.sql';
    else
      l_file_name := 'Messages.sql';
    end case;
    
    download_clob(
      p_clob => l_messages,
      p_file_name => l_file_name);
    
    pit.leave_mandatory;
  end export_messages;
  
  
  procedure translate_messages(
    p_target_language in pit_util.ora_name_type,
    p_message_pattern in pit_util.max_sql_char)
  as
    l_xliff xmltype;
  begin
    pit.enter_mandatory(
      p_action => 'translate_messages',
      p_module => C_PKG,
      p_params => msg_params(
                    msg_param('p_target_language', p_target_language),
                    msg_param('p_message_pattern', p_message_pattern)));
                    
    l_xliff := pit_admin.get_translation_xml(
                 p_target_language => p_target_language,
                 p_message_pattern => upper(p_message_pattern));
                 
    download_clob(
      p_clob => l_xliff.getClobVal(),
      p_file_name => 'MessageTranslation' || initcap(p_target_language) || '.xml');
    
    pit.leave_mandatory;
  end translate_messages;


  /* NAMED CONTEXTS */
  procedure merge_named_context(
    p_context_name in pit_util.ora_name_type,
    p_log_level in binary_integer,
    p_trace_level in binary_integer,
    p_trace_timing in pit_util.flag_type,
    p_module_list in pit_util.max_sql_char,
    p_comment in pit_util.max_char)
  as
  begin
    pit.enter_mandatory(
      p_action => 'merge_named_context',
      p_module => C_PKG,
      p_params => msg_params(
                    msg_param('p_context_name', p_context_name),
                    msg_param('p_log_level', to_char(p_log_level)),
                    msg_param('p_trace_level', to_char(p_trace_level)),
                    msg_param('p_trace_timing', p_trace_timing),
                    msg_param('p_module_list', p_module_list),
                    msg_param('p_comment', p_comment)));
                    
    pit_admin.create_named_context(
      p_context_name => p_context_name,
      p_log_level => p_log_level,
      p_trace_level => p_trace_level,
      p_trace_timing => p_trace_timing = pit_util.C_TRUE,
      p_module_list => p_module_list,
      p_comment => p_comment);
    
    pit.leave_mandatory;
  end merge_named_context;
    
    
  procedure delete_named_context(
    p_context_name in pit_util.ora_name_type)
  as
  begin
    pit.enter_mandatory(
      p_action => 'delete_named_context',
      p_module => C_PKG,
      p_params => msg_params(msg_param('p_context_name', p_context_name)));
      
    pit_admin.remove_named_context(p_context_name);
    
    pit.leave_mandatory;
  end delete_named_context;
  
  
  /* TOGGLES */
  procedure merge_context_toggle(
    p_toggle_name in pit_util.ora_name_type,
    p_module_list in pit_util.max_sql_char,
    p_context_name in pit_util.ora_name_type,
    p_comment in pit_util.max_sql_char)
  as
  begin
    pit.enter_mandatory(
      p_action => 'merge_context_toggle',
      p_module => C_PKG,
      p_params => msg_params(
                    msg_param('p_toggle_name', p_toggle_name),
                    msg_param('p_module_list', p_module_list),
                    msg_param('p_context_name', p_context_name),
                    msg_param('p_comment', p_comment)));
      
    pit_admin.create_context_toggle(
      p_toggle_name => p_toggle_name,
      p_module_list => p_module_list,
      p_context_name => p_context_name,
      p_comment => p_comment);
    
    pit.leave_mandatory;
  end merge_context_toggle;
  
  
  procedure delete_context_toggle(
    p_toggle_name in pit_util.ora_name_type)
  as
  begin
    pit.enter_mandatory(
      p_action => 'delete_context_toggle',
      p_module => C_PKG,
      p_params => msg_params(msg_param('p_toggle_name', p_toggle_name)));
    
    pit_admin.remove_context_toggle(p_toggle_name);
    
    pit.leave_mandatory;
  end delete_context_toggle;


  /* PARAMETER */
  function validate_is_integer(
    p_value in varchar2)
    return varchar2
  as
    l_number number(38,0);
  begin
    pit.enter_mandatory(
      p_action => 'validate_is_integer',
      p_module => C_PKG,
      p_params => msg_params(msg_param('p_value', p_value)));
      
    if regexp_instr(p_value, '(,\.)', 1) > 0 then
      return pit.get_message_text(msg.PIT_INVALID_INTEGER, msg_args(p_value));
    end if;
    l_number := to_number(p_value, 'fm999999999999999990');
    
    pit.leave_mandatory;
    return null;
  exception
    when others then
      return pit.get_message_text(msg.PIT_INVALID_INTEGER, msg_args(p_value));
  end validate_is_integer;
  
  
  procedure export_parameter_group(
    p_parameter_groups in pit_util.max_sql_char default null)
  as
    l_pgr_list wwv_flow_global.vc_arr2;
    l_zip_file blob;
    l_param_group_file blob;
    
    C_ZIP_FILE_NAME constant varchar2(50) := 'Parameter_ALL.zip';
  begin
    pit.enter_mandatory(
      p_params=> msg_params(msg_param('p_parameter_groups', p_parameter_groups)));
      
    l_pgr_list := apex_util.string_to_table(p_parameter_groups);
    
    if l_pgr_list.count > 0 then
      for i in l_pgr_list.first .. l_pgr_list.last loop
        l_param_group_file := clob_to_blob(param_admin.export_parameter_group(l_pgr_list(i)));
        apex_zip.add_file(
          p_zipped_blob => l_zip_file,
          p_file_name => 'ParameterGroup_' || l_pgr_list(i) || '.sql',
          p_content => l_param_group_file);
        pit.verbose(msg.PAR_PGR_EXPORTED, msg_args(l_pgr_list(i)));
      end loop;
    else
      l_param_group_file := clob_to_blob(param_admin.export_parameter_group(null));
      apex_zip.add_file(
        p_zipped_blob => l_zip_file,
        p_file_name => 'ParameterGroup_ALL.sql',
        p_content => l_param_group_file);
      pit.verbose(msg.PAR_PGR_EXPORTED, msg_args('ALL'));
    end if;
    apex_zip.finish(l_zip_file);
    
    download_blob(l_zip_file, C_ZIP_FILE_NAME);
    
    pit.leave_mandatory;
  end export_parameter_group;
  
end pit_ui_pkg;
/