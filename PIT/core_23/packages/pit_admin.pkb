create or replace package body pit_admin
as

  /**
    Package: PIT_ADMIN Body
      Implements PIT administration methods

    Author::
      Juergen Sieben, ConDeS GmbH

      Published under MIT licence
   */

  /**
    Group: Private type definitions
   */


  /**
    Group: Private constants
   */
  /**
    Constants: Constants
      C_PIT_PARAMETER_GROUP - Parameter group for PIT parameters
      C_CONTEXT_PREFIX - Prefix for context names
      C_TOGGLE_PREFIX - Prefix for toggle names
      C_XLIFF_NS - Namespace of XLIFF
      C_MIN_ERROR - First error number PIT uses for error numbering
      C_MAX_ERROR - Last error number PIT uses for error numbering
      C_FATAL - Level fatal, defined here to avoid dependency on PIT_PKG
      C_ERROR - Level error, defined here to avoid dependency on PIT_PKG
      C_DEFAULT_LANGUAGE - Sort sequence for the default language
   */
  C_PIT_PARAMETER_GROUP constant varchar2(5) := 'PIT';
  C_CONTEXT_PREFIX constant varchar2(30) := 'CONTEXT_';
  C_TOGGLE_PREFIX constant varchar2(30) := 'TOGGLE_';
  C_XLIFF_NS constant varchar2(100) := 'urn:oasis:names:tc:xliff:document:2.0';
  C_DEL char(1 byte) := '|';
  C_MIN_ERROR constant number := -20999;
  C_MAX_ERROR constant number := -20000;
  C_FATAL constant binary_integer := 20;
  C_ERROR constant binary_integer := 30;
  C_DEFAULT_LANGUAGE constant number := 10;
  C_EXCEPTION_PREFIX constant varchar2(4) := '';
  C_EXCEPTION_POSTFIX constant varchar2(4) := 'ERR';

  /**
    Group: Private package variables
   */
  /**
    Variables: Package variables
      g_predefined_errors - List of predefined errors found in existing packages
      g_default_language - ORacle name of the default language
   */
  g_default_language pit_util.ora_name_type;


  -- ERROR messages
  C_ERROR_ALREADY_ASSIGNED constant varchar2(200) := 'This Oracle error number is already assigned to message #ERRNO#';
  C_MESSAGE_DOES_NOT_EXIST constant varchar2(200) := 'Message #MESSAGE# does not exist.';


  /**
    Group: Generic helper methods
   */


  /**
    Procedure: check_error
      Helper to check whether a predefined Oracle error is to be overwritten.

      Is called whenever a new message is inserted into table MESSAGE with an Oracle error number.
      The function checks whether the Oracle error number is already a named error, such as -1 and DUP_VAL_ON_INDEX.
      If so, the procedure throws an error.

    Limitation:
      This procedure can only see Exceptions that are defined in packages from SYSTEM or SYS and only
      exceptions from non wrapped sources.

    Parameters:
      p_row - Record of <PIT_MESSAGE>
   */
  procedure check_error(
    p_row pit_message%rowtype)
  as
    l_predefined_error pit_util.predefined_error_rec;
    l_message varchar2(2000);
    l_message_length binary_integer;
    C_MSG_TOO_LONG constant varchar2(200) :=
      q'~Message "#MESSAGE#" must not exceed 26 chars but is #LENGTH#.~';
    C_ERROR_MUST_BE_NEGATIVE constant varchar2(200) :=
      q'~Predefined error numbers must be negative.~';
    C_PREDEFINED_ERROR constant varchar2(200) :=
      q'~Error number #ERROR# is a predefined Oracle error named #NAME# in #OWNER#.#PKG#. Please don't overwrite Oracle predefined errors.~';
  begin

    l_message_length := length(p_row.pms_name);

    if l_message_length > pit_util.get_max_message_length(p_row.pms_pmg_name) then
      l_message := pit_util.bulk_replace(C_MSG_TOO_LONG, char_table(
                     '#MESSAGE#', p_row.pms_name,
                     '#LENGTH#', l_message_length));
       raise_application_error(-20000, l_message);
    end if;

    if p_row.pms_custom_error >= 0 then
       raise_application_error(-20000, C_ERROR_MUST_BE_NEGATIVE);
    end if;

    l_predefined_error := pit_util.check_error_number_exists(
                            p_pms_name => p_row.pms_name,
                            p_pms_custom_error => p_row.pms_custom_error);

    if l_predefined_error.error_name is not null then
      l_message := pit_util.bulk_replace(C_PREDEFINED_ERROR, char_table(
                     '#ERROR#', p_row.pms_custom_error,
                     '#NAME#', l_predefined_error.error_name,
                     '#OWNER#', l_predefined_error.owner,
                     '#PKG#', l_predefined_error.package_name));
    end if;
  end check_error;


  /**
    Function: get_export_group_script
      Method to create a script snippet for ex- or importing a message group

    Parameter:
      p_pmg_name - Optional name of the message to create a script for. If NULL, all message groups are exported

    Returns:
      Script with a call to <merge_message_group> to import a message group or a list of message groups.
   */
  function get_export_group_script(
    p_pmg_name in pit_message_group.pmg_name%type)
    return varchar2
  as
    cursor message_group_cur(
      p_pmg_name in pit_message_group.pmg_name%type) is
      select pmg_name, pmg_description, pmg_error_prefix, pmg_error_postfix
        from pit_message_group pmg
       where exists(
             select null
               from pit_message
              where pms_pmg_name = pmg_name)
         and pmg_name = p_pmg_name
          or p_pmg_name is null
       order by pmg_name;

    c_merge_group_template constant pit_util.max_sql_char := q'~
  pit_admin.merge_message_group(
    p_pmg_name => '#NAME#',
    p_pmg_description => q'^#DESCRIPTION#^',
    p_pmg_error_prefix => '#ERROR_PREFIX#',
    p_pmg_error_postfix => '#ERROR_POSTFIX#');
