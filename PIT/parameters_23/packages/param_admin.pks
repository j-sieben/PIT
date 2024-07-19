create or replace package param_admin
  authid definer
as
  /** 
    Package: PARAM_ADMIN
      Package to maintain settings for parameter groups
   
    Author:: 
      Juergen Sieben, ConDeS GmbH
      
      Published under MIT licence
   */
  
  /**
    Group: Public Methods
   */
  /**
    Procedure: set_import_mode
      Method sets the package to import mode to allow for import of non modifiable parameters.
      
    Parameter:
      p_mode - Flag to indicate whether the package is in import mode (TRUE) or not (FALSE)
   */
  procedure set_import_mode(
    p_mode in boolean);
    
  
  /**
    Function: get_parameter_settings
      Reads metadata for parameters. Is called to read settings regarding 
      modifiability etc. Is used internally and from PARAM pkg
      
    Parameters:
      p_par_id - Name of the parameter
      p_par_pgr_id - Name of the parameter group
      
    Returns:
      Row of PARAMETER_V that contains all parameter related data 
      with the exception of the actual parameter values
   */
  function get_parameter_settings(
    p_par_id in parameter_v.par_id%type,
    p_pgr_id in parameter_group.pgr_id%type)
    return parameter_v%rowtype;
    
  
  /** 
    Procedure: validate_parameter_group
      Method to validate a parameter group entry prior to writing it to db
      
    Parameter:
      p_row - PARAMETER_GROUP record to validate
   */
  procedure validate_parameter_group(
    p_row in parameter_group%rowtype);
  
  
  /**
    Procedure: edit_parameter_group
      Method to change the definition of a parameter group.
      
      Is called by the developer to maintain the settings of a parameter group.
      May be used to create a new parameter group as well.
      
    Parameters:
      p_pgr_id - Name of the parameter group
      p_pgr_description - Longtext description of the parameter group
      p_pgr_is_modifiable - Flag indicating whether parameters within this group are allowed to be modifiable by the end user
   */
  procedure edit_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type,
    p_pgr_description in parameter_group.pgr_description%type,
    p_pgr_is_modifiable in boolean default true);
  
  
  /** 
    Procedure: edit_parameter_group
      Method to change the definition of a parameter group. 
      
      Is called by the developer to maintain the settings of a parameter group.
      May be used to create a new parameter group as well.
      
    Parameter:
      p_row - PARAMETER_GROUP record to validate
   */
  procedure edit_parameter_group(
    p_row in parameter_group%rowtype);
    
  
  /** 
    Procedure: delete_parameter_group
      Method to delete a parameter group.
      
    Parameters:
      p_pgr_id - Name of the parameter group
      p_force] - Optional flag to indicate whether all referencing parameters should be deleted (TRUE)
                 or not (FALSE, default)
   */
  procedure delete_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type,
    p_force in boolean default false);

  /** 
    Procedure: harmonize_parameter_group
      Method to harmonize local and default parameters after import.
      
      Is called after importing a parameter group. It searches for local parameters
      which do not exist in the default parameter list anymore and deletes them
      
    Parameter:
      p_pgr_id - Name of the parameter group
   */
  procedure harmonize_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type);
    
    
  /** 
    Procedure: edit_parameter_realm
      Method to change the definition of a parameter realm.
      
      Is called by the developer to maintain the settings of a parameter realm.
      May be used to create a new parameter realm as well.
      
    Parameters:
      p_pre_id - Name of the parameter realm
      p_pre_description - Longtext description of the parameter realm
      p_pgr_is_active - Flag to indicate whether realm is in use actually
   */
  procedure edit_parameter_realm(
    p_pre_id in parameter_realm.pre_id%type,
    p_pre_description in parameter_realm.pre_description%type,
    p_pre_is_active in boolean default true);


  /** 
    Procedure: edit_parameter_realm
      Method to change the definition of a parameter realm.
      
      Is called by the developer to maintain the settings of a parameter realm.
      May be used to create a new parameter realm as well.
      
    Parameter:
      p_row - PARAMETER_REALM record
   */
  procedure edit_parameter_realm(
    p_row in parameter_realm%rowtype);


  /** 
    Procedure: delete_parameter_realm
      Method to delete a parameter realm
      
    Parameters:
      p_pre_id - ID of the parameter realm to delete
      p_force - Optional flag to indicate whether local parameters of this realm are to be deleted (TRUE)
                or whether an error is thrown if the realm is in use (FALSE)
   */
  procedure delete_parameter_realm(
    p_pre_id in parameter_realm.pre_id%type,
    p_force in boolean default false);
    
    
  procedure validate_parameter_realm(
    p_pre_id in parameter_realm%rowtype);
	
  
  /**
    Procedure: edit_parameter_type
      Method to edit the definition of a parameter type.
      
      Procedure is called by the developer to edit parameter types.
      Paramater types are used to define the kind of string type a parameter has.
      Examples are HTML, SQL or similar. They are used to control 
      which editer is used to edit the parameter value on the UI
      
    Parameters:
      p_pat_id - Name of the parameter type
      p_pat_description - Longtext description of the parameter type
   */
  procedure edit_parameter_type(
    p_pat_id in parameter_type.pat_id%type,
	  p_pat_description in parameter_type.pat_description%type);
    
    
  /** 
    Procedure: validate_parameter
      Method to validate a parameter if a validation string exists
      
    Parameter:
      p_parameter - Parameter to check
   */
  procedure validate_parameter(
    p_row in parameter_v%rowtype);
	
  
  /**
    Procedure: edit_parameter
      Method to edit a parameter
      
    Parameters:
      p_par_id - Name of the parameter
      p_par_pgr_id - Name of the parameter group   
      p_par_description - Optional description of the parameter
      p_par_string_value - CLOB parameter value
      p_par_xml_value - XML parameter value
      p_par_integer_value - Integer parameter value
      p_par_float_value - Float parameter value
      p_par_date_value - Date parameter value
      p_par_timestamp_value - Timestamp with time zone parameter value
      p_par_boolean_value - Boolean parameter value
      p_pgr_is_modifiable - Flag indicating whether this parameter is modifiable by the end user
      p_par_pat_id - String type of the parameter, Reference to PARAMETER_TYPE.
      p_par_validation_string - PL/SQL-chunk to validate a parameter value entered. Is used to validate parameter values
      p_par_validation_message - Name of a Message that is thrown if a validation of the parameter fails.
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
    
    
  /** 
    Procedure: edit_parameter
      Method to edit a parameter
      
    Parameter:
      p_row - Record of PARAMETER_v
   */
  procedure edit_parameter(
    p_row in parameter_v%rowtype);
    
  
  /**
    Procedure: delete_parameter
      Method to delete a parameter
      
    Parameters:
      p_par_id - Name of the parameter
      p_par_pgr_id - Name of the parameter group   
   */
  procedure delete_parameter(
    p_par_id in parameter_tab.par_id%type,
    p_par_pgr_id in parameter_tab.par_pgr_id%type);
    
  
  /**
    Procedure: validate_realm_parameter
      Method to validate a realm based parameter if a validation string exists.
      
    Parameter:
      p_row - Record of PARAMETER_v with the parameter to check
   */
  procedure validate_realm_parameter(
    p_row in out nocopy parameter_v%rowtype);
   
   
  /**
    Procedure: edit_realm_parameter
      Sets a realm parameter value.
      
      Is called to persist realm related parameters
      These parameters contrast local parameters in that they have different values
      per "realm", i.e. for a dev, test or production environment.
      As such, those parameters are persisted centrally.
      
    Parameters:
      p_par_id - Name of the parameter
      p_par_pgr_id - Name of the parameter group
      p_par_pre_id - Name of the parameter realm
      p_par_string_value - CLOB parameter value
      p_par_xml_value - XML parameter value
      p_par_integer_value - Integer parameter value
      p_par_float_value - Float parameter value
      p_par_date_value - Date parameter value
      p_par_timestamp_value - Timestamp with time zone parameter value
      p_par_boolean_value - Boolean parameter value
   */
  procedure edit_realm_parameter(
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
    
    
  /**
    Procedure: edit_realm_parameter
      Sets a realm parameter value.
      
    Parameter:
      p_row - Record of <PARAMETER_v> with the parameter
   */
  procedure edit_realm_parameter(
    p_row in parameter_v%rowtype);
    
  
  /** 
    Procedure: delete_realm_parameter
      Resets a realm parameter to the default value
      
    Parameters:
      p_par_id - Name of the parameter
      p_par_pgr_id - Name of the parameter group
      p_par_pre_id - Name of the parameter realm
   */
  procedure delete_realm_parameter(
    p_par_id parameter_v.par_id%type,
    p_par_pgr_id parameter_v.par_pgr_id%type,
    p_par_pre_id in parameter_realm.pre_id%type);   
    
    
  /**
    Function: export_parameter_group
      Method to create a script for all parameters within a parameter group as a clob instance.
      
      Is called to create an installation file as CLOB to be downloaded at the clients browser
      
    Parameter:
      p_pgr_id - Parameter group to create a clob installation file for
   */
  function export_parameter_group(
    p_pgr_id in parameter_group.pgr_id%type)
    return clob;
    
    
  function export_local_parameters(
    p_pgr_id in parameter_group.pgr_id%type default null)
    return clob;    
    
end param_admin;
/
