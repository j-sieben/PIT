create or replace package param_admin
  authid definer
as
  /** Package to maintain settings for parameter groups */
  
  
  /* Procedure to change the definition of a parameter group
   * %param p_parameter_group_id Name of the parameter group
   * %param p_group_description Longtext description of the parameter group
   * %param p_is_modifiable Flag indicating whether parameters within this group
   *        are allowed to be modifiable by the end user
   * %usage Is called by the developer to maintain the settings of a parameter group.
   *        May be used to create a new parameter group as well.
   */
  procedure edit_parameter_group(
    p_parameter_group_id varchar2,
    p_group_description varchar2,
    p_is_modifiable varchar2);
	
  
  /* Procedure to edit the definition of a parameter type.
   * %param p_parameter_type_id Name of the parameter type
   * %param p_type_description Longtext description of the parameter type
   * %usage Procedure is called by the developer to edit parameter types.
   *        Paramater types are used to define the kind of string type a parameter
   *        has. Examples are HTML, SQL or similar. They are used to control 
   *        which editer is used to edit the parameter value on the UI
   */
  procedure edit_parameter_type(
    p_parameter_type_id varchar2,
	  p_type_description varchar2);
	
  
  /* Procedure to edit a parameter
   * %param p_parameter_id Name of the parameter
   * %param p_parametergroup Name of the parameter group   
   * %param p_string_value CLOB parameter value
   * %param p_xml_value XML parameter value
   * %param p_integer_value Integer parameter value
   * %param p_float_value Float parameter value
   * %param p_date_value Date parameter value
   * %param p_timestamp_value Timestamp with time zone parameter value
   * %param p_boolean_value Boolean parameter value
   * %param p_is_modifiable Flag indicating whether this parameter is modifiable by the end user
   * %param p_parameter_type String type of the parameter, Reference to PARAMETER_TYPE.
   * %param p_validation_string PL/SQL-chunk to validate a parameter value entered. Is used to validate parameter values
   * %param p_validation_message Name of a Message that is thrown if a validation of the parameter fails.
   *        May be any predefined message from package MSG
   * %usage Is called from the developer to create or change a parameter.
   */
  procedure edit_parameter(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2,
	  p_parameter_description in varchar2,
    p_string_value in clob default null,
    p_xml_value in xmltype default null,
    p_integer_value in number default null,
    p_float_value in number default null,
    p_date_value in date default null,
    p_timestamp_value in timestamp with time zone default null,
    p_boolean_value in varchar2 default null,
    p_is_modifiable in varchar2 default null,
    p_parameter_type_id in varchar2 default null,
    p_validation_string in varchar2 default null,
    p_validation_message in varchar2 default null);
    
  
  /* Procedure to delete a parameter
   * %param p_parameter_id Name of the parameter
   * %param p_parametergroup Name of the parameter group   
   * %usage Method is used to delete a parameter from the list of parameters
   */
  procedure delete_parameter(
    p_parameter_id in varchar2,
    p_parameter_group_id in varchar2);
end param_admin;
/
