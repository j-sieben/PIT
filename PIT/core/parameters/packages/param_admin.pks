create or replace package param_admin
  authid definer
as
  /** Package to maintain settings for parameter groups */
  
  
  /* Procedure to change the definition of a parameter group
   * %param p_pgr_id Name of the parameter group
   * %param p_pgr_description Longtext description of the parameter group
   * %param p_pgr_is_modifiable Flag indicating whether parameters within this group
   *        are allowed to be modifiable by the end user
   * %usage Is called by the developer to maintain the settings of a parameter group.
   *        May be used to create a new parameter group as well.
   */
  procedure edit_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type,
    p_pgr_description in parameter_group.pgr_description%type,
    p_pgr_is_modifiable in boolean default true);
	
  
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
	
  
  /* Procedure to edit a parameter
   * %param p_par_id Name of the parameter
   * %param p_par_pgr_id Name of the parameter group   
   * %param p_par_description Optional description of the parameter
   * %param p_par_string_value CLOB parameter value
   * %param p_par_xml_value XML parameter value
   * %param p_par_integer_value Integer parameter value
   * %param p_par_float_value Float parameter value
   * %param p_par_date_value Date parameter value
   * %param p_par_timestamp_value Timestamp with time zone parameter value
   * %param p_par_boolean_value Boolean parameter value
   * %param p_pgr_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %param p_par_pat_id String type of the parameter, Reference to PARAMETER_TYPE.
   * %param p_par_validation_string PL/SQL-chunk to validate a parameter value entered. Is used to validate parameter values
   * %param p_par_validation_message Name of a Message that is thrown if a validation of the parameter fails.
   *        May be any predefined message from package MSG
   * %usage Is called from the developer to create or change a parameter.
   */
  procedure edit_parameter(
    p_par_id in parameter_tab.par_id%type,
    p_par_pgr_id in parameter_tab.par_pgr_id%type,
	  p_par_description in parameter_tab.par_description%type,
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
    
  
  /* Procedure to delete a parameter
   * %param p_par_id Name of the parameter
   * %param p_par_pgr_id Name of the parameter group   
   * %usage Method is used to delete a parameter from the list of parameters
   */
  procedure delete_parameter(
    p_par_id in parameter_tab.par_id%type,
    p_par_pgr_id in parameter_tab.par_pgr_id%type);
    
    
  /* Return all parameters within a parameter group as a clob instance
   * %param p_pgr_id Parameter group to create a clob installation file for
   * %usage Is called to create an installation file as CLOB to be
   *        downloaded at the clients browser
   */
  function export_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type)
    return clob;
    
  
  /* Writes parameters into files per parameter group
   * %param p_par_pgr_id Optional name of a parameter group. Filters list of
   *        files to write. If set, only this parameter group gets written to file
   * %param p_directory Optional directory name of the directory to write the files to
   * %usage Creates files with the actual parameter values
   */
  procedure write_parameter_files(
    p_pgr_id in parameter_group.pgr_id%type default null,
    p_directory in varchar2 default 'DATA_DIR');
    
    
end param_admin;
/
