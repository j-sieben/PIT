create or replace  package param
  authid current_user
as
  /** Package to read and write parameter values
   */
   
  /* Sets a String parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %param p_par_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_string(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in varchar2,
    p_is_modifiable in boolean default false);
   
  /* Sets a CLOB parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %param p_par_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_clob(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_string_value%type,
    p_is_modifiable in boolean default false);
   
  /* Sets a Raw parameter value (cast to varchar2)
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %param p_par_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_raw(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in raw,
    p_is_modifiable in boolean default false);
   
  /* Sets a BLOB parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %param p_par_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_blob(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_raw_value%type,
    p_is_modifiable in boolean default false);

  /* Sets an XML parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %param p_par_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_xml(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_xml_value%type,
    p_is_modifiable in boolean default false);

  /* Sets a String parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %param p_par_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_float(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_float_value%type,
    p_is_modifiable in boolean default false);

  /* Sets a String parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %param p_par_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_integer(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_integer_value%type,
    p_is_modifiable in boolean default false);

  /* Sets a String parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %param p_par_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_date(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_date_value%type,
    p_is_modifiable in boolean default false);

  /* Sets a String parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %param p_par_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_timestamp(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_timestamp_value%type,
    p_is_modifiable in boolean default false);

  /* Sets a String parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %param p_par_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_boolean(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in boolean,
    p_is_modifiable in boolean default false);

  /* Reads a parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %return VARCHAR2 value, size limite 32KByte
   * %usage Is called by the end user to get a parameter value
   */
  function get_string(
   p_par_id in parameter_tab.par_id%type,
   p_pgr_id in parameter_group.pgr_id%type)
   return varchar2;

  /* Reads a parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %return CLOB value
   * %usage Is called by the end user to get a parameter value
   */
  function get_clob(
   p_par_id in parameter_tab.par_id%type,
   p_pgr_id in parameter_group.pgr_id%type)
   return parameter_tab.par_string_value%type;

  /* Reads a parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %return RAW value
   * %usage Is called by the end user to get a parameter value
   */
  function get_raw(
   p_par_id in parameter_tab.par_id%type,
   p_pgr_id in parameter_group.pgr_id%type)
   return raw;

  /* Reads a parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %return RAW value
   * %usage Is called by the end user to get a parameter value
   */
  function get_blob(
   p_par_id in parameter_tab.par_id%type,
   p_pgr_id in parameter_group.pgr_id%type)
   return parameter_tab.par_raw_value%type;

  /* Reads a parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %return XMLType value
   * %usage Is called by the end user to get a parameter value
   */
  function get_xml(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_tab.par_xml_value%type;

  /* Reads a parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %return Number value
   * %usage Is called by the end user to get a parameter value
   */
  function get_float(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_tab.par_float_value%type;

  /* Reads a parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %return Integer value
   * %usage Is called by the end user to get a parameter value
   */
  function get_integer(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_tab.par_integer_value%type;

  /* Reads a parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %return Date value
   * %usage Is called by the end user to get a parameter value
   */
  function get_date(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_tab.par_date_value%type;

  /* Reads a parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %return Timestamp with time zone value
   * %usage Is called by the end user to get a parameter value
   */
  function get_timestamp(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_tab.par_timestamp_value%type;

  /* Reads a parameter value
   * %param p_par_id Name of the parameter
   * %param p_pgr_id Name of the parameter group
   * %return Boolean value
   * %usage Is called by the end user to get a parameter value
   */
  function get_boolean(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return boolean;

end param;
/
