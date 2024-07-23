create or replace package pita_ui
  authid definer
as 
  /** 
    Package: PITA_UI
      UI Package for the PIT APEX maintenance application
   
    Author:: 
      Juergen Sieben, ConDeS GmbH
      
      Published under MIT licence
   */
  
  /**
    Group: Public Methods
   */
   
  /**
    Function: get_default_language
      Getter method to retrieve the default PIT language. This language is defined upon installation of PIT and cannot be changed.
      
    Returns: 
      Default language
   */
  function get_default_language
    return varchar2;
    
   
  /**
    Function: get_realm
      Getter method to retrieve the actually set realm of the environment
      
    Returns: 
      Realm
   */
  function get_realm
    return varchar2;
    
  
  /** 
    Procedure: harmonize_sql_name
      Wrapper around PIT_UTIL.harmonize_sql_name.
      
      Is used to format an entered alphanumerical key according to the naming conventions of PIT.
      
    Parameters:
      p_item_name - Name of the page item containing the SQL name
      p_prefix - Optional prefix for the resulting name     
   */
  procedure harmonize_sql_name(
    p_item_name in varchar2,
    p_prefix in varchar2 default null);
    
  
  /**
    Function: has_translatable_items
      Method to check whether translatable items are present. Is used to toggle the visibility of a region.
      
    Returns: 
      TRUE if translatable items are present, FALSE if not.
   */
  function has_translatable_items
    return boolean;
    
  
  /**
    Function: has_local_parameters
      Method to check whether local parameters are present. Is used to toggle the visibility of a region.
      
    Returns: 
      TRUE if local parameters are present, FALSE if not.
   */
  function has_local_parameters
    return boolean;
    
  
  /** 
    Function: allows_toggles
      Method to check whether toggle feature is switched on. Is used to toggle the visibility of a region.
      
    Returns: 
      TRUE if toggle feature is switched on, FALSE if not.
   */
  function allows_toggles
    return boolean;
    
  
  /** 
    Procedure: set_allow_toggles
      Method to set a new toggle value. Is called by the application via an AJAX call.
   */
  procedure set_allow_toggles;
  
  
  /**
    Function: is_default_context
      Method to check wether the actually selected context is the default context.
      Is used to control the visibility and editability of page items.
      
    Returns: 
      Flag to indicate that the context is the default context (TRUE) or not (FALSE)
   */
  function is_default_context
    return boolean;
  
  
  /**
    Function: pgr_is_modifiable
      Method to check wether the actually selected parameter group is modifiable
      
    Returns: 
      Flag to indicate that the parameter group is modifiable (TRUE) or not (FALSE)
   */
  function pgr_is_modifiable(
    p_pgr_id in pit_util.ora_name_type)
    return pit_util.flag_type;
   
   
  /**
    Procedure: set_language_settings
       Procedure for managing the default languages. Used to set the language settings for PIT.
       
       The default language cannot be changed here, it was set during the during the installation of PIT. 
       Here you can only define which translations should be used with which priority.
       
      Parameter:
        p_pml_list - List of languages in order of use.
   */
  procedure set_language_settings(
    p_pml_list in pit_util.max_sql_char);
    
    
  /** 
    Function: edit_context_validate
      Method to validate page EDIT_CONTEXT
      
    Returns:
      Always TRUE, exceptions are registered on the APEX error stack
   */
  function edit_context_validate
    return boolean;
  
  /**
    Procedure: edit_context_process
      Mehod to persist user entries of page EDIT_CONTEXT
   */
  procedure edit_context_process;
  
  
  /** 
    Function: edit_module_validate
      Method to validate page EDIT_MODULE
      
    Returns:
      Always TRUE, exceptions are registered on the APEX error stack
   */
  function edit_module_validate
    return boolean;
  
  
  /**
    Procedure: edit_module_process
      Mehod to persist user entries of page EDIT_MODULE
   */
  procedure edit_module_process;
    
  
  /**
    Procedure: edit_par_initialize
      Method to initialize page values for page EDIT_PAR
   */
  procedure edit_par_initialize;
  
  /** 
    Function: edit_par_validate
      Method to validate page EDIT_PAR
      
    Returns:
      Always TRUE, exceptions are registered on the APEX error stack
   */
  function edit_par_validate
    return boolean;
  
  
  /**
    Procedure: edit_par_process
      Mehod to persist user entries of page EDIT_PAR
   */
  procedure edit_par_process;
  
  
  /** 
    Function: edit_par_realm_validate
      Method to validate page EDIT_PAR_REALM
      
    Returns:
      Always TRUE, exceptions are registered on the APEX error stack
   */
  function edit_par_realm_validate
    return boolean;
  
  
  /**
    Procedure: edit_par_realm_process
      Mehod to persist user entries of page EDIT_PAR_REALM
   */
  procedure edit_par_realm_process;
  
   
  /** 
    Function: edit_pgr_validate
      Method to validate page EDIT_PGR
      
    Returns:
      Always TRUE, exceptions are registered on the APEX error stack
   */
  function edit_pgr_validate
    return boolean;
  
  
  /**
    Procedure: edit_pgr_process
      Mehod to persist user entries of page EDIT_PGR
   */
  procedure edit_pgr_process;
  
  
  /** 
    Function: edit_pmg_validate
      Method to validate page EDIT_PMG
      
    Returns:
      Always TRUE, exceptions are registered on the APEX error stack
   */
  function edit_pmg_validate
    return boolean;
  
  
  /**
    Procedure: edit_pmg_process
      Mehod to persist user entries of page EDIT_PMG
   */
  procedure edit_pmg_process;
  
  
  /**
    Procedure: edit_pms_get_requires_esception
      Method retrieves the requires_exception setting for a selected message severity
   */
  procedure edit_pms_get_requires_exception;
  
  
  /** 
    Function: edit_pms_validate
      Method to validate page EDIT_PMS
      
    Returns:
      Always TRUE, exceptions are registered on the APEX error stack
   */
  function edit_pms_validate
    return boolean;
  
  
  /**
    Procedure: edit_pms_process
      Mehod to persist user entries of page EDIT_PMS
   */
  procedure edit_pms_process;
  
  
  /** 
    Function: edit_pre_validate
      Method to validate page EDIT_PRE
      
    Returns:
      Always TRUE, exceptions are registered on the APEX error stack
   */
  function edit_pre_validate
    return boolean;
  
  
  /**
    Procedure: edit_pre_process
      Mehod to persist user entries of page EDIT_PRE
   */
  procedure edit_pre_process;
  
  
  /** 
    Function: edit_realm_validate
      Method to validate page EDIT_REALM
      
    Returns:
      Always TRUE, exceptions are registered on the APEX error stack
   */
  function edit_realm_validate
    return boolean;
  
  
  /**
    Procedure: edit_realm_process
      Mehod to persist user entries of page EDIT_REALM
   */
  procedure edit_realm_process;
  
  
  /** 
    Function: edit_toggle_validate
      Method to validate page EDIT_TOGGLE
      
    Returns:
      Always TRUE, exceptions are registered on the APEX error stack
   */
  function edit_toggle_validate
    return boolean;
  
  
  /**
    Procedure: edit_toggle_process
      Mehod to persist user entries of page EDIT_TOGGLE
   */
  procedure edit_toggle_process;
  
  
  /** 
    Function: export_validate
      Method to validate page EXPORT
      
    Returns:
      Always TRUE, exceptions are registered on the APEX error stack
   */
  function export_validate
    return boolean;
  
  
  /**
    Procedure: export_process
      Mehod to persist user entries of page EXPORT
   */
  procedure export_process;
  
  
  /** 
    Function: set_realm_validate
      Method to validate page SET_REALM_VALIDATE
      
    Returns:
      Always TRUE, exceptions are registered on the APEX error stack
   */
  function set_realm_validate
    return boolean;
  
  
  /**
    Procedure: set_realm_process
      Mehod to persist user entries of page SET_REALM
   */
  procedure set_realm_process;
   
end pita_ui;
/