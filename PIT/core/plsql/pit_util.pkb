create or replace package body pit_util
as

  /**** TYPE DECLARATIONS ****/

  /**** CONSTANTS ****/
  c_name_too_long constant varchar2(200) := 'Toggle name is too long. Please use a maximum of 20 byte';
  c_wrong_pattern constant varchar2(2000) := '#WHAT# not correct. Please use a valid format as described in the documentation. Checked: #PATTERN#';
  c_context_not_existing constant varchar2(200) := 'The context name you entered does not exist. Please create the named context first.';
  
  c_parameter_group constant varchar2(5) := 'PIT';
  c_context_group constant varchar2(30) := 'CONTEXT';
  c_context_prefix constant varchar2(30) := c_context_group || '_';
  
  c_true constant char(1 byte) := 'Y';
  c_false constant char(1 byte) := 'N';
  
  
  /**** GLOBAL VARS ****/
  g_user varchar2(30);
  g_error_prefix varchar2(5 byte);
  g_error_postfix varchar2(5 byte);
  
  
  /**** HELPER ****/
  procedure initialize
  as
    l_prefix_length pls_integer;
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
  function get_user
    return varchar2
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
    l_string varchar2(32767) := p_string;
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
  
  
  function concatenate(
    p_chunk_list char_table,
    p_delimiter varchar2,
    p_keep_null boolean default true)
    return varchar2
  as
    l_result varchar2(32767);
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
  
  
  /**** VALIDATION ****/
  procedure check_context_settings(
    p_context_name in varchar2,
    p_settings in varchar2)
  as
    c_setting_regex constant varchar2(200) := '^(((10|20|30|40|50|60|70)\|(10|20|30|40|50)\|(Y|N)\|[A-Z_]+(\:[A-Z_]+)*)|(10\|10\|N\|))$';
  begin
    -- context name must not be longer than 20 byte
    if length(p_context_name) > 20 then 
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
    p_toggle_name in varchar2,
    p_module_list in varchar2,
    p_context_name in varchar2)
  as
    l_context_name varchar2(30);
    l_exists char(1);
    c_module_regex constant varchar2(200) := '^[A-Z_$#.]+(\:[A-Z_$#.]+)*$';
  begin
    -- toggle name must not be longer than 20 byte
    if length(p_toggle_name) > 20 then 
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
  
begin
  initialize;
end pit_util;
/