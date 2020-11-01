create or replace package body param
as

  c_true constant parameter_group.pgr_is_modifiable%type := &C_TRUE.;
  c_false constant parameter_group.pgr_is_modifiable%type := &C_FALSE.;
  c_max_char_length constant number := 32767;
  c_max_raw_length constant number := 2000;
  
  g_parameter_rec parameter_tab%rowtype;
  
  type param_rec is record(
    is_modifiable boolean,
    is_existing boolean,
    validation_string parameter_tab.par_validation_string%type,
    validation_message parameter_tab.par_validation_message%type);
  g_param param_rec;

  /* Helper */  
  /* Procedure reads metadata for parameters
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %usage Is called internally to read settings regarding modifiability etc.
   */
  procedure get_parameter_settings(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
  as
    l_pgr_is_modifiable parameter_group.pgr_is_modifiable%type := c_false;
    l_par_is_modifiable parameter_tab.par_is_modifiable%type := c_false;
    l_is_existing char(1);
  begin
    select -- Ist Gruppe nicht modifizierbar, Einzeleinstellung uebersteuern,
           -- ansonsten Parametereinstellung
           case
             when pg.pgr_is_modifiable = c_true then
               coalesce(p.par_is_modifiable, c_true)
             else
               c_false
           end is_modifiable,
           -- Nur existierende Parameter duerfen editiert werden
           -- (Neuanlage von Parametern ueber PARAM_ADMIN)
           nvl2(p.par_id, c_true, c_false) is_existing,
           par_validation_string,
           par_validation_message
      into l_par_is_modifiable,
           l_is_existing,
           g_param.validation_string,
           g_param.validation_message
      from &INSTALL_USER..parameter_group pg
      left join
           (select *
              from &INSTALL_USER..parameter_tab p
             where par_id = p_par_id
               and par_pgr_id = p_pgr_id) p
        on pg.pgr_id = p.par_pgr_id
     where pg.pgr_id = p_pgr_id;
    g_param.is_modifiable := l_par_is_modifiable = c_true;
    g_param.is_existing := l_is_existing = c_true;
  exception
    when no_data_found then
      g_param.is_modifiable := false;
      g_param.validation_string := null;
      g_param.validation_message := null;
      raise;
  end get_parameter_settings;


  /* Helper procedure to convert a char into a boolean value
   * %param p_boolean_value char value representign a boolean value: Y|N
   * %param p_return_value boolean result true|false|null
   * %usage Is called internally to convert a boolea parameter into a boolean value.
   */
  procedure get_bool(
    p_boolean_value in boolean,
    p_return_value out nocopy varchar2)
  as
  begin
    case
      when p_boolean_value is null then
        p_return_value := null;
      when p_boolean_value then
        p_return_value := c_true;
      else
        p_return_value := c_false;
    end case;
  end get_bool;


  /* Helper method to read a row of parameter into a record
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %usage Is called internally by the Getter Methods to copy a row of parameter
   *        into the global variable g_parameter_rec.
   */
  procedure get_parameter(
    p_par_id in varchar2,
    p_pgr_id in varchar2)
  as
  begin
    select *
      into g_parameter_rec
      from parameter_vw
     where par_id = p_par_id
       and par_pgr_id = p_pgr_id;
  exception
    when no_data_found then
      dbms_output.put_line('Parameter ' || p_par_id || ' not found in ' || p_pgr_id);
  end get_parameter;


  /* SETTER */
  procedure set_multiple(
    p_par_id in varchar2,
    p_pgr_id in varchar2,
    p_par_string_value in parameter_tab.par_string_value%type default null,
    p_par_raw_value in parameter_tab.par_raw_value%type default null,
    p_par_xml_value in xmltype default null,
    p_par_integer_value in number default null,
    p_par_float_value in number default null,
    p_par_date_value in date default null,
    p_par_timestamp_value in timestamp with time zone default null,
    p_par_boolean_value in boolean default null)
  as
    l_boolean char(1);
    l_stmt varchar2(4000);
    l_valid integer;
  begin
    get_parameter_settings(p_par_id, p_pgr_id);
    get_bool(p_par_boolean_value, l_boolean);
    -- Validiere Parameter
    if g_param.validation_string is not null then
      -- Erzeuge Validierungsanweisung
      l_stmt := g_param.validation_string;
      l_stmt := replace(l_stmt, '#STRING#', p_par_string_value);
      l_stmt := replace(l_stmt, '#DATE#', case when p_par_date_value is not null then 'timestamp ''' || to_char(p_par_date_value, 'yyyy-mm-dd hh24:mi:ss') || '''' else 'NULL' end);
      l_stmt := replace(l_stmt, '#FLOAT#', p_par_float_value);
      l_stmt := replace(l_stmt, '#INTEGER#', p_par_integer_value);
      l_stmt := replace(l_stmt, '#BOOLEAN#', case when p_par_boolean_value then dbms_assert.enquote_literal(C_TRUE) else dbms_assert.enquote_literal(C_FALSE) end);
      l_stmt := 'begin if ' || l_stmt || ' then :x := 1; else :x := 0; end if; end;';
      -- Validiere den Ausdruck
      execute immediate l_stmt using out l_valid;
      if l_valid != 1 then
        -- Validierung fehlgeschlagen, Fehler erzeugen
        raise_application_error(-20000, g_param.validation_message);
      end if;
    end if;
    if g_param.is_existing and g_param.is_modifiable then
      merge into parameter_local p
      using (select p_par_id pal_id,
                    p_pgr_id pal_pgr_id,
                    p_par_string_value pal_string_value,
                    p_par_raw_value pal_raw_value,
                    p_par_xml_value pal_xml_value,
                    p_par_integer_value pal_integer_value,
                    p_par_float_value pal_float_value,
                    p_par_date_value pal_date_value,
                    p_par_timestamp_value pal_timestamp_value,
                    l_boolean pal_boolean_value
               from dual) v
         on (p.pal_id = v.pal_id
         and p.pal_pgr_id = v.pal_pgr_id)
       when matched then update set
            p.pal_string_value = v.pal_string_value,
            p.pal_raw_value = v.pal_raw_value,
            p.pal_xml_value = v.pal_xml_value,
            p.pal_integer_value = v.pal_integer_value,
            p.pal_float_value = v.pal_float_value,
            p.pal_date_value = v.pal_date_value,
            p.pal_timestamp_value = v.pal_timestamp_value,
            p.pal_boolean_value = v.pal_boolean_value
       when not matched then insert
            (pal_id, pal_pgr_id, pal_string_value, pal_raw_value, pal_xml_value, pal_integer_value, 
             pal_float_value, pal_date_value, pal_timestamp_value, pal_boolean_value)
            values
            (v.pal_id, v.pal_pgr_id, v.pal_string_value, v.pal_raw_value, v.pal_xml_value, v.pal_integer_value, 
             v.pal_float_value, v.pal_date_value, v.pal_timestamp_value, v.pal_boolean_value);
    end if;
  end set_multiple;
  
  
  procedure set_string(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in varchar2)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_pgr_id => p_pgr_id,
      p_par_string_value => to_clob(p_par_value));
  end set_string;
  
  procedure set_clob(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_string_value%type)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_pgr_id => p_pgr_id,
      p_par_string_value => p_par_value);
  end set_clob;
  
  procedure set_raw(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in raw)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_pgr_id => p_pgr_id,
      p_par_raw_value => to_blob(p_par_value));
  end set_raw;
  
  procedure set_blob(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_raw_value%type)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_pgr_id => p_pgr_id,
      p_par_raw_value => p_par_value);
  end set_blob;

  procedure set_xml(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_xml_value%type)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_pgr_id => p_pgr_id,
      p_par_xml_value => p_par_value);
  end set_xml;

  procedure set_float(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_float_value%type)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_pgr_id => p_pgr_id,
      p_par_float_value => p_par_value);
  end set_float;

  procedure set_integer(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_integer_value%type)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_pgr_id => p_pgr_id,
      p_par_integer_value => p_par_value);
  end set_integer;

  procedure set_date(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_date_value%type)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_pgr_id => p_pgr_id,
      p_par_date_value => p_par_value);
  end set_date;

  procedure set_timestamp(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_timestamp_value%type)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_pgr_id => p_pgr_id,
      p_par_timestamp_value => p_par_value);
  end set_timestamp;

  procedure set_boolean(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in boolean)
  as
  begin
    set_multiple(
      p_par_id => p_par_id,
      p_pgr_id => p_pgr_id,
      p_par_boolean_value => p_par_value);
  end set_boolean;


  /* GETTER */
  function get_string(
   p_par_id in parameter_tab.par_id%type,
   p_pgr_id in parameter_group.pgr_id%type)
   return varchar2
  as
  begin
    get_parameter(p_par_id, p_pgr_id);
    return dbms_lob.substr(g_parameter_rec.par_string_value, c_max_char_length, 1);
  end get_string;
  
  function get_clob(
   p_par_id in parameter_tab.par_id%type,
   p_pgr_id in parameter_group.pgr_id%type)
   return parameter_tab.par_string_value%type
  as
  begin
    get_parameter(p_par_id, p_pgr_id);
    return g_parameter_rec.par_string_value;
  end get_clob;
  
  function get_raw(
   p_par_id in parameter_tab.par_id%type,
   p_pgr_id in parameter_group.pgr_id%type)
   return raw
  as
  begin
    get_parameter(p_par_id, p_pgr_id);
    return dbms_lob.substr(g_parameter_rec.par_raw_value, c_max_raw_length, 1);
  end get_raw;
  
  function get_blob(
   p_par_id in parameter_tab.par_id%type,
   p_pgr_id in parameter_group.pgr_id%type)
   return parameter_tab.par_raw_value%type
  as
  begin
    get_parameter(p_par_id, p_pgr_id);
    return g_parameter_rec.par_raw_value;
  end get_blob;

  function get_xml(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_tab.par_xml_value%type
  as
  begin
    get_parameter(p_par_id, p_pgr_id);
    return g_parameter_rec.par_xml_value;
  end get_xml;

  function get_float(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_tab.par_float_value%type
  as
  begin
    get_parameter(p_par_id, p_pgr_id);
    return g_parameter_rec.par_float_value;
  end get_float;

  function get_integer(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_tab.par_integer_value%type
  as
  begin
    get_parameter(p_par_id, p_pgr_id);
    return g_parameter_rec.par_integer_value;
  end get_integer;

  function get_date(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_tab.par_date_value%type
  as
  begin
    get_parameter(p_par_id, p_pgr_id);
    return g_parameter_rec.par_date_value;
  end get_date;

  function get_timestamp(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_tab.par_timestamp_value%type
  as
  begin
    get_parameter(p_par_id, p_pgr_id);
    return g_parameter_rec.par_timestamp_value;
  end get_timestamp;

  function get_boolean(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return boolean
  as
  begin
    get_parameter(p_par_id, p_pgr_id);
    return g_parameter_rec.par_boolean_value = c_true;
  end get_boolean;
  
  
  procedure reset_parameter(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
  as
  begin
    delete from parameter_local
     where pal_pgr_id = p_pgr_id
       and pal_id = p_par_id;
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
   ,p_pgr_id => '#PAL_PGR_ID#'#CLAUSES#);
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
