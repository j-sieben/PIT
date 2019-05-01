create or replace package body pit_admin
as

  /************************* TYPE DEFINITIONS *********************************/    
  type predefined_error_rec is record(
    source_type pit_util.ora_name_type,
    owner pit_util.ora_name_type,
    package_name pit_util.ora_name_type,
    error_name pit_util.ora_name_type);
  type predefined_error_t is table of predefined_error_rec index by binary_integer;
  
  
  /************************* PACKAGE VARIABLES ********************************/
  g_predefined_errors predefined_error_t;
  g_default_language pit_util.ora_name_type;

  c_pkg constant pit_util.ora_name_type := $$PLSQL_UNIT;
  c_parameter_group constant varchar2(5) := 'PIT';
  c_context_group constant varchar2(30) := 'CONTEXT';
  c_context_prefix constant varchar2(30) := c_context_group || '_';
  c_toggle_group constant varchar2(30) := 'TOGGLE';
  c_toggle_prefix constant varchar2(30) := c_toggle_group || '_';
  c_true constant pit_util.flag_type := pit_util.c_true;
  c_false constant pit_util.flag_type := pit_util.c_false;
  c_xliff_ns constant varchar2(100) := 'urn:oasis:names:tc:xliff:document:1.2';
  c_del char(1 byte) := '|';
  c_min_error constant number := -20999;
  c_max_error constant number := -20000;
  c_default_language constant number := 10;


  -- ERROR messages
  c_error_already_assigned constant varchar2(200) := 'This Oracle error number is already assigned to message #ERRNO#';
  c_message_does_not_exist constant varchar2(200) := 'Message #MESSAGE# does not exist.';
  c_error_msg_name_too_long constant varchar2(200) := 'Message name exceeds maximum length of ' || to_char(pit_util.c_max_length - 4) || ' chars for error messages';
  c_msg_name_too_long constant varchar2(200) := 'Message name exceeds maximum length of ' || to_char(pit_util.c_max_length) || ' chars';


  /********************** GENERIC HELPER FUNCTIONS ****************************/

  procedure initialize_error_list
  as
    cursor predefined_errors_cur is
        with errors as(
             select type source_type, owner, name package_name,
                    upper(substr(text, instr(text, '(') + 1, instr(text, ')') - instr(text, '(') - 1)) init
               from all_source a
              where (owner in ('SYS') or owner like 'APEX%')
                and upper(text) like '%PRAGMA EXCEPTION_INIT%'
                and name not in ('PIT_ADMIN', 'PIT_UTIL'))
      select source_type, owner, package_name,
             -- don't convert to numbers here as it's possible that conversion errors occur
             to_number(trim(replace(substr(init, instr(init, ',') + 1), '''', '')), '99999') error_number,
             trim(substr(init, 1, instr(init, ',') - 1)) error_name
        from errors
       where trim(substr(init, 1, instr(init, ',') - 1)) is not null;
    l_predefined_error predefined_error_rec;
  begin
    -- scan all_source view for predefined Oracle errors
    for err in predefined_errors_cur loop
      begin
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
  end initialize_error_list;


  /* Helper to check whether a predefined Oracle error shall be redefined
   * %param p_pms_name Name of the message to check the error for
   * %param p_pms_custom_error Error number for which a PIT message shall be created
   * %usage Is called whenever a new message is inserted into table MESSAGE with an Oracle
   *        error number. The function checks whether the Oracle error number is already
   *        a defined error, such as -1 and DUP_VAL_ON_INDEX.
   *        If so, the procedure throws an error.
   *        Limitation: This procedure can only see Exceptions that are defined in 
   *        packages from SYSTEM or SYS and only exceptions from non wrapped sources.
   */
  procedure check_error(
    p_pms_name in pit_message.pms_name%type,
    p_pms_custom_error in pit_message.pms_custom_error%type)
  as
    l_predefined_error predefined_error_rec;
    l_message varchar2(2000);
    l_message_length binary_integer;
    l_error_regexp varchar2(1000);
    c_error_regexp constant varchar2(100) := q'~^(#NAME#|#NAME#_ERR)$~';
    c_msg_too_long constant varchar2(200) := 
      q'~Message "#MESSAGE#" must not exceed 26 chars but is #LENGTH#.~';
    c_predefined_error constant varchar2(200) :=
      q'~Error number #ERROR# is a predefined Oracle error named #NAME# in #OWNER#.#PKG#. Please don't overwrite Oracle predefined errors.~';
  begin
    if g_predefined_errors is null then
      initialize_error_list;
    end if;
    
    l_message_length := length(p_pms_name);
    if l_message_length > pit_util.c_max_length - 4 then
      l_message := pit_util.bulk_replace(c_msg_too_long, char_table(
                     '#MESSAGE#', p_pms_name,
                     '#LENGTH#', l_message_length));
       raise_application_error(-20000, l_message);
    end if;
    if g_predefined_errors.exists(p_pms_custom_error) then
      l_error_regexp := replace(c_error_regexp, '#NAME#', p_pms_name);
      if not regexp_like(g_predefined_errors(p_pms_custom_error).error_name, l_error_regexp) then
        l_predefined_error := g_predefined_errors(p_pms_custom_error);
        l_message := pit_util.bulk_replace(c_predefined_error, char_table(
                       '#ERROR#', p_pms_custom_error,
                       '#NAME#', l_predefined_error.error_name,
                       '#OWNER#', l_predefined_error.owner,
                       '#PKG#', l_predefined_error.package_name));
        raise_application_error(-20000, l_message);
      end if;
    end if;
  end check_error;
  
  
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
    select pml_name default_language
      into g_default_language
      from (select pml_name, rank() over (order by pml_default_order) rang
              from pit_message_language
             where pml_default_order > 0)
     where rang = 1;
    $ELSE
    select pml_name default_language
      into g_default_language
      from pit_message_language
     where pml_default_order > 0
     order by pml_default_order
     fetch first 1 rows only;
    $END
  end initialize;


  /****************************** INTERFACE ***********************************/
  procedure set_default_language(
    p_pml_list in varchar2,
    p_delimiter in varchar2 default ':')
  as
    l_pml_list args;
    l_pml_default_order pit_message_language.pml_default_order%type;
  begin
    
    update pit_message_language
       set pml_default_order = 0
     where pml_default_order != c_default_language;

    if p_pml_list is not null then
      l_pml_list := pit_util.string_to_table(p_pml_list, p_delimiter);
      l_pml_default_order := (l_pml_list.count + 1) * 10;
      for i in l_pml_list.first .. l_pml_list.last loop
        update pit_message_language
           set pml_default_order = l_pml_default_order
         where pml_name = l_pml_list(i);
        l_pml_default_order := l_pml_default_order - 10;
      end loop;
    end if;
    
  end set_default_language;
  
  
  function get_message_text(
    p_pms_name in pit_message.pms_name%type,
    p_pms_pml_name in pit_message_language.pml_name%type := null)
    return varchar2
  as
    l_pms_text pit_message.pms_text%type;
  begin
    select pms_text
      into l_pms_text
      from (select pms_text, pms_pse_id,
                   rank() over (order by pml_default_order desc) ranking
              from pit_message
              join pit_message_language_v on pms_pml_name = pml_name
             where pms_name = coalesce(p_pms_name, g_default_language))
      where ranking = 1;
    return l_pms_text;
  exception
    when no_data_found then
      return null;
  end get_message_text;


  procedure merge_message_group(
    p_pmg_name in pit_message_group.pmg_name%type,
    p_pmg_description in pit_message_group.pmg_description%type default null)
  as
  begin
    merge into pit_message_group t
    using (select upper(p_pmg_name) pmg_name,
                  p_pmg_description pmg_description
             from dual) s
       on (t.pmg_name = s.pmg_name)
     when matched then update set
          pmg_description = s.pmg_description
     when not matched then insert(pmg_name, pmg_description)
          values(s.pmg_name, s.pmg_description);
  end merge_message_group;


  procedure merge_message(
    p_pms_name in pit_message.pms_name%type,
    p_pms_text in pit_message.pms_text%type,
    p_pms_pse_id in pit_message.pms_pse_id%type,
    p_pms_description in pit_message.pms_description%type default null,
    p_pms_pmg_name in pit_message_group.pmg_name%type default null,
    p_pms_pml_name in pit_message_language.pml_name%type default null,
    p_error_number in pit_message.pms_custom_error%type default null)
  as
    l_pms_name pit_message.pms_name%type;
    l_error_number pit_message.pms_custom_error%type;
    c_fatal constant binary_integer := 20;
    c_error constant binary_integer := 30;
  begin
    case
    when p_pms_pse_id in (c_fatal, c_error) and p_error_number not between c_min_error and c_max_error then
      check_error(p_pms_name, p_error_number);
      l_error_number := p_error_number;
    when p_pms_pse_id in (c_fatal, c_error) then
      l_error_number := c_max_error;
    else
      null;
    end case;

    merge into pit_message t
    using (select upper(p_pms_name) pms_name,
                  upper(coalesce(p_pms_pml_name, g_default_language)) pms_pml_name,
                  upper(p_pms_pmg_name) pms_pmg_name,
                  p_pms_text pms_text,
                  p_pms_description pms_description,
                  p_pms_pse_id pms_pse_id,
                  l_error_number pms_custom_error
             from dual) s
       on (t.pms_name = s.pms_name and t.pms_pml_name = s.pms_pml_name)
     when matched then update set
          t.pms_pmg_name = s.pms_pmg_name,
          t.pms_text = s.pms_text,
          t.pms_description = s.pms_description,
          t.pms_pse_id = s.pms_pse_id,
          t.pms_custom_error = s.pms_custom_error
     when not matched then insert
            (pms_name, pms_pmg_name, pms_pml_name, pms_text, pms_description, pms_pse_id, pms_custom_error)
          values
            (s.pms_name, s.pms_pmg_name, s.pms_pml_name, s.pms_text, s.pms_description, s.pms_pse_id, s.pms_custom_error);
    commit;

  exception
    when dup_val_on_index then
      -- DUP_VAL_ON_INDEX may occur if a user tries to assign a custom error number twice
      select pms_name
        into l_pms_name
        from pit_message
       where pms_custom_error = p_error_number
         and rownum = 1;
      rollback;
      raise_application_error(c_max_error, replace(c_error_already_assigned, '#ERRNO#', l_pms_name));
    when others then
      rollback;
        raise;
  end merge_message;


  procedure translate_message(
    p_pms_name in pit_message.pms_name%type,
    p_pms_text in pit_message.pms_text%type,
    p_pms_pml_name in pit_message_language.pml_name%type,
    p_pms_description in pit_message.pms_description%type default null)
  as
    l_pms_pse_id pit_message.pms_pse_id%type;
    l_error_number pit_message.pms_custom_error%type;
  begin
    select pms_pse_id, pms_custom_error
      into l_pms_pse_id, l_error_number
      from pit_message
     where pms_name = p_pms_name
       and pms_pml_name = g_default_language;

    merge_message(
      p_pms_name => p_pms_name,
      p_pms_text => p_pms_text,
      p_pms_description => p_pms_description,
      p_pms_pse_id => l_pms_pse_id,
      p_pms_pml_name => p_pms_pml_name,
      p_error_number => l_error_number);
  exception
    when no_data_found then
      raise_application_error(c_max_error, replace(c_message_does_not_exist, '#MESSAGE#', p_pms_name));
  end translate_message;


  procedure remove_message(
    p_pms_name in pit_message.pms_name%type,
    p_pms_pml_name in pit_message_language.pml_name%type)
  as
  begin
    if upper(p_pms_pml_name) = g_default_language then
      delete from pit_message
       where pms_name = upper(p_pms_name);
    else
      delete from pit_message
       where pms_name = upper(p_pms_name)
         and pms_pml_name = upper(p_pms_pml_name);
    end if;
  end remove_message;


  procedure remove_message_group(
    p_pmg_name in pit_message_group.pmg_name%type)
  as
    cursor pmg_cur(p_pmg_name in pit_message_group.pmg_name%type) is
      select pms_name
        from pit_message
       where pms_pmg_name = p_pmg_name;
  begin
    -- remove all messages within group
    for msg in pmg_cur(p_pmg_name) loop
      remove_message(msg.pms_name, g_default_language);
    end loop;
    -- remove group itself
    delete from pit_message_group
     where pmg_name = p_pmg_name;
    commit;
    
    create_message_package;
  end remove_message_group;
  

  procedure remove_all_messages
  as
  begin
    delete from pit_message;
  end remove_all_messages;


  function get_translation_xml(
    p_target_language in pit_message_language.pml_name%type,
    p_message_pattern in varchar2 default null)
    return xmltype
  as
    l_xliff xmltype;
    l_source_iso_code varchar2(10);
    l_source_language pit_util.ora_name_type;
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
                 xmlattributes(t.pms_name "id"),
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
      from (select pms_name,
                   l_source_iso_code source_language,
                   l_target_iso_code target_language,
                   max(
                     decode(
                       pms_pml_name,
                       l_source_language, to_char(pms_text))) source_text,
                   max(
                     decode(
                       pms_pml_name,
                       p_target_language, to_char(pms_text))) target_text
              from pit_message m
             where pms_name like p_message_pattern || '%'
             group by pms_name) t;

    select updatexml(
             par_xml_value,
             '/xliff/file/body', l_xliff,
             '/xliff/file/@source-language', l_source_iso_code,
             '/xliff/file/@target-language', l_target_iso_code,
             'xmlns="' || c_xliff_ns || '"'
             )
      into l_xliff
      from parameter_vw
     where par_id = 'XLIFF_SKELETON'
       and par_pgr_id = c_parameter_group;

    return l_xliff;
  end get_translation_xml;


  procedure translate_messages(
    p_translation_xml in xmltype)
  as
  begin
    merge into pit_message m
    using (select m.pms_name as pms_name,
                  utl_i18n.map_language_from_iso(d.pms_pml_name) pms_pml_name,
                  d.translation as pms_text,
                  m.pms_pse_id,
                  m.pms_custom_error
             from xmltable(
                    xmlnamespaces(default 'urn:oasis:names:tc:xliff:document:1.2'),
                    '/xliff/file/body/trans-unit'
                    passing p_translation_xml
                    columns
                    pms_name varchar2(30 char) path '/trans-unit/@id',
                    pms_pml_name varchar2(30 char) path '/trans-unit/target/@xml:lang',
                    translation clob path '/trans-unit/target') d
             join pit_message m
               on m.pms_name = d.pms_name
              and m.pms_pml_name =
                    utl_i18n.map_language_from_iso(d.pms_pml_name)) v
    on (m.pms_name = v.pms_name and m.pms_pml_name = v.pms_pml_name)
    when matched then update set
         m.pms_text = v.pms_text
    when not matched then insert
         (pms_name, pms_pml_name, pms_text,
          pms_pse_id, pms_custom_error)
         values
         (v.pms_name, v.pms_pml_name, v.pms_text,
          v.pms_pse_id, v.pms_custom_error);
    commit;
  exception
    when others then
      rollback;
      raise;
  end translate_messages;


  procedure remove_translation(
    p_language in pit_message_language.pml_name%type)
  as
  begin
    delete from pit_message
     where pms_pml_name = upper(p_language);
  end remove_translation;
  
  
  procedure set_language_settings(
    p_pml_list in pit_util.max_sql_char)
  as
    l_pml_list wwv_flow_global.vc_arr2;
    l_pml_default_order pit_message_language.pml_default_order%type;
  begin

    update pit_message_language
       set pml_default_order = 0
     where pml_default_order != 10;

    if p_pml_list is not null then
      l_pml_list := apex_util.string_to_table(p_pml_list);
      l_pml_default_order := (l_pml_list.count + 1) * 10;
      for i in l_pml_list.first .. l_pml_list.last loop
        update pit_message_language
           set pml_default_order = l_pml_default_order
         where pml_name = l_pml_list(i);
        l_pml_default_order := l_pml_default_order - 10;
      end loop;
    end if;
    
  end set_language_settings;


  procedure create_message_package (
    p_directory varchar2 default null)
  as
    c_package_name  constant varchar2(30) := 'msg';
    c_r constant varchar2(2) := chr(10);

    l_sql_text clob := 'create or replace package ' || c_package_name || ' as' || c_r;
    l_constant_template varchar2(200) :=
      q'~  #CONSTANT# constant varchar2(30) := '#CONSTANT#';~' || c_r;
    l_exception_template varchar2(200) :=
      '  #ERROR_NAME# exception;' || c_r;
    l_pragma_template varchar2(200) :=
      '  pragma exception_init(#ERROR_NAME#, #ERROR#);' || c_r;
    l_end_clause varchar2(20) := 'end ' || c_package_name || ';';

    l_constants clob := c_r || '  -- CONSTANTS:' || c_r;
    l_exceptions clob := c_r || '  -- EXCEPTIONS:' || c_r;
    l_pragmas clob := c_r || '  -- EXCEPTION INIT:' || c_r;

    cursor message_cur is
        with messages as(
             select pms_name,
                    case pms_custom_error when C_MAX_ERROR then pms_active_error else pms_custom_error end pms_custom_error
               from pit_message m
              where pms_pml_name = g_default_language)
      select replace(l_constant_template, '#CONSTANT#', pms_name) constant_chunk,
             case when pms_custom_error is not null then
               replace (l_exception_template, '#ERROR_NAME#', pit_util.get_error_name(pms_name))
             else null end exception_chunk,
             case when pms_custom_error is not null then
               replace(replace(l_pragma_template, '#ERROR_NAME#', pit_util.get_error_name(pms_name)), '#ERROR#', pms_custom_error)
             else null end pragma_chunk
        from messages
       order by pms_name;

  begin
    -- persist active error numbers for all errors in message table
    merge into pit_message m
    using (select pms_name, pms_pml_name, c_min_error - 1 + dense_rank() over (order by pms_name) pms_active_error
             from pit_message
            where pms_pse_id <= 30) v
       on (m.pms_name = v.pms_name
       and m.pms_pml_name = v.pms_pml_name)
     when matched then update set
          pms_active_error = v.pms_active_error;
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

    -- pit_util.recompile_invalid_objects;

  end create_message_package;


  function get_messages(
    p_message_pattern in varchar2 default null,
    p_pmg_name in pit_message_group.pmg_name%type default null)
    return clob
  as
    cursor message_group_cur(
      p_message_pattern in varchar2,
      p_pmg_name in pit_message_group.pmg_name%type) is
      select distinct pmg_name, pmg_description
        from pit_message_group
        join (select pms_pmg_name
                from pit_message
               where pms_pmg_name is not null
                 and pms_name like p_message_pattern || '%'
                 and (pms_pmg_name = p_pmg_name or p_pmg_name is null))
          on pmg_name = pms_pmg_name
       order by pmg_name;

    cursor message_cur(
      p_message_pattern in varchar2,
      p_pmg_name in pit_message_group.pmg_name%type) is
      select m.*, rank() over (partition by pms_name order by pml_default_order) rang
        from pit_message m
        join pit_message_language ml
          on m.pms_pml_name = ml.pml_name
       where ml.pml_default_order > 0
         and m.pms_name like p_message_pattern || '%'
         and (m.pms_pmg_name = p_pmg_name
          or p_pmg_name is null)
       order by m.pms_name, ml.pml_default_order;
    l_script clob;
    l_chunk pit_util.max_char;
    c_start constant varchar2(200) := q'~begin
~';
    c_end constant varchar2(200) := q'~
  commit;
  pit_admin.create_message_package;
end;
/~';
    c_merge_group_template constant varchar2(200) := q'~
  pit_admin.merge_message_group(
    p_pmg_name => '#NAME#',
    p_pmg_description => q'^#DESCRIPTION#^'
  );
~';
    c_merge_template constant varchar2(1000) := q'~
  pit_admin.merge_message(
    p_pms_name => '#NAME#',
    p_pms_pmg_name => '#GROUP#',
    p_pms_text => q'^#TEXT#^',
    p_pms_description => q'^#DESCRIPTION#^',
    p_pms_pse_id => #pms_pse_id#,
    p_pms_pml_name => '#LANGUAGE#',
    p_error_number => #ERRNO#
  );
~';
    c_translate_template constant varchar2(200) := q'~
  pit_admin.translate_message(
    p_pms_name => '#NAME#',
    p_pms_text => q'^#TEXT#^',
    p_pms_description => q'^#DESCRIPTION#^',
    p_pms_pml_name => '#LANGUAGE#'
  );
~';
  begin
    dbms_lob.createtemporary(l_script, false, dbms_lob.call);
    dbms_lob.append(l_script, c_start);

    for pmg in message_group_cur(p_message_pattern, p_pmg_name) loop
      l_chunk := l_chunk
              || pit_util.bulk_replace(c_merge_group_template, char_table(
                   '#NAME#', pmg.pmg_name,
                   '#DESCRIPTION#', pmg.pmg_description));
    end loop;
    dbms_lob.append(l_script, l_chunk);

    for msg in message_cur(p_message_pattern, p_pmg_name) loop
      case msg.rang
      when 1 then
        if l_chunk is not null then
          dbms_lob.append(l_script, l_chunk);
        end if;
        l_chunk := pit_util.bulk_replace(c_merge_template, char_table(
                     '#NAME#', msg.pms_name,
                     '#GROUP#', msg.pms_pmg_name,
                     '#TEXT#', msg.pms_text,
                     '#DESCRIPTION#', msg.pms_description,
                     '#PMS_PSE_ID#', to_char(msg.pms_pse_id),
                     '#LANGUAGE#', msg.pms_pml_name,
                     '#ERRNO#', coalesce(to_char(msg.pms_custom_error), 'null')));
      else
        l_chunk := l_chunk
                || pit_util.bulk_replace(c_translate_template, char_table(
                     '#NAME#', msg.pms_name,
                     '#TEXT#', msg.pms_text,
                     '#DESCRIPTION#', msg.pms_description,
                     '#LANGUAGE#', msg.pms_pml_name));
      end case;
    end loop;

    dbms_lob.append(l_script, l_chunk);
    dbms_lob.append(l_script, c_end);

    return l_script;
  end get_messages;


  procedure write_message_file(
    p_directory in varchar2 default 'DATA_DIR')
  as
    c_file_name constant pit_util.ora_name_type := 'messages.sql';
  begin
    dbms_xslprocessor.clob2file(get_messages, p_directory, c_file_name);
  end write_message_file;
  
  
  procedure merge_translatable_item(
    p_pti_id in pit_translatable_item.pti_id%type,
    p_pti_pml_name in pit_message_language.pml_name%type,
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_name in varchar2,
    p_pti_display_name in varchar2 default null,
    p_pti_description in clob default null)
  as
  begin
    merge into pit_translatable_item t
    using (select p_pti_id pti_id,
                  coalesce(p_pti_pml_name, g_default_language) pti_pml_name,
                  p_pti_pmg_name pti_pmg_name,
                  p_pti_name pti_name,
                  p_pti_display_name pti_display_name,
                  p_pti_description pti_description
             from dual) s
       on (t.pti_id = s.pti_id
       and t.pti_pml_name = s.pti_pml_name)
      when matched then update set
           t.pti_pmg_name = s.pti_pmg_name,
           t.pti_name = s.pti_name,
           t.pti_display_name = s.pti_display_name,
           t.pti_description = s.pti_description
      when not matched then insert(pti_id, pti_pmg_name, pti_pml_name, pti_name, pti_display_name, pti_description)
           values(s.pti_id, s.pti_pmg_name, s.pti_pml_name, s.pti_name, s.pti_display_name, s.pti_description);
  end merge_translatable_item;
  
  
  procedure delete_translatable_item(
    p_pti_id in pit_translatable_item.pti_id%type)
  as
  begin
    delete from pit_translatable_item
     where pti_id = p_pti_id;
  end delete_translatable_item;
  
  
  function get_translatable_items(
    p_pmg_name in pit_message_group.pmg_name%type default null)
    return clob
  as
    cursor pti_cur(
      p_pmg_name in pit_message_group.pmg_name%type) is
      select i.*, rank() over (partition by pti_id order by pml_default_order) rang
        from pit_translatable_item i
        join pit_message_language ml
          on i.pti_pml_name = ml.pml_name
       where ml.pml_default_order > 0
         and i.pti_pmg_name = p_pmg_name
       order by i.pti_id, ml.pml_default_order;
    l_script clob;
    l_chunk pit_util.max_char;
    c_start constant varchar2(200) := q'~begin
~';
    c_end constant varchar2(200) := q'~
  commit;
end;
/~';
    c_pti_template constant varchar2(300) := q'~
  pit_admin.merge_translatable_item(
    p_pti_id => #PTI_ID#,
    p_pti_pml_name => q'^#PTI_PML_NAME#^',
    p_pti_pmg_name => q'^#PTI_PMG_NAME#^',
    p_pti_name => q'^#PTI_NAME#^',
    p_pti_display_name => q'^#PTI_DISPLAY_NAME#^',
    p_pti_description => q'^#PTI_DESCRIPTION_NAME#^'
  );
~';
  begin
    dbms_lob.createtemporary(l_script, false, dbms_lob.call);
    dbms_lob.append(l_script, c_start);

    for pti in pti_cur(p_pmg_name) loop
      l_chunk := pit_util.bulk_replace(c_pti_template, char_table(
                   '#PTI_ID#', to_char(pti.pti_id),
                   '#PTI_PML_NAME#', pti.pti_pml_name,
                   '#PTI_PMG_NAME#', pti.pti_pmg_name,
                   '#PTI_NAME#', pti.pti_name,
                   '#PTI_DISPLAY_NAME#', pti.pti_display_name,
                   '#PTI_DESCRIPTION_NAME#', pti.pti_description
                 ));
      dbms_lob.append(l_script, l_chunk);
    end loop;
    
    dbms_lob.append(l_script, c_end);
    return l_script;
  end get_translatable_items;


  procedure create_named_context(
    p_context_name in varchar2,
    p_log_level in number,
    p_trace_level in number,
    p_trace_timing in boolean,
    p_module_list in varchar2,
    p_comment in varchar2 default null)
  as
    l_trace_timing pit_util.flag_type;
    l_settings pit_util.max_sql_char;
  begin
    l_trace_timing := case when p_trace_timing then c_true else c_false end;
    l_settings := pit_util.concatenate(
                    p_chunk_list => char_table(p_log_level, p_trace_level, l_trace_timing, p_module_list), 
                    p_delimiter => c_del);
    create_named_context(
      p_context_name => p_context_name,
      p_settings => l_settings, 
      p_comment => p_comment);
  end create_named_context;


  procedure create_named_context(
    p_context_name in varchar2,
    p_settings in varchar2,
    p_comment in varchar2 default null)
  as
    c_standard_comment constant varchar2(200) := ' [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST]';
  begin

    pit_util.check_context_settings(
      p_context_name => p_context_name,
      p_settings => p_settings);

    -- Create parameter
    param_admin.edit_parameter(
      p_par_id => pit_util.harmonize_name(c_context_prefix, p_context_name),
      p_par_pgr_id => c_parameter_group,
      p_par_description => replace(p_comment, c_standard_comment) || c_standard_comment,
      p_par_string_value => upper(p_settings));
  end create_named_context;


  procedure remove_named_context(
    p_context_name in varchar2)
  as
  begin
    param_admin.delete_parameter(
      p_par_id => c_context_prefix || replace(upper(p_context_name), c_context_prefix),
      p_par_pgr_id => c_parameter_group);
  end remove_named_context;


  procedure create_context_toggle(
    p_toggle_name in varchar2,
    p_module_list in varchar2,
    p_context_name in varchar2,
    p_comment in varchar2 default null)
  as
    l_toggle_name pit_util.ora_name_type;
    l_context_name pit_util.ora_name_type;
  begin

    pit_util.check_toggle_settings(p_toggle_name, p_module_list, p_context_name);

    -- Create parameter
    l_toggle_name := pit_util.harmonize_name(c_toggle_prefix, p_toggle_name);
    l_context_name := replace(p_context_name, c_context_prefix);
    param_admin.edit_parameter(
      p_par_id => l_toggle_name,
      p_par_pgr_id => c_parameter_group,
      p_par_description => p_comment,
      p_par_string_value => upper(p_module_list || c_del || l_context_name));
  end create_context_toggle;


  procedure remove_context_toggle(
    p_toggle_name in varchar2)
  as
  begin
    param_admin.delete_parameter(
      p_par_id => c_toggle_prefix || replace(upper(p_toggle_name), c_toggle_prefix),
      p_par_pgr_id => c_parameter_group);
  end remove_context_toggle;

begin
  initialize;
end pit_admin;
/
