create or replace package body param
as

  /** Package to read and write parameter values */

  C_TRUE constant parameter_group.pgr_is_modifiable%type := &C_TRUE.;
  C_FALSE constant parameter_group.pgr_is_modifiable%type := &C_FALSE.;
  c_max_char_length constant number := 32767;
  C_DEFAULT_REALM constant parameter_local.pal_pre_id%type := 'DEFAULT';

  /* Helper */  

  /* Helper procedure to convert a char into a boolean value
   * %param  p_boolean_value char value representign a boolean value: Y|N
   * %return Flag result C_TRUE|C_FALSE|null
   * %usage  Is called internally to convert a boolea parameter into a boolean value.
   */
  function get_bool(
    p_boolean_value in boolean)
    return parameter_v.par_boolean_value%type
  as
    l_boolean parameter_v.par_boolean_value%type;
  begin
    case
      when p_boolean_value is null then
        l_boolean := null;
      when p_boolean_value then
        l_boolean := C_TRUE;
      else
        l_boolean := C_FALSE;
    end case;
    
    return l_boolean;
    
  end get_bool;
  

  /* Helper procedure to convert a boolean value into a flag type
   * %param  p_boolean_value - Boolean flag to convert
   * %return char value representing a boolean value: Y|N
   * %usage  Is called internally to convert a boolean value to a parameter a boolean value.
   */
  function bool_to_flag(
    p_flag in boolean)
    return parameter_v.par_boolean_value%type
  as
    l_result parameter_v.par_boolean_value%type;
  begin
    if p_flag then
      l_result := C_TRUE;
    else
      l_result := C_FALSE;
    end if;
    return l_result;
  end bool_to_flag;


  /* Helper method to read a row of parameter into a record
   * %param  p_par_id Name of the parameter
   * %param  p_par_pgr_id Name of the parameter group
   * %usage  Is called internally by the Getter Methods to copy a row of parameter into the global variable l_row.
   */
  function get_parameter(
    p_par_id in varchar2,
    p_par_pgr_id in varchar2)
    return parameter_v%rowtype
  as
    l_row parameter_v%rowtype;
  begin
    select *
      into l_row
      from parameter_v
     where par_id = p_par_id
       and par_pgr_id = p_par_pgr_id;
    return l_row;
  exception
    when no_data_found then
      dbms_output.put_line('Parameter ' || p_par_id || ' not found in ' || p_par_pgr_id);
      return null;
  end get_parameter;
  

  /* INTERFACE */    
  procedure validate_parameter(
    p_par_id parameter_v.par_id%type,
    p_par_pgr_id parameter_v.par_pgr_id%type,
    p_par_string_value in parameter_v.par_string_value%type default null,
    p_par_xml_value in parameter_v.par_xml_value%type default null,
    p_par_integer_value in parameter_v.par_integer_value%type default null,
    p_par_float_value in parameter_v.par_float_value%type default null,
    p_par_date_value in parameter_v.par_date_value%type default null,
    p_par_timestamp_value in parameter_v.par_timestamp_value%type default null,
    p_par_boolean_value in boolean default null)
  as
    l_boolean_value parameter_v.par_boolean_value%type;
    l_is_modifiable boolean;
    l_row parameter_v%rowtype;
  begin
  
    l_row := param_admin.get_parameter_settings(
                         p_par_id => p_par_id,
                         p_pgr_id => p_par_pgr_id);
    
    l_is_modifiable := l_row.par_id is not null and l_row.par_is_modifiable = C_TRUE;
    
    if l_is_modifiable then
      l_row.par_string_value := p_par_string_value;
      l_row.par_xml_value := p_par_xml_value;
      l_row.par_integer_value := p_par_integer_value;
      l_row.par_float_value := p_par_float_value;
      l_row.par_date_value := p_par_date_value;
      l_row.par_timestamp_value := p_par_timestamp_value;
      l_row.par_boolean_value := get_bool(p_par_boolean_value);
      
      param_admin.validate_parameter(l_row);
    else
      if l_row.par_id is not null then
        raise_application_error(-20000, 'Parameter not existing');
      else
        raise_application_error(-20000, 'Parameter not modifiable');
      end if;
    end if;
    
  end validate_parameter;
  
  
  /* SETTER */
  procedure set_multiple(
    p_par_id parameter_v.par_id%type,
    p_par_pgr_id parameter_v.par_pgr_id%type,
    p_par_pre_id in parameter_realm.pre_id%type,
    p_par_string_value in parameter_v.par_string_value%type default null,
    p_par_xml_value in parameter_v.par_xml_value%type default null,
    p_par_integer_value in parameter_v.par_integer_value%type default null,
    p_par_float_value in parameter_v.par_float_value%type default null,
    p_par_date_value in parameter_v.par_date_value%type default null,
    p_par_timestamp_value in parameter_v.par_timestamp_value%type default null,
    p_par_boolean_value in boolean default null)
  as
    l_boolean_flag parameter_v.par_boolean_value%type;
  begin    
    validate_parameter(
      p_par_id => p_par_id,
      p_par_pgr_id => p_par_pgr_id,
      p_par_string_value => p_par_string_value,
      p_par_xml_value => p_par_xml_value,
      p_par_integer_value => p_par_integer_value,
      p_par_float_value => p_par_float_value,
      p_par_date_value => p_par_date_value,
      p_par_timestamp_value => p_par_timestamp_value,
      p_par_boolean_value => p_par_boolean_value);
    
    if p_par_pre_id is null then
      l_boolean_flag := bool_to_flag(p_par_boolean_value);
      merge into parameter_local t
      using (select p_par_id pal_id,
                    p_par_pgr_id pal_pgr_id,
                    p_par_string_value pal_string_value,
                    p_par_xml_value pal_xml_value,
                    p_par_integer_value pal_integer_value,
                    p_par_float_value pal_float_value,
                    p_par_date_value pal_date_value,
                    p_par_timestamp_value pal_timestamp_value,
                    l_boolean_flag pal_boolean_value
               from dual) s
         on (t.pal_id = s.pal_id
         and t.pal_pgr_id = s.pal_pgr_id)
       when matched then update set
            t.pal_string_value = s.pal_string_value,
            t.pal_xml_value = s.pal_xml_value,
            t.pal_integer_value = s.pal_integer_value,
            t.pal_float_value = s.pal_float_value,
            t.pal_date_value = s.pal_date_value,
            t.pal_timestamp_value = s.pal_timestamp_value,
            t.pal_boolean_value = s.pal_boolean_value
       when not matched then insert
            (pal_id, pal_pgr_id, pal_string_value, pal_xml_value, pal_integer_value, 
             pal_float_value, pal_date_value, pal_timestamp_value, pal_boolean_value)
            values
            (s.pal_id, s.pal_pgr_id, s.pal_string_value, s.pal_xml_value, s.pal_integer_value, 
             s.pal_float_value, s.pal_date_value, s.pal_timestamp_value, s.pal_boolean_value);
    else
      param_admin.edit_realm_parameter(  
        p_par_id => p_par_id,
        p_par_pgr_id => p_par_pgr_id,
        p_par_pre_id => p_par_pre_id,
        p_par_string_value => p_par_string_value,
        p_par_xml_value => p_par_xml_value,
        p_par_integer_value => p_par_integer_value,
        p_par_float_value => p_par_float_value,
        p_par_date_value => p_par_date_value,
        p_par_timestamp_value => p_par_timestamp_value,
        p_par_boolean_value => p_par_boolean_value);
    end if;
  end set_multiple;
  
  
  procedure set_string(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_value in varchar2,
    p_par_pre_id in parameter_realm.pre_id%type default null)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_par_pgr_id => p_par_pgr_id,
      p_par_pre_id => p_par_pre_id,
      p_par_string_value => to_clob(p_par_value));
  end set_string;
  
  procedure set_clob(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_v.par_string_value%type,
    p_par_pre_id in parameter_realm.pre_id%type default null)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_par_pgr_id => p_par_pgr_id,
      p_par_pre_id => p_par_pre_id,
      p_par_string_value => p_par_value);
  end set_clob;

  procedure set_xml(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_v.par_xml_value%type,
    p_par_pre_id in parameter_realm.pre_id%type default null)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_par_pgr_id => p_par_pgr_id,
      p_par_pre_id => p_par_pre_id,
      p_par_xml_value => p_par_value);
  end set_xml;

  procedure set_float(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_v.par_float_value%type,
    p_par_pre_id in parameter_realm.pre_id%type default null)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_par_pgr_id => p_par_pgr_id,
      p_par_pre_id => p_par_pre_id,
      p_par_float_value => p_par_value);
  end set_float;

  procedure set_integer(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_v.par_integer_value%type,
    p_par_pre_id in parameter_realm.pre_id%type default null)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_par_pgr_id => p_par_pgr_id,
      p_par_pre_id => p_par_pre_id,
      p_par_integer_value => p_par_value);
  end set_integer;

  procedure set_date(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_v.par_date_value%type,
    p_par_pre_id in parameter_realm.pre_id%type default null)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_par_pgr_id => p_par_pgr_id,
      p_par_pre_id => p_par_pre_id,
      p_par_date_value => p_par_value);
  end set_date;

  procedure set_timestamp(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_v.par_timestamp_value%type,
    p_par_pre_id in parameter_realm.pre_id%type default null)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_par_pgr_id => p_par_pgr_id,
      p_par_pre_id => p_par_pre_id,
      p_par_timestamp_value => p_par_value);
  end set_timestamp;

  procedure set_boolean(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_value in boolean,
    p_par_pre_id in parameter_realm.pre_id%type default null)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_par_pgr_id => p_par_pgr_id,
      p_par_pre_id => p_par_pre_id,
      p_par_boolean_value => p_par_value);
  end set_boolean;


  /* GETTER */
  function get_string(
   p_par_id in parameter_v.par_id%type,
   p_par_pgr_id in parameter_group.pgr_id%type)
   return varchar2 result_cache
  as
    l_row parameter_v%rowtype;
  begin
    l_row := get_parameter(p_par_id, p_par_pgr_id);
    return dbms_lob.substr(l_row.par_string_value, c_max_char_length, 1);
  end get_string;
  
  function get_clob(
   p_par_id in parameter_v.par_id%type,
   p_par_pgr_id in parameter_group.pgr_id%type)
   return parameter_v.par_string_value%type
  as
    l_row parameter_v%rowtype;
  begin
    l_row := get_parameter(p_par_id, p_par_pgr_id);
    return l_row.par_string_value;
  end get_clob;

  function get_xml(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type)
    return parameter_v.par_xml_value%type
  as
    l_row parameter_v%rowtype;
  begin
    l_row := get_parameter(p_par_id, p_par_pgr_id);
    return l_row.par_xml_value;
  end get_xml;

  function get_float(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type)
    return parameter_v.par_float_value%type result_cache
  as
    l_row parameter_v%rowtype;
  begin
    l_row := get_parameter(p_par_id, p_par_pgr_id);
    return l_row.par_float_value;
  end get_float;

  function get_integer(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type)
    return parameter_v.par_integer_value%type result_cache
  as
    l_row parameter_v%rowtype;
  begin
    l_row := get_parameter(p_par_id, p_par_pgr_id);
    return l_row.par_integer_value;
  end get_integer;

  function get_date(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type)
    return parameter_v.par_date_value%type result_cache
  as
    l_row parameter_v%rowtype;
  begin
    l_row := get_parameter(p_par_id, p_par_pgr_id);
    return l_row.par_date_value;
  end get_date;

  function get_timestamp(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type)
    return parameter_v.par_timestamp_value%type result_cache
  as
    l_row parameter_v%rowtype;
  begin
    l_row := get_parameter(p_par_id, p_par_pgr_id);
    return l_row.par_timestamp_value;
  end get_timestamp;

  function get_boolean(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type)
    return boolean result_cache
  as
    l_row parameter_v%rowtype;
  begin
    l_row := get_parameter(p_par_id, p_par_pgr_id);
    return l_row.par_boolean_value = C_TRUE;
  end get_boolean;
  
  
  procedure reset_parameter(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_pre_id in parameter_realm.pre_id%type default null)
  as
  begin
    delete from parameter_local
     where pal_pgr_id = p_par_pgr_id
       and pal_id = p_par_id
       and decode(pal_pre_id, p_par_pre_id, 0, 1) = 0;
  end reset_parameter;
  
  
  function get_parameters
    return clob
  as
    cursor local_param_cur is
      select pal_id, pal_pgr_id, pal_string_value, 
             l.pal_xml_value.getClobVal() pal_xml_value, pal_integer_value, 
             to_char(pal_float_value, 'fm9999999999999999.99999999999999') pal_float_value,
             to_char(pal_date_value, 'yyyy-mm-dd') pal_date_value,
             to_char(pal_timestamp_value, 'yyyy-mm-dd hh24:mi:ss') pal_timestamp_value,
             case pal_boolean_value when C_TRUE then 'true' when C_FALSE then 'false' else 'null' end pal_boolean_value
        from parameter_local l;
    C_START_TEMPLATE constant varchar2(100) := q'^begin
