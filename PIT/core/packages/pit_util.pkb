create or replace package body pit_util
as
  /** 
    Package: PIT_UTIL Body
      Implementation of generic utitilies for PIT.
   
    Author:: 
      Juergen Sieben, ConDeS GmbH
      
      Published under MIT licence
   */
   
  /**
    Group: Private constants
   */
  /**
    Constants: Message constants
      C_NAME_TOO_LONG - Message if a name exceeds the maximum length#
      C_WRONG_PATTERN - Message if a name does not adhere to the given naming conventions
   */
  C_PKG constant ora_name_type := $$PLSQL_UNIT;
  C_NAME_TOO_LONG constant varchar2(200) := 'Toggle name is too long. Please use a maximum of #MAX_LENGTH# byte';
  C_WRONG_PATTERN constant varchar2(2000) := '#WHAT# not correct. Please use a valid format as described in the documentation. Checked: #PATTERN#';
  C_NAME_SPELLING constant ora_name_type := 'NAME_SPELLING';
  
  /**
    Constants: Other constants
      C_CTX_DEL - Delimiter between context values in string representation
      C_TRUTHY - Boolean TRUE as <flag_type
      C_FALSY - Boolean FALSE as <flag_type
   */
  C_CTX_DEL constant char(1 byte) := '|';  
  C_TRUTHY constant flag_type := &C_TRUE.;
  C_FALSY constant flag_type := &C_FALSE.;
    
  /**
    Group: Private package variables
   */    
  /**
    Type predefined_error_t
      Table that stores all predefined errors <PIT_ADMIN> found within the database
      to prevent any overwrites of predefined errors.
   */
  type predefined_error_t is table of pit_util.predefined_error_rec index by binary_integer;
  
  type pmg_allowed_length_t is table of binary_integer index by pit_util.ora_name_type;
  
  /**
    Variables: Parameter variables
      g_omit_pit_in_stack - Container for parameter OMIT_PIT_IN_STACK
   */
  g_omit_pit_in_stack boolean;
  g_omit_pkg_list varchar2(1000 byte);
  
  g_predefined_errors predefined_error_t;
  g_pmg_allowed_length pmg_allowed_length_t;
  
  /**
    Group: Private methods
   */
  /**
    Procedure: initialize_error_list
      Method to collect all predefined error names within the database.
      Is called during package initiazation.
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
             to_number(trim(replace(substr(init, instr(init, ',') + 1), '''', '')), '99999') error_number,
             upper(trim(substr(init, 1, instr(init, ',') - 1))) error_name
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
  
  
  procedure initialize_pmg_max_length
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
    g_pmg_allowed_length.delete;
    for pmg in pmg_length_cur loop
      g_pmg_allowed_length(pmg.pmg_name) := pmg.allowed_length;
    end loop;
  end initialize_pmg_max_length;
  
  
  /**
    Procedure: append
      Method to append <P_CHUNK> to <P_TEXT>
      
    Parameters:
      p_text - Text to append <p_chunk> to
      p_chunk - Text to append
   */
  procedure append(
    p_text in out nocopy varchar2,
    p_chunk in varchar2)
  as
  begin
    p_text := p_text || p_chunk || chr(10);
  end append;
  
  
  /**
    Function: harmonize_name
      Harmonizes the spelling of database names etc.
      Conversion is based on parameter <PIT.NAME_SPELLING>
      
    Parameter:
      p_name - Name to harmonize
      
    Returns:
      Harmonized name
   */
  function harmonize_name(
    p_name in varchar2)
    return varchar2
  as
  begin
    case param.get_string(C_NAME_SPELLING, C_PARAMETER_GROUP)
      when 'LOWER' then
        return lower(p_name);
      when 'UPPER' then
        return upper(p_name);
      else
        return p_name;
      end case;
  end harmonize_name;
  
  
  /** 
    Function: ignore_subprogram
      Helper to decide whether a subprogram has to be ignored due to parameter settings
      
    Parameter:
      p_subprogram - Method to check
      
    Returns:
      Flag to indicate whether a subprogram has to be ignored (TRUE) or not (FALSE)
   */
  function ignore_subprogram(
    p_subprogram in varchar2)
    return boolean
  as
    l_ignore boolean := false;
  begin
    if g_omit_pit_in_stack then
      l_ignore := (upper(p_subprogram) like 'PIT%' and p_subprogram != 'PIT_UI') 
               or (instr(g_omit_pkg_list, ':' || upper(p_subprogram) || ':') > 0)
               or (upper(p_subprogram) like 'MESSAGE_TYPE%');
    end if;
    return l_ignore;
  end ignore_subprogram;
  
  
  /**
    Procedure: initialize
      Package Initialization 
   */
  procedure initialize
  as
    l_prefix_length binary_integer;
  begin
    -- set package vars
    g_omit_pit_in_stack := param.get_boolean('OMIT_PIT_IN_STACK', C_PARAMETER_GROUP);
    g_omit_pkg_list := ':' ||param.get_string('OMIT_PKG_IN_STACK', C_PARAMETER_GROUP) || ':';
  end initialize;
  
  
  function c_true
    return flag_type
  as
  begin
    return C_TRUTHY;
  end c_true;
  
  
  function c_false
    return flag_type
  as
  begin
    return C_FALSY;
  end c_false;
  
  
  /**
    Group: Public getter methods
   */
  /**
    Function: get_call_stack
      See <PIT_UTIL.get_call_stack>
   */
  function get_call_stack
    return varchar2
  as
    l_depth binary_integer;
    l_stack max_char;
  begin
    l_depth := utl_call_stack.dynamic_depth;
    
    append(l_stack, param.get_string('PIT_CALL_STACK_TEMPLATE', C_PARAMETER_GROUP));
    
    for i in 1 .. l_depth loop
      if not ignore_subprogram(utl_call_stack.subprogram(i)(1)) then
        append(l_stack,
          lpad(to_char(utl_call_stack.unit_line(i), 'fm99999999'), 7) || ' ' ||
          rpad(coalesce(to_char(utl_call_stack.owner(i)), ' '), 16) ||
          utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(i)));
      end if;
    end loop;
    
    return substrb(l_stack, 1, 2000);
  end get_call_stack;
  
  
  /**
    Function: get_error_stack
      See <PIT_UTIL.get_error_stack>
   */
  function get_error_stack
    return varchar2
  as
    l_depth binary_integer;
    l_stack max_char;
  begin
    l_depth := utl_call_stack.error_depth;
    
    append(l_stack, param.get_string('PIT_ERROR_STACK_TEMPLATE', C_PARAMETER_GROUP));

    for i in 1 .. l_depth loop
      begin
        if not ignore_subprogram(utl_call_stack.subprogram(i)(1)) then
          append(l_stack,
            lpad(to_char(utl_call_stack.unit_line(i), 'fm99999999'), 7) || ' '  ||
            rpad(coalesce(to_char(utl_call_stack.owner(i)), ' '), 16) ||
            utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(i)));
        end if;
      exception
        when utl_call_stack.BAD_DEPTH_INDICATOR then
          append(l_stack, 'Bad depth indicator error raised');
      end;
    end loop;
    
    return l_stack;
  end get_error_stack;
  

  /**
    Function: get_module_and_action
      See <PIT_UTIL.get_module_and_action>
   */
  procedure get_module_and_action(
    p_module in out nocopy varchar2,
    p_action in out nocopy varchar2)
  as
    l_depth binary_integer;
  begin
    l_depth := utl_call_stack.dynamic_depth;
    for i in 1 .. l_depth loop
      if not ignore_subprogram(utl_call_stack.subprogram(i)(1)) then
        l_depth := i;
        exit;
      end if;
    end loop;
    
    -- Set action and module to the first non excluded entry
    begin
      p_action := coalesce(p_action, harmonize_name(utl_call_stack.subprogram(l_depth)(2)));
      p_module := harmonize_name(utl_call_stack.subprogram(l_depth)(1));
    exception
      when others then
        -- when called from an anonymous block, not all values may have entries
        p_action := harmonize_name(null, utl_call_stack.subprogram(l_depth)(1));
    end;
  end get_module_and_action;
  
  
  /**
    Function: get_max_message_length
      See <PIT_UTIL.get_max_message_length>
   */
  function get_max_message_length(
    p_pmg_name in pit_message_group.pmg_name%type)
    return binary_integer
  as
    l_max_length binary_integer;
  begin
    if g_pmg_allowed_length.exists(p_pmg_name) then
      l_max_length := g_pmg_allowed_length(p_pmg_name);
    else
      select 1
        into l_max_length
        from pit_message_group
       where pmg_name = p_pmg_name;
      initialize_pmg_max_length;
      -- Try again
      l_max_length := get_max_message_length(p_pmg_name);
    end if;
    
    return l_max_length;
  end get_max_message_length;
    
  
  /**
    Function: check_error_number_exists
      See <PIT_UTIL.check_error_number_exists>
   */
  function check_error_number_exists(
    p_pms_name in pit_message.pms_name%type,
    p_pms_custom_error in pit_message.pms_custom_error%type)
    return predefined_error_rec
  as
    l_error predefined_error_rec;
    l_error_marker pit_util.ora_name_type;
  begin
    initialize_error_list;
    
    case
      when p_pms_custom_error is null then
        null;
      when g_predefined_errors.exists(p_pms_custom_error) then
        -- predefined error found
        l_error := g_predefined_errors(p_pms_custom_error);
        -- Check that we didn't find the exception we want to create itself
        begin
          select pmg_error_prefix || pmg_error_postfix
            into l_error_marker
            from pit_message_group
            join pit_message
              on pmg_name = pms_pmg_name
           where pms_name = p_pms_name;
          if p_pms_name = l_error.error_name 
             or replace(replace(l_error.error_name, p_pms_name), '_') = l_error_marker then
            l_error := null;
          end if;
        exception
          when NO_DATA_FOUND then
            null;
        end;
      else
        null;
    end case;
  
    return l_error;
  end check_error_number_exists;
  
  
  /**
    Group: Public text methods
   */
  
  
  /**
    Function: bulk_replace
      See <PIT_UTIL.bulk_replace>
   */
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


  /**
    Procedure: clob_append
      See <PIT_UTIL.clob_append>
   */
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
  
  
  /**
    Function: concatenate
      See <PIT_UTIL.concatenate>
   */
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
  
  
  /**
    Function: harmonize_name
      See <PIT_UTIL.harmonize_name>
   */
  function harmonize_name(
    p_prefix in varchar2,
    p_name in varchar2)
    return varchar2
  as
    C_ANONYMOUS_BLOCK constant ora_name_type := '__ANONYMOUS_BLOCK';
    l_harmonized_name max_sql_char;
  begin
    l_harmonized_name := upper(p_name);
    case 
      when l_harmonized_name = C_ANONYMOUS_BLOCK then
        l_harmonized_name:= initcap(trim(replace(l_harmonized_name, '_', ' ')));
      when substr(upper(p_name), 1, length(p_prefix)) != upper(p_prefix) then
        l_harmonized_name := p_prefix || l_harmonized_name;
      else
        null;
    end case;
    return l_harmonized_name;
  end harmonize_name;
  
  
  /**
    Function: harmonize_sql_name
      See <PIT_UTIL.harmonize_sql_name>
   */
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
  
  
  /**
    Group: Public validation helper methods
   */
  /**
    Procedure: check_context_settings
      See <PIT_UTIL.check_context_settings>
   */
  procedure check_context_settings(
    p_context_name in ora_name_type,
    p_settings in varchar2)
  as
    C_SETTING_REGEX constant varchar2(200) := '^(((10|20|30|40|50|60|70)\|(10|20|30|40|50)\|(' || C_TRUE || '|' || C_FALSE || ')\|[A-Z_]+(\:[A-Z_]+)*)|(10\|10\|' || C_FALSE || '\|))$';
  begin
    -- context name must not be longer than 10 byte under C_MAX_LENGTH
    if length(p_context_name) > C_MAX_LENGTH - 10 then 
      raise_application_error(-20000, replace(C_NAME_TOO_LONG, '#MAX_LENGTH#', C_MAX_LENGTH - 10));
    end if;
    -- check context pattern
    if not regexp_like(upper(p_settings), C_SETTING_REGEX) then
      raise_application_error(
        -20000, 
        bulk_replace(
          C_WRONG_PATTERN, char_table(
          '#WHAT#', 'Settings are',
          '#PATTERN#', p_settings)));
    end if;
  end check_context_settings;
  
  
  /**
    Procedure: check_toggle_settings
      See <PIT_UTIL.check_toggle_settings>
   */
  procedure check_toggle_settings(
    p_toggle_name in ora_name_type,
    p_module_list in varchar2,
    p_context_name in ora_name_type)
  as
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
  
  
  /**
    Group: Public conversion methods
   */
  /**
    Function: cast_to_msg_args_char
      See <PIT_UTIL.cast_to_msg_args_char>
   */
  function cast_to_msg_args_char(
    p_msg_args msg_args)
    return msg_args_char
  as
    l_msg_args msg_args_char;
  begin
    if p_msg_args is not null then
      l_msg_args := msg_args_char();
      for i in p_msg_args.first .. p_msg_args.last loop
        l_msg_args.extend;
        l_msg_args(i) := dbms_lob.substr(p_msg_args(i), 4000, 1);
      end loop;
    end if;
    return l_msg_args;
  end cast_to_msg_args_char;
    
    
  /**
    Function: cast_to_msg_args
      See <PIT_UTIL.cast_to_msg_args>
   */
  function cast_to_msg_args(
    p_msg_args msg_args_char)
    return msg_args
  as
    l_msg_args msg_args;
  begin
    if p_msg_args is not null then
      l_msg_args := msg_args();
      for i in p_msg_args.first .. p_msg_args.last loop
        l_msg_args.extend;
        l_msg_args(i) := p_msg_args(i);
      end loop;
    end if;
    return l_msg_args;
  end cast_to_msg_args;
  
  
  /**
    Function: string_to_table
      See <PIT_UTIL.string_to_table>
   */
  function string_to_table(
    p_string_value in varchar2,
    p_delimiter in varchar2 := ':')
    return pit_args
  as
    l_args pit_args := pit_args();
  begin
    if p_string_value is not null then
      if instr(p_string_value, p_delimiter) > 0 then
        for i in 1 .. regexp_count(p_string_value, '\' || p_delimiter) + 1 loop
          l_args.extend;
          l_args(i) := regexp_substr(p_string_value, '[^\' || p_delimiter || ']+', 1, i);
        end loop;
      else
        l_args.extend;
        l_args(1) := p_string_value;
      end if;
    end if;
    return l_args;
  end string_to_table;
  
  
  /**
    Function: table_to_string
      See <PIT_UTIL.table_to_string>
   */
  function table_to_string(
    p_table in pit_args,
    p_delimiter in varchar2 := ':')
  return varchar2
  as
    l_string pit_util.max_char;
  begin
    for i in 1 .. p_table.count loop
      if p_table(i) is not null then
        if i > 1 then
          l_string := l_string || p_delimiter;
        end if;
        l_string := l_string || p_table(i);
      end if;
    end loop;
    return l_string;
  end table_to_string;
  
  
  /**
    Function: to_bool
      See <PIT_UTIL.to_bool>
   */
  function to_bool(
    p_boolean in flag_type)
    return boolean
  as
  begin
    return p_boolean = C_TRUE;
  end to_bool;

  /**
    Function: to_bool
      See <PIT_UTIL.to_bool>
   */
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
  
  
  /**
    Group: Public helper methods
   */
  /**
    Procedure: recompile_invalid_objects
      See <PIT_UTIL.recompile_invalid_objects>
   */
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
        l_stmt := bulk_replace(C_RECOMPILE_STMT, char_table(
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
              bulk_replace(C_COMPILED, char_table(
                '#TYPE#', obj.object_type,
                '#OWNER#', obj.owner,
                '#NAME#', obj.object_name)));
          exception
            when compilation_error then
              null;
            when others then
              dbms_output.put_line(
                bulk_replace(C_COMPILE_ERROR, char_table(
                  '#TYPE#', obj.object_type,
                  '#OWNER#', obj.owner,
                  '#NAME#', obj.object_name,
                  '#ERROR#', sqlerrm)));
          end;
        else
          dbms_output.put_line(
            bulk_replace(C_INVALID_OBJECT, char_table(
              '#TYPE#', obj.object_type,
              '#OWNER#', obj.owner,
              '#NAME#', obj.object_name)));
        end if;
      end loop;
    end loop;
  end recompile_invalid_objects;
  
  
  /**
    Function: check_number_datatype
      See <PIT_UTIL.check_number_datatype>
   */
  function check_number_datatype(
    p_value in varchar2,
    p_format_mask in varchar2)
    return boolean
  as
    l_format_mask pit_util.ora_name_type;
    l_number number;
  begin
    l_format_mask := coalesce(p_format_mask, '999999999999999999D999999999');
    l_number := to_number(p_value, l_format_mask);
    return true;
  exception
    when others then
      return false;
  end check_number_datatype;
  
  
  /**
    Function: check_date_datatype
      See <PIT_UTIL.check_number_datatype>
   */
  function check_date_datatype(
    p_value in varchar2,
    p_format_mask in varchar2)
    return boolean
  as
    l_format_mask pit_util.ora_name_type;
    l_date date;
  begin
    l_format_mask := coalesce(p_format_mask, sys_context('USERENV', 'NLS_DATE_FORMAT'));
    l_date := to_date(p_value, l_format_mask);
    return true;
  exception
    when others then
      return false;
  end check_date_datatype;
  
  
  /**
    Function: check_timestamp_datatype
      See <PIT_UTIL.check_timestamp_datatype>
   */
  function check_timestamp_datatype(
    p_value in varchar2,
    p_format_mask in varchar2)
    return boolean
  as
    l_format_mask pit_util.ora_name_type;
    l_timestamp timestamp with time zone;
  begin
    if p_format_mask is null then
      select value
        into l_format_mask
        from v$nls_parameters
       where parameter = 'NLS_TIMESTAMP_FORMAT';
    end if;
    l_timestamp := to_timestamp(p_value, l_format_mask);
    return true;
  exception
    when others then
      return false;
  end check_timestamp_datatype;
  
  
  /**
    Function: check_xml_datatype
      See <PIT_UTIL.varchar2>
   */
  function check_xml_datatype(
    p_value in varchar2)
    return boolean
  as
    l_xml xmltype;
  begin
    l_xml := xmltype(p_value);
    return true;
  exception
    when others then
      return false;
  end check_xml_datatype;
  
begin
  initialize;
end pit_util;
/