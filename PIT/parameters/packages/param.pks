create or replace  package param
  authid current_user
as
  /** Package to read and write parameter values */
   
  /** Sets more than one parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_pgr_id         Name of the parameter group
   * %param [p_string_value..p_boolean_value] Value of the parameter
   * %usage  Is called in two use cases:
   *         - You need to have more than one value for one parameter (the other methods set the value and null any other value)
   *         - You have a software that sets parameters generically which does not know what the type of the value is
   */
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
    p_par_boolean_value in boolean default null);
   
  /** Sets a String parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_pgr_id         Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_string(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in varchar2);
   
  /** Sets a CLOB parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_pgr_id         Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_clob(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_string_value%type);
   
  /** Sets a Raw parameter value (cast to varchar2)
   * %param  p_par_id         Name of the parameter
   * %param  p_pgr_id         Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_raw(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in raw);
   
  /** Sets a BLOB parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_pgr_id         Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_blob(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_raw_value%type);

  /** Sets an XML parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_pgr_id         Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_xml(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_xml_value%type);

  /** Sets a String parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_pgr_id         Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_float(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_float_value%type);

  /** Sets a String parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_pgr_id         Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_integer(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_integer_value%type);

  /** Sets a String parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_pgr_id         Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_date(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_date_value%type);

  /** Sets a String parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_pgr_id         Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_timestamp(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in parameter_tab.par_timestamp_value%type);

  /** Sets a String parameter value
   * %param  p_par_id         Name of the parameter
   * %param  p_pgr_id         Name of the parameter group
   * %param  p_par_value      Value of the parameter
   * %usage  Is called by the end user to set a new parameter value
   */
  procedure set_boolean(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type,
    p_par_value in boolean);
    

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_pgr_id  Name of the parameter group
   * %return VARCHAR2 value, size limite 32KByte
   * %usage  Is called by the end user to get a parameter value
   */
  function get_string(
   p_par_id in parameter_tab.par_id%type,
   p_pgr_id in parameter_group.pgr_id%type)
   return varchar2;

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_pgr_id  Name of the parameter group
   * %return CLOB value
   * %usage  Is called by the end user to get a parameter value
   */
  function get_clob(
   p_par_id in parameter_tab.par_id%type,
   p_pgr_id in parameter_group.pgr_id%type)
   return parameter_tab.par_string_value%type;

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_pgr_id  Name of the parameter group
   * %return RAW value
   * %usage  Is called by the end user to get a parameter value
   */
  function get_raw(
   p_par_id in parameter_tab.par_id%type,
   p_pgr_id in parameter_group.pgr_id%type)
   return raw;

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_pgr_id  Name of the parameter group
   * %return RAW value
   * %usage  Is called by the end user to get a parameter value
   */
  function get_blob(
   p_par_id in parameter_tab.par_id%type,
   p_pgr_id in parameter_group.pgr_id%type)
   return parameter_tab.par_raw_value%type;

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_pgr_id  Name of the parameter group
   * %return XMLType value
   * %usage  Is called by the end user to get a parameter value
   */
  function get_xml(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_tab.par_xml_value%type;

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_pgr_id  Name of the parameter group
   * %return Number value
   * %usage  Is called by the end user to get a parameter value
   */
  function get_float(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_tab.par_float_value%type;

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_pgr_id  Name of the parameter group
   * %return Integer value
   * %usage  Is called by the end user to get a parameter value
   */
  function get_integer(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_tab.par_integer_value%type;

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_pgr_id  Name of the parameter group
   * %return Date value
   * %usage  Is called by the end user to get a parameter value
   */
  function get_date(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_tab.par_date_value%type;

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_pgr_id  Name of the parameter group
   * %return Timestamp with time zone value
   * %usage  Is called by the end user to get a parameter value
   */
  function get_timestamp(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_tab.par_timestamp_value%type;

  /** Reads a parameter value
   * %param  p_par_id  Name of the parameter
   * %param  p_pgr_id  Name of the parameter group
   * %return Boolean value
   * %usage  Is called by the end user to get a parameter value
   */
  function get_boolean(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return boolean;
    
  
  /** Method to reset a parameter to its default value
   * %param  p_par_id  Name of the parameter
   * %param  p_pgr_id  Name of the parameter group
   * %usage  Is used to remove a local setting. If removed, the default parameter value is active again.
   */
  procedure reset_parameter(
    p_par_id in parameter_tab.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type);
    
  
  /** Method to create an installation script for the locally defined parameters
   * %return CLOB instance containing a script with all locally overwritten or defined parameters
   * %usage  Is used to export local settings. Defined here and not at PARAM_ADMIN as this package runs with
   *         current user settings and has therefore access to the locally defined PARAMETER_LOCAL
   */
  function get_parameters
    return clob;

end param;
/
