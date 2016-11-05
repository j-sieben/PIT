create or replace package body pit_ui_pkg 
as

  c_pkg constant varchar2(30 byte) := $$PLSQL_UNIT;
  c_true constant char(1 byte) := 'Y';
  c_false constant char(1 byte) := 'N';
  
  /* Hilfsfunktionen */
  -- TODO: Auslagern in UTIL-Package
  function clob_to_blob(
    p_clob in clob)
    return blob
  as
    l_blob blob;
    l_lang_context  integer := DBMS_LOB.DEFAULT_LANG_CTX;
    l_warning       integer := DBMS_LOB.WARN_INCONVERTIBLE_CHAR;
    l_dest_offset   integer := 1;
    l_source_offset integer := 1;
  begin
    pit.enter_detailed('clob_to_blob', c_pkg);
    
    dbms_lob.createtemporary(l_blob, true, dbms_lob.call);
      dbms_lob.converttoblob (
        dest_lob => l_blob,
        src_clob => p_clob,
        amount => DBMS_LOB.LOBMAXSIZE,
        dest_offset => l_dest_offset,
        src_offset => l_source_offset,
        blob_csid => DBMS_LOB.DEFAULT_CSID,
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
      p_module => c_pkg,
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
      p_module => c_pkg,
      p_params => msg_params(msg_param('p_file_name', p_file_name)));
    
    l_blob := clob_to_blob(p_clob);
    download_blob(l_blob, p_file_name);
    
    pit.leave_optional;
  end download_clob;
  

  procedure merge_message(
    p_pms_name in varchar2,
    p_pms_pml_name in varchar2,
    p_pms_text in clob,
    p_pms_pse_id in number,
    p_pms_custom_error number) as
  begin
    pit.enter_mandatory(
      p_action => 'merge_message',
      p_module => c_pkg,
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
    p_pms_name in varchar2,
    p_pms_pml_name in varchar2) as
  begin
    pit.enter_mandatory(
      p_action => 'delete_message',
      p_module => c_pkg,
      p_params => msg_params(
                    msg_param('p_pms_name', p_pms_name),
                    msg_param('p_pms_pml_name', p_pms_pml_name)));
                    
    pit_admin.remove_message(
      p_pms_name => p_pms_name,
      p_pms_pml_name => p_pms_pml_name);
    
    pit.leave_mandatory;
  end delete_message;
  
    
  procedure export_messages(
    p_message_pattern in varchar2)
  as
    l_messages clob;
  begin
    pit.enter_mandatory(
      p_action => 'export_messages',
      p_module => c_pkg,
      p_params => msg_params(msg_param('p_message_pattern', p_message_pattern)));
      
    l_messages := pit_admin.get_messages(
                    p_message_pattern => upper(p_message_pattern));
                 
    download_clob(
      p_clob => l_messages,
      p_file_name => 'Messages_' || upper(p_message_pattern) || '.sql');
    
    pit.leave_mandatory;
  end export_messages;
  
  
  procedure translate_messages(
    p_target_language in varchar2,
    p_message_pattern in varchar2)
  as
    l_xliff xmltype;
  begin
    pit.enter_mandatory(
      p_action => 'translate_messages',
      p_module => c_pkg,
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


  procedure merge_named_context(
    p_context_name in varchar2,
    p_log_level in number,
    p_trace_level in number,
    p_trace_timing in varchar2,
    p_module_list in varchar2,
    p_comment in varchar2)
  as
  begin
    pit.enter_mandatory(
      p_action => 'merge_named_context',
      p_module => c_pkg,
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
      p_trace_timing => p_trace_timing = c_true,
      p_module_list => p_module_list,
      p_comment => p_comment);
    
    pit.leave_mandatory;
  end merge_named_context;
    
    
  procedure delete_named_context(
    p_context_name in varchar2)
  as
  begin
    pit.enter_mandatory(
      p_action => 'delete_named_context',
      p_module => c_pkg,
      p_params => msg_params(msg_param('p_context_name', p_context_name)));
      
    pit_admin.remove_named_context(p_context_name);
    
    pit.leave_mandatory;
  end delete_named_context;
  
  
  procedure merge_context_toggle(
    p_toggle_name in varchar2,
    p_module_list in varchar2,
    p_context_name in varchar2,
    p_comment in varchar2)
  as
  begin
    pit.enter_mandatory(
      p_action => 'merge_context_toggle',
      p_module => c_pkg,
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
    p_toggle_name in varchar2)
  as
  begin
    pit.enter_mandatory(
      p_action => 'delete_context_toggle',
      p_module => c_pkg,
      p_params => msg_params(msg_param('p_toggle_name', p_toggle_name)));
    
    pit_admin.remove_context_toggle(p_toggle_name);
    
    pit.leave_mandatory;
  end delete_context_toggle;


  function validate_is_integer(
    p_value in varchar2)
    return varchar2
  as
    l_number number(38,0);
  begin
    pit.enter_mandatory(
      p_action => 'validate_is_integer',
      p_module => c_pkg,
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
    p_parameter_groups in varchar2)
  as
    l_pgr_list wwv_flow_global.vc_arr2;
    l_zip_file blob;
    l_param_group_file blob;
    
    c_zip_file_name constant varchar2(50) := 'Parameter_ALL.zip';
  begin
    pit.enter_mandatory(
      p_action => 'export_parameter_group', 
      p_module => c_pkg,
      p_params=> msg_params(msg_param('p_parameter_groups', p_parameter_groups)));
      
    l_pgr_list := apex_util.string_to_table(p_parameter_groups);
    
    for i in l_pgr_list.first .. l_pgr_list.last loop
      l_param_group_file := clob_to_blob(param_admin.export_parameter_group(l_pgr_list(i)));
      apex_zip.add_file(
        p_zipped_blob => l_zip_file,
        p_file_name => 'ParameterGroup_' || l_pgr_list(i) || '.sql',
        p_content => l_param_group_file);
      pit.verbose(msg.PAR_PGR_EXPORTED, msg_args(l_pgr_list(i)));
    end loop;
    apex_zip.finish(l_zip_file);
    
    download_blob(l_zip_file, c_zip_file_name);
    
    pit.leave_mandatory;
  end export_parameter_group;
  
end pit_ui_pkg;
/