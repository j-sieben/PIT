create or replace package body pit_admin
as

  /************************* PACKAGE VARIABLES ********************************/
  g_default_language varchar2(30);
  
  c_parameter_group constant varchar2(5) := 'PIT';
  c_context_group constant varchar2(30) := 'CONTEXT';
  c_context_prefix constant varchar2(30) := c_context_group || '_';
  c_toggle_group constant varchar2(30) := 'TOGGLE';
  c_toggle_prefix constant varchar2(30) := c_toggle_group || '_';
  c_true constant char(1 byte) := 'Y';
  c_false constant char(1 byte) := 'N';
  c_xliff_ns constant varchar2(100) := 'urn:oasis:names:tc:xliff:document:1.2';
  c_del char(1 byte) := '|';
  
  
  -- ERROR messages
  c_error_already_assigned constant varchar2(200) := 'This Oracle error number is already assigned to message #ERRNO#';
  c_message_does_not_exist constant varchar2(200) := 'Message #MESSAGE# does not exist.';
  
  /********************** GENERIC HELPER FUNCTIONS ****************************/
  /* Initialization procedure
   * %usage Called internally. It has the following functionality:
   *        <ul><li>Read all predefined oracle errors from the oracle packages</li>
   *        <li>Read default language</li></ul>
   */
  procedure initialize
  as
  begin    
    -- Read default language
    $IF dbms_db_version.ver_le_11 $THEN
    select name default_language
      into g_default_language
      from (select name, rank() over (order by default_order) rang
              from message_language
             where default_order > 0)
     where rang = 1;
    $ELSE
    select name default_language
      into g_default_language
      from message_language
     where default_order > 0
     order by default_order
     fetch first 1 rows only;
    $END
  end initialize;
  

  /****************************** INTERFACE ***********************************/
  function get_message_text(
    p_message_name in message.message_name%type,
    p_message_language in message.message_language%type := null)
    return varchar2
  as
    l_message_text message.message_text%type;
  begin
    select message_text
      into l_message_text
      from (select message_text, severity,
                   rank() over (order by l.default_order desc) ranking
              from message m
              join v_message_language l on m.message_language = l.name
             where m.message_name = coalesce(p_message_name, g_default_language))
      where ranking = 1;
    return l_message_text;
  exception
    when no_data_found then
      return null;
  end get_message_text;


  procedure merge_message(
    p_message_name in message.message_name%type,
    p_message_text in message.message_text%type,
    p_severity in message.severity%type,
    p_message_language in message.message_language%type default null,
    p_error_number in message.custom_error_number%type default null)
  as
    l_message_name message.message_name%type;
  begin
    if p_severity in (20,30) then
      pit_util.check_error(p_message_name, p_error_number);
    end if;
    
    merge into message m
    using (select p_message_name message_name,
                  coalesce(p_message_language, g_default_language) message_language,
                  p_message_text message_text,
                  p_severity severity,
                  p_error_number custom_error_number
             from dual) v
       on (m.message_name = v.message_name and m.message_language = v.message_language)
     when matched then update set
          m.message_text = v.message_text,
          m.severity = v.severity,
          m.custom_error_number = v.custom_error_number
     when not matched then insert
            (message_name, message_language, message_text, severity, custom_error_number)
          values
            (v.message_name, v.message_language, v.message_text, v.severity, v.custom_error_number);
    commit;
    
  exception
    when dup_val_on_index then
      -- DUP_VAL_ON_INDEX may occur if a user tries to assign a custom error number twice
      select message_name
        into l_message_name
        from message
       where custom_error_number = p_error_number
         and rownum = 1;
      rollback;
      raise_application_error(-20000, replace(c_error_already_assigned, '#ERRNO#', l_message_name));
    when others then
      rollback;
      raise;
  end merge_message;


  procedure translate_message(
    p_message_name in message.message_name%type,
    p_message_text in message.message_text%type,
    p_message_language in message.message_language%type)
  as
    l_severity message.severity%type;
    l_error_number message.custom_error_number%type;
  begin
    select severity, custom_error_number
      into l_severity, l_error_number
      from message
     where message_name = p_message_name
       and message_language = g_default_language;

    merge_message(
      p_message_name => p_message_name,
      p_message_text => p_message_text,
      p_severity => l_severity,
      p_message_language => p_message_language,
      p_error_number => l_error_number);
  exception
    when no_data_found then
      raise_application_error(-20000, replace(c_message_does_not_exist, '#MESSAGE#', p_message_name));
  end translate_message;
  
  
  procedure remove_message(
    p_message_name in message.message_name%type)
  as
  begin
    delete from message
     where message_name = upper(p_message_name);
  end remove_message;
    
    
  procedure remove_all_messages
  as
  begin
    delete from message;
  end remove_all_messages;


  function get_translation_xml(
    p_target_language in message.message_language%type)
    return xmltype
  as
    l_xliff xmltype;
    l_source_iso_code varchar2(10);
    l_source_language varchar2(30);
    l_target_iso_code varchar2(10);
  begin
    select replace(utl_i18n.map_locale_to_iso(g_default_language, null), '_', '-') source_iso_language,
           g_default_language source_language,
           replace(utl_i18n.map_locale_to_iso(p_target_language, null), '_', '-') target_iso_language
      into l_source_iso_code, l_source_language, l_target_iso_code
      from dual;

    select xmlelement("body",
             xmlattributes(c_xliff_ns "xmlns"),
             xmlagg(
               xmlelement("trans-unit",
                 xmlattributes(t.message_name "id"),
                 xmlelement("source",
                   xmlattributes(t.source_language "xml:lang"),
                   t.source_text
                 ),
                 xmlelement("target",
                   xmlattributes(t.target_language "xml:lang"),
                   t.target_text
                 )
               )
             )
           ) xml_result
      into l_xliff
      from (select message_name,
                   l_source_iso_code source_language,
                   l_target_iso_code target_language,
                   max(
                     decode(
                       message_language,
                       l_source_language, to_char(message_text))) source_text,
                   max(
                     decode(
                       message_language,
                       p_target_language, to_char(message_text))) target_text
              from message m
             group by message_name) t;

    select updatexml(
             xml_value,
             '/xliff/file/body', l_xliff,
             '/xliff/file/@source-language', l_source_iso_code,
             '/xliff/file/@target-language', l_target_iso_code,
             'xmlns="' || c_xliff_ns || '"'
             )
      into l_xliff
      from parameter
     where parameter_id = 'XLIFF_SKELETON';

    return l_xliff;
  end get_translation_xml;


  procedure translate_messages(
    p_translation_xml in xmltype)
  as
  begin
    merge into message m
    using (select m.message_name as message_name,
                  utl_i18n.map_language_from_iso(d.message_language) message_language,
                  d.translation as message_text,
                  m.severity,
                  m.custom_error_number
             from xmltable(
                    xmlnamespaces(default 'urn:oasis:names:tc:xliff:document:1.2'),
                    '/xliff/file/body/trans-unit'
                    passing p_translation_xml
                    columns
                    message_name varchar2(30 char) path '/trans-unit/@id',
                    message_language varchar2(30 char) path '/trans-unit/target/@xml:lang',
                    translation clob path '/trans-unit/target') d
             join message m
               on m.message_name = d.message_name
              and m.message_language =
                    utl_i18n.map_language_from_iso(d.message_language)) v
    on (m.message_name = v.message_name and m.message_language = v.message_language)
    when matched then update set
         m.message_text = v.message_text
    when not matched then insert
         (message_name, message_language, message_text,
          severity, custom_error_number)
         values
         (v.message_name, v.message_language, v.message_text,
          v.severity, v.custom_error_number);
    commit;
  exception
    when others then
      rollback;
      raise;
  end translate_messages;
  
  
  procedure remove_translation(
    p_language in message.message_language%type)
  as
  begin
    delete from message
     where message_language = upper(p_language);
  end remove_translation;
  

  procedure create_message_package (
    p_directory varchar2 default null)
  as
    c_package_name  constant varchar2(30) := 'msg';
    c_exception_postfix constant varchar2(4) := '_ERR';
    c_r constant varchar2(2) := chr(10);
    
    l_sql_text clob := 'create or replace package ' || c_package_name || ' as' || c_r;
    l_constant_template varchar2(200) := 
      q'~  #CONSTANT# constant varchar2(30) := '#CONSTANT#';~' || c_r;
    l_exception_template varchar2(200) := 
      '  #CONSTANT#' || c_exception_postfix || ' exception;' || c_r;
    l_pragma_template varchar2(200) := 
      '  pragma exception_init(#CONSTANT#' || c_exception_postfix || ', #ERROR#);' || c_r;
    l_end_clause varchar2(20) := 'end ' || c_package_name || ';';
    
    l_constants clob := c_r || '  -- CONSTANTS:' || c_r;
    l_exceptions clob := c_r || '  -- EXCEPTIONS:' || c_r;
    l_pragmas clob := c_r || '  -- EXCEPTION INIT:' || c_r;
    
    cursor message_cur is
        with messages as(
             select message_name,
                    coalesce(active_error_number, custom_error_number) custom_error_number
               from message m
              where message_language = g_default_language)
      select replace(l_constant_template, '#CONSTANT#', message_name) constant_chunk,
             case when custom_error_number is not null then
               replace (l_exception_template, '#CONSTANT#', message_name)
             else null end exception_chunk,
             case when custom_error_number is not null then
               replace(replace(l_pragma_template, '#CONSTANT#', message_name), '#ERROR#', custom_error_number)
             else null end pragma_chunk
        from messages
       order by message_name;
  begin
    -- persist active error numbers for -20000 errors in message table
    merge into message m
    using (select message_name, message_language, -21000 + dense_rank() over (order by message_name) active_error_number
             from message
            where severity <= 30
              and custom_error_number = -20000) v
       on (m.message_name = v.message_name
       and m.message_language = v.message_language)
     when matched then update set
          active_error_number = v.active_error_number;    
    commit;
    
    -- create package code
    for msg in message_cur loop
      pit_util.clob_append(l_constants, msg.constant_chunk);
      pit_util.clob_append(l_exceptions, msg.exception_chunk);
      pit_util.clob_append(l_pragmas, msg.pragma_chunk);
    end loop;
    pit_util.clob_append(l_sql_text, l_constants);
    pit_util.clob_append(l_sql_text, l_exceptions);
    pit_util.clob_append(l_sql_text, l_pragmas);
    pit_util.clob_append(l_sql_text, l_end_clause);
    
    if p_directory is not null then
      dbms_xslprocessor.clob2file(l_sql_text, p_directory, c_package_name || '.pkg');
    else
      execute immediate l_sql_text;
    end if;
  end create_message_package;
  
  
  procedure create_named_context(
    p_context_name in varchar2,
    p_log_level in number,
    p_trace_level in number,
    p_trace_timing in boolean,
    p_module_list in varchar2,
    p_comment in varchar2 default null)
  as
    l_trace_timing char(1 byte);
    l_settings varchar2(4000);
  begin
    l_trace_timing := case when p_trace_timing then c_true else c_false end;
    l_settings := pit_util.concatenate(char_table(p_log_level, p_trace_level, l_trace_timing, p_module_list), c_del);
    create_named_context(p_context_name, l_settings, p_comment);
  end create_named_context;
  
  
  procedure create_named_context(
    p_context_name in varchar2,
    p_settings in varchar2,
    p_comment in varchar2 default null)
  as
    c_standard_comment constant varchar2(200) := ' [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]';
  begin
    
    pit_util.check_context_settings(p_context_name, p_settings);
    
    -- Create parameter
    param_admin.edit_parameter(
      p_parameter_id => pit_util.harmonize_name(c_context_prefix, p_context_name),  
      p_parameter_group_id => c_parameter_group,  
      p_parameter_description => p_comment || c_standard_comment,
      p_string_value => upper(p_settings));
  end create_named_context;
  
  
  procedure remove_named_context(
    p_context_name in varchar2)
  as
  begin
    param_admin.delete_parameter(
      p_parameter_id => c_context_prefix || replace(upper(p_context_name), c_context_prefix),
      p_parameter_group_id => c_parameter_group);
  end remove_named_context;
    
    
  procedure create_context_toggle(
    p_toggle_name in varchar2,
    p_module_list in varchar2,
    p_context_name in varchar2,
    p_comment in varchar2 default null)
  as
    l_toggle_name varchar(30);
    l_context_name varchar2(30);
  begin
  
    pit_util.check_toggle_settings(p_toggle_name, p_module_list, p_context_name);
    
    -- Create parameter
    l_toggle_name := pit_util.harmonize_name(c_toggle_prefix, p_toggle_name);
    l_context_name := replace(p_context_name, c_context_prefix);
    param_admin.edit_parameter(
      p_parameter_id => l_toggle_name,  
      p_parameter_group_id => c_parameter_group,  
      p_parameter_description => p_comment,
      p_string_value => upper(p_module_list || c_del || l_context_name));
  end create_context_toggle;
    
    
  procedure remove_context_toggle(
    p_toggle_name in varchar2)
  as
  begin
    param_admin.delete_parameter(
      p_parameter_id => c_toggle_prefix || replace(upper(p_toggle_name), c_toggle_prefix),
      p_parameter_group_id => c_parameter_group);
  end remove_context_toggle;
  
  
  procedure write_message_file(
    p_directory in varchar2 default 'DATA_DIR')
  as
    cursor message_cur is
      select m.*, rank() over (partition by message_name order by default_order) rang
        from message m
        join message_language ml
          on m.message_language = ml.name
       where ml.default_order > 0
       order by m.message_name, ml.default_order;
    l_script clob;
    l_chunk varchar2(32767);
    c_file_name constant varchar2(30) := 'messages.sql';
    c_start constant varchar2(200) := q'~begin
