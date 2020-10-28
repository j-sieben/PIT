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

  C_PREDEFINED_ERROR constant varchar2(5) := 'PIT';
  C_CONTEXT_PREFIX constant varchar2(30) := 'CONTEXT_';
  C_TOGGLE_PREFIX constant varchar2(30) := 'TOGGLE_';
  C_XLIFF_NS constant varchar2(100) := 'urn:oasis:names:tc:xliff:document:2.0';
  C_DEL char(1 byte) := '|';
  C_MIN_ERROR constant number := -20999;
  C_MAX_ERROR constant number := -20000;
  C_DEFAULT_LANGUAGE constant number := 10;


  -- ERROR messages
  C_ERROR_ALREADY_ASSIGNED constant varchar2(200) := 'This Oracle error number is already assigned to message #ERRNO#';
  C_MESSAGE_DOES_NOT_EXIST constant varchar2(200) := 'Message #MESSAGE# does not exist.';
 
  /********************** GENERIC HELPER FUNCTIONS ****************************/
  /** Method to collect all predefined error names within the database
   */
  procedure initialize_error_list
  as
    cursor predefined_errors_cur is
        with errors as(
             select type source_type, owner, name package_name,
                    upper(substr(text, instr(text, '(') + 1, instr(text, ')') - instr(text, '(') - 1)) init
               from all_source a
              where (owner in ('SYS') or owner like 'APEX%')
                and upper(text) like '%PRAGMA EXCEPTION_INIT%'
                    -- Next to internal PIT packages, some packages don't adhere to Oracles error strategy. Filter them out!
                and name not in ('PIT_ADMIN', 'PIT_UTIL', 'DBMS_BDSQL'))
      select source_type, owner, package_name,
             -- don't convert to numbers here as it's possible that conversion errors occur
             to_number(trim(replace(substr(init, instr(init, ',') + 1), '''', '')), '99999') error_number,
             trim(substr(init, 1, instr(init, ',') - 1)) error_name
        from errors
       where trim(substr(init, 1, instr(init, ',') - 1)) is not null;
    l_predefined_error predefined_error_rec;
  begin
    if g_predefined_errors.count = 0 then
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
    end if;
  end initialize_error_list;


  /* Helper to check whether a predefined Oracle error is to be overwritten
   * %param  p_pms_name          Name of the message to check the error for
   * %param  p_pms_custom_error  Error number for which a PIT message shall be created
   * %usage  Is called whenever a new message is inserted into table MESSAGE with an Oracle
   *         error number. The function checks whether the Oracle error number is already
   *         a predefined error, such as -1 and DUP_VAL_ON_INDEX.
   *         If so, the procedure throws an error.
   *         Limitation: This procedure can only see Exceptions that are defined in 
   *         packages from SYSTEM or SYS and only exceptions from non wrapped sources.
   */
  procedure check_error(
    p_pms_name in pit_message.pms_name%TYPE,
    p_pms_custom_error in pit_message.pms_custom_error%TYPE)
  as
    l_predefined_error predefined_error_rec;
    l_message varchar2(2000);
    l_message_length binary_integer;
    l_error_regexp varchar2(1000);
    C_ERROR_REGEXP constant varchar2(100) := q'~^(#NAME#|#NAME#_ERR)$~';
    C_MSG_TOO_LONG constant varchar2(200) := 
      q'~Message "#MESSAGE#" must not exceed 26 chars but is #LENGTH#.~';
    C_PREDEFINED_ERROR constant varchar2(200) :=
      q'~Error number #ERROR# is a predefined Oracle error named #NAME# in #OWNER#.#PKG#. Please don't overwrite Oracle predefined errors.~';
  begin
    initialize_error_list;
    
    l_message_length := length(p_pms_name);
    if l_message_length > pit_util.c_max_length - 4 then
      l_message := pit_util.bulk_replace(C_MSG_TOO_LONG, char_table(
                     '#MESSAGE#', p_pms_name,
                     '#LENGTH#', l_message_length));
       raise_application_error(-20000, l_message);
    end if;
    if g_predefined_errors.exists(p_pms_custom_error) then
      l_error_regexp := replace(C_ERROR_REGEXP, '#NAME#', p_pms_name);
      if not regexp_like(g_predefined_errors(p_pms_custom_error).error_name, l_error_regexp) then
        l_predefined_error := g_predefined_errors(p_pms_custom_error);
        l_message := pit_util.bulk_replace(C_PREDEFINED_ERROR, char_table(
                       '#ERROR#', p_pms_custom_error,
                       '#NAME#', l_predefined_error.error_name,
                       '#OWNER#', l_predefined_error.owner,
                       '#PKG#', l_predefined_error.package_name));
        raise_application_error(-20000, l_message);
      end if;
    end if;
  end check_error;
  
  
  function get_export_group_script(
    p_pmg_name in pit_message_group.pmg_name%TYPE)
    return varchar2
  as
    cursor message_group_cur(
      p_pmg_name in pit_message_group.pmg_name%TYPE) is
      select pmg_name, pmg_description
        from pit_message_group pmg
       where exists(
             select null
               from pit_message
              where pms_pmg_name = pmg_name)
         and pmg_name = p_pmg_name
          or p_pmg_name is null
       order by pmg_name;
       
    c_merge_group_template constant varchar2(200) := q'~    
  pit_admin.merge_message_group(
    p_pmg_name => '#NAME#',
    p_pmg_description => q'^#DESCRIPTION#^');
~';
    l_chunk pit_util.max_char;
  begin

    for pmg in message_group_cur(p_pmg_name) loop
      l_chunk := l_chunk
              || pit_util.bulk_replace(c_merge_group_template, char_table(
                   '#NAME#', pmg.pmg_name,
                   '#DESCRIPTION#', pmg.pmg_description));
    end loop;
    return l_chunk;
  end get_export_group_script;
  
  
  /** Helper method to generate a message install script
   * %param  p_pmg_name   Message group to filter output
   * %param  p_file_name  Out parameter that provides the file name for the Script file
   * %param  p_script     Out parameter that contains the SQL script created
   * %usage  Is called internally by CREATE_INSTALLATION_SCRIPT
   */
  procedure script_messages(
    p_pmg_name in pit_message_group.pmg_name%TYPE,
    p_file_name out nocopy pit_util.ora_name_type,
    p_script out nocopy clob)
  as
    cursor message_cur(
      p_pmg_name in pit_message_group.pmg_name%TYPE) is
      select m.*, rank() over (partition by pms_name order by pml_default_order) rang
        from pit_message m
        join pit_message_language ml
          on m.pms_pml_name = ml.pml_name
       where ml.pml_default_order > 0
         and (m.pms_pmg_name = p_pmg_name
          or p_pmg_name is null)
       order by m.pms_name, ml.pml_default_order;
    l_chunk pit_util.max_char;
    C_START constant varchar2(200) := q'~begin
~';
    C_END constant varchar2(200) := q'~
  commit;
  pit_admin.create_message_package;
end;
/~';
    C_MERGE_TEMPLATE constant varchar2(1000) := q'~
  pit_admin.merge_message(
    p_pms_name => '#NAME#',
    p_pms_pmg_name => '#GROUP#',
    p_pms_text => q'^#TEXT#^',
    p_pms_description => q'^#DESCRIPTION#^',
    p_pms_pse_id => #PMS_PSE_ID#,
    p_pms_pml_name => '#LANGUAGE#',
    p_error_number => #ERRNO#);
~';
    C_TRANSLATE_TEMPLATE constant varchar2(200) := q'~
  pit_admin.translate_message(
    p_pms_name => '#NAME#',
    p_pms_text => q'^#TEXT#^',
    p_pms_description => q'^#DESCRIPTION#^',
    p_pms_pml_name => '#LANGUAGE#');
~';
  begin
    -- Initialize
    p_file_name := 'MessageGroup_' || p_pmg_name || '.sql';
    dbms_lob.createtemporary(p_script, false, dbms_lob.call);
    pit_util.clob_append(p_script, C_START);
    pit_util.clob_append(p_script, get_export_group_script(p_pmg_name));

    for msg in message_cur(p_pmg_name) loop
      case msg.rang
      when 1 then
        if l_chunk is not null then
          pit_util.clob_append(p_script, l_chunk);
        end if;
        l_chunk := pit_util.bulk_replace(C_MERGE_TEMPLATE, char_table(
                     '#NAME#', msg.pms_name,
                     '#GROUP#', msg.pms_pmg_name,
                     '#TEXT#', msg.pms_text,
                     '#DESCRIPTION#', msg.pms_description,
                     '#PMS_PSE_ID#', to_char(msg.pms_pse_id),
                     '#LANGUAGE#', msg.pms_pml_name,
                     '#ERRNO#', coalesce(to_char(msg.pms_custom_error), 'null')));
      else
        l_chunk := l_chunk
                || pit_util.bulk_replace(C_TRANSLATE_TEMPLATE, char_table(
                     '#NAME#', msg.pms_name,
                     '#TEXT#', msg.pms_text,
                     '#DESCRIPTION#', msg.pms_description,
                     '#LANGUAGE#', msg.pms_pml_name));
      end case;
    end loop;

    pit_util.clob_append(p_script, l_chunk);
    pit_util.clob_append(p_script, C_END);
  end script_messages;
  
  
  /** Helper method to generate a translatable items install script
   * %param  p_pmg_name   Message group to filter output
   * %param  p_file_name  Out parameter that provides the file name for the Script file
   * %param  p_script     Out parameter that contains the SQL script created
   * %usage  Is called internally by CREATE_INSTALLATION_SCRIPT
   */
  procedure script_translatable_items(
    p_pmg_name in pit_message_group.pmg_name%TYPE default null,
    p_file_name out nocopy pit_util.ora_name_type,
    p_script out nocopy clob)
  as
    cursor pti_cur(
      p_pmg_name in pit_message_group.pmg_name%TYPE) is
      select i.*, rank() over (partition by pti_id order by pml_default_order) rang
        from pit_translatable_item i
        join pit_message_language ml
          on i.pti_pml_name = ml.pml_name
       where ml.pml_default_order > 0
         and i.pti_pmg_name = p_pmg_name
       order by i.pti_id, ml.pml_default_order;
    l_chunk pit_util.max_char;
    C_START constant varchar2(200) := q'~begin
~';
    C_END constant varchar2(200) := q'~
  commit;
end;
/~';
    C_PTI_TEMPLATE constant varchar2(300) := q'~
  pit_admin.merge_translatable_item(
    p_pti_id => '#PTI_ID#',
    p_pti_pml_name => q'^#PTI_PML_NAME#^',
    p_pti_pmg_name => q'^#PTI_PMG_NAME#^',
    p_pti_name => q'^#PTI_NAME#^',
    p_pti_display_name => q'^#PTI_DISPLAY_NAME#^',
    p_pti_description => q'^#PTI_DESCRIPTION_NAME#^'
  );
~';
  begin
    -- Initialize
    p_file_name := 'TranslatableItemGroup_' || p_pmg_name || '.sql';
    dbms_lob.createtemporary(p_script, false, dbms_lob.call);
    pit_util.clob_append(p_script, C_START);
    pit_util.clob_append(p_script, get_export_group_script(p_pmg_name));

    for pti in pti_cur(p_pmg_name) loop
      l_chunk := pit_util.bulk_replace(C_PTI_TEMPLATE, char_table(
                   '#PTI_ID#', to_char(pti.pti_id),
                   '#PTI_PML_NAME#', pti.pti_pml_name,
                   '#PTI_PMG_NAME#', pti.pti_pmg_name,
                   '#PTI_NAME#', pti.pti_name,
                   '#PTI_DISPLAY_NAME#', pti.pti_display_name,
                   '#PTI_DESCRIPTION_NAME#', pti.pti_description
                 ));
      pit_util.clob_append(p_script, l_chunk);
    end loop;
    
    pit_util.clob_append(p_script, C_END);
  end script_translatable_items;
  
  
  /** Method to extract language and group from an XLIFF envelope
   * %param  p_xliff  XLIFF instance
   * %param  p_pml_name         Language name converted to Oracle language name
   * %param  p_pmg_name         Group name
   * %usage  Is used to extract information from an XLIFF header.
   */
  procedure analyze_xliff(
    p_xliff xmltype,
    p_pml_name out nocopy pit_message_language.pml_name%TYPE, 
    p_pmg_name out nocopy pit_message_group.pmg_name%TYPE) 
  as
  begin
    select utl_i18n.map_language_from_iso(pml_name), pmg_name
      into p_pml_name, p_pmg_name
      from xmltable(
             xmlnamespaces(default 'urn:oasis:names:tc:xliff:document:2.0'),
             '/xliff'
             passing p_xliff
             columns
               pml_name varchar2(128 byte) path '@trgLang',
               pmg_name varchar2(128 byte) path 'file/@id');
  end analyze_xliff;


  /** Helper method to extract XLIFF instance into PIT_MESSAGE
   * %param  p_xliff  XLIFF instance to apply
   * %usage  Is called internally by APPLY_TRANSLATIONS
   */
  procedure translate_messages(
    p_xliff in xmltype)
  as
    l_pml_name pit_message_language.pml_name%TYPE;
    l_pmg_name pit_message_group.pmg_name%TYPE;
  begin
    analyze_xliff(p_xliff, l_pml_name, l_pmg_name);
    
    merge into pit_message t
    using (select d.pms_name as pms_name,
                  l_pml_name pms_pml_name,
                  l_pmg_name pms_pmg_name,
                  -- if only description is translated, get orginal text to avoid NOT NULL constraint error
                  coalesce(d.text_translation, 
                    (select pms_text
                       from pit_message o
                      where o.pms_name = d.pms_name
                        and o.pms_pml_name = g_default_language)) as pms_text,
                  d.description_translation as pms_description,
                  m.pms_pse_id,
                  m.pms_custom_error
             from xmltable(
                    xmlnamespaces(default 'urn:oasis:names:tc:xliff:document:2.0'),
                    '/xliff/file/unit'
                    passing p_xliff
                    columns
                      pms_name varchar2(128 byte) path '@id',
                      text_translation clob path 'segment[@id="TEXT"]/target',
                      description_translation clob path 'segment[@id="DESC"]/target') d
             left join pit_message m
               on m.pms_name = d.pms_name
              and m.pms_pml_name = l_pml_name
            where d.text_translation || d.description_translation is not null) s
    on (t.pms_name = s.pms_name
    and t.pms_pml_name = s.pms_pml_name)
    when matched then update set
         t.pms_text = s.pms_text,
         t.pms_description = s.pms_description
    when not matched then insert
         (pms_name, pms_pml_name, pms_pmg_name, pms_text,
          pms_description, pms_pse_id, pms_custom_error)
         values
         (s.pms_name, s.pms_pml_name, s.pms_pmg_name, s.pms_text,
          s.pms_description, s.pms_pse_id, s.pms_custom_error);
          
    update pit_message_language
       set pml_default_order = greatest(pml_default_order, 50)
     where pml_name = l_pml_name;
     
    commit;
  exception
    when others then
      rollback;
      raise;
  end translate_messages;


  /** Helper method to extract XLIFF instance into PIT_TRANSLATABLE_ITEM
   * %param  p_xliff  XLIFF instance to apply
   * %usage  Is called internally by APPLY_TRANSLATIONS
   */
  procedure translate_translatable_items(
    p_xliff in xmltype)
  as
    l_pml_name pit_message_language.pml_name%TYPE;
    l_pmg_name pit_message_group.pmg_name%TYPE;
  begin
    analyze_xliff(p_xliff, l_pml_name, l_pmg_name);
    
    merge into pit_translatable_item t
    using (select pti_id,
                  l_pml_name pti_pml_name,
                  l_pmg_name pti_pmg_name,
                  pti_name,
                  pti_display_name,
                  pti_description
             from xmltable(
                    xmlnamespaces(default 'urn:oasis:names:tc:xliff:document:2.0'),
                    '/xliff/file/unit'
                    passing p_xliff
                    columns
                      pti_id varchar2(128 byte) path '@id',
                      pti_name clob path 'segment[@id="NAME"]/target',
                      pti_display_name clob path 'segment[@id="DISP"]/target',
                      pti_description clob path 'segment[@id="DESC"]/target')) s
    on (t.pti_id = s.pti_id
    and t.pti_pml_name = s.pti_pml_name)
    when matched then update set
         t.pti_name = s.pti_name,
         t.pti_display_name = s.pti_display_name,
         t.pti_description = s.pti_description
    when not matched then insert
         (pti_id, pti_pml_name, pti_pmg_name, 
          pti_name, pti_display_name, pti_description)
         values
         (s.pti_id, s.pti_pml_name, s.pti_pmg_name, 
          s.pti_name, s.pti_display_name, s.pti_description);
          
    commit;
  exception
    when others then
      rollback;
      raise;
  end translate_translatable_items;
  
  
  /** Help method to generate XLIFF compatible translation entries for messages
   * %param  p_target_language  Language to translate the messages to
   * %param  p_pmg_name         Message group to tranlsate
   * %return XML fragment to incorporate into an XLIFF envelope generated by GET_TRANSLATION_XML
   * %usage  Is called internally by GET_TRANSLATION_XML to allow for different target types
   */
  function get_pms_xml(
    p_target_language in pit_message_language.pml_name%TYPE,
    p_pmg_name in pit_message_group.pmg_name%TYPE default null)
    return xmltype
  as
    l_xml xmltype;
  begin
    with messages as(
           select pms_name,
                  -- pivot test and description to source and target columns
                  max(
                    decode(
                      pms_pml_name,
                      g_default_language, to_char(pms_text))) source_text,
                  max(
                    decode(
                      pms_pml_name,
                      p_target_language, to_char(pms_text))) target_text,
                  max(
                    decode(
                      pms_pml_name,
                      g_default_language, to_char(pms_description))) source_description,
                  max(
                    decode(
                      pms_pml_name,
                      p_target_language, to_char(pms_description))) target_description
             from pit_message m
            where pms_pmg_name = p_pmg_name
              and pms_pml_name in (g_default_language, p_target_language)
            group by pms_name)
    select xmlagg(
             xmlelement("unit",
               xmlattributes(
                 pms_name "id"),
               xmlelement("segment",
                 xmlattributes(
                   'TEXT' "id"),
                 xmlforest(
                   source_text "source",
                   target_text "target"
                 )
               ),
               case when source_description is not null then
                 xmlelement("segment",
                   xmlattributes(
                     'DESC' "id"),
                   xmlforest(
                     source_description "source",
                     target_description "target"
                   )
                 )
               end
             )
           )
      into l_xml
      from messages;
    return l_xml;
  end get_pms_xml;
  
  
  /** Help method to generate XLIFF compatible translation entries for translatable items
   * %param  p_target_language  Language to translate the translatable items to
   * %param  p_pmg_name         Translatable items group to tranlsate
   * %return XML fragment to incorporate into an XLIFF envelope generated by GET_TRANSLATION_XML
   * %usage  Is called internally by GET_TRANSLATION_XML to allow for different target types
   */
  function get_pti_xml(
    p_target_language in pit_message_language.pml_name%TYPE,
    p_pmg_name in pit_message_group.pmg_name%TYPE default null)
    return xmltype
  as
    l_xml xmltype;
  begin
    with messages as(
           select pti_id,
                  -- pivot test and description to source and target columns
                  max(
                    decode(
                      pti_pml_name,
                      g_default_language, to_char(pti_name))) source_name,
                  max(
                    decode(
                      pti_pml_name,
                      p_target_language, to_char(pti_name))) target_name,
                  max(
                    decode(
                      pti_pml_name,
                      g_default_language, to_char(pti_display_name))) source_display_name,
                  max(
                    decode(
                      pti_pml_name,
                      p_target_language, to_char(pti_display_name))) target_display_name,
                  max(
                    decode(
                      pti_pml_name,
                      g_default_language, to_char(pti_description))) source_description,
                  max(
                    decode(
                      pti_pml_name,
                      p_target_language, to_char(pti_description))) target_description
             from pit_translatable_item i
            where pti_pmg_name = p_pmg_name
              and pti_pml_name in (g_default_language, p_target_language)
            group by pti_id)
    select xmlagg(
             xmlelement("unit",
               xmlattributes(
                 pti_id "id"),
               xmlelement("segment",
                 xmlattributes(
                   'NAME' "id"),
                 xmlforest(
                   source_name "source",
                   target_name "target"
                 )
               ),
               xmlelement("segment",
                 xmlattributes(
                   'DISP' "id"),
                 xmlforest(
                   source_display_name "source",
                   target_display_name "target"
                 )
               ),
               case when source_description is not null then
                 xmlelement("segment",
                   xmlattributes(
                     'DESC' "id"),
                   xmlforest(
                     source_description "source",
                     target_description "target"
                   )
                 )
               end
             )
           )
      into l_xml
      from messages;
    return l_xml;
  end get_pti_xml;
  
  
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
  procedure merge_message_group(
    p_pmg_name in pit_message_group.pmg_name%TYPE,
    p_pmg_description in pit_message_group.pmg_description%TYPE default null)
  as
    l_pmg_name pit_message_group.pmg_name%TYPE;
  begin
    l_pmg_name := pit_util.harmonize_sql_name(p_pmg_name);
    merge into pit_message_group t
    using (select l_pmg_name pmg_name,
                  p_pmg_description pmg_description
             from dual) s
       on (t.pmg_name = s.pmg_name)
     when matched then update set
          pmg_description = s.pmg_description
     when not matched then insert(pmg_name, pmg_description)
          values(s.pmg_name, s.pmg_description);
  end merge_message_group;
  
  
  procedure delete_message_group(
    p_pmg_name in pit_message_group.pmg_name%TYPE,
    p_force in boolean default false)
  as
  begin
    if p_force then
      delete from pit_message
       where pms_pmg_name = p_pmg_name;
       
      delete from pit_translatable_item
       where pti_pmg_name = p_pmg_name;
    end if;
    
    delete from pit_message_group
     where pmg_name = p_pmg_name;    
  end delete_message_group;


  procedure merge_message(
    p_pms_name in pit_message.pms_name%TYPE,
    p_pms_text in pit_message.pms_text%TYPE,
    p_pms_pse_id in pit_message.pms_pse_id%TYPE,
    p_pms_description in pit_message.pms_description%TYPE default null,
    p_pms_pmg_name in pit_message_group.pmg_name%TYPE default null,
    p_pms_pml_name in pit_message_language.pml_name%TYPE default null,
    p_error_number in pit_message.pms_custom_error%TYPE default null)
  as
    l_pms_name pit_message.pms_name%TYPE;
    l_error_number pit_message.pms_custom_error%TYPE;
    C_FATAL constant binary_integer := 20;
    C_ERROR constant binary_integer := 30;
  begin
  
    l_pms_name := pit_util.harmonize_sql_name(p_pms_name);
    
    case
    when p_pms_pse_id in (C_FATAL, C_ERROR) and p_error_number not between C_MIN_ERROR and C_MAX_ERROR then
      check_error(l_pms_name, p_error_number);
      l_error_number := p_error_number;
    when p_pms_pse_id in (C_FATAL, C_ERROR) then
      l_error_number := C_MAX_ERROR;
    else
      null;
    end case;

    merge into pit_message t
    using (select l_pms_name pms_name,
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
      raise_application_error(C_MAX_ERROR, replace(C_ERROR_ALREADY_ASSIGNED, '#ERRNO#', l_pms_name));
    when others then
      rollback;
        raise;
  end merge_message;


  procedure delete_message(
    p_pms_name in pit_message.pms_name%TYPE,
    p_pms_pml_name in pit_message_language.pml_name%TYPE)
  as
  begin
    delete from pit_message
     where pms_name = upper(p_pms_name)
       and (pms_pml_name = upper(p_pms_pml_name)
        or p_pms_pml_name is null);
  end delete_message;
  

  procedure delete_all_messages(
    p_pmg_name in pit_message_group.pmg_name%TYPE default null)
  as
  begin
    delete from pit_message
     where pms_pmg_name = p_pmg_name
        or p_pmg_name is null;
  end delete_all_messages;
  
  
  procedure merge_translatable_item(
    p_pti_id in pit_translatable_item.pti_id%TYPE,
    p_pti_pml_name in pit_message_language.pml_name%TYPE,
    p_pti_pmg_name in pit_message_group.pmg_name%TYPE,
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
    p_pti_id in pit_translatable_item.pti_id%TYPE)
  as
  begin
    delete from pit_translatable_item
     where pti_id = p_pti_id;
  end delete_translatable_item;


  /*********** SETTINGS **************/
  function get_message_text(
    p_pms_name in pit_message.pms_name%TYPE,
    p_pms_pml_name in pit_message_language.pml_name%TYPE := null)
    return varchar2
  as
    l_pms_text pit_message.pms_text%TYPE;
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
  
  
  procedure set_language_settings(
    p_pml_list in pit_util.max_sql_char)
  as
    l_pml_list args;
    l_pml_default_order pit_message_language.pml_default_order%TYPE;
  begin

    update pit_message_language
       set pml_default_order = 0
     where pml_default_order != C_DEFAULT_LANGUAGE;

    if p_pml_list is not null then
      l_pml_list := pit_util.string_to_table(p_pml_list);
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
    C_PACKAGE_NAME  constant varchar2(30) := 'msg';
    C_R constant varchar2(2) := chr(10);

    l_sql_text clob := 'create or replace package ' || C_PACKAGE_NAME || ' as' || C_R;
    l_constant_template varchar2(200) :=
      q'~  #CONSTANT# constant pit_util.ora_name_type := '#CONSTANT#';~' || C_R;
    l_exception_template varchar2(200) :=
      '  #ERROR_NAME# exception;' || C_R;
    l_pragma_template varchar2(200) :=
      '  pragma exception_init(#ERROR_NAME#, #ERROR#);' || C_R;
    l_end_clause varchar2(20) := 'end ' || C_PACKAGE_NAME || ';';

    l_constants clob := C_R || '  -- CONSTANTS:' || C_R;
    l_exceptions clob := C_R || '  -- EXCEPTIONS:' || C_R;
    l_pragmas clob := C_R || '  -- EXCEPTION INIT:' || C_R;

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
    using (select pms_name, pms_pml_name, C_MIN_ERROR - 1 + dense_rank() over (order by pms_name) pms_active_error
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
      dbms_xslprocessor.clob2file(l_sql_text, p_directory, C_PACKAGE_NAME || '.pkg');
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
    l_trace_timing pit_util.flag_type;
    l_settings pit_util.max_sql_char;
  begin
    l_trace_timing := case when p_trace_timing then pit_util.C_TRUE else pit_util.C_FALSE end;
    l_settings := pit_util.concatenate(
                    p_chunk_list => char_table(p_log_level, p_trace_level, l_trace_timing, p_module_list), 
                    p_delimiter => C_DEL);
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
      p_par_id => pit_util.harmonize_name(C_CONTEXT_PREFIX, p_context_name),
      p_par_pgr_id => C_PREDEFINED_ERROR,
      p_par_description => replace(p_comment, c_standard_comment) || c_standard_comment,
      p_par_string_value => upper(p_settings));
  end create_named_context;


  procedure remove_named_context(
    p_context_name in varchar2)
  as
  begin
    param_admin.delete_parameter(
      p_par_id => C_CONTEXT_PREFIX || replace(upper(p_context_name), C_CONTEXT_PREFIX),
      p_par_pgr_id => C_PREDEFINED_ERROR);
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
    l_toggle_name := pit_util.harmonize_name(C_TOGGLE_PREFIX, p_toggle_name);
    l_context_name := replace(p_context_name, C_CONTEXT_PREFIX);
    param_admin.edit_parameter(
      p_par_id => l_toggle_name,
      p_par_pgr_id => C_PREDEFINED_ERROR,
      p_par_description => p_comment,
      p_par_string_value => upper(p_module_list || C_DEL || l_context_name));
  end create_context_toggle;


  procedure delete_context_toggle(
    p_toggle_name in varchar2)
  as
  begin
    param_admin.delete_parameter(
      p_par_id => C_TOGGLE_PREFIX || replace(upper(p_toggle_name), C_TOGGLE_PREFIX),
      p_par_pgr_id => C_PREDEFINED_ERROR);
  end delete_context_toggle;

  
  /*********** EXPORT **************/
  procedure create_installation_script(
    p_pmg_name in pit_message_group.pmg_name%TYPE,
    p_target in varchar2,
    p_file_name out nocopy pit_util.ora_name_type,
    p_script out nocopy clob)
  as
  begin
  
    case p_target
    when C_TARGET_PMS then
      script_messages(p_pmg_name, p_file_name, p_script);
    when C_TARGET_PTI then
      script_translatable_items(p_pmg_name, p_file_name, p_script);
    when C_TARGET_PAR then
      p_script := param_admin.export_parameter_group(p_pmg_name);
      p_file_name := 'ParameterGroup_' || p_pmg_name || '.sql';
    else
      null;
    end case;
  end create_installation_script;
  
  
  /*********** TRANSLATION **************/
  procedure translate_message(
    p_pms_name in pit_message.pms_name%TYPE,
    p_pms_text in pit_message.pms_text%TYPE,
    p_pms_pml_name in pit_message_language.pml_name%TYPE,
    p_pms_description in pit_message.pms_description%TYPE default null)
  as
    l_pms_pse_id pit_message.pms_pse_id%TYPE;
    l_error_number pit_message.pms_custom_error%TYPE;
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
      raise_application_error(C_MAX_ERROR, replace(C_MESSAGE_DOES_NOT_EXIST, '#MESSAGE#', p_pms_name));
  end translate_message;
  
  
  procedure create_translation_xml(
    p_target_language in pit_message_language.pml_name%TYPE,
    p_pmg_name in pit_message_group.pmg_name%TYPE default null,
    p_target in varchar2,
    p_file_name out nocopy pit_util.ora_name_type,
    p_xliff out nocopy xmltype)
  as
  begin

    case p_target
      when C_TARGET_PMS then
        p_file_name := 'MessageTranslation_' || p_pmg_name || '_to_' || p_target_language || '.xlf';
        p_xliff := get_pms_xml(p_target_language, p_pmg_name);
      when C_TARGET_PTI then
        p_file_name := 'TranslatableItemsTranslation_' || p_pmg_name || '_to_' || p_target_language || '.xlf';
        p_xliff := get_pti_xml(p_target_language, p_pmg_name);
      else
        null;
    end case;

    -- Wrap xml in XLIFF envelope
    with params as(
           select replace(utl_i18n.map_locale_to_iso(g_default_language, null), '_', '-') source_iso_language,
                  replace(utl_i18n.map_locale_to_iso(p_target_language, null), '_', '-') target_iso_language,
                  g_default_language source_language,
                  p_target_language target_language,
                  C_XLIFF_NS xmlns,
                  p_file_name file_name,
                  p_pmg_name pmg_name
             from dual)
    select xmlelement("xliff",
             xmlattributes(
               '2.0' "version",
               xmlns "xmlns",
               source_iso_language "srcLang",
               target_iso_language "trgLang"
             ),
             xmlelement("file",
               xmlattributes(
                 file_name "original",
                 pmg_name "id"
               ),
               p_xliff
             )
           )
      into p_xliff
      from params;
      
  end create_translation_xml;
  
  
  procedure apply_translation(
    p_xliff in xmltype,
    p_target in varchar2)
  as
  begin
  
    case p_target
    when C_TARGET_PMS then
      translate_messages(p_xliff);
    when C_TARGET_PTI then
      translate_translatable_items(p_xliff);
    else
      null;
    end case;
  end apply_translation;
  
  
  procedure delete_translation(
    p_pml_name in pit_message_language.pml_name%TYPE,
    p_target in varchar2)
  as
  begin
    case p_target
      when C_TARGET_PMS then
        delete from pit_message
         where pms_pml_name = upper(p_pml_name);
      when C_TARGET_PTI then
        delete from pit_translatable_item
         where pti_pml_name = upper(p_pml_name);
      else
        null;
    end case;
  end delete_translation;
  
  
  procedure register_translation(
    p_pml_name in pit_message_language.pml_name%TYPE)
  as
  begin
    update pit_message_language
       set pml_default_order = 50
     where pml_name = p_pml_name
       and pml_default_order = 0;
    
  end register_translation;
  
  
begin
  initialize;
end pit_admin;
/
