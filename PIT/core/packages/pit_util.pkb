create or replace package body pit_util
as

  /**** CONSTANTS ****/
  C_PKG constant ora_name_type := $$PLSQL_UNIT;
  C_NAME_TOO_LONG constant varchar2(200) := 'Toggle name is too long. Please use a maximum of #MAX_LENGTH# byte';
  C_WRONG_PATTERN constant varchar2(2000) := '#WHAT# not correct. Please use a valid format as described in the documentation. Checked: #PATTERN#';
  
  C_PARAMETER_GROUP constant varchar2(5) := 'PIT';
  C_NAME_SPELLING constant pit_util.ora_name_type := 'NAME_SPELLING';
    
  /**** GLOBAL VARS ****/
  g_user ora_name_type;
  g_error_prefix varchar2(5 byte);
  g_error_postfix varchar2(5 byte);
  g_call_stack_template varchar2(1000 byte);
  g_error_stack_template varchar2(1000 byte);
  g_omit_pit_in_stack boolean;
  g_name_spelling varchar2(10 byte);
  
  /**** HELPER ****/
  /** Method to append P_CHUNK to P_TEXT */
  procedure append(
    p_text in out nocopy varchar2,
    p_chunk in varchar2)
  as
  begin
    p_text := p_text || p_chunk || chr(10);
  end append;
  
  
  /* Harmonizes the spelling of database names etc.
   * @usage  Is used to harmonize the spelling of names. Conversion is based on parameter PIT.NAME_SPELLING
   * @param  p_name  Name to harmonize
   * @return Harmonized name
   */
  function harmonize_name(
    p_name in varchar2)
    return varchar2
  as
  begin
    case g_name_spelling
      when 'LOWER' then
        return lower(p_name);
      when 'UPPER' then
        return upper(p_name);
      else
        return p_name;
      end case;
  end harmonize_name;
  
  
  /** Helper to decide whether a subprogram has to be ignored due to parameter settings
   * @param  p_subprogram  Method to check
   * @return Flag to indicate whether a subprogram has to be ignored (TRUE) or not (FALSE)
   */
  function ignore_subprogram(
    p_subprogram in varchar2)
    return boolean
  as
    l_ignore boolean := false;
  begin
    if g_omit_pit_in_stack then
      l_ignore := p_subprogram like 'PIT%' and p_subprogram != 'PIT_UI_PKG';
    end if;
    return l_ignore;
  end ignore_subprogram;
  
  
  /** Package Initialization */
  procedure initialize
  as
    l_prefix_length binary_integer;
  begin
    -- set package vars
    g_user := user;
    g_error_prefix := param.get_string('ERROR_PREFIX', C_PARAMETER_GROUP);
    if g_error_prefix is not null then
      g_error_prefix := g_error_prefix || '_';
    end if;
    g_error_postfix := param.get_string('ERROR_POSTFIX', C_PARAMETER_GROUP);
    if g_error_postfix is not null then
      g_error_postfix := '_' || g_error_postfix;
    end if;
    
    g_call_stack_template := param.get_string('PIT_CALL_STACK_TEMPLATE', C_PARAMETER_GROUP);
    g_error_stack_template := param.get_string('PIT_ERROR_STACK_TEMPLATE', C_PARAMETER_GROUP);
    g_omit_pit_in_stack := param.get_boolean('OMIT_PIT_IN_STACK', C_PARAMETER_GROUP);
    g_name_spelling := param.get_string(C_NAME_SPELLING, C_PARAMETER_GROUP);
    
    l_prefix_length := coalesce(length(g_error_prefix), 0) + coalesce(length(g_error_postfix), 0);
    case when l_prefix_length > 4 then
      raise_application_error(-20000, 'Length of Prefix and Postfix together may not exceed 2 characters or each may not exceed 3 characters when used alone.');
    when l_prefix_length = 0 then
      raise_application_error(-20000, 'At least one of Error and Postfix-Prefix has to be defined.');
    else 
      null;
    end case;
  end initialize;
  
  
  /**** INTERFACE ****/
  function get_true
    return flag_type
  as
  begin
    return C_TRUE;
  end get_true;
  
  
  function get_false
    return flag_type
  as
  begin
    return C_FALSE;
  end get_false;
  
  
  function get_user
    return ora_name_type
  as
  begin
    return g_user;
  end get_user;
  
  
  /**** TEXT FUNCTIONS ****/
  function string_to_table(
    p_string_value in varchar2,
    p_delimiter in varchar2 := ':')
    return args
  as
    l_args args := args();
  begin
    if p_string_value is not null then
      for i in 1 .. regexp_count(p_string_value, '\' || p_delimiter) + 1 loop
        l_args.extend;
        l_args(i) := regexp_substr(p_string_value, '[^\' || p_delimiter || ']+', 1, i);
      end loop;
    end if;
    return l_args;
  end string_to_table;
  
  
  function bulk_replace(
    p_string in varchar2,
    p_chunks in char_table)
    return varchar2
  as
    l_string max_char := p_string;
  begin
    for i in p_chunks.first .. p_chunks.last loop
      if mod(i, 2) = 1 then
        l_string := replace(l_string, p_chunks(i), p_chunks(i+1));
      end if;
    end loop;
    return l_string;
  end bulk_replace;


  procedure clob_append(
    p_clob in out nocopy clob,
    p_chunk in clob)
  as
  begin
    if p_chunk is not null then
      if p_clob is null then
        dbms_lob.createtemporary(p_clob, false, dbms_lob.call);
      end if;
      dbms_lob.append(p_clob, p_chunk);
    end if;
  end clob_append;
  
  
  function concatenate(
    p_chunk_list char_table,
    p_delimiter varchar2,
    p_keep_null boolean default true)
    return varchar2
  as
    l_result max_char;
  begin
    for i in p_chunk_list.first .. p_chunk_list.last loop
      if i > 1 and (p_chunk_list(i) is not null or p_keep_null) then
        l_result := l_result || p_delimiter;
      end if;
      l_result := l_result || p_chunk_list(i);
    end loop;
    return l_result;
  end concatenate;
  
  
  function harmonize_sql_name(
    p_name in varchar2,
    p_prefix in varchar2 default null,
    p_max_length number default null)
    return varchar2
  as
    l_name max_sql_char;
  begin
    if p_max_length is not null then
      if length(p_name) > p_max_length then
        raise_application_error(-20000, replace(C_MAX_LENGTH, '#MAX_LENGTH#', p_max_length));
      end if;
    end if;
    
    l_name := upper(replace(p_name, ' ', '_'));
    l_name := replace(replace(replace(replace(l_name, 
                'Ü', 'UE'),
                'Ä', 'AE'),
                'Ö', 'OE'),
                'ß', 'SS');
    l_name := regexp_replace(l_name, '[^0-9A-Za-z_#]', '');
    if p_prefix is not null and substr(l_name, 1, length(p_prefix)) != p_prefix then
      l_name := p_prefix || l_name;
    end if;
    l_name := substr(ltrim(l_name, '#_'), 1, C_MAX_LENGTH);
    l_name := dbms_assert.simple_sql_name(l_name);
    return l_name;
  end harmonize_sql_name;
  
  
  function harmonize_name(
    p_prefix in varchar2,
    p_name in varchar2)
    return varchar2
  as
    l_harmonized_name max_sql_char;
  begin
    l_harmonized_name := p_name;
    if substr(upper(p_name), 1, length(p_prefix)) != upper(p_prefix) then
      l_harmonized_name := p_prefix || l_harmonized_name;
    end if;
    return upper(l_harmonized_name);
  end harmonize_name;
  
  
  function to_bool(
    p_boolean in boolean)
    return flag_type
  as
    l_result flag_type;
  begin
    if p_boolean is not null then
      if p_boolean then
        l_result := C_TRUE;
      else
        l_result := C_FALSE;
      end if;
    end if;
    return l_result;
  end to_bool;
  
  
  function to_bool(
    p_boolean in flag_type)
    return boolean
  as
  begin
    return p_boolean = C_TRUE;
  end to_bool;
  
  
  function get_error_name(
    p_pms_name in pit_message.pms_name%type)
    return varchar2
  as
  begin
    return g_error_prefix || p_pms_name || g_error_postfix;
  end get_error_name;


  function cast_to_char_list(
    p_msg_args msg_args)
    return msg_args_char
  as
    l_msg_args msg_args_char := msg_args_char();
  begin
    if p_msg_args is not null then
      for i in p_msg_args.first .. p_msg_args.last loop
        l_msg_args.extend;
        l_msg_args(i) := dbms_lob.substr(p_msg_args(i), 4000, 1);
      end loop;
    end if;
    return l_msg_args;
  end cast_to_char_list;
  
  
  /**** VALIDATION ****/
  procedure check_context_settings(
    p_context_name in ora_name_type,
    p_settings in varchar2)
  as
    C_SETTING_REGEX constant varchar2(200) := '^(((10|20|30|40|50|60|70)\|(10|20|30|40|50)\|(Y|N)\|[A-Z_]+(\:[A-Z_]+)*)|(10\|10\|N\|))$';
  begin
    -- context name must not be longer than 10 byte under C_MAX_LENGTH
    if length(p_context_name) > C_MAX_LENGTH - 10 then 
      raise_application_error(-20000, replace(C_NAME_TOO_LONG, '#MAX_LENGTH#', C_MAX_LENGTH - 10));
    end if;
    -- check context pattern
    if not regexp_like(upper(p_settings), C_SETTING_REGEX) then
      raise_application_error(
        -20000, 
        pit_util.bulk_replace(
          C_WRONG_PATTERN, char_table(
          '#WHAT#', 'Settings are',
          '#PATTERN#', p_settings)));
    end if;
  end check_context_settings;
  
  
  procedure check_toggle_settings(
    p_toggle_name in ora_name_type,
    p_module_list in varchar2,
    p_context_name in ora_name_type)
  as
    C_CONTEXT_PREFIX constant ora_name_type := 'CONTEXT_';
    C_TOGGLE_PREFIX constant ora_name_type := 'TOGGLE_';
    l_toggle_name max_sql_char;
    l_context_name ora_name_type;
    l_exists flag_type;
  begin
    -- Harmonize names
    l_toggle_name := harmonize_sql_name(p_toggle_name, C_TOGGLE_PREFIX);
    l_context_name := harmonize_sql_name(p_context_name, C_CONTEXT_PREFIX);
    
    select C_TRUE
      into l_exists
      from parameter_tab
     where par_id = l_context_name
       and par_pgr_id = C_PARAMETER_GROUP;
       
  exception
    when no_data_found then
      raise context_missing;
  end check_toggle_settings;
  
  
  procedure recompile_invalid_objects
  as
    -- Constants
    C_COMPILE_ERROR constant varchar2(200) := 'Error when compiling #TYPE# #OWNER#.#NAME#: #ERROR#';
    C_INVALID_OBJECT constant varchar2(200) := 'Invalid: #TYPE# #OWNER#.#NAME#';
    C_COMPILED constant varchar2(200) := '#TYPE# #OWNER#.#NAME# compiled';
    C_TYPE constant ora_name_type := 'TYPE';
    C_TYPE_BODY constant ora_name_type := 'TYPE BODY';
    C_PACKAGE constant ora_name_type := 'PACKAGE';
    C_PACKAGE_BODY constant ora_name_type := 'PACKAGE BODY';
    C_RECOMPILE_STMT constant varchar2(1000) := q'^alter #TYPE# #OWNER#.#NAME# compile #POSTFIX#^';
    C_MAX_COMPILE_RUNS constant binary_integer := 3;

    -- Variables
    l_stmt varchar2(1000);
    l_index binary_integer;
    l_no binary_integer;

    -- Exceptions
    compilation_error exception;
    pragma exception_init(compilation_error, -24344);

    -- Cursors
    cursor invalid_objects_cur is
      select distinct obj.owner, obj.object_name, obj.object_type, count(*) over () cnt,
             case obj.object_type
             when C_TYPE then 1
             when C_TYPE_BODY then 2
             when C_PACKAGE then 3
             when C_PACKAGE_BODY then 4
             else 5 end recompile_order,
             case when obj.object_type in (C_TYPE_BODY, C_PACKAGE_BODY) then 'body'
             end recompile_postfix
        from all_dependencies dep
        join all_objects obj
          on dep.type = obj.object_type
         and dep.name = obj.object_name
       where obj.status != 'VALID'
         and obj.owner = sys_context('USERENV', 'CURRENT_SCHEMA')
         and obj.object_name != C_PKG
       order by obj.object_name, recompile_order;
  begin
    l_index := dbms_application_info.set_session_longops_nohint;
    for i in 1 .. C_MAX_COMPILE_RUNS loop
      dbms_output.put_line('compile Run ' || i);
      for obj in invalid_objects_cur loop
        l_stmt := pit_util.bulk_replace(C_RECOMPILE_STMT, char_table(
                    '#OWNER#', obj.owner,
                    '#TYPE#', replace(obj.object_type, ' BODY'),
                    '#NAME#', obj.object_name,
                    '#POSTFIX#', obj.recompile_postfix));
        dbms_application_info.set_session_longops(
          l_index, l_no, 'Compiling ' || obj.object_type || obj.object_name, 0, 0, i, obj.cnt);
        if i < C_MAX_COMPILE_RUNS then
          begin
            execute immediate l_stmt;
            dbms_output.put_line(
              pit_util.bulk_replace(C_COMPILED, char_table(
                '#TYPE#', obj.object_type,
                '#OWNER#', obj.owner,
                '#NAME#', obj.object_name)));
          exception
            when compilation_error then
              null;
            when others then
              dbms_output.put_line(
                pit_util.bulk_replace(C_COMPILE_ERROR, char_table(
                  '#TYPE#', obj.object_type,
                  '#OWNER#', obj.owner,
                  '#NAME#', obj.object_name,
                  '#ERROR#', sqlerrm)));
          end;
        else
          dbms_output.put_line(
            pit_util.bulk_replace(C_INVALID_OBJECT, char_table(
              '#TYPE#', obj.object_type,
              '#OWNER#', obj.owner,
              '#NAME#', obj.object_name)));
        end if;
      end loop;
    end loop;
  end recompile_invalid_objects;
  

  procedure get_module_and_action(
    p_module in out nocopy varchar2,
    p_action in out nocopy varchar2)
  as
    $IF dbms_db_version.ver_le_11 $THEN
    $ELSE
    l_depth binary_integer;
    $END
  begin
    $IF dbms_db_version.ver_le_11 $THEN
    null;
    $ELSE
    if p_action is null or p_module is null then
      l_depth := utl_call_stack.dynamic_depth;
      for i in 1 .. l_depth loop
        if not ignore_subprogram(utl_call_stack.subprogram(i)(1)) then
          l_depth := i;
          exit;
        end if;
      end loop;
      -- Get actual unit name and try to find it in stack. If found, pop all entries including this one
      begin
        p_action := harmonize_name(utl_call_stack.subprogram(l_depth)(2));
        p_module := harmonize_name(utl_call_stack.subprogram(l_depth)(1));
      exception
        when others then
          p_action := harmonize_name(null, utl_call_stack.subprogram(l_depth)(1));
      end;
    end if;
    $END
  end get_module_and_action;
  
  
  function get_call_stack
    return varchar2
  as
    l_depth binary_integer;
    l_stack max_char;
  begin
    $IF dbms_db_version.ver_le_11 $THEN
    return dbms_utility.format_call_stack;
    $ELSE
    l_depth := utl_call_stack.dynamic_depth;
    
    append(l_stack, g_call_stack_template);
    
    for i in 1 .. l_depth loop
      if not ignore_subprogram(utl_call_stack.subprogram(i)(1)) then
        append(l_stack,
          lpad(to_char(utl_call_stack.unit_line(i), 'fm99999999'), 7) || ' ' ||
          rpad(coalesce(to_char(utl_call_stack.owner(i)), ' '), 16) ||
          utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(i)));
      end if;
    end loop;
    
    return l_stack;
    $END
  end get_call_stack;
  
  
  function get_error_stack
    return varchar2
  as
    l_depth binary_integer;
    l_stack max_char;
  begin
    $IF dbms_db_version.ver_le_11 $THEN
    return dbms_utility.format_error_backtrace;
    $ELSE
    l_depth := utl_call_stack.error_depth;
    
    append(l_stack, g_error_stack_template);
    
    for i in 1 .. l_depth loop
      if not g_omit_pit_in_stack or instr(utl_call_stack.error_msg(i), 'PIT') = 0 then
        append(l_stack,
          lpad(i, 5) || ' ' ||
          rpad('ORA-' || trim(to_char(utl_call_stack.error_number(i),'00000')), 10) ||
          utl_call_stack.error_msg(i));
      end if;
    end loop;
    
    return l_stack;
    $END
  end get_error_stack;
  
begin
  initialize;
end pit_util;
/