~';
    l_chunk pit_util.max_char;
  begin

    for pmg in message_group_cur(p_pmg_name) loop
      l_chunk := l_chunk
              || pit_util.bulk_replace(c_merge_group_template, char_table(
                   '#NAME#', pmg.pmg_name,
                   '#DESCRIPTION#', pmg.pmg_description,
                   '#ERROR_PREFIX#', pmg.pmg_error_prefix,
                   '#ERROR_POSTFIX#', pmg.pmg_error_postfix));
    end loop;
    return l_chunk;
  end get_export_group_script;


  /**
    Procedure: script_messages
      Helper method to generate a message install script. Is called internally by <create_installation_script>

    Parameters:
      p_pmg_name - Message group to filter output
      p_script - Out parameter that contains the SQL script created
   */
  procedure script_messages(
    p_pmg_name in pit_message_group.pmg_name%type,
    p_script out nocopy clob)
  as
    cursor message_cur(
      p_pmg_name in pit_message_group.pmg_name%type) is
      select pms_name, pms_pmg_name, pms_text, pms_description,
             case pms_pse_id
               when 10 then 'pit.LEVEL_FATAL'
               when 20 then 'pit.LEVEL_SEVERE'
               when 30 then 'pit.LEVEL_ERROR'
               when 40 then 'pit.LEVEL_WARN'
               when 50 then 'pit.LEVEL_INFO'
               when 60 then 'pit.LEVEL_DEBUG'
               when 70 then 'pit.LEVEL_ALL'
               else null end pms_pse_id,
             pms_pml_name, pms_custom_error,
             rank() over (partition by pms_name order by pml_default_order) rang
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
                     '#PMS_PSE_ID#', msg.pms_pse_id,
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


  /**
    Procedure: script_translatable_items
      Helper method to generate a translatable items install script.  Is called internally by <create_installation_script>

    Parameters:
      p_pmg_name - Message group to filter output
      p_script - Out parameter that contains the SQL script created
   */
  procedure script_translatable_items(
    p_pmg_name in pit_message_group.pmg_name%type default null,
    p_script out nocopy clob)
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


  /**
    Procedure: analyze_xliff
      Method to extract language and group from an XLIFF envelope. Is used to extract information from an XLIFF header.

    Parameters:
      p_xliff - XLIFF instance
      p_pml_name - Language name converted to Oracle language name
      p_pmg_name - Group name
   */
  procedure analyze_xliff(
    p_xliff xmltype,
    p_pml_name out nocopy pit_message_language.pml_name%type,
    p_pmg_name out nocopy pit_message_group.pmg_name%type)
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


  /**
    Procedure: translate_messages.
      Helper method to extract XLIFF instance into <PIT_MESSAGE>. Is called internally by <apply_translations>.

    Parameter:
      p_xliff - XLIFF instance to apply
   */
  procedure translate_messages(
    p_xliff in xmltype)
  as
    l_pml_name pit_message_language.pml_name%type;
    l_pmg_name pit_message_group.pmg_name%type;
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


  /**
    Procedure: translate_translatable_items
      Helper method to extract XLIFF instance into <PIT_TRANSLATABLE_ITEM>.  Is called internally by <apply_translations>.

    Parameter
      p_xliff - XLIFF instance to apply
   */
  procedure translate_translatable_items(
    p_xliff in xmltype)
  as
    l_pml_name pit_message_language.pml_name%type;
    l_pmg_name pit_message_group.pmg_name%type;
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


  /**
    Function: get_pms_xml
      Help method to generate XLIFF compatible translation entries for messages.
      <Is called internally by get_translation_xml> to allow for different target types.

    Parameters:
      p_target_language - Language to translate the messages to
      p_pmg_name - Message group to tranlsate

    Returns:
      XML fragment to incorporate into an XLIFF envelope generated by <get_translation_xml>
   */
  function get_pms_xml(
    p_target_language in pit_message_language.pml_name%type,
    p_pmg_name in pit_message_group.pmg_name%type default null)
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


  /**
    Function: get_pti_xml
      Help method to generate XLIFF compatible translation entries for translatable items.
      Is called internally by <get_translation_xml> to allow for different target types.

    Parameters:
      p_target_language - Language to translate the translatable items to
      p_pmg_name - Translatable items group to tranlsate

    Returns:
      XML fragment to incorporate into an XLIFF envelope generated by <get_translation_xml>
   */
  function get_pti_xml(
    p_target_language in pit_message_language.pml_name%type,
    p_pmg_name in pit_message_group.pmg_name%type default null)
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


  /**
    Procedure: initialize
      Initialization procedure.

      Called internally. It has the following functionality:

      - Read all predefined oracle errors from the oracle packages
      - Read default language
   */
  procedure initialize
  as
  begin
    if g_default_language is null then
      -- Read default language
      select pml_name default_language
        into g_default_language
        from pit_message_language
       where pml_default_order > 0
       order by pml_default_order
       fetch first 1 rows only;
    end if;
  end initialize;


  /**
    Group: Public administration methods
   */


  /**
    Procedure: set_language_settings
      See <PIT_ADMIN.set_language_settings>
   */
  procedure set_language_settings(
    p_pml_list in pit_util.max_sql_char)
  as
    l_pml_list pit_args;
    l_pml_default_order pit_message_language.pml_default_order%type;
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


  /**
    Procedure: create_message_package
      See <PIT_ADMIN.create_message_package>
   */
  procedure create_message_package (
    p_directory varchar2 default null)
  as
    C_PACKAGE_NAME  constant varchar2(30) := 'msg';
    C_R constant varchar2(2) := chr(10);

    l_sql_text clob := 'create or replace package ' || C_PACKAGE_NAME || ' as' || C_R || '  /** Generated package to provide message constants and exceptions*/' || C_R;
    l_constant_template pit_util.max_sql_char :=
      q'~  #CONSTANT# constant pit_util.ora_name_type := '#CONSTANT#';~' || C_R;
    l_exception_template pit_util.max_sql_char :=
      '  #ERROR_NAME# exception;' || C_R;
    l_pragma_template pit_util.max_sql_char :=
      '  pragma exception_init(#ERROR_NAME#, #ERROR#);' || C_R;
    l_end_clause pit_util.max_sql_char := q'[

  function get_messages(
    p_pmg_name in pit_message_group.pmg_name%type default null)
    return char_table
    pipelined;

  function check_is_message(
    p_message_name in pit_message.pms_id%type default null)
    return boolean;

  function check_is_error(
    p_message_name in pit_message.pms_id%type default null)
    return boolean;

