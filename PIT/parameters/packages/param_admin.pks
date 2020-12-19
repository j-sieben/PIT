create or replace package param_admin
  authid definer
as

  /** Package to maintain settings for parameter groups */
  
    
  param_value_invalid_err exception;
  pragma exception_init(param_value_invalid_err, -20000);
  
  
  /* Procedure reads metadata for parameters
   * %param  p_par_id      Name of the parameter
   * %param  p_par_pgr_id  Name of the parameter group
   * %return Instance of PARAMETER_VW that contains all parameter related data
   *         with the exception of the concreate parameter values
   * %usage  Is called to read settings regarding modifiability etc. Is used internally
   *         and from PARAM pkg
   */
  function get_parameter_settings(
    p_par_id in parameter_vw.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_vw%rowtype;
    
  
  /** Method to validate a parameter group
   * %param  p_row  PARAMETER_GROUP record to validate
   * %usage  Is used to validate a parameter_group entry prior to writing it to db
   */
  procedure validate_parameter_group(
    p_row in parameter_group%rowtype);
  
  
  /* Procedure to change the definition of a parameter group
   * %param  p_pgr_id             Name of the parameter group
   * %param  p_pgr_description    Longtext description of the parameter group
   * %param  p_pgr_is_modifiable  Flag indicating whether parameters within this group
   *                              are allowed to be modifiable by the end user
   * %usage  Is called by the developer to maintain the settings of a parameter group.
   *         May be used to create a new parameter group as well.
   */
  procedure edit_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type,
    p_pgr_description in parameter_group.pgr_description%type,
    p_pgr_is_modifiable in boolean default true);
  
  
  /** Method to change the definition of a parameter group
   * %param  p_row  PARAMETER_GROUP record to validate
   * %usage  Is called by the developer to maintain the settings of a parameter group.
   *         May be used to create a new parameter group as well.
   */
  procedure edit_parameter_group(
    p_row in parameter_group%rowtype);
    
  
  /** Procedure to delete a parameter group
   * %param  p_pgr_id  Name of the parameter group
   * %param [p_force]  Optional flag to indicate whether all referencing parameters should be deleted (TRUE)
   *                   or not (FALSE, default)
   * %usage  Is called by the developer to delete a parameter group.
   */
  procedure delete_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type,
    p_force in boolean default false);


  /* Procedure to change the definition of a parameter realm
   * %param  p_pre_id           Name of the parameter realm
   * %param  p_pre_description  Longtext description of the parameter realm
   * %param  p_pgr_is_active    Flag to indicate whether realm is in use actually
   * %usage  Is called by the developer to maintain the settings of a parameter realm.
   *         May be used to create a new parameter realm as well.
   */
  procedure edit_parameter_realm(
    p_pre_id in parameter_realm.pre_id%type,
    p_pre_description in parameter_realm.pre_description%type,
    p_pre_is_active in boolean default true);


  /* Procedure to change the definition of a parameter realm
   * %param  p_row  PARAMETER_REALM record
   * %usage  Is called by the developer to maintain the settings of a parameter realm.
   *         May be used to create a new parameter realm as well.
   */
  procedure edit_parameter_realm(
    p_row in parameter_realm%rowtype);


  /** Method to delete a parameter realm
   * %param  p_pre_id  ID of the parameter realm to delete
   * %param [p_force]  Flag to indicate whether local parameters of this realm are to be deleted (TRUE)
   *                   or whether an error is thrown if the realm is in use (FALSE)
   * %usage  Is used to remove a parameter realm
   */
  procedure delete_parameter_realm(
    p_pre_id in parameter_realm.pre_id%type,
    p_force in boolean default false);
	
  
  /* Procedure to edit the definition of a parameter type.
   * %param p_pat_id Name of the parameter type
   * %param p_pat_description Longtext description of the parameter type
   * %usage Procedure is called by the developer to edit parameter types.
   *        Paramater types are used to define the kind of string type a parameter
   *        has. Examples are HTML, SQL or similar. They are used to control 
   *        which editer is used to edit the parameter value on the UI
   */
  procedure edit_parameter_type(
    p_pat_id in parameter_type.pat_id%type,
	  p_pat_description in parameter_type.pat_description%type);
    
    
  /** Method to validate a parameter if a validation string exists
   * %param  p_parameter  Parameter to check
   * %throws param_value_invalid_err
   */
  procedure validate_parameter(
    p_row in parameter_vw%rowtype);
	
  
  /* Procedure to edit a parameter
   * %param  p_par_id                  Name of the parameter
   * %param  p_par_pgr_id              Name of the parameter group   
   * %param [p_par_description]        Optional description of the parameter
   * %param [p_par_string_value]       CLOB parameter value
   * %param [p_par_xml_value]          XML parameter value
   * %param [p_par_integer_value]      Integer parameter value
   * %param [p_par_float_value]        Float parameter value
   * %param [p_par_date_value]         Date parameter value
   * %param [p_par_timestamp_value]    Timestamp with time zone parameter value
   * %param [p_par_boolean_value]      Boolean parameter value
   * %param [p_pgr_is_modifiable]      Flag indicating whether this parameter is modifiable by the end user
   * %param [p_par_pat_id]             String type of the parameter, Reference to PARAMETER_TYPE.
   * %param [p_par_validation_string]  PL/SQL-chunk to validate a parameter value entered. Is used to validate parameter values
   * %param [p_par_validation_message] Name of a Message that is thrown if a validation of the parameter fails.
   * %usage  Is called from the developer to create or change a parameter.
   */
  procedure edit_parameter(
    p_par_id in parameter_tab.par_id%type,
    p_par_pgr_id in parameter_tab.par_pgr_id%type,
	  p_par_description in parameter_tab.par_description%type default null,
    p_par_string_value in parameter_tab.par_string_value%type default null,
    p_par_xml_value in parameter_tab.par_xml_value%type default null,
    p_par_integer_value in parameter_tab.par_integer_value%type default null,
    p_par_float_value in parameter_tab.par_float_value%type default null,
    p_par_date_value in parameter_tab.par_date_value%type default null,
    p_par_timestamp_value in parameter_tab.par_timestamp_value%type default null,
    p_par_boolean_value in boolean default null,
    p_par_is_modifiable in boolean default null,
    p_par_pat_id in parameter_tab.par_pat_id%type default null,
    p_par_validation_string in parameter_tab.par_validation_string%type default null,
    p_par_validation_message in parameter_tab.par_validation_message%type default null);
    
    
  /** Record overloaded version */
  procedure edit_parameter(
    p_row in parameter_vw%rowtype);
    
  
  /* Procedure to delete a parameter
   * %param  p_par_id      Name of the parameter
   * %param  p_par_pgr_id  Name of the parameter group   
   * %usage  Method is used to delete a parameter from the list of parameters
   */
  procedure delete_parameter(
    p_par_id in parameter_tab.par_id%type,
    p_par_pgr_id in parameter_tab.par_pgr_id%type);
    
  
  /** Method to validate a realm based parameter if a validation string exists
   * %param  p_parameter  Parameter to check
   * %throws {*} - param_value_invalid_err, if validation failed or parameter does not exist or parameter is not modifiable
   */
  procedure validate_realm_parameter(
    p_par_id parameter_vw.par_id%type,
    p_par_pgr_id parameter_vw.par_pgr_id%type,
    p_par_string_value in parameter_vw.par_string_value%type default null,
    p_par_raw_value in parameter_vw.par_raw_value%type default null,
    p_par_xml_value in parameter_vw.par_xml_value%type default null,
    p_par_integer_value in parameter_vw.par_integer_value%type default null,
    p_par_float_value in parameter_vw.par_float_value%type default null,
    p_par_date_value in parameter_vw.par_date_value%type default null,
    p_par_timestamp_value in parameter_vw.par_timestamp_value%type default null,
    p_par_boolean_value in boolean default null);
   
   
  /** Sets a realm parameter value
   * %param  p_par_id      Name of the parameter
   * %param  p_par_pgr_id  Name of the parameter group
   * %param  p_par_pre_id      Name of the parameter realm
   * %param [p_string_value..p_boolean_value] Value of the parameter
   * %usage  Is called to persist realm related parameters
   *         These parameters contrast local parameters in that they have different values
   *         per "realm", i.e. for a dev, test or production environment.
   *         As such, those parameters are persisted centrally
   */
  procedure edit_realm_parameter(
    p_par_id parameter_vw.par_id%type,
    p_par_pgr_id parameter_vw.par_pgr_id%type,
    p_par_pre_id in parameter_realm.pre_id%type,
    p_par_string_value in parameter_vw.par_string_value%type default null,
    p_par_raw_value in parameter_vw.par_raw_value%type default null,
    p_par_xml_value in parameter_vw.par_xml_value%type default null,
    p_par_integer_value in parameter_vw.par_integer_value%type default null,
    p_par_float_value in parameter_vw.par_float_value%type default null,
    p_par_date_value in parameter_vw.par_date_value%type default null,
    p_par_timestamp_value in parameter_vw.par_timestamp_value%type default null,
    p_par_boolean_value in boolean default null);
    
  
  /** Resets a realm parameter to the default value
   * %param  p_par_id      Name of the parameter
   * %param  p_par_pgr_id  Name of the parameter group
   * %param  p_par_pre_id      Name of the parameter realm
   * %usage  Is called to remove a realm related parameter
   */
  procedure delete_realm_parameter(
    p_par_id parameter_vw.par_id%type,
    p_par_pgr_id parameter_vw.par_pgr_id%type,
    p_par_pre_id in parameter_realm.pre_id%type);   
    
    
  /* Return all parameters within a parameter group as a clob instance
   * %param  p_pgr_id  Parameter group to create a clob installation file for
   * %usage  Is called to create an installation file as CLOB to be downloaded at the clients browser
   */
  function export_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type)
    return clob;
    
  
  /* Writes parameters into files per parameter group
   * %param  p_pgr_id     Optional name of a parameter group. Filters list of
   *                      files to write. If set, only this parameter group gets written to file
   * %param  p_directory  Optional directory name of the directory to write the files to
   * %usage  Creates files with the actual parameter values
   */
  procedure write_parameter_files(
    p_pgr_id in parameter_group.pgr_id%type default null,
    p_directory in varchar2 default 'DATA_DIR');
    
    
end param_admin;
/