~';
    c_end constant varchar2(200) := q'~
  commit;
  pit_admin.create_message_package;
end;
/~';
    c_merge_template constant varchar2(200) := q'~
  pit_admin.merge_message(
    p_message_name => '#NAME#',
    p_message_text => q'ø#TEXT#ø',
    p_severity => #SEVERITY#,
    p_message_language => '#LANGUAGE#',
    p_error_number => #ERRNO#
  );
~';
    c_translate_template constant varchar2(200) := q'~
  pit_admin.translate_message(
    p_message_name => '#NAME#',
    p_message_text => q'ø#TEXT#ø',
    p_message_language => '#LANGUAGE#'
  );
~';
  begin
    dbms_lob.createtemporary(l_script, false, dbms_lob.call);
    dbms_lob.append(l_script, c_start);
    for msg in message_cur loop
      case msg.rang
      when 1 then
        if l_chunk is not null then
          dbms_lob.append(l_script, l_chunk);
        end if;
        l_chunk := pit_util.bulk_replace(c_merge_template, char_table(
                     '#NAME#', msg.message_name,
                     '#TEXT#', msg.message_text,
                     '#SEVERITY#', to_char(msg.severity),
                     '#LANGUAGE#', msg.message_language,
                     '#ERRNO#', coalesce(to_char(msg.custom_error_number), 'null')));
      else
        l_chunk := l_chunk
                || pit_util.bulk_replace(c_translate_template, char_table(
                     '#NAME#', msg.message_name,
                     '#TEXT#', msg.message_text,
                     '#LANGUAGE#', msg.message_language));
      end case;
    end loop;
    dbms_lob.append(l_script, l_chunk);
    dbms_lob.append(l_script, c_end);
    dbms_xslprocessor.clob2file(l_script, p_directory, c_file_name);
  end write_message_file;
  

begin
  initialize;
end pit_admin;
/