create or replace  package param
as
  /** Package to read and write parameter values
   */
   
  /* Sets a String parameter value
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %param p_parameter_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_string(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2,
    p_parameter_value in clob,
    p_is_modifiable in boolean default false);

  /* Sets a String parameter value
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %param p_parameter_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_xml(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2,
    p_parameter_value in xmltype,
    p_is_modifiable in boolean default false);

  /* Sets a String parameter value
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %param p_parameter_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_float(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2,
    p_parameter_value in number,
    p_is_modifiable in boolean default false);

  /* Sets a String parameter value
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %param p_parameter_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_integer(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2,
    p_parameter_value in number,
    p_is_modifiable in boolean default false);

  /* Sets a String parameter value
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %param p_parameter_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_date(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2,
    p_parameter_value in date,
    p_is_modifiable in boolean default false);

  /* Sets a String parameter value
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %param p_parameter_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_timestamp(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2,
    p_parameter_value in timestamp with time zone,
    p_is_modifiable in boolean default false);

  /* Sets a String parameter value
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %param p_parameter_value Value of the parameter
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %usage Is called by the end user to set a new parameter value
   */
  procedure set_boolean(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2,
    p_parameter_value in boolean,
    p_is_modifiable in boolean default false);

  /* Reads a parameter value
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %return CLOB value
   * %usage Is called by the end user to get a parameter value
   */
  function get_string(
   p_parameter_id in varchar2,
   p_parameter_group_id in varchar2)
   return clob;

  /* Reads a parameter value
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %return XMLType value
   * %usage Is called by the end user to get a parameter value
   */
  function get_xml(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2)
    return xmltype;

  /* Reads a parameter value
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %return Number value
   * %usage Is called by the end user to get a parameter value
   */
  function get_float(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2)
    return number;

  /* Reads a parameter value
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %return Integer value
   * %usage Is called by the end user to get a parameter value
   */
  function get_integer(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2)
    return number;

  /* Reads a parameter value
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %return Date value
   * %usage Is called by the end user to get a parameter value
   */
  function get_date(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2)
    return date;

  /* Reads a parameter value
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %return Timestamp with time zone value
   * %usage Is called by the end user to get a parameter value
   */
  function get_timestamp(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2)
    return timestamp with time zone;

  /* Reads a parameter value
   * %param p_parameter_id Name of the parameter
   * %param p_parameter_group_id Name of the parameter group
   * %return Boolean value
   * %usage Is called by the end user to get a parameter value
   */
  function get_boolean(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2)
    return boolean;

end param;
/