^';
    C_PARAM_TEMPLATE constant varchar2(100) := q'^
  param.set_multiple(
    p_par_id => '#PAL_ID#'
   ,p_par_pgr_id => '#PAL_PGR_ID#'#CLAUSES#);
^';
    C_STRING_TEMPLATE constant varchar2(100) := q'~   ,p_par_string_value => q'^#STRING#^'~';
    C_XML_TEMPLATE constant varchar2(100) := q'~   ,p_par_xml_value => xmltype(q'^#XML#^')~';
    C_INTEGER_TEMPLATE constant varchar2(100) := q'~   ,p_par_integer_value => #INTEGER#~';
    C_FLOAT_TEMPLATE constant varchar2(100) := q'~   ,p_par_float_value => #FLOAT#~';
    C_DATE_TEMPLATE constant varchar2(100) := q'~   ,p_par_date_value => date '#DATE#'~';
    C_TIMESTAMP_TEMPLATE constant varchar2(100) := q'~   ,p_par_timestamp_value => timestamp '#TIMESTAMP#'~';
    C_BOOLEAN_TEMPLATE constant varchar2(100) := q'~   ,p_par_boolean_value => #BOOLEAN#~';
    C_END_TEMPLATE constant varchar2(100) := q'^    
  commit;
end;
/^';
    l_script clob;
    l_chunk clob;
    l_clause varchar2(32767);
    
    procedure calc_clause(
      p_clause in out nocopy varchar2,
      p_value in varchar2,
      p_pattern in varchar2,
      p_template in varchar2)
    as
    begin
      if p_value is not null then
        p_clause := p_clause || chr(13) || replace(p_template, p_pattern, p_value);
      end if;
    end calc_clause;
  begin
    
    l_script := C_START_TEMPLATE;
    
    for par in local_param_cur loop
      calc_clause(l_clause, par.pal_string_value, '#STRING#', C_STRING_TEMPLATE);
      calc_clause(l_clause, par.pal_xml_value, '#XML#', C_XML_TEMPLATE);
      calc_clause(l_clause, par.pal_integer_value, '#INTEGER#', C_INTEGER_TEMPLATE);
      calc_clause(l_clause, par.pal_float_value, '#FLOAT#', C_FLOAT_TEMPLATE);
      calc_clause(l_clause, par.pal_date_value, '#DATE#', C_DATE_TEMPLATE);
      calc_clause(l_clause, par.pal_timestamp_value, '#TIMESTAMP#', C_TIMESTAMP_TEMPLATE);
      calc_clause(l_clause, par.pal_boolean_value, '#BOOLEAN#', C_BOOLEAN_TEMPLATE);
      l_chunk := replace(replace(replace(c_param_template,
                   '#PAL_ID#', par.pal_id),
                   '#PAL_PGR_ID#', par.pal_pgr_id),
                   '#CLAUSES#', l_clause);
      l_clause := null;
      dbms_lob.append(l_script, l_chunk);
      
    end loop;
    
    dbms_lob.append(l_script, C_END_TEMPLATE);
    return l_script;
  end get_parameters;
  
end param;
/
