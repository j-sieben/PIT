create or replace package body pit_admin
as
  /* Packagevariablen */
  c_xliff_ns constant varchar2(100) := 'urn:oasis:names:tc:xliff:document:1.2';
  
  type predefined_error_rec is record(
    source_type varchar2(30),
    owner varchar2(30),
    package_name varchar2(30),
    error_name varchar2(30));
  type predefined_error_t is table of predefined_error_rec index by binary_integer;
  
  g_predefined_errors predefined_error_t;
  g_default_language varchar2(30);

  /* HELPER */
  /* Initialization procedure
   * %usage Called internally. It has the following functionality:
   *        <ul><li>Read all predefined oracle errors from the oracle packages</li>
   *        <li>Read default language</li></ul>
   */
  procedure initialize
  as
    cursor predefined_errors_cur is
        with errors as(
             select type source_type, owner, name package_name,
                    upper(substr(text, instr(text, '(') + 1, instr(text, ')') - instr(text, '(') - 1)) init
               from all_source a
              where (owner in ('SYS') or owner like 'APEX%')
                and upper(text) like '%PRAGMA EXCEPTION_INIT%')
      select source_type, owner, package_name,
             -- don't convert to numbers here as it's possible that conversion errors occur
             trim(replace(substr(init, instr(init, ',') + 1), '''', '')) error_number,
             trim(substr(init, 1, instr(init, ',') - 1)) error_name
        from errors;
    l_predefined_error predefined_error_rec;
    l_error_number number;
  begin
    -- scan all_source view for predefined Oracle errors
    for err in predefined_errors_cur loop
      begin
        l_error_number := to_number(err.error_number, '99999');
        l_predefined_error.source_type := err.source_type;
        l_predefined_error.owner := err.owner;
        l_predefined_error.package_name := err.package_name;
        l_predefined_error.error_name := err.error_name;
        g_predefined_errors(err.error_number) := l_predefined_error;
      exception
        when others then
          dbms_output.put_line('Error when trying to convert error number ' || err.error_number);
      end;
    end loop;
    
    -- Read default language
    $IF dbms_db_version.ver_le_11 $THEN
    select name
      into g_default_language
      from (select name, rank() over (order by default_order) rang
              from message_language
             where default_order > 0)
     where rang = 1;
    $ELSE
    select name 
      into g_default_language
      from message_language
     where default_order > 0
     order by default_order
     fetch first 1 rows only;
    $END
  end initialize;
  

  /* INTERFACE */
  
  
  function get_message_text(
    p_message_name     in varchar2,
    p_message_language in varchar2 := null)
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
    p_message_name in varchar2,
    p_message_text in clob,
    p_severity in number,
    p_message_language in varchar2 default null,
    p_error_number in number default null)
  as
    l_message_name message.message_name%type;
  begin
    if p_severity in (20,30) then
      check_error(p_message_name, p_error_number);
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
      select message_name
        into l_message_name
        from message
       where custom_error_number = p_error_number
         and rownum = 1;
      rollback;
      raise_application_error(-20000, 'This Oracle error number is already assigned to message ' || l_message_name);
    when others then
      rollback;
      raise;
  end merge_message;


  procedure translate_message(
    p_message_name in varchar2,
    p_message_text in clob,
    p_message_language in varchar2)
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
      raise_application_error(-20000, 'Message ' || p_message_name || ' does not exist.');
  end translate_message;


  procedure check_error(
    p_message_name in varchar2,
    p_error_number in number)
  as
    l_predefined_error predefined_error_rec;
    l_message varchar2(2000);
    l_message_length binary_integer;
  begin
    l_message_length := length(p_message_name);
    l_message :=
      'Message name ' || p_message_name ||
			' must not exceed 26 chars in length but is ' || l_message_length;
    if l_message_length > 26 then
       raise_application_error(-20000, l_message);
    end if;
    if g_predefined_errors.exists(p_error_number) then
      l_predefined_error := g_predefined_errors(p_error_number);
      l_message :=
        'Error number ' || p_error_number ||
        ' is a predefined Oracle error named ' || l_predefined_error.error_name ||
        ' in ' || l_predefined_error.owner || '.' || l_predefined_error.package_name ||
        '. Please don''t overwrite Oracle predefined errors.';
      raise_application_error(-20000, l_message);
    end if;
  end check_error;


  function get_translation_xml(
    p_target_language in varchar2)
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


  procedure clob_append(
    p_clob in out nocopy clob,
    p_chunk in clob)
  as
    l_length number;
  begin
    l_length := dbms_lob.getlength(p_chunk);
    if l_length > 0 then
      if p_clob is null then
        dbms_lob.createtemporary(p_clob, false, dbms_lob.call);
      end if;
      dbms_lob.writeappend(p_clob, l_length, p_chunk);
    end if;
  end clob_append;
  

  procedure create_message_package (
    p_directory varchar2 default null)
  as
    c_package_name  constant varchar2(30) := 'msg';
    c_exception_postfix constant varchar2(4) := '_ERR';
    c_r constant varchar2(2) := chr(10);
    
    l_sql_text clob := 'create or replace package ' || c_package_name || ' as' || c_r;
    l_constant_template varchar2(200) := 
      '  #CONSTANT# constant varchar2(30) := ''#CONSTANT#'';' || c_r;
    l_exception_template varchar2(200) := 
      '  #CONSTANT#' || c_exception_postfix || ' exception;' || c_r;
    l_pragma_template varchar2(200) := 
      '  pragma exception_init(#CONSTANT#' || c_exception_postfix || ', #ERROR#);' || c_r;
    l_end_clause varchar2(20) := 'end ' || c_package_name || ';';
    
    l_constants clob := c_r || '  -- CONSTANTS:' || c_r;
    l_exceptions clob := c_r || '  -- EXCEPTIONS:' || c_r;
    l_pragmas clob := c_r || '  -- EXCEPTION INIT:' || c_r;
    
    cursor message_cur is
      select replace(l_constant_template, '#CONSTANT#', message_name) constant_chunk,
             case when custom_error_number is not null then
               replace (l_exception_template, '#CONSTANT#', message_name)
             else null end exception_chunk,
             case when custom_error_number is not null then
               replace(replace (l_pragma_template, '#CONSTANT#', message_name), '#ERROR#', custom_error_number)
             else null end pragma_chunk
        from (select message_name, 
                     case custom_error_number
                     -- Create unique custom error numbers
                     when -20000 then -21000 + error_counter
                     else custom_error_number end custom_error_number
                from (select message_name,
                             custom_error_number,
                             -- count -20000-errors to create unique error number
                             row_number() over (partition by custom_error_number order by message_name) error_counter
                        from message m
                       where message_language = g_default_language))
       order by message_name;
  begin
    for msg in message_cur loop
      clob_append(l_constants, msg.constant_chunk);
      clob_append(l_exceptions, msg.exception_chunk);
      clob_append(l_pragmas, msg.pragma_chunk);
    end loop;
    clob_append(l_sql_text, l_constants);
    clob_append(l_sql_text, l_exceptions);
    clob_append(l_sql_text, l_pragmas);
    clob_append(l_sql_text, l_end_clause);
    
    if p_directory is not null then
      dbms_xslprocessor.clob2file(l_sql_text, p_directory, c_package_name || '.pkg');
    else
      execute immediate l_sql_text;
    end if;
  end create_message_package;

begin
  initialize;
end pit_admin;
/