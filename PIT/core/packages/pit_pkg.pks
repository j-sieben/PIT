create or replace package pit_pkg
  authid definer
  -- accessible by (package PIT)
as
  /** Project:      PIT (www.github.com/j-sieben/PIT)
   *  Descriptioon: Package to implement the core PIT logic. 
   *                This package is called by PIT as the API for PIT_PKG only.
   *  @headcom
   */    
  
  /** CONSTANTS */
  C_LEVEL_OFF constant number := 10;
  C_LEVEL_FATAL constant number := 20;
  C_LEVEL_ERROR constant number := 30;
  C_LEVEL_WARN constant number := 40;
  C_LEVEL_INFO constant number := 50;
  C_LEVEL_DEBUG constant number := 60;
  C_LEVEL_ALL constant number := 70;
  
  C_TRACE_OFF constant number := 10;
  C_TRACE_MANDATORY constant number := 20;
  C_TRACE_OPTIONAL constant number := 30;
  C_TRACE_DETAILED constant number := 40;
  C_TRACE_ALL constant number := 50;
    

  /** Initialization procedure
   * @usage  Made public to allow for any session to re-initialize PIT.
   *         As the actual status is persisted in a global context, initializing
   *         PIT will effectively re-initialize all PIT packages
   */
  procedure initialize;
  
   
  /* CORE */    
  /** Logs messages
   * @usage  This method is called from PIT. It takes the message_name and
   *         constructs an instance of <code>MESSAGE_TYPE</code> for it. It then calls any
   *         log procedure of all active output modules and passes the message.
   * @param  p_severity      Log-level. Allows to decide whether PIT should log or not.
   *                         If 0, the message gets logged anyway, regardless of log settings
   * @param  p_message_name  Name of the message to log
   * @param  p_arg_list      List of replacement values for the message
   * @param  p_affected_id   Optional ID of an item a log entry relates to
   * @param  p_error_code    Additional error code, used in external applications
   */
  procedure log_event(
    p_severity in binary_integer,
    p_message_name in pit_util.ora_name_type default null,
    p_arg_list in msg_args default null,
    p_affected_id in pit_util.max_sql_char default null,
    p_error_code in varchar2 default null);
  

  /** Logs messages regardless of log settings
   * @usage  This procedure is called from PIT. It takes the message_name and
   *         constructs an instance of <code>MESSAGE_TYPE</code> for it. It then calls any
   *         log procedure of all active output modules and passes the message, regardless of the actual log settings.
   *         This overloaded version is used to provide a mechanism to log different
   *         messages to a certain set of log modules only
   * @param  p_message_name   Name of the message to log
   * @param  p_affected_id    Optional ID of an item a log entry relates to
   * @param  p_error_code     Additional error code, used in external applications
   * @param  p_arg_list       List of replacement values for the message
   * @param  p_log_threshold  Threshold that is taken as a comparison to the message
   *                          severity to decide whether a message should be logged
   * @param  p_log_modules    List of output modules to log to. This list is taken
   *                          for this single call only. It does not affected the overall
   *                          log module settings for the active or default context
   */
  procedure log_specific(
    p_message_name in pit_util.ora_name_type,
    p_affected_id in pit_util.max_sql_char,
    p_error_code in varchar2,
    p_arg_list in msg_args,
    p_log_threshold in pit_message.pms_pse_id%type,
    p_log_modules in pit_util.max_sql_char);
    
  
  /** Traces entering a method
   * @usage  Is called from PIT to trace entering a method.
   *         It will determine timing information and maintain a call stack.
   * @param  p_action       Name of the block that is executed. Normally the procedure
   *                        or function name within a package.
   * @param  p_module       Unit that contains the method that is executed. Either the
   *                        package name or <code>ANONYMOUS, PROCEDURE, FUNCTION</code> or <code>TRIGGER</code>
   * @param  p_params       List of parameters which is passed into tracing. 
   *                        Only varchar2 is allowed as a parameter value with a maximum of 4000 byte.
   * @param  p_trace_level  Trace level to allow for selective tracing.
   * @param  p_client_info  Optional info to be passed to <code>DBMS_APPLICATION_INFO</code>,
   *                        applicable for <code>TRACE_MANDATORY</code> only
   */
  procedure enter(
    p_action in pit_util.ora_name_type,
    p_module in pit_util.ora_name_type,
    p_params in msg_params,
    p_trace_level in binary_integer,
    p_client_info in varchar2);

  
  /** Traces leaving a method
   * @usage  Is called from PIT to trace leaving a method.
   *         Calculates timing information if requested and maintain a call stack.
   * @param  p_trace_level  Trace level to allow for selective tracing.
   * @param  p_params       Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   */
  procedure leave(
    p_trace_level in binary_integer,
    p_params in msg_params);  
  
  
  /** Sets dbms_application_info.
   * @usage  Use this procedure to pass information about long operations to the
   *         database. If this task is completed, call this procedure with
   *         <code>p_sofar = p_total (or p_sofar = 100)</code> to allow for proper state cleansing.<br>
   *         If you call <code>pit.SQL_EXCEPTION</code> or <code>pit.STOP</code>, the state will be cleaned as well.
   *         This method will work only if tracing is enabled, as it takes <code>OP_NAME</code> from the call stack and
   *         persist the actual index with the call stack.
   * @param  p_target   Description of the operation
   * @param  p_sofar    Percentage of the task completed (0 .. 100 or individual scale)
   * @param  p_total    Amount of work to be done
   * @param  p_units    Unit of work, eg. "rows processed" or similar
   * @param  p_op_name  Actual action. Either passed in manually or taken from the method name
   */
  procedure long_op(
    p_target in varchar2,
    p_sofar in number,
    p_total in number,
    p_units in varchar2,
    p_op_name in varchar2);
  
  
  /** Purges the message stack after a given point in time
   * @usage  Is called from PIT to purge the message stack
   *         - P_DATE_BEFORE            determines which entries to purge. 
   *         - P_SEVERITY_GREATER_EQUAL determines which severity is to be purged. 
   *           Setting it to 40 will purge all entries with severity of 40 and greater.
   * @param  p_date_before           Date, before which the message log is purged 
   * @param  p_severity_lower_equal  Optional severity level that controls which severity of messages shall be purged.
   *                                 Includes all messages with severity <code>P_SEVERITY_GREATER_EQUAL</code> and lower
   */
  procedure purge_log(
    p_date_before in date,
    p_severity_lower_equal in binary_integer);
  
  
  /** Prints a message to the output modules. Used to pass user information to the view layer
   * @param  p_message_name  Name of the message to log
   * @param  p_arg_list      List of replacement values for the message
   * @usage  This procedure is called from PIT. It takes the message_name and
   *         constructs an instance of MESSAGE_TYPE for it. It then calls any
   *         print procedure of all active output modules and passes the message.
   */
  procedure print(
    p_message_name in pit_util.ora_name_type,
    p_arg_list msg_args);
  

  /** Notify output modules
   * @param  p_message_name   Name of the message to log
   * @param  p_affected_id    Optional ID of an item a log entry relates to
   * @param  p_arg_list       List of replacement values for the message
   * @param  p_log_threshold  Threshold that is taken as a comparison to the message
   *                          severity to decide whether a message should be logged
   * @param  p_module_list    List of output modules to log to. This list is taken
   *                          for this single call only. It does not affected the overall
   *                          log module settings for the active or default context
   * @usage  This procedure is called from PIT. It takes the message_name and
   *         constructs an instance of MESSAGE_TYPE for it. It then calls any
   *         notify procedure of all active output modules and passes the message.
   *         Notifications are meant to be used for progress messages and the like.
   */
  procedure notify(
    p_message_name in pit_util.ora_name_type,
    p_affected_id in pit_util.max_sql_char,
    p_arg_list in msg_args,
    p_log_threshold in pit_message.pms_pse_id%type,
    p_module_list in pit_util.max_sql_char);
  
  
  /** Raises an error
   * @param  p_severity      Severity of the message to raise (FATAL|ERROR)
   * @param  p_message_name  Name of the message to raise 
   * @param  p_arg_list      List of replacement values for the message
   * @param  p_affected_id   ID of an object that is affected by this message
   * @param  p_error_code    Additional error code, used in external applications
   * @usage  This procedure is called from PIT. It takes the message_name and
   *         constructs an instance of MESSAGE_TYPE for it. It then calls raises
   *         an error with the respective message that can be caught by the exception
   *         block. Messages with severity error or fatal have an associated error
   *         called <MESSAGE_NAME>_ERR that can be used to capture the error.
   */
  procedure raise_error(
    p_severity in binary_integer,
    p_message_name pit_util.ora_name_type default null,
    p_arg_list in msg_args default null,
    p_affected_id in pit_util.max_sql_char default null,
    p_error_code in varchar2 default null);
  
  
  /** Handels an error
   * @param  p_severity      Severity of the message to log (FATAL|ERROR)
   * @param  p_message_name  Name of the message to log
   * @param  p_arg_list      List of replacement values for the message
   * @param  p_affected_id   ID of an object that is affected by this message
   * @param  p_error_code    Additional error code, used in external applications
   * @param  p_params        Instance of <code>msg_params</code> with a list of
   *                         key-value pairs representing parameter name and -value.
   * @usage  This procedure is called from PIT. It takes the message_name and
   *         constructs an instance of MESSAGE_TYPE for it. It then calls raises
   *         an error with the respective message that can be caught by the exception
   *         block. Messages with severity error or fatal have an associated error
   *         called <MESSAGE_NAME>_ERR that can be used to capture the error.
   */
  procedure handle_error(
    p_severity in binary_integer,
    p_message_name pit_util.ora_name_type default null,
    p_arg_list in msg_args default null,
    p_affected_id in pit_util.max_sql_char default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null);
  
  
  /** Returns an instance of type MESSAGE_TYPE.
   * @param  p_message_name  Name of the message to log
   * @param  p_arg_list      List of replacement values for the message
   * @param  p_affected_id   ID of an object that is affected by this message
   * @param  p_error_code    Optional error code, usable by external applications
   * @return Instance of the requested message.
   * @usage  This procedure is called from PIT. It takes the message_name,
   *         constructs an instance of MESSAGE_TYPE and returns the message instance.
   */
  function get_message(
    p_message_name in pit_util.ora_name_type,
    p_arg_list in msg_args,
    p_affected_id in pit_util.max_sql_char,
    p_error_code in varchar2)
    return message_type;
    
  
  /** Helper function to retrieve the actually instantiated message instance
   * %return Instance of type MESSAGE_TYPE that has been instantiated by PIT before
   */
  function get_active_message
    return message_type;
    
    
  /** Returns the text of a message
   * @param  p_message_name  Name of the message to log
   * @param  p_arg_list      List of replacement values for the message
   * @return Messagetext of the requested message.
   * @usage  This procedure is called from PIT. It takes the message_name ,
   *         constructs an instance of MESSAGE_TYPE and returns the message text.
   */
  function get_message_text(
    p_message_name in pit_util.ora_name_type,
    p_arg_list in msg_args)
    return clob;
    

  /** Function to retrieve a PIT translatable item (PTI)
   * @param  p_pti_pmg_name  Name of the message group the PTI belongs to
   * @param  p_pti_id        ID of the item to retreive translations for
   * @param  p_arg_list      MSG_ARGS object to adjust NAME or DISPLAY_NAME of the PTI
   * @param  p_pti_pml_name  Oracle language reference
   * %return Record of type PIT_UTIL.TRANSLATABLE_ITEM_REC with access to PTI_NAME, PTI_DISPLAY_NAME and PTI_DESCRIPTION
   * @usage  method to get access to a translated item.
   */
  function get_trans_item(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_arg_list msg_args,
    p_pti_pml_name in pit_message_language.pml_name%type)
    return pit_util.translatable_item_rec;
    
    
  /** CONTEXT MAINTENANCE */
  /** Functon to retrieve the actual context as an instance of <ocde>pit_util.CONTEXT_TYPE</code>
   * @return Instance of context_type filled with the actually valid settings
   * @usage  is called if an external function wishes to persist the actual
   *         settings and reset them later
   */
  function get_context
    return pit_util.context_type;
    
    
  /** Procedure to change the settings in the global PIT_CONTEXT
   * @param  p_log_level     New log level.
   * @param  p_trace_level   New trace level
   * @param  p_trace_timing  Flag to switch timing on or off
   * @param  p_module_list   Colon-separated list of output modules used
   * @param  p_focus         Indicates whether changes are made for the active session 
   *                         only (ACTIVE) or as a new default setting (DEFAULT). Defaults to ACTIVE
   * @usage  This procedure is used when log settings shall be changed dynamically
   *         Normal usage is to overwrite log settings as defined in the parameters
   *         for a given session.
   */
  procedure set_context(
    p_log_level in binary_integer,
    p_trace_level in binary_integer,
    p_trace_timing in boolean,
    p_module_list in pit_util.max_sql_char);
    
  
  /** Overloaded version that takes an instance of CONTEXT_TYPE-record as input parameter
   * @param  p_context  Instance of CONTEXT_TYPE-record with the actually valid context settings
   */
  procedure set_context(
    p_context in pit_util.context_type);
    
  
  /** Overloaded version that expects the name of a named context as defined in the parameters
   * @param  p_context_name  Name of a context. Reuqires a matching parameter named CONTEXT_<Name>
   *                         with predefined debug settings in the format 
   *                         [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST],
   *                         fi: CONTEXT_FULL = '70|70|Y|PIT_CONSOLE:PIT_FILE'
   * @param  p_validate      Optional flag to indicate that session data (user, client-id)
   *                         has to be fetched dynamically. Leave this untouched.
   * @usage  This method is used to adjust the debug settings during execution of the code.
   */
  procedure set_context(
    p_context_name in pit_util.ora_name_type,
    p_validate in boolean default true);
  
  
  /** Procedure to reset log settings to the default settings
   * @param  p_validate      Optional flag to indicate that session data (user, client-id)
   *                         has to be fetched dynamically. Leave this untouched.
   * @usage  If settings for a session were changed, calling this procedure
   *         resets these settings to the default settings as defined by the 
   *         parameters
   */
  procedure reset_active_context(
    p_validate in boolean default true);
  
  
  /** Procedure to reset the complete context to default settings
   * @usage  Use this procedure to rest all session settings to the 
   *         default settings. Be aware that calling this procedure will reset
   *         ALL log settings of ALL sessions to default
   */
  procedure reset_context;
  
  
  /** Procedure to toggle PIT collection mode
   * @param  p_mode  Flag to indicate whether PIT shall collect messages (TRUE) or not (FALSE);
   * @usage  Is used to set PIT to collect mode, where all messages are collected rather than thrown or processed immediate.
   *         This mode allows for validation methods to perfrom all internal validations prior to raising validation errors.
   *         If collection mode is switched off by passing FALSE into this function, the list of raised messages is examined.
   *         If at least one message of secverity C_LEVEL_FATAL is present, exception PIT_BULK_FATAL is raised. 
   *         If at least one message of secverity C_LEVEL_ERROR is present, exception PIT_BULK_ERROR is raised. 
   */
  procedure set_collect_mode(
    p_mode in boolean);
    
    
  /** Method to read the actually set collection mode */
  function get_collect_mode
    return boolean;
    
  
  /** Method to retrieve the collection of messages raised since setting PIT to collect mode
   * %return Instance of PIT_MESSAGE_TABLE, a list of message instances
   * @usage  Is used to retrieve a list of all messages raised during the collect cycle. It implicitly terminates collection
   *         mode by calling SET_COLLECT_MODE(FALSE) if PIT is still in collection mode. Normal usage is terminating collection
   *         mode explicity and deal with the list of messages in the exception block
   */
  function get_message_collection
    return pit_message_table;
    
    
  /** Method to retrieve the actual call stack depth.
   * @usage  Used internally to check whether the call stack is correctly maintained
   * @return Actual stack depth
   */
  function get_actual_call_stack_depth
    return binary_integer;
    
  
  /** MODULE MAINTENANCE */
  /** Function to retrieve a list of all installed modules
   * @return PIT_MODULE_LIST-type, List of modules, availabilty and active status
   * @usage  Use this function if you require a list of all installed modules.
   */
  function get_modules
    return pit_module_list
    pipelined;
    
    
  /** Function to retrieve a list of active modules
   * @return ARGS-type, List of module names
   * @usage  Use this function if you require a list of active modules.
   */
  function get_active_modules
   return args
   pipelined;
   
   
  /** Function to retrieve a list of available modules
   * @return ARGS-type, List of module names
   * @usage  Use this function if you require a list of available modules.
   *         A module is AVAILABLE if it could be initialized succesfully.
   */
  function get_available_modules
   return args
   pipelined;
   
   
  /** Function to retrieve status of all modules
   * @return ARGS-type, List of module names
   * @usage  Use this function if you require a status of all modules.
   */
  function report_module_status
    return args 
    pipelined;
 
end pit_pkg;
/
