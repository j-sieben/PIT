create or replace package pit_app_api
authid definer
as 
  /** 
    Package: PIT_APP_API
      Package to support the PIT administration application.
      
      This package provides access to the core administration packages and
      wraps the validation logic. Most of the methods are simple wrapper around
      the packages <PIT_ADMIN> and <PARAM_ADMIN>, but some validation logic is
      doubled wihtin this package.
      
      Reason for this is that <PIT_ADMIN> and <PARAM_ADMIN> are not allowed to have
      a dependency on <PIT>, as they create <PIT> in first place. 
      
      Using the validation logic from these package therefore is cumbersome 
      for the administration application as it can't collect errors
      during the validation cycle. This collection would require the errors 
      to be raised using <PIT> which is not possible in <PIT_ADMIN> and <PARAM_ADMIN>.
   
      The solution is to double the validation logic, once throwing errors directly
      and once using <PIT>. The duplication is somewhat reduced by extracting
      more complex validation functions into package <PIT_UTIL>, allowing these
      methods to be reused in both validation implementations.
      
    Author:: 
      Juergen Sieben, ConDeS GmbH
      
      Published under MIT licence
   */
  
  /**
    Group: Public Constants
   */
  /** 
    Constants: Export groups
      Target distinguish between areas of similar items to streamline the API
      
      C_TARGET_PMS - Messages
      C_TARGET_PTI - Translatable Items
      C_TARGET_PAR - Parameters
   */  
  C_TARGET_PMS constant pit_util.ora_name_type := pit_admin.C_TARGET_PMS;
  C_TARGET_PTI constant pit_util.ora_name_type := pit_admin.C_TARGET_PTI;
  C_TARGET_PAR constant pit_util.ora_name_type := pit_admin.C_TARGET_PAR;
  
  /**
    Group: Public Methods
   */
  /**
    Function: allows_toggles
      Metho d to check whether toggles are actually allowed.
      
    Returns:
      TRUE if toggles are allowed, FALSE orherwise.
   */
  function allows_toggles
  return boolean;
  
  
  /**
    Procedure: apply_translation
      Procedure to import translated items into the database.
      
      If provided with a translated XLIFF-Instance, this procedure creates
      the necessary items for the new language based on it target type.
      
    Parameters:
      p_xliff - XLIFF-instance with the translated messages
      p_target - Type of items to translate <C_TARGET_PMS>|<C_TARGET_PTI>
   */
  procedure apply_translation(
    p_xliff in xmltype,
    p_target in varchar2);
    
    
  /** 
    Function: check_name
      Method to check whether a name conforms to the internal naming standards.
      Is used as a wrapper to reduce code on various validate methods
      
    Parameters
      p_name - Name to check
      p_prefix - optional prefix. If set, the method adds it to the name, making sure it is not doubled
      
    Returns: 
      Harmonized name if possible, entered name in case of error
      
    Raises:
      NAME_MISSING - if <p_name> is null
      INVALID_SQL_NAME - if <p_name> does not adhere to the naming conventions
   */
  function check_name(
    p_name in pit_util.ora_name_type,
    p_prefix in varchar2 default null)
    return varchar2;
    
    
  /**
    Procedure: create_named_context
      Procedure to create a named context to control debug settings.
      
    Parameters:
      p_context_name - Name of the context. Maximum of 20 byte. Don't use umlauts or special chars
      p_log_level - Log level of the named context. Allowed values: LOG_LEVEL(10,20..70)
      p_trace level - Trace level of the named context. Allowed values: TRACE_LEVEL (10,20..40)
      p_trace_timing - Flag to indicate whether timing information must be captured
      p_module_list - List of colon separated output module names to be used for logging
      p_comment - Optional comment to explain the usage of the named context
   */
  procedure create_named_context(
    p_context_name in varchar2,
    p_log_level in number,
    p_trace_level in number,
    p_trace_timing in boolean,
    p_module_list in varchar2,
    p_comment in varchar2 default null);
    
    
  /**
    Procedure: delete_context_toggle
      Procedure to remove a context toggle
    
    Parameter:
      p_toggle_name - Name of the context toggle to remove
   */
  procedure delete_context_toggle(
    p_toggle_name in varchar2); 
    
    
  /**
    Procedure: delete_message
      Procedure to delete a single pit_message. Will delete all translations as well. Is called to remove mistyped
      or unnecessary messages in all languages. Will not commit nor re-create the <MSG> package.
      
    Parameters:
      p_pms_name - Name of the message to delete
      p_pms_pml_name - Optional language of the message to delete. If null, all translations are deleted, otherwise only the translated message
   */
  procedure delete_message(
    p_pms_name in pit_message.pms_name%type,
    p_pms_pml_name in pit_message_language.pml_name%type default null);
    
    
  /** 
    Procedure: delete_message_group
      Procedure to delete a message group. Does not delete a message group if messages exists within that group,
      unless specified by setting the <P_FORCE> parameter to true. Will not commit nor re-create the <MSG> package.
   
    Parameters:
      p_pmg_name - Name of the message group
      p_force - Flag to indicate whether deleting this group should delete all messages of this group.
                Defaults to FALSE: If messages exists, an error is thrown
   */
  procedure delete_message_group(
    p_pmg_name in pit_message_group.pmg_name%type,
    p_force in boolean default false);
    
  
  /**
    Procedure: delete_named_context
      Procedure to delete a named context
      
    Parameter:
      p_context_name - Name of the context to delete
   */
  procedure delete_named_context(
    p_context_name in varchar2);
    
  
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
    
  
  /** 
    Procedure: delete_realm_parameter
      Resets a realm parameter to the default value
      
    Parameters:
      p_par_id - Name of the parameter
      p_par_pgr_id - Name of the parameter group
      p_par_pre_id - Name of the parameter realm
   */
  procedure delete_realm_parameter(
    p_par_id parameter_vw.par_id%type,
    p_par_pgr_id parameter_vw.par_pgr_id%type,
    p_par_pre_id in parameter_realm.pre_id%type);
    
    
  /**
    Procedure: export_group
      Method to create a script for all parameters within a parameter group as a clob instance.
      
      Is called to create an installation file as CLOB to be downloaded at the clients browser
      
    Parameter:
      p_target - Kind of items to export (PMS, PTI)
      p_group_name - Name of the group to export
      p_group_file_name - File name for the exported group
      p_script - Script, content of the file
      p_target_language - Optional differing language for the export
   */
  procedure export_group(
    p_target pit_util.ora_name_type,
    p_group_name in pit_util.ora_name_type,
    p_group_file_name out nocopy pit_util.ora_name_type,
    p_script out nocopy clob,
    p_target_language in pit_message_language.pml_name%type default null);
    
    
  /**
    Procedure: merge_context_toggle
      Procedure to create a context toggle. Is called to have PIT toggle it's context settings based on 
      entering a module or a list of modules. A toggle switches the debug settings if the package or 
      procedure mentioned in the toggle is entered.
      
    Parameters:
      p_toggle_name - Name of the context toggle. Maximum of 20 byte. Don't use umlauts or special chars
      p_module_list - Name of the module to toggle the context for. May be a pipe separated list of modules
                      Two formats are allowed: Name of a package/method or qualified name of a method in a package (without owner)
      p_context_name - Name of the context to switch to. Must be an excisting context
      p_comment - Optional comment to explain the usage of the toggle
   
    Example: 
      Valid examples for the object list parameter are:
      
      - MY_PACKAGE|MY_OTHER_PACKAGE.MY_PROC
   */
  procedure merge_context_toggle(
    p_toggle_name in varchar2,
    p_module_list in varchar2,
    p_context_name in varchar2,
    p_comment in varchar2 default null);
    
    
  /**
    Procedure: merge_message
      Procedure to merge a message. Overload with a row record.
      
    Parameter:
      p_row  Record  of PIT_MESSAGE%ROWTYPE
   */
  procedure merge_message(
    p_row in out nocopy pit_message%rowtype);    
    
    
  /**
    Procedure: merge_message_group
      Procedure to matain a message group. Overload with a row record.
    
    Parameter:
      p_row  Record of a message group
   */
  procedure merge_message_group(
    p_row in out nocopy pit_message_group%rowtype);
    
    
  /** 
    Procedure: merge_parameter
      Method to edit a parameter
      
    Parameter:
      p_row - Record of PARAMETER_VW
   */
  procedure merge_parameter(
    p_row in parameter_vw%rowtype);
  
  
  /** 
    Procedure: merge_parameter_group
      Method to change the definition of a parameter group. 
      
      Is called by the developer to maintain the settings of a parameter group.
      May be used to create a new parameter group as well.
      
    Parameter:
      p_row - PARAMETER_GROUP record to validate
   */
  procedure merge_parameter_group(
    p_row in parameter_group%rowtype);


  /** 
    Procedure: merge_parameter_realm
      Method to change the definition of a parameter realm.
      
      Is called by the developer to maintain the settings of a parameter realm.
      May be used to create a new parameter realm as well.
      
    Parameter:
      p_row - PARAMETER_REALM record
   */
  procedure merge_parameter_realm(
    p_row in parameter_realm%rowtype);
    
    
  /**
    Procedure: merge_realm_parameter
      Sets a realm parameter value.
      
    Parameter:
      p_row - Record of <PARAMETER_VW> with the parameter
   */
  procedure merge_realm_parameter(
    p_row in parameter_vw%rowtype);
    
    
  /**
    Procedure: set_allow_toggles
      Method to set the allow toggle switch.
      
    Parameter:
      p_allowed - Flag to indicate whether toggles are allowed (TRUE) or not (FALSE)
   */
  procedure set_allow_toggles(
    p_allowed in boolean);
    
    
  /**
    Procedure: set_language_settings
      Method to set default language settings.
      
      Is used to initially set the default language settings.
      Precedence is set accoding to the sort order: First languages preceede later languages.
      
    Parameter:
      p_pml_list - List of colon-separated language names
   */
  procedure set_language_settings(
    p_pml_list in pit_util.max_sql_char);
    
    
  /**
    Procedure: translate_group
      Method to generate an XML file in format XLIFF to translate items.
      
      Call this procedure to create an XLIFF-File that can be used to translate
      all members of a target type group to a target language.
      
    Parameters:
      p_target_language - Oracle supported language name to tranlsate the items to
      p_pmg_name - Group to filter the items to translate
      p_target - Type of items to translate <C_TARGET_PMS>|<C_TARGET_PTI>
      p_file_name - Out parameter that provides the file name for the XLIFF file
      p_xliff - Out parameter that contains the XLIFF file created
   */
  procedure translate_group(
    p_target_language in pit_message_language.pml_name%type,
    p_pmg_name in pit_message_group.pmg_name%type default null,
    p_target in varchar2,
    p_file_name out nocopy pit_util.ora_name_type,
    p_xliff out nocopy xmltype);
    
    
  /**
    Procedure: validate_context_toggle
      Method to check whether a toggle has valid settings
    
    Parameters: 
      p_toggle_name - Record of <PARAMETER_VW> with the actual parameter values to check.
      p_context_name . Nmae of the context to switch logging to
      p_module_list - List of packages or procedures that toggle pit settings
      
    Raises:
      msg.INVALID_SQL_NAME - if the name of the toggle does not adhere to the naming standards
      msg.PIT_CONTEXT_MISSING - if the requested context does not exist
      TOGGLE_NAME_MISSING - if the name of the toggle is missing
      TOGGLE_NAME_TOO_LONG - if the name of the toggle is too long
      CONTEXT_NAME_MISSING - if the name of the context is missing
      CONTEXT_NAME_TOO_LONG - if the name of the toggle is too long
   */
  procedure validate_context_toggle(
    p_toggle_name in out nocopy pit_util.ora_name_type,
    p_context_name in out nocopy pit_util.ora_name_type,
    p_module_list in pit_util.max_sql_char);
    
    
  /**
    Procedure: validate_data_type
      Method to check whether a parameter value conforms to the parameter data types.
    
    Parameter: 
      p_row - Record of <PARAMETER_VW> with the actual parameter values to check.
      
    Raises:
      DATAYPE_MISMATCH_INTEGER - if an integer parameter value is not a valid integer
      DATAYPE_MISMATCH_FLOAT - if an integer parameter value is not a valid number
      DATAYPE_MISMATCH_DATE - if an integer parameter value is not a valid date
      DATAYPE_MISMATCH_TIMESTAMP - if an integer parameter value is a valid timestamp
   */
  procedure validate_data_type(
    p_row in parameter_vw%rowtype);
    
    
  /**
    Procedure: validate_message_group
      Method to check whether a PIT message group is valid.
    
    Parameter: 
      p_row - Record of <PIT_MESSAGE_GROUP> with the values to check.
      
    Raises:
      NAME_MISSING - if <p_name> is null
      INVALID_SQL_NAME - if <p_name> does not adhere to the naming conventions
      msg.PIT_PMG_ERROR_MARKER_INVALID - if prefix/postfix length are too long
   */
  procedure validate_message_group(
    p_row in out nocopy pit_message_group%rowtype);
    
    
  /**
    Procedure: validate_message
      Method to check whether a PIT message is valid.
    
    Parameter: 
      p_row - Record of <PIT_MESSAGE> with the values to check.
      
    Raises:
      NAME_MISSING - if the message name is null
      INVALID_SQL_NAME - if the message name does not adhere to the naming conventions
      PMS_PMG_NAME_MISSING - if not message group was provided
      PMS_TEXT_MISSING - if no message text is provided
      PMS_PSE_ID_MISSING - if not message severity is provided
      msg.PIT_PMS_PREDEFINED_ERROR - if the Oracle error number is already a named exception
   */
  procedure validate_message(
    p_row in out nocopy pit_message%rowtype);
    
    
  /** 
    Procedure: validate_parameter
      Method to validate a parameter if a validation string exists
      
    Parameter:
      p_parameter - Parameter to check
      
    Raises:
      NAME_MISSING - if the message name is null
      INVALID_SQL_NAME - if the message name does not adhere to the naming conventions
      DATAYPE_MISMATCH_INTEGER - if an integer parameter value is not a valid integer
      DATAYPE_MISMATCH_FLOAT - if an integer parameter value is not a valid number
      DATAYPE_MISMATCH_DATE - if an integer parameter value is not a valid date
      DATAYPE_MISMATCH_TIMESTAMP - if an integer parameter value is a valid timestamp
   */
  procedure validate_parameter(
    p_row in out nocopy parameter_vw%rowtype);
    
  
  /** 
    Procedure: validate_parameter_group
      Method to validate a parameter group entry prior to writing it to db
      
    Parameter:
      p_row - Recorid if <PARAMETER_GROUP> with the values to check
      
    Raises:
      NAME_MISSING - if the message name is null
      INVALID_SQL_NAME - if the message name does not adhere to the naming conventions
      PGR_DESCRIPTION_MISSING - if the description text is missing
   */
  procedure validate_parameter_group(
    p_row in out nocopy parameter_group%rowtype);
    
  
  /**
    Procedure: validate_realm_parameter
      Method to validate a realm based parameter if a validation string exists.
      
    Parameter:
      p_row - Record of PARAMETER_VW with the parameter to check
    
    Raises:
      NAME_MISSING - if the message name is null
      INVALID_SQL_NAME - if the message name does not adhere to the naming conventions
      DATAYPE_MISMATCH_INTEGER - if an integer parameter value is not a valid integer
      DATAYPE_MISMATCH_FLOAT - if an integer parameter value is not a valid number
      DATAYPE_MISMATCH_DATE - if an integer parameter value is not a valid date
      DATAYPE_MISMATCH_TIMESTAMP - if an integer parameter value is a valid timestamp
      msg.PARAM_IS_NULL - if the parameter does not exist
      msg.PARAM_NOT_MODIFIABLE - if it is not allow to modify this parameter
   */
  procedure validate_realm_parameter(
    p_row in out nocopy parameter_vw%rowtype);
    
end pit_app_api;
/