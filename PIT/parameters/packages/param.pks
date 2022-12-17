create or replace  package param
  authid current_user
as
  /** Package to read and write parameter values */
  
    
  /** Method to validate a parameter if a validation string exists
   * %param  p_parameter  Parameter to check
   * %throws {*} - param_value_invalid_err, if validation failed or parameter does not exist or parameter is not modifiable
   */
  procedure validate_parameter(
    p_par_id parameter_v.par_id%type,
    p_par_pgr_id parameter_v.par_pgr_id%type,
    p_par_string_value in parameter_v.par_string_value%type default null,
    p_par_xml_value in parameter_v.par_xml_value%type default null,
    p_par_integer_value in parameter_v.par_integer_value%type default null,
    p_par_float_value in parameter_v.par_float_value%type default null,
    p_par_date_value in parameter_v.par_date_value%type default null,
    p_par_timestamp_value in parameter_v.par_timestamp_value%type default null,
    p_par_boolean_value in boolean default null);
   
   
  /** Sets more than one parameter value
   * %param  p_par_id      Name of the parameter
   * %param  p_par_pgr_id  Name of the parameter group
   * %param  p_par_pre_id      Name of the parameter realm
   * %param [p_string_value..p_boolean_value] Value of the parameter
   * %usage  Is called in two use cases:
   *         - You need to have more than one value for one parameter (the other methods set the value and null any other value)
   *         - You have a software that sets parameters generically which does not know what the type of the value is
   */
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
    p_par_boolean_value in boolean default null);
   
  /** Sets a String parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_par_pgr_id     Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %param [p_par_pre_id]    Name of the parameter realm
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_string(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_value in varchar2,
    p_par_pre_id in parameter_realm.pre_id%type default null);
   
  /** Sets a CLOB parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_par_pgr_id     Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %param [p_par_pre_id]    Name of the parameter realm
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_clob(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_v.par_string_value%type,
    p_par_pre_id in parameter_realm.pre_id%type default null);

  /** Sets an XML parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_par_pgr_id     Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %param [p_par_pre_id]    Name of the parameter realm
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_xml(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_v.par_xml_value%type,
    p_par_pre_id in parameter_realm.pre_id%type default null);

  /** Sets a String parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_par_pgr_id     Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %param [p_par_pre_id]    Name of the parameter realm
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_float(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_v.par_float_value%type,
    p_par_pre_id in parameter_realm.pre_id%type default null);

  /** Sets a String parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_par_pgr_id     Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %param [p_par_pre_id]    Name of the parameter realm
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_integer(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_v.par_integer_value%type,
    p_par_pre_id in parameter_realm.pre_id%type default null);

  /** Sets a String parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_par_pgr_id     Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %param [p_par_pre_id]    Name of the parameter realm
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_date(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_v.par_date_value%type,
    p_par_pre_id in parameter_realm.pre_id%type default null);

  /** Sets a String parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_par_pgr_id     Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %param [p_par_pre_id]    Name of the parameter realm
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_timestamp(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_v.par_timestamp_value%type,
    p_par_pre_id in parameter_realm.pre_id%type default null);

  /** Sets a String parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_par_pgr_id     Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %param [p_par_pre_id]    Name of the parameter realm
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_boolean(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_value in boolean,
    p_par_pre_id in parameter_realm.pre_id%type default null);
    

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_par_pgr_id  Name of the parameter group
   * %return VARCHAR2 value, size limite 32KByte
   * %usage  Is called by the end user to get a parameter value
   */
  function get_string(
   p_par_id in parameter_v.par_id%type,
   p_par_pgr_id in parameter_group.pgr_id%type)
   return varchar2;

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_par_pgr_id  Name of the parameter group
   * %return CLOB value
   * %usage  Is called by the end user to get a parameter value
   */
  function get_clob(
   p_par_id in parameter_v.par_id%type,
   p_par_pgr_id in parameter_group.pgr_id%type)
   return parameter_v.par_string_value%type;
   
  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_par_pgr_id  Name of the parameter group
   * %return XMLType value
   * %usage  Is called by the end user to get a parameter value
   */
  function get_xml(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type)
    return parameter_v.par_xml_value%type;

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_par_pgr_id  Name of the parameter group
   * %return Number value
   * %usage  Is called by the end user to get a parameter value
   */
  function get_float(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type)
    return parameter_v.par_float_value%type;

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_par_pgr_id  Name of the parameter group
   * %return Integer value
   * %usage  Is called by the end user to get a parameter value
   */
  function get_integer(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type)
    return parameter_v.par_integer_value%type;

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_par_pgr_id  Name of the parameter group
   * %return Date value
   * %usage  Is called by the end user to get a parameter value
   */
  function get_date(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type)
    return parameter_v.par_date_value%type;

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_par_pgr_id  Name of the parameter group
   * %return Timestamp with time zone value
   * %usage  Is called by the end user to get a parameter value
   */
  function get_timestamp(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type)
    return parameter_v.par_timestamp_value%type;

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_par_pgr_id  Name of the parameter group
   * %return Boolean value
   * %usage  Is called by the end user to get a parameter value
   */
  function get_boolean(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type)
    return boolean;
    
  
  /** Method to reset a parameter to its default value
   * %param  p_par_id  Name of the parameter
   * %param  p_par_pgr_id  Name of the parameter group
   * %param  p_par_pre_id  Name of the parameter realm
   * %usage  Is used to remove a local setting. If removed, the default parameter value is active again.
   */
  procedure reset_parameter(
    p_par_id in parameter_v.par_id%type,
    p_par_pgr_id in parameter_group.pgr_id%type,
    p_par_pre_id in parameter_realm.pre_id%type default null);
    
  
  /** Method to create an installation script for the locally defined parameters
   * %return CLOB instance containing a script with all locally overwritten or defined parameters
   * %usage  Is used to export local settings. Defined here and not at PARAM_ADMIN as this package runs with
   *         current user settings and has therefore access to the locally defined PARAMETER_LOCAL
   */
  function get_parameters
    return clob;

end param;
/