end ]' || C_PACKAGE_NAME || ';';

    l_constants clob := C_R || '  -- CONSTANTS:' || C_R;
    l_exceptions clob := C_R || '  -- EXCEPTIONS:' || C_R;
    l_pragmas clob := C_R || '  -- EXCEPTION INIT:' || C_R;

    cursor message_cur is
        with messages as(
             select pms_name,
                    case pms_custom_error when C_MAX_ERROR then pms_active_error else pms_custom_error end pms_custom_error,
                    case when pmg_error_prefix is not null  then pmg_error_prefix || '_' end ||
                    pms_name ||
                    case when pmg_error_postfix is not null then '_' || pmg_error_postfix end pms_error_name
               from pit_message m
               join pit_message_group
                 on pms_pmg_name = pmg_name
              where pms_pml_name = g_default_language)
      select replace(l_constant_template, '#CONSTANT#', pms_name) constant_chunk,
             case when pms_custom_error is not null then
               replace (l_exception_template, '#ERROR_NAME#', pms_error_name)
             else null end exception_chunk,
             case when pms_custom_error is not null then
               replace(replace(l_pragma_template, '#ERROR_NAME#', pms_error_name), '#ERROR#', pms_custom_error)
             else null end pragma_chunk
        from messages
       order by pms_name;

  begin
    -- persist active error numbers for all errors in message table
    merge into pit_message m
    using (select pms_name, pms_pml_name, C_MIN_ERROR - 1 + dense_rank() over (order by pms_name) pms_active_error
             from pit_message
            where pms_pse_id <= 30
              and pms_custom_error = C_MAX_ERROR
           union all
           select pms_name, pms_pml_name, pms_custom_error
             from pit_message
            where pms_pse_id <= 30
              and pms_custom_error != C_MAX_ERROR) v
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


  /**
    Function: get_message_text
      See <PIT_ADMIN.get_message_text>
   */
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


  /**
    Group: Public message maintenance methods
   */
  /**
    Procedure: validate_message_group
      See <PIT_ADMIN.validate_message_group>
   */
  procedure validate_message_group(
    p_row in out nocopy pit_message_group%rowtype)
  as
  begin
    null;
  end validate_message_group;


  /**
    Procedure: merge_message_group
      See <PIT_ADMIN.merge_message_group>
   */
  procedure merge_message_group(
    p_pmg_name in pit_message_group.pmg_name%type,
    p_pmg_description in pit_message_group.pmg_description%type default null,
    p_pmg_error_prefix in pit_message_group.pmg_error_prefix%type default null,
    p_pmg_error_postfix in pit_message_group.pmg_error_postfix%type default null)
  as
    l_row pit_message_group%rowtype;
  begin
    l_row.pmg_name := p_pmg_name;
    l_row.pmg_description := p_pmg_description;
    l_row.pmg_error_prefix := coalesce(p_pmg_error_prefix, C_EXCEPTION_PREFIX);
    l_row.pmg_error_postfix := coalesce(p_pmg_error_postfix, C_EXCEPTION_POSTFIX);

    merge_message_group(l_row);
  end merge_message_group;


  /**
    Procedure: merge_message_group
      See <PIT_ADMIN.merge_message_group>
   */
  procedure merge_message_group(
    p_row in out nocopy pit_message_group%rowtype)
  as
  begin
    -- Initialization
    p_row.pmg_name := pit_util.harmonize_sql_name(p_row.pmg_name);

    validate_message_group(p_row);

    merge into pit_message_group t
    using (select p_row.pmg_name pmg_name,
                  p_row.pmg_description pmg_description,
                  p_row.pmg_error_prefix pmg_error_prefix,
                  p_row.pmg_error_postfix pmg_error_postfix
             from dual) s
       on (t.pmg_name = s.pmg_name)
     when matched then update set
          t.pmg_description = s.pmg_description,
          t.pmg_error_prefix = s.pmg_error_prefix,
          t.pmg_error_postfix = s.pmg_error_postfix
     when not matched then insert(pmg_name, pmg_description, pmg_error_prefix, pmg_error_postfix)
          values(s.pmg_name, s.pmg_description, s.pmg_error_prefix, s.pmg_error_postfix);
  end merge_message_group;


  /**
    Procedure: delete_message_group
      See <PIT_ADMIN.delete_message_group>
   */
  procedure delete_message_group(
    p_pmg_name in pit_message_group.pmg_name%type,
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


  /**
    Procedure: validate_message
      See <PIT_ADMIN.validate_message>
   */
  procedure validate_message(
    p_row in out nocopy pit_message%rowtype)
  as
  begin

    case
    when p_row.pms_pse_id in (C_FATAL, C_ERROR) and p_row.pms_custom_error not between C_MIN_ERROR and C_MAX_ERROR then
      check_error(p_row);
    when p_row.pms_pse_id in (C_FATAL, C_ERROR) then
      p_row.pms_custom_error := C_MAX_ERROR;
    else
      null;
    end case;

  end validate_message;


  /**
    Procedure: merge_message
      See <PIT_ADMIN.merge_message>
   */
  procedure merge_message(
    p_pms_name in pit_message.pms_name%type,
    p_pms_text in pit_message.pms_text%type,
    p_pms_pse_id in pit_message.pms_pse_id%type,
    p_pms_description in pit_message.pms_description%type default null,
    p_pms_pmg_name in pit_message_group.pmg_name%type default null,
    p_pms_pml_name in pit_message_language.pml_name%type default null,
    p_error_number in pit_message.pms_custom_error%type default null)
  as
    l_row pit_message%rowtype;
  begin
    l_row.pms_name := p_pms_name;
    l_row.pms_text := p_pms_text;
    l_row.pms_pse_id := p_pms_pse_id;
    l_row.pms_description := p_pms_description;
    l_row.pms_pmg_name := p_pms_pmg_name;
    l_row.pms_pml_name := p_pms_pml_name;
    l_row.pms_custom_error := p_error_number;

    merge_message(l_row);
  end merge_message;


  /**
    Procedure: merge_message
      See <PIT_ADMIN.merge_message>
   */
  procedure merge_message(
    p_row in out nocopy pit_message%rowtype)
  as
  begin
    -- Initialization
    p_row.pms_name := pit_util.harmonize_sql_name(p_row.pms_name);

    validate_message(p_row);

    merge into pit_message t
    using (select p_row.pms_name pms_name,
                  upper(coalesce(p_row.pms_pml_name, g_default_language)) pms_pml_name,
                  upper(p_row.pms_pmg_name) pms_pmg_name,
                  p_row.pms_text pms_text,
                  p_row.pms_description pms_description,
                  p_row.pms_pse_id pms_pse_id,
                  p_row.pms_custom_error pms_custom_error
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
        into p_row.pms_name
        from pit_message
       where pms_custom_error = p_row.pms_custom_error
         and rownum = 1;
      rollback;
      raise_application_error(C_MAX_ERROR, replace(C_ERROR_ALREADY_ASSIGNED, '#ERRNO#', p_row.pms_name));
    when others then
      rollback;
        raise;
  end merge_message;


  /**
    Procedure: delete_message
      See <PIT_ADMIN.delete_message>
   */
  procedure delete_message(
    p_pms_name in pit_message.pms_name%type,
    p_pms_pml_name in pit_message_language.pml_name%type)
  as
  begin
    delete from pit_message
     where pms_name = upper(p_pms_name)
       and (pms_pml_name = upper(p_pms_pml_name)
        or p_pms_pml_name is null);
  end delete_message;


  /**
    Procedure: delete_all_messages
      See <PIT_ADMIN.delete_all_messages>
   */
  procedure delete_all_messages(
    p_pmg_name in pit_message_group.pmg_name%type default null)
  as
  begin
    delete from pit_message
     where pms_pmg_name = p_pmg_name
        or p_pmg_name is null;
  end delete_all_messages;



  /**
    Procedure: translate_message
      See <PIT_ADMIN.translate_message>
   */
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
      raise_application_error(C_MAX_ERROR, replace(C_MESSAGE_DOES_NOT_EXIST, '#MESSAGE#', p_pms_name));
  end translate_message;


  /**
    Group: Public translatable items maintenance methods
   */
  /**
    Procedure: validate_translatable_item
      See <PIT_ADMIN.validate_translatable_item>
   */
  procedure validate_translatable_item(
    p_row in pit_translatable_item%rowtype)
  as
  begin
    null;
  end validate_translatable_item;


  /**
    Procedure: merge_translatable_item
      See <PIT_ADMIN.merge_translatable_item>
   */
  procedure merge_translatable_item(
    p_row in out nocopy pit_translatable_item%rowtype)
  as
  begin
    -- Initialize
    p_row.pti_id := pit_util.harmonize_sql_name(p_row.pti_id);

    validate_translatable_item(p_row);

    merge into pit_translatable_item t
    using (select p_row.pti_id pti_id,
                  coalesce(p_row.pti_pml_name, g_default_language) pti_pml_name,
                  p_row.pti_pmg_name pti_pmg_name,
                  p_row.pti_name pti_name,
                  p_row.pti_display_name pti_display_name,
                  p_row.pti_description pti_description
             from dual) s
       on (t.pti_id = s.pti_id
       and t.pti_pml_name = s.pti_pml_name
       and t.pti_pmg_name = s.pti_pmg_name)
      when matched then update set
           t.pti_name = s.pti_name,
           t.pti_display_name = s.pti_display_name,
           t.pti_description = s.pti_description
      when not matched then insert(pti_id, pti_pmg_name, pti_pml_name, pti_name, pti_display_name, pti_description)
           values(s.pti_id, s.pti_pmg_name, s.pti_pml_name, s.pti_name, s.pti_display_name, s.pti_description);
  end merge_translatable_item;


  /**
    Procedure: merge_translatable_item
      See <PIT_ADMIN.merge_translatable_item>
   */
  procedure merge_translatable_item(
    p_pti_id in pit_translatable_item.pti_id%type,
    p_pti_pml_name in pit_message_language.pml_name%type,
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_name in pit_translatable_item.pti_name%type,
    p_pti_display_name pit_translatable_item.pti_display_name%type default null,
    p_pti_description pit_translatable_item.pti_description%type default null)
  as
    l_row pit_translatable_item%rowtype;
  begin
    l_row.pti_id := p_pti_id;
    l_row.pti_pml_name := p_pti_pml_name;
    l_row.pti_pmg_name := p_pti_pmg_name;
    l_row.pti_name := p_pti_name;
    l_row.pti_display_name := p_pti_display_name;
    l_row.pti_description := p_pti_description;

    merge_translatable_item(l_row);
  end merge_translatable_item;


  /**
    Procedure: delete_translatable_item
      See <PIT_ADMIN.delete_translatable_item>
   */
  procedure delete_translatable_item(
    p_pti_id in pit_translatable_item.pti_id%type,
    p_pti_pmg_name in pit_message_group.pmg_name%type)
  as
  begin
    delete from pit_translatable_item
     where pti_id = p_pti_id
       and pti_pmg_name = p_pti_pmg_name;
  end delete_translatable_item;


  /**
    Group: Public context maintenanace methods
   */
  /**
    Procedure: create_context_toggle
      See <PIT_ADMIN.create_context_toggle>
   */
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
      p_par_pgr_id => C_PIT_PARAMETER_GROUP,
      p_par_description => p_comment,
      p_par_string_value => upper(p_module_list || C_DEL || l_context_name));
  end create_context_toggle;


  /**
    Procedure: delete_context_toggle
      See <PIT_ADMIN.delete_context_toggle>
   */
  procedure delete_context_toggle(
    p_toggle_name in varchar2)
  as
  begin
    param_admin.delete_parameter(
      p_par_id => C_TOGGLE_PREFIX || replace(upper(p_toggle_name), C_TOGGLE_PREFIX),
      p_par_pgr_id => C_PIT_PARAMETER_GROUP);
  end delete_context_toggle;


  /**
    Procedure: create_named_context
      See <PIT_ADMIN.create_named_context>
   */
  procedure create_named_context(
    p_context_name in varchar2,
    p_log_level in number,
    p_trace_level in number,
    p_trace_timing in boolean,
    p_module_list in varchar2,
    p_comment in varchar2 default null)
  as
    l_trace_timing pit_util.ora_name_type;
    l_settings pit_util.max_sql_char;
  begin
    l_trace_timing := case when p_trace_timing then 'true' else 'false' end;
    l_settings := pit_util.concatenate(
                    p_chunk_list => char_table(p_log_level, p_trace_level, l_trace_timing, p_module_list),
                    p_delimiter => C_DEL);
    create_named_context(
      p_context_name => p_context_name,
      p_settings => l_settings,
      p_comment => p_comment);
  end create_named_context;


  /**
    Procedure: create_named_context
      See <PIT_ADMIN.create_named_context>
   */
  procedure create_named_context(
    p_context_name in varchar2,
    p_settings in varchar2,
    p_comment in varchar2 default null)
  as
    c_standard_comment constant varchar2(200) := ' [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (true,false)|MODULE_LIST]';
  begin

    pit_util.check_context_settings(
      p_context_name => p_context_name,
      p_settings => p_settings);

    -- Create parameter
    param_admin.edit_parameter(
      p_par_id => pit_util.harmonize_name(C_CONTEXT_PREFIX, p_context_name),
      p_par_pgr_id => C_PIT_PARAMETER_GROUP,
      p_par_description => replace(p_comment, c_standard_comment) || c_standard_comment,
      p_par_string_value => upper(p_settings));
  end create_named_context;


  /**
    Procedure: delete_named_context
      See <PIT_ADMIN.delete_named_context>
   */
  procedure delete_named_context(
    p_context_name in varchar2)
  as
  begin
    param_admin.delete_parameter(
      p_par_id => C_CONTEXT_PREFIX || replace(upper(p_context_name), C_CONTEXT_PREFIX),
      p_par_pgr_id => C_PIT_PARAMETER_GROUP);
  end delete_named_context;


  /**
    Group: Public export and translation methods
   */
  /**
    Procedure: create_installation_script
      See <PIT_ADMIN.create_installation_script>
   */
  procedure create_installation_script(
    p_pmg_name in pit_message_group.pmg_name%type,
    p_target in varchar2,
    p_script out nocopy clob,
    p_target_language in pit_message_language.pml_name%type default null)
  as
  begin

    case p_target
    when C_TARGET_PMS then
      script_messages(p_pmg_name, p_script);
    when C_TARGET_PTI then
      script_translatable_items(p_pmg_name, p_script);
    when C_TARGET_PAR then
      p_script := param_admin.export_parameter_group(p_pmg_name);
    else
      null;
    end case;
  end create_installation_script;


  /**
    Function: get_installation_script
      See <PIT_ADMIN.get_installation_script>
   */
  function get_installation_script(
    p_pmg_name in pit_message_group.pmg_name%type,
    p_target in varchar2)
    return clob
  as
    l_script clob;
  begin
    create_installation_script(
      p_pmg_name => p_pmg_name,
      p_target => p_target,
      p_script => l_script);
    return l_script;
  end get_installation_script;


  /**
    Procedure: create_translation_xml
      See <PIT_ADMIN.create_translation_xml>
   */
  procedure create_translation_xml(
    p_target_language in pit_message_language.pml_name%type,
    p_pmg_name in pit_message_group.pmg_name%type default null,
    p_target in varchar2,
    p_file_name in pit_util.ora_name_type,
    p_xliff out nocopy xmltype)
  as
  begin

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
    select xmlroot(
             xmlelement("xliff",
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
             ),
             version '1.0', standalone yes
           )
      into p_xliff
      from params;

  end create_translation_xml;


  /**
    Function: get_translation_xml
      See <PIT_ADMIN.get_translation_xml>
   */
  function get_translation_xml(
    p_target_language in pit_message_language.pml_name%type,
    p_pmg_name in pit_message_group.pmg_name%type default null,
    p_target in varchar2)
    return clob
  as
    l_xliff xmltype;
    l_file_name pit_util.ora_name_type;
  begin
    create_translation_xml(
      p_target_language => p_target_language,
      p_pmg_name => p_pmg_name,
      p_target => p_target,
      p_file_name => l_file_name,
      p_xliff => l_xliff);
    return l_xliff.getClobVal();
  end get_translation_xml;


  /**
    Procedure: apply_translation
      See <PIT_ADMIN.apply_translation>
   */
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


  /**
    Procedure: delete_translation
      See <PIT_ADMIN.delete_translation>
   */
  procedure delete_translation(
    p_pml_name in pit_message_language.pml_name%type,
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


  /**
    Procedure: register_translation
      See <PIT_ADMIN.register_translation>
   */
  procedure register_translation(
    p_pml_name in pit_message_language.pml_name%type)
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