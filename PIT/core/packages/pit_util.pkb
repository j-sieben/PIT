create or replace package body pit_util
as

  /**** CONSTANTS ****/
  c_pkg constant ora_name_type := $$PLSQL_UNIT;
  c_name_too_long constant varchar2(200) := 'Toggle name is too long. Please use a maximum of ' || (c_max_length - 10) || ' byte';
  c_wrong_pattern constant varchar2(2000) := '#WHAT# not correct. Please use a valid format as described in the documentation. Checked: #PATTERN#';
  c_context_not_existing constant varchar2(200) := 'The context name you entered does not exist. Please create the named context first.';
  
  c_parameter_group constant varchar2(5) := 'PIT';
  c_context_group constant ora_name_type := 'CONTEXT';
  c_context_prefix constant ora_name_type := c_context_group || '_';
  
  
  /**** GLOBAL VARS ****/
  g_user ora_name_type;
  g_error_prefix varchar2(5 byte);
  g_error_postfix varchar2(5 byte);
  g_call_stack_template varchar2(1000 byte);
  g_error_stack_template varchar2(1000 byte);
  
  
  /**** HELPER ****/
  procedure append(
    p_text in out nocopy varchar2,
    p_chunk in varchar2)
  as
  begin
    p_text := p_text || p_chunk || chr(10);
  end append;
  
  
  procedure initialize
  as
    l_prefix_length binary_integer;
  begin
    -- set package vars
    g_user := user;
    g_error_prefix := param.get_string('ERROR_PREFIX', c_parameter_group);
    if g_error_prefix is not null then
      g_error_prefix := g_error_prefix || '_';
    end if;
    g_error_postfix := param.get_string('ERROR_POSTFIX', c_parameter_group);
    if g_error_postfix is not null then
      g_error_postfix := '_' || g_error_postfix;
    end if;
    
    g_call_stack_template := param.get_string('PIT_CALL_STACK_TEMPLATE', c_parameter_group);
    g_error_stack_template := param.get_string('PIT_ERROR_STACK_TEMPLATE', c_parameter_group);
    
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
    l_arg_list args := args();
  begin
    if p_string_value is not null then
      for i in 1 .. regexp_count(p_string_value, '\' || p_delimiter) + 1 loop
        l_arg_list.extend;
        l_arg_list(i) := regexp_substr(p_string_value, '[^\' || p_delimiter || ']+', 1, i);
      end loop;
    end if;
    return l_arg_list;
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
    l_length binary_integer;
  begin
    l_length := dbms_lob.getlength(p_chunk);
    if l_length > 0 then
      if p_clob is null then
        dbms_lob.createtemporary(p_clob, false, dbms_lob.call);
      end if;
      dbms_lob.writeappend(p_clob, l_length, p_chunk);
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
  
  
  function harmonize_name(
    p_prefix in varchar2,
    p_name in varchar2)
    return varchar2
  as
  begin
    return upper(p_prefix) || replace(upper(p_name), upper(p_prefix));
  end harmonize_name;
  
  
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
    l_arg_list msg_args_char := msg_args_char();
  begin
    if p_msg_args is not null then
      for i in p_msg_args.first .. p_msg_args.last loop
        l_arg_list.extend;
        l_arg_list(i) := dbms_lob.substr(p_msg_args(i), 4000, 1);
      end loop;
    end if;
    return l_arg_list;
  end cast_to_char_list;
  
  
  /**** VALIDATION ****/
  procedure check_context_settings(
    p_context_name in ora_name_type,
    p_settings in varchar2)
  as
    c_setting_regex constant varchar2(200) := '^(((10|20|30|40|50|60|70)\|(10|20|30|40|50)\|(Y|N)\|[A-Z_]+(\:[A-Z_]+)*)|(10\|10\|N\|))$';
  begin
    -- context name must not be longer than 10 byte under C_MAX_LENGTH
    if length(p_context_name) > c_max_length - 10 then 
      raise_application_error(-20000, c_name_too_long);
    end if;
    -- check context pattern
    if not regexp_like(upper(p_settings), c_setting_regex) then
      raise_application_error(
        -20000, 
        pit_util.bulk_replace(
          c_wrong_pattern, char_table(
          '#WHAT#', 'Settings are',
          '#PATTERN#', p_settings)));
    end if;
  end check_context_settings;
  
  
  procedure check_toggle_settings(
    p_toggle_name in ora_name_type,
    p_module_list in varchar2,
    p_context_name in ora_name_type)
  as
    l_context_name ora_name_type;
    l_exists flag_type;
    c_module_regex constant varchar2(200) := '^[A-Z_$#.]+(\:[A-Z_$#.]+)*$';
  begin
    -- toggle name must not be longer than 10 byte under C_MAX_LENGTH
    if length(p_toggle_name) > c_max_length - 10 then 
      raise_application_error(-20000, c_name_too_long);
    end if;
    -- check module pattern
    if not regexp_like(upper(p_module_list), c_module_regex) then
      raise_application_error(
        -20000, 
        pit_util.bulk_replace(
          c_wrong_pattern, char_table(
          '#WHAT#', 'Module list is',
          '#PATTERN#', upper(p_module_list))));
    end if;
    -- check if context exists
    l_context_name := harmonize_name(c_context_prefix, p_context_name);
    select c_true
      into l_exists
      from parameter_tab
     where par_id = l_context_name
       and par_pgr_id = c_parameter_group;
  exception
    when no_data_found then
      raise_application_error(-20000, c_context_not_existing);      
  end check_toggle_settings;
  
  
  procedure recompile_invalid_objects
  as
    -- Constants
    c_compile_error constant varchar2(200) := 'Error when compiling #TYPE# #OWNER#.#NAME#: #ERROR#';
    c_invalid_object constant varchar2(200) := 'Invalid: #TYPE# #OWNER#.#NAME#';
    c_compiled constant varchar2(200) := '#TYPE# #OWNER#.#NAME# compiled';
    c_type constant ora_name_type := 'TYPE';
    c_type_body constant ora_name_type := 'TYPE BODY';
    c_package constant ora_name_type := 'PACKAGE';
    c_package_body constant ora_name_type := 'PACKAGE BODY';
    c_recompile_stmt constant varchar2(1000) := q'^alter #TYPE# #OWNER#.#NAME# compile #POSTFIX#^';
    c_max_compile_runs constant binary_integer := 3;

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
             when c_type then 1
             when c_type_body then 2
             when c_package then 3
             when c_package_body then 4
             else 5 end recompile_order,
             case when obj.object_type in (c_type_body, c_package_body) then 'body'
             end recompile_postfix
        from all_dependencies dep
        join all_objects obj
          on dep.type = obj.object_type
         and dep.name = obj.object_name
       where obj.status != 'VALID'
         and obj.owner = sys_context('USERENV', 'CURRENT_SCHEMA')
         and obj.object_name != c_pkg
       order by obj.object_name, recompile_order;
  begin
    l_index := dbms_application_info.set_session_longops_nohint;
    for i in 1 .. c_max_compile_runs loop
      dbms_output.put_line('compile Run ' || i);
      for obj in invalid_objects_cur loop
        l_stmt := pit_util.bulk_replace(c_recompile_stmt, char_table(
                    '#OWNER#', obj.owner,
                    '#TYPE#', replace(obj.object_type, ' BODY'),
                    '#NAME#', obj.object_name,
                    '#POSTFIX#', obj.recompile_postfix));
        dbms_application_info.set_session_longops(
          l_index, l_no, 'Compiling ' || obj.object_type || obj.object_name, 0, 0, i, obj.cnt);
        if i < c_max_compile_runs then
          begin
            execute immediate l_stmt;
            dbms_output.put_line(
              pit_util.bulk_replace(c_compiled, char_table(
                '#TYPE#', obj.object_type,
                '#OWNER#', obj.owner,
                '#NAME#', obj.object_name)));
          exception
            when compilation_error then
              null;
            when others then
              dbms_output.put_line(
                pit_util.bulk_replace(c_compile_error, char_table(
                  '#TYPE#', obj.object_type,
                  '#OWNER#', obj.owner,
                  '#NAME#', obj.object_name,
                  '#ERROR#', sqlerrm)));
          end;
        else
          dbms_output.put_line(
            pit_util.bulk_replace(c_invalid_object, char_table(
              '#TYPE#', obj.object_type,
              '#OWNER#', obj.owner,
              '#NAME#', obj.object_name)));
        end if;
      end loop;
    end loop;
  end recompile_invalid_objects;
  
  
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
      if utl_call_stack.subprogram(i)(1) not like 'PIT%' then
        append(l_stack,
          lpad(to_char(utl_call_stack.unit_line(i), '99999'), 5) || ' ' ||
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
      if instr(utl_call_stack.error_msg(i), 'PIT') = 0 then
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