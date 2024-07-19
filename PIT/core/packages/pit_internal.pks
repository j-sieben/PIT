create or replace package pit_internal
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

  C_PANIC_MESSAGE constant pit_util.ora_name_type := 'PIT_PANIC';
  
  /**
    Group: Maintenance
   */  
  /**
    Procedure: initialize_pit
      Initialization procedure.
      
      Made public to allow for any session to re-initialize PIT. As the actual status is 
      persisted in a global context, initializing PIT will effectively re-initialize all 
      PIT package instances across sessions.
   */
  procedure initialize_pit;
  
   
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
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Additional error code, used in external applications
      
    Returns:
      Instance of the requested message.
   */
  function get_message(
    p_message_name in pit_util.ora_name_type,
    p_msg_args in msg_args,
    p_affected_id in pit_util.max_sql_char,
    p_affected_ids in msg_params default null,
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
    Function: get_message_severity
      Returns the severity of a PIT message.
      
    Parameters:
      p_message_name - Name of the message to log
      
    Returns:
      Severrity of the requested message.
   */
  function get_message_severity(
    p_message_name in pit_util.ora_name_type)
    return binary_integer;
    

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
    Procedure: handle_validation
      Handels a valiation error. It takes the message_name and constructs an instance of MESSAGE_TYPE for it. 
      The severity of the message controls remains unchanged. It is meant to indicate whether a validation
      should be rendered as an error, a warning or as an informational hint rather than being
      used as PL/SQL errors. Therefore, error messages passed in do not need to have an associated
      exception variable.
   */
  procedure handle_validation;
  
  
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
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Additional error code, used in external applications
      p_params - Instance of <MSG_PARAMS> with a list of key-value pairs representing parameter name and -value.
   */
  procedure handle_error(
    p_severity in pls_integer,
    p_message_name in pit_util.ora_name_type default null,
    p_msg_args in msg_args default null,
    p_affected_id in pit_util.max_sql_char default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null);
  
  
  /** 
    Procedure: handle_panic
      Handels a panic. A panic is an unexpected, unrecoverable error that needs a clean
      handling by any output module.
   */
  procedure handle_panic;

  
  /** 
    Procedure: leave
      Traces leaving a method, calculates timing information if requested and maintains a call stack.
      
    Parameters:
      p_trace_level - Trace level to allow for selective tracing.
      p_params - Instance of <msg_params> with a list of key-value pairs representing parameter name and -value.
      p_severity - Indicates whether leave was called in the vicinity of error handling. Based on severity, 
                   either any entry up to the calling entry is popped from stack or the stack is completely emptied.
   */
  procedure leave(
    p_trace_level in pls_integer,
    p_params in msg_params,
    p_severity in binary_integer default null);  
    
    
  /**
    Procedure: tweet
      Lightweight message for temporary comments additiona debug information.
      
      Does not require full messages, will not translate nor will it generate
      environment information such as call stack or error stack information.
      
    Parameter:
      p_message - Textmessage to tweet
   */
  procedure tweet(
    p_message in varchar2);
    
    
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
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Additional error code, used in external applications and to distinguish
                     several occurences of the same message.
   */
  procedure log_event(
    p_severity in pls_integer,
    p_message_name in pit_util.ora_name_type default null,
    p_msg_args in msg_args default null,
    p_affected_id in pit_util.max_sql_char default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null);
  

  /** 
    Procedure: log_explicit
      Logs messages regardless of log settings. It takes the message_name and constructs an instance of 
      <MESSAGE_TYPE> for it. It then calls any log procedure of all active output modules and passes the message, 
      regardless of the actual log settings.
      
      This method is used to provide a mechanism to log different messages to a certain set of log modules only.
      
    Parameters:
      p_message_name - Name of the message to log
      p_affected_id - Optional ID of an item a log entry relates to
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Additional error code, used in external applications
      p_msg_args - List of replacement values for the message
      p_log_threshold - Threshold that is taken as a comparison to the message
                        severity to decide whether a message should be logged
      p_log_modules - List of output modules to log to. This list is taken
                      for this single call only. It does not affected the overall
                      log module settings for the active or default context
   */
  procedure log_explicit(
    p_message_name in pit_util.ora_name_type,
    p_affected_id in pit_util.max_sql_char,
    p_affected_ids in msg_params default null,
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
    p_affected_ids in msg_params default null,
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
    
    
  procedure raise_validation_error(
    p_error_name pit_util.ora_name_type,
    p_message_name pit_util.ora_name_type,
    p_msg_args in msg_args,
    p_affected_id in pit_util.max_sql_char,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2);
  
  
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
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Additional error code, used in external applications
   */
  procedure raise_error(
    p_severity in pls_integer,
    p_message_name in pit_util.ora_name_type default null,
    p_msg_args in msg_args default null,
    p_affected_id in pit_util.max_sql_char default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null);
    
  
  /**
    Group: Context maintenance
   */
  /** 
    Procedure: set_context
      Procedure to change the settings in the global PIT_CONTEXT.
      
      This procedure is used if log settings have to be changed dynamically.
      This method is either called with an existing context name or with explicit log settings.
      If the method is called with an exising context name, the settings are derived from the
      parameters for that context. Otherwise, an anonymous context is copied to the active context.
      
    Parameter:
      p_context_name - Optional name of the context
      p_log_level - Optional log level of the context
      p_trace_level - Optional trace level of the context
      p_trace_timing - Optional flag to indicate whether timing should be switched on
      p_log_modules - Optional list of log modules to log to
   */  
  procedure set_context(
    p_context_name in varchar2 default null,
    p_log_level in integer default null,
    p_trace_level in integer default null,
    p_trace_timing in boolean default null,
    p_log_modules in varchar2 default null);
  
  
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
  function get_collect_least_severity(
    p_error_code_list in char_table)
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
    Function: check_needs_assert
      Method to check whether an assertion has to be executed. If an assertion
      is requested for an error code that has been asserted in the same run before
      (applies to collect mode only) and it has envounterd an error already, the
      assertion is not executed anymore.
    
    Parameter:
      p_message_name - Name of the message, is taken as the error code if this is null
      p_error_code - Error code to group assertions
      
    Returns:
      TRUE if the assertion needs to be executed and FALSE otherwise
   */
  function check_needs_assert(
    p_message_name in varchar2,
    p_error_code in varchar2)
    return boolean;
    
  
  /**
    Procedure: raise_assertion_finding
      Method raises a message, respecting the severity settings
      
    Parameters:
      p_default_error - If no message name is passed in or if the message does not have an exception, this error is thrown
      p_condition - String expression to check.
      p_message_name - Name of the message. Reference to package MSG
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Optional error code, usable by external applications
      p_severity - Optional severity, overrides the message severity
   */    
  procedure raise_assertion_finding(
    p_default_error in varchar2,
    p_message_name in varchar2,
    p_msg_args msg_args,
    p_affected_id in varchar2,
    p_affected_ids in msg_params,
    p_error_code in varchar2);
 
end pit_internal;
/
