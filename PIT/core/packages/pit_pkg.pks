create or replace package pit_pkg
  authid definer
  --accessible by (package pit, package pit_ui)
as
  /** 
    Package: PIT_PKG
      Declares the core PIT logic. This package is called by PIT as the API for PIT_PKG only.
   
    Author:: 
      Juergen Sieben, ConDeS GmbH
      
      Published under MIT licence
   */
   
  C_LEVEL_OFF constant pls_integer := 10;
  C_LEVEL_FATAL constant pls_integer := 20;
  C_LEVEL_ERROR constant pls_integer := 30;
  C_LEVEL_WARN constant pls_integer := 40;
  C_LEVEL_INFO constant pls_integer := 50;
  C_LEVEL_DEBUG constant pls_integer := 60;
  C_LEVEL_ALL constant pls_integer := 70;
  
  C_TRACE_OFF constant pls_integer := 10;
  C_TRACE_MANDATORY constant pls_integer := 20;
  C_TRACE_OPTIONAL constant pls_integer := 30;
  C_TRACE_DETAILED constant pls_integer := 40;
  C_TRACE_ALL constant pls_integer := 50;
    
  C_TYPE_INTEGER constant pit_util.ora_name_type := 'INTEGER';
  C_TYPE_NUMBER constant pit_util.ora_name_type := 'NUMBER';
  C_TYPE_DATE constant pit_util.ora_name_type := 'DATE';
  C_TYPE_TIMESTAMP constant pit_util.ora_name_type := 'TIMESTAMP';
  C_TYPE_XML constant pit_util.ora_name_type := 'XML';

  /**
    Group: Maintenance
   */  
  /**
    Procedure: initialize
      Initialization procedure.
      
      Made public to allow for any session to re-initialize PIT. As the actual status is 
      persisted in a global context, initializing PIT will effectively re-initialize all 
      PIT package instances across sessions.
   */
  procedure initialize;
  
   
  /**
    Group: Core methods
   */    
  /** 
    Function: check_datatype
      Implements a data type check for a given VARCHAR2 value.
    
    Parameters:
      p_value - Value to check
      p_type - Expected data type. One of the C_TYPE_... constants
      p_format_mask - Format mask to convert a string to the target value. May be NULL.
      p_accept_null - Define whether a value must exist. If set to TRUE, a NULL value returns TRUE and FALSE otherwise.
      
    Returns:
      TRUE, if the value could be casted to the requested data type, FALSE if not.
   */
  function check_datatype(
    p_value in varchar2,
    p_type in varchar2,
    p_format_mask in varchar2,
    p_accept_null in boolean)
    return boolean;
    
    
  /** 
    Function: check_log_level_greater_equal
      Method checks whether the actually valid log level is greater or equal to <P_LOG_LEVEL>.
      
      Allows external code to check whether PIT is in a given log level. 
      This is useful to run logic only if it would be logged anyway.
      
    Parameter:
      p_log_level - Severity to check, one of the constants C_LEVEL_... of this package
      
    Returns:
      TRUE, if the acutally log level is greater or equal to <P_LOG_LEVEL>, FALSE otherwise
   */
  function check_log_level_greater_equal(
    p_log_level in pls_integer)
    return boolean;
    
  
  /**
    Function: check_trace_level_greater_equal
      Method checks whether the actually valid trace level is greater or equal to <P_TRACE_LEVEL>.
      
      Allows external code to check whether PIT is in a given trace level. 
      This is useful to run logic only if it would be traced anyway.
      
    Parameter:
      p_log_level - Severity to check, one of the constants C_TRACE_... of this package
      
    Returns:
      TRUE, if the acutally trace level is greater or equal to <P_TRACE_LEVEL>, FALSE otherwise
   */
  function check_trace_level_greater_equal(
    p_trace_level in pls_integer)
    return boolean;
    
  
  /** 
    Procedure: enter
      Traces entering a method and maintains a call stack.
      
    Parameters:
      p_action - Name of the block that is executed. Normally the procedure or function name within a package.
      p_params - List of parameters which is passed into tracing. Only VARCHAR2 is allowed as a parameter value with a maximum of 4000 byte.
      p_trace_level - Trace level to allow for selective tracing.
      p_client_info - Optional info to be passed to DBMS_APPLICATION_INFO,
   */
  procedure enter(
    p_action in pit_util.ora_name_type,
    p_params in msg_params,
    p_trace_level in pls_integer,
    p_client_info in varchar2);
  
  /** 
    Function: get_active_message
      Retrieves the actually instantiated message instance.
      
    Returns:
      Instance of type <MESSAGE_TYPE> that has been instantiated by PIT before
   */
  function get_active_message
    return message_type;
  
  
  /** 
    Function: get_message
      Returns an instance of type <MESSAGE_TYPE>. It takes the message_name,
      constructs an instance of <MESSAGE_TYPE> and returns the message instance.
      
    Parameters:
      p_message_name - Name of the message to log
      p_msg_args - List of replacement values for the message
      p_affected_id - ID of an object that is affected by this message
      p_error_code - Additional error code, used in external applications
      
    Returns:
      Instance of the requested message.
   */
  function get_message(
    p_message_name in pit_util.ora_name_type,
    p_msg_args in msg_args,
    p_affected_id in pit_util.max_sql_char,
    p_error_code in varchar2)
    return message_type;    
       
    
  /** 
    Function: get_message_text
      Returns the text of a message. It takes the message_name, constructs an instance of <MESSAGE_TYPE> and returns the message text.
      
    Parameters:
      p_message_name - Name of the message to log
      p_msg_args - List of replacement values for the message
      
    Returns:
      Messagetext of the requested message.
   */
  function get_message_text(
    p_message_name in pit_util.ora_name_type,
    p_msg_args in msg_args)
    return clob;
    
    
  /** 
    Function:get_actual_call_stack_depth
      Method to retrieve the actual call stack depth. Used internally to check whether the call stack is correctly maintained.
      
    Returns:
      Actual stack depth
   */
  function get_actual_call_stack_depth
    return pls_integer;
    

  /** 
    Function: get_trans_item
      Function to retrieve a PIT translatable item (PTI).
      
    Parameters:
      p_pti_pmg_name - Name of the message group the PTI belongs to
      p_pti_id - ID of the item to retreive translations for
      p_msg_args - <MSG_ARGS> object to adjust NAME or DISPLAY_NAME of the PTI
      p_pti_pml_name - Oracle language reference
      
    Returns:
      Record of type <PIT_UTIL.TRANSLATABLE_ITEM_REC> with access to PTI_NAME, PTI_DISPLAY_NAME and PTI_DESCRIPTION
   */
  function get_trans_item(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_msg_args msg_args,
    p_pti_pml_name in pit_message_language.pml_name%type)
    return pit_util.translatable_item_rec;
  
  
  /** 
    Procedure: handle_error
      Handels an error. It takes the message_name and constructs an instance of MESSAGE_TYPE for it. 
      It then calls raises an error with the respective message that can be caught by the exception block. 
      Messages with severity error or fatal have an associated error called <MESSAGE_NAME>_ERR that can be used to capture the error.
      
    Attention:
      The postfix or prefix for an exception depends on the installation of PIT and may differ.
   
    Parameters:
      p_severity - Severity of the message to log (FATAL|ERROR)
      p_message_name - Name of the message to log
      p_msg_args - List of replacement values for the message
      p_affected_id - ID of an object that is affected by this message
      p_error_code - Additional error code, used in external applications
      p_params - Instance of <MSG_PARAMS> with a list of key-value pairs representing parameter name and -value.
   */
  procedure handle_error(
    p_severity in pls_integer,
    p_message_name in pit_util.ora_name_type default null,
    p_msg_args in msg_args default null,
    p_affected_id in pit_util.max_sql_char default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null);

  
  /** 
    Procedure: leave
      Traces leaving a method, calculates timing information if requested and maintains a call stack.
      
    Parameters:
      p_trace_level - Trace level to allow for selective tracing.
      p_params - Instance of <msg_params> with a list of key-value pairs representing parameter name and -value.
      p_on_error - Flag to indicate whether leave method was called in connection with error handling
   */
  procedure leave(
    p_trace_level in pls_integer,
    p_params in msg_params,
    p_on_error in boolean default false);  
    
    
  /** 
    Procedure: log_event
      Logs messages. It takes the message_name and constructs an instance of <MESSAGE_TYPE> for it. 
      It then calls any log procedure of all active output modules and passes the message.
      
    Parameters:
      p_severity - Log-level. Allows to decide whether PIT should log or not.
                   If 0, the message gets logged anyway, regardless of log settings
      p_message_name - Name of the message to log
      p_msg_args - List of replacement values for the message
      p_affected_id - Optional ID of an item a log entry relates to
      p_error_code - Additional error code, used in external applications and to distinguish
                     several occurences of the same message.
   */
  procedure log_event(
    p_severity in pls_integer,
    p_message_name in pit_util.ora_name_type default null,
    p_msg_args in msg_args default null,
    p_affected_id in pit_util.max_sql_char default null,
    p_error_code in varchar2 default null);
  

  /** 
    Procedure: log_specific
      Logs messages regardless of log settings. It takes the message_name and constructs an instance of 
      <MESSAGE_TYPE> for it. It then calls any log procedure of all active output modules and passes the message, 
      regardless of the actual log settings.
      
      This method is used to provide a mechanism to log different messages to a certain set of log modules only.
      
    Parameters:
      p_message_name - Name of the message to log
      p_affected_id - Optional ID of an item a log entry relates to
      p_error_code - Additional error code, used in external applications
      p_msg_args - List of replacement values for the message
      p_log_threshold - Threshold that is taken as a comparison to the message
                        severity to decide whether a message should be logged
      p_log_modules - List of output modules to log to. This list is taken
                      for this single call only. It does not affected the overall
                      log module settings for the active or default context
   */
  procedure log_specific(
    p_message_name in pit_util.ora_name_type,
    p_affected_id in pit_util.max_sql_char,
    p_error_code in varchar2,
    p_msg_args in msg_args,
    p_log_threshold in pit_message.pms_pse_id%type,
    p_log_modules in pit_util.max_sql_char);
    
    
  /** 
    Procedure: log_state
      Logs parameters. It expects an instance of <MSG_PARAMS>, containing variable names and 
      their actual value. Useful if you want to log the state of variables without the context 
      of a method call, fi to debug state within a loop.
      
      Optionally, you may add an ID to reference an item.
      
    Parameters:
      p_params - List of replacement values for the message
      p_severity - Optional log level of the state message. Values get logged only if the actual
                   log settings are lower (mor severe) or equal to P_SEVERITY.
                   If NULL, parameter LOG_STATE_THRESHOLD controls whether the params get logged or not.
   */
  procedure log_state(
    p_params in msg_params,
    p_severity in pit_message_severity.pse_id%type default null);
  
  
  /** 
    Procedure: long_op
      Sets dbms_application_info.
      
      Use this procedure to pass information about long operations to the database. If this task is completed, 
      call this procedure with
      
      --- SQL
      p_sofar = p_total (or p_sofar = 100)
      ---
      
      to allow for proper state cleansing.
      
      If you call <pit.HANDLE_EXCEPTION> or <pit.STOP>, the state will be cleaned as well.
      This method will work only if tracing is enabled, as it takes the method name from the call stack and
      persist the actual index with the call stack.
      
    Parameters:
      p_target - Description of the operation
      p_sofar - Percentage of the task completed (0 .. 100 or individual scale)
      p_total - Amount of work to be done
      p_units - Unit of work, eg. "rows processed" or similar
      p_op_name - Actual action. Either passed in manually or taken from the method name
   */
  procedure long_op(
    p_target in varchar2,
    p_sofar in number,
    p_total in number,
    p_units in varchar2,
    p_op_name in varchar2);
  

  /** 
    Procedure: notify
      Notifies output modules.It takes the message_name and constructs an instance of <MESSAGE_TYPE> for it. 
      It then calls any notify procedure of all active output modules and passes the message.
      
      Notifications are meant to be used for progress messages and the like.
      
    Parameters:
      p_message_name - Name of the message to log
      p_affected_id - Optional ID of an item a log entry relates to
      p_msg_args - List of replacement values for the message
      p_log_threshold - Threshold that is taken as a comparison to the message severity to decide whether a message should be logged
      p_log_modules - List of output modules to log to. This list is taken for this single call only. It does not affected the overall
                      log module settings for the active or default context
   */
  procedure notify(
    p_message_name in pit_util.ora_name_type,
    p_affected_id in pit_util.max_sql_char,
    p_msg_args in msg_args,
    p_log_threshold in pit_message.pms_pse_id%type,
    p_log_modules in pit_util.max_sql_char);
  
  
  /** 
    Procedure: print
      Prints a message to the output modules. Used to pass user information to the view layer.
      It takes the message_name and constructs an instance of <MESSAGE_TYPE> for it. 
      It then calls any print procedure of all active output modules and passes the message.
      
    Parameters:
      p_message_name - Name of the message to log
      p_msg_args - List of replacement values for the message
   */
  procedure print(
    p_message_name in pit_util.ora_name_type,
    p_msg_args in msg_args);
  
  
  /** 
    Procedure: purge_log
      Purges the message stack after a given point in time.
      
      - P_DATE_BEFORE determines which entries to purge. 
      - P_SEVERITY_GREATER_EQUAL determines which severity is to be purged. 
    
    Example:
      Setting it to 40 will purge all entries with severity of 40 and greater.
      
    Parameters:
      p_date_before - Date before which the message log is purged 
      p_severity_lower_equal - Optional severity level that controls which severity of messages shall be purged.
                               Includes all messages with severity <code>P_SEVERITY_GREATER_EQUAL</code> and lower
   */
  procedure purge_log(
    p_date_before in date,
    p_severity_lower_equal in pls_integer);
  
  
  /** 
    Procedure: raise_error
      Raises an error. It takes the message_name and constructs an instance of <MESSAGE_TYPE> for it. 
      It then calls raises an error with the respective message that can be caught by the exception block. 
      Messages with severity error or fatal have an associated error called <MESSAGE_NAME>_ERR 
      that can be used to capture the error.
      
    Attention:    
      The postfix or prefix for an exception depends on the installation of PIT and may differ.
      
    Parameters:
      p_severity - Severity of the message to raise (FATAL|ERROR)
      p_message_name - Name of the message to raise 
      p_msg_args - List of replacement values for the message
      p_affected_id - ID of an object that is affected by this message
      p_error_code - Additional error code, used in external applications
   */
  procedure raise_error(
    p_severity in pls_integer,
    p_message_name in pit_util.ora_name_type default null,
    p_msg_args in msg_args default null,
    p_affected_id in pit_util.max_sql_char default null,
    p_error_code in varchar2 default null);
    
  
  /**
    Group: Context maintenance
   */
  /** 
    Function: get_context
      Functon to retrieve the actual context as an instance of <pit_util.CONTEXT_TYPE>.
      is called if an external function wishes to persist the actual settings and reset them later
      
    Returns:
      Instance of context_type filled with the actually valid settings
   */
  function get_context
    return pit_util.context_type;
    
    
  /** 
    Procedure: set_context
      Procedure to change the settings in the global PIT_CONTEXT.
      
      This procedure is used if log settings have to be changed dynamically.
      Normal usage is to overwrite log settings as defined in the parameters for a given session.
      
    Parameter:
      p_context  Instance of <PIT_UTIL.context_type>
   */
  
  procedure set_context(
    p_context in pit_util.context_type);
  
  
  /* 
    Function: get_context_value
      Method to get a context value eplicitly. Is used to retrieves sert values from the context. 
      This allows for maintaining information such as a test flag in a cross session aware manner.
      
    Parameter:
      p_name - Name of the attribute to get
    
    Returns:
      Value of the attribute <P_NAME>
   */
  function get_context_value(
    p_name in varchar2)
    return varchar2;
  
  
  /* 
    Procedure: set_context_value
      Method to set a context value eplicitly. Is used to persist arbitrary values at the context.
      This allows for maintaining information such as a test flag in a cross session aware manner.
      Setting an attribute to NULL eliminates this attribute from the context.
      
    Parameters:
      p_name - Name of the attribute to set
      p_value - Value to set, VARCHAR2 up to 4000 bytes.
   */
  procedure set_context_value(
    p_name in varchar2,
    p_value in varchar2);
    
  
  /** 
    Procedure: reset_active_context
      Procedure to reset log settings to the default settings.
      
      If settings for a session were changed, calling this procedure resets these settings 
      to the default settings as defined by the parameters.
   */
  procedure reset_active_context;
  
  
  /** 
    Procedure reset_context
      Procedure to reset the complete context to default settings
      
      Use this procedure to rest all session settings to the  default settings. 
      Be aware that calling this procedure will reset ALL log settings of ALL sessions to default
   */
  procedure reset_context;
  
  
  /**
    Group: Collect mode methods
   */
   /** 
    Function: get_collect_least_severity
      Method to retrieve the actually least severity during collect mode.
      
      Is used to examine during collect mode whether an error or fatal error has occurred.
      Based on this information, validation logic may be executed or not.
      
    Returns:
      Least severity received so far
   */
  function get_collect_least_severity
    return binary_integer;
    
  
  /** 
    Function: get_collect_mode
      Method to read the actually set collection mode.
      
    Returns: TRUE, if PIT is in collect mode, FALSE otherwise.
   */
  function get_collect_mode
    return boolean;
    
    
  /** 
    Procedure: set_collect_mode
      Procedure to toggle PIT collection mode. 
      
      Is used to set PIT to collect mode, where all messages are collected rather than thrown or processed immediate.
      This mode allows for validation methods to perfrom all internal validations prior to raising validation errors.
      
      - If collection mode is switched off by passing FALSE into this function, the list of raised messages is examined.
      - If at least one message of secverity C_LEVEL_FATAL is present, exception PIT_BULK_FATAL is raised. 
      - If at least one message of secverity C_LEVEL_ERROR is present, exception PIT_BULK_ERROR is raised. 
      
    Parameter:
      p_mode - Flag to indicate whether PIT must collect messages (TRUE) or not (FALSE);
   */
  procedure set_collect_mode(
    p_mode in boolean);
    
  
  /** 
    Function: get_message_collection
      Method to retrieve the collection of messages raised since setting PIT to collect mode.
      
      Is used to retrieve a list of all messages raised during the collect cycle. It implicitly terminates collection
      mode by calling <set_collect_mode> with FALSE if PIT is still in collection mode.
      Normal usage is terminating collection mode explicity and deal with the list of messages in the exception block.
   
    Returns:
      Instance of <PIT_MESSAGE_TABLE>, a list of message instances
   */
  function get_message_collection
    return pit_message_table;
    
  
  /** 
    Group: Module maintenance methods
   */
  /** 
    Function: get_active_modules
      Function to retrieve a list of active modules.
      
    Returns:
      <ARGS>, List of module names
   */
  function get_active_modules
   return args
   pipelined;
    
    
  /** 
    Function: get_available_modules
      Function to retrieve a list of available modules. A module is AVAILABLE if it could be initialized succesfully.
      
    Returns:
      <ARGS>, List of module names
   */
  function get_available_modules
   return args
   pipelined;
   
   
  /**
    Function: get_modules
      Function to retrieve a list of all installed modules.
      
    Returns:
      <PIT_MODULE_LIST>, List of modules, availabilty and active status
   */
  function get_modules
    return pit_module_list
    pipelined;
   
   
  /** 
    Function: report_module_status
      Function to retrieve status of all modules
    
    Returns:
      <ARGS>, List of module names
   */
  function report_module_status
    return args 
    pipelined;
 
end pit_pkg;
/
