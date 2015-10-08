create or replace package body param
as
  g_parameter_rec parameter%rowtype;
  type param_rec is record(
    is_modifiable boolean,
    is_existing boolean,
    validation_string parameter_tab.validation_string%type,
    validation_message parameter_tab.validation_message%type);
  g_param param_rec;

  /* Helper */
  procedure initialize
  as
  begin
    null;
  end initialize;

  /* Procedure reads metadata for parameters
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %usage Is called internally to read settings regarding modifiability etc.
   */
  procedure get_parameter_settings(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2)
  as
    l_is_group_modifiable parameter_group.is_modifiable%type := 'N';
    l_is_modifiable parameter_tab.is_modifiable%type := 'N';
    l_is_existing char(1);
  begin
    select -- Ist Gruppe nicht modifizierbar, Einzeleinstellung uebersteuern,
           -- ansonsten Parametereinstellung
           case
             when pg.is_modifiable = 'Y' then
               nvl(p.is_modifiable, 'Y')
             else
               'N'
           end is_modifiable,
		   -- Nur existierende Parameter duerfen editiert werden
		   -- (Neuanlage von Parametern ueber PARAM_ADMIN)
           nvl2(p.parameter_id, 'Y', 'N') is_existing,
           validation_string,
           validation_message
      into l_is_modifiable,
           l_is_existing,
           g_param.validation_string,
           g_param.validation_message
      from &INSTALL_USER..parameter_group pg
      left join
           (select *
              from parameter p
             where parameter_id = p_parameter_id
               and parameter_group_id = p_parameter_group_id) p
        on pg.parameter_group_id = p.parameter_group_id
     where pg.parameter_group_id = p_parameter_group_id;
    g_param.is_modifiable := l_is_modifiable = 'Y';
    g_param.is_existing := l_is_existing = 'Y';
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
        p_return_value := 'Y';
      else
        p_return_value := 'N';
    end case;
  end get_bool;


  /* Helper to store a new parameter value at the database
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %param p_string_value CLOB parameter value
   * %param p_xml_value XML parameter value
   * %param p_integer_value Integer parameter value
   * %param p_float_value Float parameter value
   * %param p_date_value Date parameter value
   * %param p_timestamp_value Timestamp with time zone parameter value
   * %param p_boolean_value Boolean parameter value
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called from the Setter Methods to adjust a parameter value.
   */
  procedure set_parameter(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2,
    p_string_value in clob default null,
    p_xml_value in xmltype default null,
    p_integer_value in number default null,
    p_float_value in number default null,
    p_date_value in date default null,
    p_timestamp_value in timestamp with time zone default null,
    p_boolean_value in boolean default null,
    p_is_modifiable in boolean)
  as
    l_boolean char(1);
    l_stmt varchar2(4000);
    l_valid integer;
  begin
    get_parameter_settings(p_parameter_id, p_parameter_group_id);
    get_bool(p_boolean_value, l_boolean);
    -- Validiere Parameter
    if g_param.validation_string is not null then
      -- Erzeuge Validierungsanweisung
      l_stmt := g_param.validation_string;
      l_stmt := replace(l_stmt, '#STRING#', p_string_value);
      l_stmt := replace(l_stmt, '#DATE#', p_date_value);
      l_stmt := replace(l_stmt, '#FLOAT#', p_float_value);
      l_stmt := replace(l_stmt, '#INTEGER#', p_integer_value);
      l_stmt := 'begin if ' || l_stmt
             || ' then :x := 1; else :x := 0; end if; end;';
      -- Validiere den Ausdruck
      execute immediate l_stmt using out l_valid;
      if l_valid != 1 then
        -- Validierung fehlgeschlagen, Fehler erzeugen
        raise_application_error(-20000, g_param.validation_message);
      end if;
    end if;
    if g_param.is_existing and g_param.is_modifiable then
      merge into parameter_tab p
      using (select p_parameter_id parameter_id,
                    p_parameter_group_id parameter_group_id,
                    p_string_value string_value,
                    p_xml_value xml_value,
                    p_integer_value integer_value,
                    p_float_value float_value,
                    p_date_value date_value,
                    p_timestamp_value timestamp_value,
                    l_boolean boolean_value
               from dual) v
         on (p.parameter_id = v.parameter_id
         and p.parameter_group_id = v.parameter_group_id)
       when matched then update set
            p.string_value = v.string_value,
            p.xml_value = v.xml_value,
            p.integer_value = v.integer_value,
            p.float_value = v.float_value,
            p.date_value = v.date_value,
            p.timestamp_value = v.timestamp_value,
            p.boolean_value = v.boolean_value
       when not matched then insert
            (parameter_id, parameter_group_id, string_value, xml_value,
             integer_value, float_value, date_value, timestamp_value,
             boolean_value)
            values
            (v.parameter_id, v.parameter_group_id, v.string_value, v.xml_value,
             v.integer_value, v.float_value, v.date_value, v.timestamp_value,
             v.boolean_value);
    end if;
  end set_parameter;


  /* Helper method to read a row of parameter into a record
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %usage Is called internally by the Getter Methods to copy a row of parameter
   *        into the global variable g_parameter_rec.
   */
  procedure get_parameter(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2)
  as
  begin
    select *
      into g_parameter_rec
      from parameter
     where parameter_id = p_parameter_id
       and parameter_group_id = p_parameter_group_id;
  end get_parameter;


  /* SETTER */
  procedure set_string(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2,
    p_parameter_value in clob,
    p_is_modifiable in boolean default false)
  as
  begin
    set_parameter(
      p_parameter_id => p_parameter_id,
      p_parameter_group_id => p_parameter_group_id,
      p_string_value => p_parameter_value,
      p_is_modifiable => p_is_modifiable);
  end set_string;

  procedure set_xml(
  p_parameter_id in varchar2,
  p_parameter_group_id in varchar2,
  p_parameter_value in xmltype,
  p_is_modifiable in boolean default false)
  as
  begin
    set_parameter(
      p_parameter_id => p_parameter_id,
      p_parameter_group_id => p_parameter_group_id,
      p_xml_value => p_parameter_value,
      p_is_modifiable => p_is_modifiable);
  end set_xml;

  procedure set_integer(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2,
    p_parameter_value in number,
    p_is_modifiable in boolean default false)
  as
  begin
    set_parameter(
      p_parameter_id => p_parameter_id,
      p_parameter_group_id => p_parameter_group_id,
      p_integer_value => p_parameter_value,
      p_is_modifiable => p_is_modifiable);
  end set_integer;

  procedure set_float(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2,
    p_parameter_value in number,
    p_is_modifiable in boolean default false)
  as
  begin
    set_parameter(
      p_parameter_id => p_parameter_id,
      p_parameter_group_id => p_parameter_group_id,
      p_float_value => p_parameter_value,
      p_is_modifiable => p_is_modifiable);
  end set_float;

  procedure set_date(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2,
    p_parameter_value in date,
    p_is_modifiable in boolean default false)
  as
  begin
    set_parameter(
      p_parameter_id => p_parameter_id,
      p_parameter_group_id => p_parameter_group_id,
      p_date_value => p_parameter_value,
      p_is_modifiable => p_is_modifiable);
  end set_date;

  procedure set_timestamp(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2,
    p_parameter_value in timestamp with time zone,
    p_is_modifiable in boolean default false)
  as
  begin
    set_parameter(
      p_parameter_id => p_parameter_id,
      p_parameter_group_id => p_parameter_group_id,
      p_timestamp_value => p_parameter_value,
      p_is_modifiable => p_is_modifiable);
  end set_timestamp;

  procedure set_boolean(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2,
    p_parameter_value in boolean,
    p_is_modifiable in boolean default false)
  as
  begin
    set_parameter(
      p_parameter_id => p_parameter_id,
      p_parameter_group_id => p_parameter_group_id,
      p_boolean_value => p_parameter_value,
      p_is_modifiable => p_is_modifiable);
  end set_boolean;


  /* GETTER */
  function get_string(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2)
    return clob
  as
  begin
    get_parameter(p_parameter_id, p_parameter_group_id);
    return g_parameter_rec.string_value;
  end get_string;

  function get_xml(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2)
    return xmltype
  as
  begin
    get_parameter(p_parameter_id, p_parameter_group_id);
    return g_parameter_rec.xml_value;
  end get_xml;

  function get_float(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2)
    return number
  as
  begin
    get_parameter(p_parameter_id, p_parameter_group_id);
    return g_parameter_rec.float_value;
  end get_float;

  function get_integer(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2)
    return number
  as
  begin
    get_parameter(p_parameter_id, p_parameter_group_id);
    return g_parameter_rec.integer_value;
  end get_integer;

  function get_date(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2)
    return date
  as
  begin
    get_parameter(p_parameter_id, p_parameter_group_id);
    return g_parameter_rec.date_value;
  end get_date;

  function get_timestamp(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2)
    return timestamp with time zone
  as
  begin
    get_parameter(p_parameter_id, p_parameter_group_id);
    return g_parameter_rec.timestamp_value;
  end get_timestamp;

  function get_boolean(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2)
    return boolean
  as
  begin
    get_parameter(p_parameter_id, p_parameter_group_id);
    return g_parameter_rec.boolean_value = 'Y';
  end get_boolean;

begin
  initialize;
end param;
/
