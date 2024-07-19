create or replace package pit_context
  authid definer
  --accessible by (package pit_internal, package pit, package pit_call_stack, package ut_pit_context, package ut_pit_call_stack, type pit_context_type)
as
  /** 
    Package: pit_context
      Helper package to implement the Context functionality for PIT.
      
      A context is used to memorize the debug settings whih are actually valid. It may be implemented
      by using a globally accessible context or by means of a local memory if no globally accessible contet
      is present.
      
      If used locally, it must be assured that the calling environment sets or resets the logging settings
      in a session pool environment. This is achieved by implementing the decision logic for the logging settings
      in the session adapter object.
      
      So for APEX, the APEX session adapter may decide whether the actually connected user should be logged or not.
   
    Author:: 
      Juergen Sieben, ConDeS GmbH
      
      Published under MIT licence
   */
   
  /**
    Group: Type Definitions
   */  
  /**
    Type: pit_module_tab
      PL/SQL-table indexed by <pit_util.ora_name_type> to hold a list of output modules
   */
  type pit_module_tab is table of pit_module index by pit_util.ora_name_type;
  
   
  /**
    Group: Exceptions
   */  
  /**
    Exceptions: Validation errors
      global_context_missing - Is thrown if a method is called that requires a globally accesible context but the context is missing.
      invalid_log_level - Is thrown if a context contains a non existing log level
      invalid_trace_level - Is thrown if a context contains a non existing trace level
      invalid_trace_flag - Is thrown if the trace flag cannot be evaluated to false or true
      non_existing_log_module - Is thrown if a context requires a non existing output module
      invalid_settings - Is thrown if the settings for a context are missing or in invalid format
   */
  global_context_missing exception;
  invalid_log_level exception;
  invalid_trace_level exception;
  invalid_trace_flag exception;
  unknown_log_module exception;
  invalid_settings exception;
  pragma exception_init(invalid_log_level, -20000);
  pragma exception_init(invalid_trace_level, -20001);
  pragma exception_init(invalid_trace_flag, -20002);
  pragma exception_init(unknown_log_module, -20003);
  pragma exception_init(invalid_settings, -20004);
  
  
  /**
    Group: Public Package Constants
   */
  /**
    Constants: Context Constants
      C_CONTEXT_DEFAULT - Name of the default context, containing the peramterized default log behaviour
      C_FOCUS_ALL_MODULES - Sets method <pit_context.get_modules> to return all installed output modules
      C_FOCUS_AVAILABLE_MODULES - Sets method <pit_context.get_modules> to return all succesfully initialized output modules
      C_FOCUS_ACTIVE_MODULES - Sets method <pit_context.get_modules> to return all actually active output modules (based on availability and context settings)
      C_FOCUS_UNAVAILABLE_MODULES - Sets method <pit_context.get_modules> to return all output modules which could not be instantiated
   */
  C_CONTEXT_GROUP constant pit_util.ora_name_type := 'CONTEXT';
  C_CONTEXT_PREFIX constant pit_util.ora_name_type := C_CONTEXT_GROUP || '_';
  C_CONTEXT_DEFAULT constant pit_util.ora_name_type := C_CONTEXT_PREFIX || 'DEFAULT';
  C_FOCUS_ALL_MODULES constant binary_integer := 1;
  C_FOCUS_AVAILABLE_MODULES constant binary_integer := 2;
  C_FOCUS_ACTIVE_MODULES constant binary_integer := 3;  
  C_FOCUS_UNAVAILABLE_MODULES constant binary_integer := 2;
  
  
  /**
    Group: Public Methods
   */  
  /**
    Procedure: initialize
      Initialization method, called during <PIT_INTERNAL> package initialization. 
      
      Instantiates an internal collection of available contexts and context toggles. 
      It also loads a list of all output modules and instantiates them.
   */
  procedure initialize;
  
   
  /**
    Function: get_context
      Returns the actually active context.
      
    Parameter:
      p_context_name - Optional name of the context to retrieve
      
    Returns: 
      Actually active context as instance of <PIT_CONTEXT_TYPE>. If a name is passed in, it tries to retrieve this
      context and returns it.
      
    Raises:
      NO_DATA_FOUND - THe context requested in parameter <p_context_name> does not exist.
   */
  function get_context(
    p_context_name in pit_util.ora_name_type default null)
  return pit_context_type;
  
   
  /**
    Function: get_toggle_context
      Returns the required context, either the actually active context if no toggle could be found,
      or the context as required by the toggle.
      
      A toggle controls whether PIT should log or not on a per package or per method basis. 
      Therefore it must be checked whether a toggle was defined for the actual package/method executed actually.
      If a toggle is found, this method activates the required context and returns it.
      
      The method is called by the <pit_call_stack> package to maintain the context settings
      on the call stack if the toggle functionality is switched on. This allows the call stack
      to switch logging on and off based on the calling methods.
      
    Parameter:
      p_module - Package name of the code that is executed actually
      p_action - Method name of the code that is executed actually
      
    Returns: 
      Context instance, if a context could be found based on the toggle settings.
   */
  function get_toggle_context(
    p_module in pit_util.ora_name_type,
    p_action in pit_util.ora_name_type)
  return pit_context_type;
  
   
  /**
    Procedure: set_context
      Make the context passed in the actual context.
      
      If <p_context_name> is passed in but no respective context exists, a warning is emitted
      and the default context is set active.
      
      If a global context is available, the method harmonizes the context with the changed settings.
      If a context has changed, parameter <p_context_has_change> is set to true, allowing the calling
      environment to raise the respective log change event.
      
      Overloaded versions for the following parameter combinations:
      
      - p_context_name (predefined context name)
      - p_log_level, p_trace_level, p_trace_timing, p_log_modules (explicit combination of log settings)
      - p_settings (combined log settings as persisted in the context parameters)
      - p_context (instance of a context, created by the overloaded versions or directly from the call stack)
      
    Parameters:
      p_context_name - Name of the context
      p_log_level - Log level of the context
      p_trace_level - Trace level of the context
      p_trace_timing - Flag to indicate whether timing should be switched on
      p_log_modules - List of log modules to log to
      p_settings - Combined string with the context settings
      p_context - Instance of <pit_context_type> to directly set a context, fi. based on call stack settings
      p_context_has_changed - OUT-Flag to indicate whether a context has changed. Used for logging
   */
  procedure set_context(
    p_context_name in varchar2,
    p_context_has_changed out boolean);
    
  procedure set_context(
    p_log_level in integer,
    p_trace_level in integer,
    p_trace_timing in boolean,
    p_log_modules in varchar2,
    p_context_has_changed out boolean);
    
  procedure set_context(
    p_settings in varchar2,
    p_context_has_changed out boolean);
    
  procedure set_context(
    p_context in pit_context_type,
    p_context_has_changed out boolean);


  /* Procedure to read a value from one of the available contexts
   * %param  p_context    Name of the context to write a value to
   * %param  p_attribute  Name of the parameter for which a value shall be stored
   * %param [p_client_id] optional client id as set at sys_context('USERENV', 'CLIENT_IDENTIFIER')
   * %return Varchar-value of the parameter
   * %usage  This procedure gets a parameter value for a given parameter from the 
   *         context requested. When using the p_client_id attribute, a parameter
   *         may be read that is private for a given session
   */
  function get_value(
    p_attribute in varchar2,
    p_client_id varchar2 default null)
  return varchar2;
  
  
  /**
    Procedure: set_value
      Sets a value in the PIT context. When using the <p_client_id> attribute, a parameter
      may be set for a given session only and be invisible to other sessions
      
    Parameters:
      p_attribute - Name of the parameter
      p_value - Varchar-value of the parameter. If NULL, the value will be cleared.
      p_client_id - Optional client id as set at sys_context('USERENV', 'CLIENT_IDENTIFIER')
   */
  procedure set_value(
    p_attribute in varchar2,
    p_value in varchar2,
    p_client_id varchar2 default null);


  /** 
    Function: log_me
      Decides whether a message has to be logged. 
      
      Is called during logging to decide whether the actual settings allow for logging.
      The decision is based on the requested log level as well as on settings in the global context.
      
    Parameter:
      p_severity - log_level for which a decision is requested
      
    Returns:
      Flag that indicates whether settings allow for logging (TRUE) or not (FALSE).
   */
  function log_me(
    p_severity in pit_message.pms_pse_id%type)
    return boolean;


  /** 
    Function: trace_me
      Decides whether a message has to be traced. 
      
      Is called during logging to decide whether the actual settings allow for tracing.
      The decision is based on the requested trace level as well as on settings in the global context.
      
    Parameter:
      p_trace_level - trace_level for which a decision is requested
      
    Returns:
      Flag that indicates whether settings allow for tracing (TRUE) or not (FALSE).
   */
  function trace_me(
    p_trace_level in integer)
    return boolean;


  /** 
    Function: trace_timing
      Decides whether timing information has to be captured
      
    Returns:
      Flag that indicates whether timing has to be captured (TRUE) or not (FALSE).
   */
  function trace_timing
    return boolean;


  /** 
    Function: allows_toggle
      Decides whether toggles are set active actually
      
    Returns:
      Flag that indicates whether settings allow for toggling (TRUE) or not (FALSE).
   */
  function allows_toggle
    return boolean;
    
    
  /**
    Function: get_log_level
      Method returns the actually set log level.
      
    Returns:
      Log level that is actually active.
   */
  function get_log_level
    return binary_integer;
    
    
  /**
    Function: get_trace_level
      Method returns the actually set trace level.
      
    Returns:
      Trace level that is actually active.
   */
  function get_trace_level
    return binary_integer;
  
  
  /**
    Function: get_active_modules
    
    Parameter:
      p_focus - On of the constant <C_FOCUS_ALL_MODULES>, <C_FOCUS_AVAILABLE_MODULES>, <C_FOCUS_UNAVAILABLE_MODULES>
                or <C_FOCUS_ACTIVE_MODULES> to control the focus of the output modules to return
                
    Returns:
      List of output modules as requested by parameter <p_focus>.
   */
  function get_modules(
    p_focus in binary_integer)
  return pit_module_list;
  
  
  /** 
    Function: get_available_modules
      Getter Function for the available modules list
   */
  function get_available_modules
  return pit_module_tab;
  
  
  /** 
    Function: get_active_modules
      Getter Function for the active modules list
   */
  function get_active_modules
  return pit_module_tab;
  
  
  /**
    Function: get_active_module_list
      Getter Function returning the list of active modules as a comma separated list
   */
  function get_active_module_list
  return varchar2;
  
   
  /** 
    Function: report_module_status
      Function to retrieve status of all modules
    
    Returns:
      <ARGS>, List of module names
   */
  function report_module_status
    return pit_args 
    pipelined;
  
  
  /**
    Procedure: validate_context
      Method to validate the context parameters. Is called from within the constructor
      method with a pre-populated instance of a context type.
    
    Parameter:
      p_context - Pre-populated context instance with potentially invalid settings
      
    Throws:
      invalid_log_level - if a context contains a non existing log level
      invalid_trace_level - if a context contains a non existing trace level
      invalid_trace_flag - if the trace flag cannot be evaluated to false or true
      non_existing_out_module - if a context requires a non existing output module
      invalid_settings - If either <p_settings> is missing or it is in an unexpected format
   */
  procedure validate_context(
    p_settings in varchar2);
    
  
  /**
    Procedure: instantiate_pit_context_type
      Constructor Function for a <pit_context_type> instance, overload with a string settings parameter.
      
      Is used for both constructor methods of the type.
      
    Parameters:
      p_self - Instance to be created
      p_settings - Text representation of the context to create
      p_context_name - Optional Name of the context
   */
  procedure instantiate_pit_context_type(
    p_self in out nocopy pit_context_type,
    p_settings in varchar2,
    p_context_name in varchar2 default null);
  
end pit_context;
/