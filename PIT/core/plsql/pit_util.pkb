create or replace package body pit_util
as

  /**** TYPE DECLARATIONS ****/
  type predefined_error_rec is record(
    source_type varchar2(30),
    owner varchar2(30),
    package_name varchar2(30),
    error_name varchar2(30));
  type predefined_error_t is table of predefined_error_rec index by binary_integer;
  

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
  g_predefined_errors predefined_error_t;
  
  
  /**** HELPER ****/
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
    -- set package vars
    g_user := user;
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
  
  
  /**** VALIDATION ****/
  procedure check_error(
    p_message_name in message.message_name%type,
    p_error_number in message.custom_error_number%type)
  as
    l_predefined_error predefined_error_rec;
    l_message varchar2(2000);
    l_message_length binary_integer;
    c_msg_too_long constant varchar2(200) := 
      q'~Message "#MESSAGE#" must not exceed 26 chars but is #LENGTH#.~';
    c_predefined_error constant varchar2(200) :=
      q'~Error number #ERROR# is a predefined Oracle error named #NAME# in #OWNER#.#PKG#. Please don't overwrite Oracle predefined errors.~';
  begin
    l_message_length := length(p_message_name);
    if l_message_length > 26 then
      l_message := pit_util.bulk_replace(c_msg_too_long, char_table(
                     '#MESSAGE#', p_message_name,
                     '#LENGTH#', l_message_length));
       raise_application_error(-20000, l_message);
    end if;
    if g_predefined_errors.exists(p_error_number) then
      l_predefined_error := g_predefined_errors(p_error_number);
      l_message := pit_util.bulk_replace(c_predefined_error, char_table(
                     '#ERROR#', p_error_number,
                     '#NAME#', l_predefined_error.error_name,
                     '#OWNER#', l_predefined_error.owner,
                     '#PKG#', l_predefined_error.package_name));
      raise_application_error(-20000, l_message);
    end if;
  end check_error;
  
  
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
     where parameter_id = l_context_name
       and parameter_group_id = c_parameter_group;
  exception
    when no_data_found then
      raise_application_error(-20000, c_context_not_existing);      
  end check_toggle_settings;
  
begin
  initialize;
end pit_util;
/