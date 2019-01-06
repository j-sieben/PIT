create or replace package pit
  authid definer 
as
  /** PIT-API package. Implements all functionality that is required to 
   *  utilize PIT in custom code.
   */
   
  /* PACKAGE VARIABLE GETTER */
  /* Constant level_off
   * @usage  Getter function for debug level OFF
   */
  function level_off return number deterministic;
  /* Constant level_fatal
   * @usage  Getter function for debug level FATAL
   */
  function level_fatal return number deterministic;
  /* Constant level_error
   * @usage  Getter function for debug level ERROR
   */
  function level_error return number deterministic;
  /* Constant level_warn
   * @usage  Getter function for debug level WARN
   */
  function level_warn return number deterministic;
  /* Constant level_info
   * @usage  Getter function for debug level INFO
   */
  function level_info return number deterministic;
  /* Constant level_debug
   * @usage  Getter function for debug level DEBUG
   */
  function level_debug return number deterministic;
  /* Constant level_all
   * @usage  Getter function for debug level ALL
   */
  function level_all return number deterministic;
  
  
  /* Constant trace_off
   * @usage  Getter function for trace level OFF
   */
  function trace_off return number deterministic;
  /* Constant trace_mandatory
   * @usage  Getter function for trace level MANDATORY
   */
  function trace_mandatory return number deterministic;
  /* Constant trace_optional
   * @usage  Getter function for trace level OPTIONAL
   */
  function trace_optional return number deterministic;
  /* Constant trace_detailed
   * @usage  Getter function for trace level DETAILED
   */
  function trace_detailed return number deterministic;
  /* Constant trace_all
   * @usage  Getter function for trace level ALL
   */
  function trace_all return number deterministic;
  
  /* Method to log a message regardless of the actual log settings.
   * @param  p_message_name   Name of the message. Reference to package MSG
   * @param [p_arg_list]      Optional list of replacement information
   * @param [p_affected_id]   Optional id of an item a message relates to
   * @param [p_error_code]    Optional error code, usable by external applications
   * @param [p_log_threshold] Optional log level for the log process. Should the
   *                          severity of the requested message be higher than this level, it
   *                          won't get logged. If null, the message is logged if it's severity
   *                          is higher than the actual log level defined.
   * @param [p_module_list]   Optional list of module names, separated by semicolon
   *                          that is used to log the message. If NULL, the list of
   *                          actually set modules is used.
   * @usage  Call this procedure to emit debug messages regardless of log settings.
   *         Use this method if you want to emit a message anyway or if you decide
   *         to emit a log message or not in code outside PIT.
   *         Optionally, set a list of modules that will become active for this
   *         method only. Modules set her will not remain active after this method.
   *         The context remains unchanged.
   */
  procedure log(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null,
    p_log_threshold in number default null,
    p_module_list in varchar2 default null); 
    
  
  /* Captures debug information, level verbose
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @usage  Call this procedure to emit debug messages. Normal usage
   *         is to report verbose information that is useful for a detailled
   *         code insight on development and production systems.
   */  
  procedure verbose(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null);
    
    
  /* Captures debug information, level debug
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @usage  Call this procedure to emit debug messages. Normal usage
   *         is to report additional information that is useful in tracing a bug
   *         on development and production systems.
   */
  procedure debug(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null);
    
    
  /* Captures debug information, level info
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @usage  Call this procedure to emit info messages. Normal usage
   *         is to report information that is useful in normal operation
   *         on development and production systems. In contrast to Warn, ERROR
   *         and FATAL, this information will be reported more frequently on
   *         production systems.
   */
  procedure info(
    p_message_name in varchar2,
    p_arg_list msg_args default null,
    p_affected_id in varchar2 default null);
    
    
  /* Captures debug information, level warn
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @usage  Call this procedure to emit warning messages. Normal usage
   *         is to report uncommon behavior of the system which is not
   *         categorized as error, such as warning thresholds reached etc.
   */
  procedure warn(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null);
    
    
  /* Captures debug information, level error
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   * @usage  Call this procedure to emit error messages. Normal usage
   *         is to report errors which have occured but which are not seen
   *         as fatal for the application.
   */
  procedure error(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
    
  /* Captures debug information, level fatal
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   * @usage  Call this procedure to emit fatal error messages. Normal usage
   *         is to report errors which cause the application to abort operation.
   */
  procedure fatal(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    

  /* sql_exception
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   * @param [p_params]       Instance of <code>msg_params</code> with a list of
   *                         key-value pairs representing parameter name and -value.
   * @usage  Call this procedure in EXCEPTION handlers of your code.<br>
   *         <code>sql_exception</code> not only reports the error but handles it as well.
   *         This means that if you pass any error that occurred to this
   *         procedure, the error gets logged and handled.<br>
   *         <code>sql_exception</code> includes a call to <code>leave</code>,
   *         so there is no need to call <code>leave</code> explicitly.
   */
  procedure sql_exception(
    p_message_name in varchar2 default null,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null);
  
  
  /* Exception handler that handles an error and calls leave and re-raises the error
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   * @param [p_params]       Instance of <code>msg_params</code> with a list of
   *                         key-value pairs representing parameter name and -value.
   * @usage  Call this procedure in EXCEPTION handlers of your code.<br>
   *         <code>stop</code> not only reports the error but handles it as well.
   *         This means that if you pass any error that occurred to this
   *         procedure, the error gets logged and handled.<br>
   *         <code>stop</code> includes a call to <code>leave</code>,
   *         so there is no need to call <code>leave</code> explicitly.
   */
  procedure stop(
    p_message_name in varchar2 default null,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null);
  
  
  
  /* Helper function to retrieve the text for a given message and msg_args-list
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * %return Translated and parameterized message text as CLOB
   * @usage  Call this function to get a translated message with replaced
   *         arguments for your usage within the code you write.<br>
   *         This function is a convenience function for you if you need to
   *         compose more complex content for the application that includes
   *         translated messages.
   */
  function get_message_text(
    p_message_name in varchar2,
    p_arg_list in msg_args default null)
    return clob;
    
  
  /* Heklper function to retrieve a message_type instance
   * %param  p_message_name  Name of the Message
   * %param [p_arg_list]     Optional list of message parameters
   * %param [p_affected_id]  Optional reference to an object the message relates to
   * %param [p_error_code]   Optional error code, usable by external applications
   */
  function get_message(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
    return message_type;
    

  /* Function to retrieve a PIT translatable item (PTI)
   * %param  p_pti_pmg_name  Name of the message group the PTI belongs to
   * %param  p_pti_id        ID of the item to retreive translations for
   * %param [p_arg_list]     Optional MSG_ARGS object to adjust NAME or DISPLAY_NAME of the PTI
   * %param [p_pti_pml_name] Oracle language reference
   * %return Varchar2, CLOB or PIT_UTIL.TRANSLATABLE_ITEM_REC, depending on the method
   * %usage  Three distinct methods to get access to name, display_name and description, returning varchar2 or CLOB.
   *         One method to return a record of type PIT.PIT_TRANSLATABLE_ITEM_REC containting all three translated items.
   *         This API is aimed towards PL/SQL code that needs direct access to the
   *         respective items without the need to declare a record variable.
   *         In SQL, view PIT_TRANSLATABLE_ITEM_V should be used to avoid expensive roundtrips between SQL and PL/SQL
   *         If access to more than one item is required, rather call the overloaded method returning a record.
   */
  function get_trans_item_name(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_arg_list msg_args default null,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
    return varchar2;  
    
  function get_trans_item_display_name(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_arg_list msg_args default null,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
    return varchar2;  
    
  function get_trans_item_description(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
    return CLOB;
    
  function get_trans_item(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_arg_list msg_args default null,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
    return pit_util.translatable_item_rec;
  
  
  /* Traces entering a method, level mandatory
   * @param [p_action]      Deprecated. For stability reasons, the method name is auto detected
   * @deprecated            Will be removed in a future version
   * @param [p_module]      Deprecated. For stability reasons, the package name is auto detected
   * @deprecated            Will be removed in a future version
   * @param [p_params]      Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   * @param [p_client_info] Optional value for CLIENT_INFO column of V$SESSION.
   * @usage  Call this procedure to indicate the entrance to a method that
   *         always should be traced (should tracing be switched on).<br>
   *         Normal usage is to call this procedure within the major procedures
   *         for a given use case.
   */
  procedure enter_mandatory(
    p_action in varchar2 default null,
    p_module in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null);
    
    
  /* Traces entering a method, level optional
   * @param [p_action]      Deprecated. For stability reasons, the method name is auto detected
   * @deprecated            Will be removed in a future version
   * @param [p_module]      Deprecated. For stability reasons, the package name is auto detected
   * @deprecated            Will be removed in a future version
   * @param [p_params]      Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   * @param [p_client_info] Optional value for CLIENT_INFO column of V$SESSION.
   *                        This parameter exists in ENTER_MANDATORY only as this method automatically
   *                        sets DBMS_APPLICATION_INFO with the respective values
   * @usage  Call this procedure to indicate the entrance to a method that
   *         optionally should be traced (should tracing be switched on).<br>
   *         Normal usage is to call this procedure within detail procedures
   *         for a given use case.
   */
  procedure enter_optional(
    p_action in varchar2 default null,
    p_module in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null);
    
    
  /* Traces entering a method, level detailed
   * @param [p_action]      Deprecated. For stability reasons, the method name is auto detected
   * @deprecated            Will be removed in a future version
   * @param [p_module]      Deprecated. For stability reasons, the package name is auto detected
   * @deprecated            Will be removed in a future version
   * @param [p_params]      Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   * @param [p_client_info] Optional value for CLIENT_INFO column of V$SESSION.
   *                        This parameter exists in ENTER_MANDATORY only as this method automatically
   *                        sets DBMS_APPLICATION_INFO with the respective values
   * @usage  Call this procedure to indicate the entrance to a method that
   *         should be traced on development only (should tracing be switched on).<br>
   *         Normal usage is to call this procedure within the helper procedures
   *         to allow for detailled performance analysis.
   */
  procedure enter_detailed(
    p_action in varchar2 default null,
    p_module in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null);
    
    
  /* enter
   * @param [p_action]      Deprecated. For stability reasons, the method name is auto detected
   * @deprecated            Will be removed in a future version
   * @param [p_module]      Deprecated. For stability reasons, the package name is auto detected
   * @deprecated            Will be removed in a future version
   * @param [p_params]      Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   * @param [p_trace_level] Optional inidcation of the trace level this method should use.
   *                        It's not recommended to use it, rather use the respective overloads.
   *                        This option is useful if you decide on the level dynamically.
   * @param [p_client_info] Optional value for CLIENT_INFO column of V$SESSION.
   * @usage  Call this procedure if you don't want to distinguish between
   *         trace levels or if you want to pass a trace level as a parameter
   *         from the environmental procedures.
   */
  procedure enter(
    p_action in varchar2 default null,
    p_module in varchar2 default null,
    p_params in msg_params default null,
    p_trace_level in number default pit.trace_all,
    p_client_info in varchar2 default null);
  
  
  /* Traces leaving a method, level mandatory
   * @param [p_params]      Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   * @usage  Call this procedure if you normally leave a method. It's important
   *         to make sure that any possible exit point of a method first calls
   *         this procedure to make sure that the call stack is correctly
   *         maintained.<br>
   *         Also, make sure that the stack level corresponds to the respective
   *         <code>enter_...</code> procedure to avoid call stack confusion if
   *         the trace level is set to a lower level.<br>
   *         No call to this procedure is required in <code>exception</code>-Blocks
   *         if you called <code>sql_exception</code> or <code>stop</code> within
   *         the exception block, as these procedures handle this call.
   */
  procedure leave_mandatory(
    p_params in msg_params default null);
  
  
  /* Traces leaving a method, level optional
   * @param [p_params]      Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   * @usage  Call this procedure if you normally leave a method. It's important
   *         to make sure that any possible exit point of a method first calls
   *         this procedure to make sure that the call stack is correctly
   *         maintained.<br>
   *         Also, make sure that the stack level corresponds to the respective
   *         <code>enter_...</code> procedure to avoid call stack confusion if
   *         the trace level is set to a lower level.<br>
   *         No call to this procedure is required in <code>exception</code>-Blocks
   *         if you called <code>sql_exception</code> or <code>stop</code> within
   *         the exception block, as these procedures handle this call.
   */
  procedure leave_optional(
    p_params in msg_params default null);
  
  
  /* Traces leaving a method, level detailed
   * @param [p_params]      Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   * @usage Call this procedure if you normally leave a method. It's important
   *        to make sure that any possible exit point of a method first calls
   *        this procedure to make sure that the call stack is correctly
   *        maintained.<br>
   *        Also, make sure that the stack level corresponds to the respective
   *        <code>enter_...</code> procedure to avoid call stack confusion if
   *        the trace level is set to a lower level.<br>
   *        No call to this procedure is required in <code>exception</code>-Blocks
   *        if you called <code>sql_exception</code> or <code>stop</code> within
   *        the exception block, as these procedures handle this call.
   */
  procedure leave_detailed(
    p_params in msg_params default null);
  
  
  /* Traces leaving a method, level variable
   * @param  p_trace_level  Optional trace level. References <code>trace_level</code><br>
   *                        defaults to <code>trace_all</code>.
   * @param [p_params]      Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   * @usage  Call this procedure if you normally leave a method. It's important
   *         to make sure that any possible exit point of a method first calls
   *         this procedure to make sure that the call stack is correctly
   *         maintained.<br>
   *         No call to this procedure is required in <code>exception</code>-Blocks
   *         if you called <code>sql_exception</code> or <code>stop</code> within
   *         the exception block, as these procedures handle this call.<br>
   *         Call this procedure if you don't want to distinguish between
   *         trace levels or if you want to pass a trace level as a parameter
   *         from the environmental procedures.
   */
  procedure leave(
    p_trace_level in number default pit.trace_all,
    p_params in msg_params default null);
  
  
  /* Procedure to set dbms_application_info.
   * @param  p_target   Description of the operation. Max length is 32 byte.
   * @param  p_sofar    Percentage of the task completed (0 .. 100 or individual scale)
   * @param [p_total]   Amount of work to be done. Defaults to 100 (percent)
   * @param [p_units]   Unit of work, eg. "rows processed" or similar. Defaults to "iterations done"
   * @param [p_op_name] Optional indication of the task that is performed. If NULL, the package.method name is used.
   *                    Max length is 64 byte.
   * @usage  Use this procedure to pass information about long operations to the
   *         database. If this task is completed, call this procedure with
   *         <code>p_sofar = p_total (or p_sofar = 100)</code> to allow for proper state cleansing.<br>
   *         If you call <code>sql_exception</code> or <code>stop</code>, the
   *         state will be cleaned as well.
   *         This method will work only if tracing is enabled, as it takes op_name from the call stack and persists
   *         the actual index with the call stack.
   */
  procedure long_op(
    p_target in varchar2,
    p_sofar in number,
    p_total in number default 100,
    p_units in varchar2 default null,
    p_op_name in varchar2 default null);
  
  
  /* Procedure to pass a message to the view layer.
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @usage  Call this procedure to emit a message to the output modules.<br>
   *         Normal usage is to call the procedure if you want to display
   *         translated messages on the applications GUI. Therefore, this
   *         procedure needs to be implemented by the output module for your
   *         application environment.
   */
  procedure print (
    p_message_name in varchar2,
    p_arg_list in msg_args default null);


  /* procedure to notify output modules
   * @param  p_message_name   Name of the message. Reference to package MSG
   * @param [p_arg_list]      Optional list of replacement information
   * @param [p_affected_id]   Optional id of an item a message relates to
   * @param  p_log_threshold  Optional log level for the log process. Should the
   *                          severity of the requested message be higher than this level, it
   *                          won't get logged. If null, the message is logged if it's severity
   *                          is higher than the actual log level defined.
   * @param  p_log_modules    Optional list of colon-separated log modules to be
   *                          used for this log. If provided, the log message is broadcasted to 
   *                          this list of modules only. It won't affect the settings of the actual
   *                          log context. If null, the settings of the log context apply
   * @usage  Use this method to notify output modules. This method is supposed to be used for
   *         immediate logging purposes, such as progress messages and the like. If you don't need
   *         this immediate mechanism, log or print may be alternatives.
   */
  procedure notify(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null,
    p_log_threshold in number default null,
    p_log_modules in varchar2 default null);
  
  
  /* Procedure to purge the message log. Overloaded
   * @param  p_date_until              Date to indicate up to when the log should be purged.
   * @param [p_severity_greater_equal] Optional severity level that controls which
   *                                   severity of messages shall be purged. Includes an message with a 
   *                                   severity passed in and greater
   * @usage  Call this procedure to clean up logging information. Only useful if
   *         your output modules support purging of log information, such as
   *         <code>PIT_TABLE</code> output module.
   */
  procedure purge_log(
    p_date_before in date,
    p_severity_greater_equal in number default null);
    
    
  /* Procedure to purge the message log. Overloaded
   * @param  p_days_since              Number of days the logging should be kept.
   * @param [p_severity_greater_equal] Optional severity level that controls which
   *                                   severity of messages shall be purged. Includes an message with a 
   *                                   severity passed in and greater
   * @usage  Call this procedure to clean up logging information. Only useful if
   *         your output modules support purging of log information, such as
   *         <code>PIT_TABLE</code> output module.
   */
  procedure purge_log(
    p_days_before in number,
    p_severity_greater_equal in number default null);
  
  
  /* Procedure to purge session related message log.
   * @param [p_session_id] Optional session_id. If null, the active session is purged.
   * @usage  Call this procedure to clean up logging information. Only useful if
   *         your output modules support purging of log information, such as
   *         <code>PIT_TABLE</code> output module.
   */
  procedure purge_session_log(
    p_session_id in varchar2 default null);
  
  
  /* Assertion function that checks whether p_condition is true
   * @param  p_condition     Boolean expression to check.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   * @usage  Methods for <em>Contract Driven Development</em><br>
   *         Use this procedure to check whether an expression evaluates to true.
   *         If the assertion fails, an error is thrown.<br>
   *         You may choose to throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_TRUE</code>
   *         is used.
   */
  procedure assert(
    p_condition in boolean,
    p_message_name in varchar2 default msg.ASSERT_TRUE,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
  
  
  /* Assertion function that checks whether p_condition is null. Overloaded
   * @param  p_condition     String expression to check.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   * @usage  Methods for <em>Contract Driven Development</em><br>
   *         Use this procedure to check whether an expression evaluates to true.
   *         If the assertion fails, an error is thrown.<br>
   *         You may choose to throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_IS_NULL</code>
   *         is used.
   */
  procedure assert_is_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.ASSERT_IS_NULL,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
    
  /* Assertion function that checks whether p_condition is null. Overloaded
   * @param  p_condition     Number expression to check.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   * @usage  Methods for <em>Contract Driven Development</em><br>
   *         Use this procedure to check whether an expression evaluates to true.
   *         If the assertion fails, an error is thrown.<br>
   *         You may choose to throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_IS_NULL</code>
   *         is used.
   */
  procedure assert_is_null(
    p_condition in number,
    p_message_name in varchar2 default msg.ASSERT_IS_NULL,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
    
  /* Assertion function that checks whether p_condition is null. Overloaded
   * @param  p_condition     Date expression to check.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   * @usage  Methods for <em>Contract Driven Development</em><br>
   *         Use this procedure to check whether an expression evaluates to true.
   *         If the assertion fails, an error is thrown.<br>
   *         You may choose to throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_IS_NULL</code>
   *         is used.
   */
  procedure assert_is_null(
    p_condition in date,
    p_message_name in varchar2 default msg.ASSERT_IS_NULL,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
  
  
  /* Assertion function that checks whether p_condition is not null. Overloaded
   * @param  p_condition     String expression to check.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   * @usage  Methods for <em>Contract Driven Development</em><br>
   *         Use this procedure to check whether an expression evaluates to true.
   *         If the assertion fails, an error is thrown.<br>
   *         You may choose to throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_NOT_NULL</code>
   *         is used.
   */
  procedure assert_not_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.ASSERT_IS_NOT_NULL,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
    
  /* Assertion function that checks whether p_condition is not null. Overloaded
   * @param  p_condition     Number expression to check.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   * @usage  Methods for <em>Contract Driven Development</em><br>
   *         Use this procedure to check whether an expression evaluates to true.
   *         If the assertion fails, an error is thrown.<br>
   *         You may choose to throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_NOT_NULL</code>
   *         is used.
   */
  procedure assert_not_null(
    p_condition in number,
    p_message_name in varchar2 default msg.ASSERT_IS_NOT_NULL,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
    
  /* Assertion function that checks whether p_condition is not null. Overloaded
   * @param  p_condition     Date expression to check.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   * @usage  Methods for <em>Contract Driven Development</em><br>
   *         Use this procedure to check whether an expression evaluates to true.
   *         If the assertion fails, an error is thrown.<br>
   *         You may choose to throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_NOT_NULL</code>
   *         is used.
   */
  procedure assert_not_null(
    p_condition in date,
    p_message_name in varchar2 default msg.ASSERT_IS_NOT_NULL,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
    
  /* Assertion function that checks whether p_stmt returns any values
   * @param  p_stmt          SQL-statement that either returns rows or not.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   * @usage  Pass a select statement that is expected to return a row.
   *         If the statement does return a row, it will silently quit, otherwise
   *         it will throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_EXISTS</code>
   *         is used.
   */
  procedure assert_exists(
    p_stmt in varchar2,
    p_message_name in varchar2 default msg.ASSERT_EXISTS,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
    
  /* Assertion function that checks whether p_stmt returns no values
   * @param  p_stmt          SQL-statement that either returns rows or not.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_arg_list]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   * @usage  Pass a select statement that is expected to return no rows.
   *         If the statement does not return a row, it will silently quit, otherwise
   *         it will throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_NOT_EXISTS</code>
   *         is used.
   */
  procedure assert_not_exists(
    p_stmt in varchar2,
    p_message_name in varchar2 default msg.ASSERT_NOT_EXISTS,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
  
  
  /* Procedure to set the trace context for the active session
   * @param  p_log_level    Requested log level
   * @param  p_trace_level  Requested stack level
   * @param  p_timing_on    Flag to indicate whehter timing information should be
   *                        captured.
   * @param  p_module_list  Colon-separated list of output modules to be used.
   * @usage  Call this procedure to dynamically change the debug settings
   *         to allow for dynamic debugging from within an application.<br>
   *         Normal usage is to specify that the active session only should be
   *         logged and/or traced. Set the options you wish and immediately
   *         these settings apply. To reset logging to the default call
   *         <code>reset_context</code>
   */
  procedure set_context(
    p_log_level in integer,
    p_trace_level in integer,
    p_trace_timing in boolean,
    p_module_list in varchar2);
  
  
  /* Overloaded version to allow to use named contexts
   * @param  p_context_name  Name of the context to swithc to.
   * @usage  Call this procedure to set the active context to a predefined context.
   *         Contexts are defined as parameters with the name pattern
   *         CONTEXT_<Name> and a string value according to this pattern:
   *         [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST],
   *         fi: CONTEXT_FULL = '70|70|Y|PIT_CONSOLE:PIT_FILE'
   */
  procedure set_context(
    p_context_name in varchar2);
    
  
  /* Procedure to reset the trace context for the active session to the default values
   * @param p_active_session_only Flag to indicate whether the active session
   *        should be reset only.
   * @usage Call this procedure to reset trace/debug setting to the default.<br>
   *        If <code>p_active_session_only</code> is true, other settings
   *        remain unchanged. If false, any active context cross session is set back
   *        to default. This option is useful to clean up any unwanted debugging.
   */
  procedure reset_context(
    p_active_session_only in boolean default true);
  
  
  /* Pipelined function to retrieve a list of all installed modules
   * %return PIT_MODULE_LIST-type, List of modules, availabilty and active status
   * @usage  Use this function if you require a list of all installed modules.
   */
  function get_modules
    return pit_module_list
    pipelined;
    
    
  /* Pipelined function to retrieve the list of available output modules
   * @return ARGS-type, name list of the available (successfully instantiated) modules
   * @usage  Helper function to get a list of available ourput modules.<br>
   *         Useful to populate a drop down list of output modules.
   */
  function get_available_modules
    return args 
    pipelined;
    
    
  /* Pipelined function to retrieve the list of active output modules
   * @return ARGS-type, name list of the actually active modules
   * @usage  Helper function to get a list of active ourput modules.<br>
   *         Useful to populate a drop down list of output modules.
   */
  function get_active_modules
    return args 
    pipelined;
    
  
  /* Re-initializes the PIT
   * @usage  Initializes the package. Either called implicitly upon first
   *         instantiation or explicitly upon request.
   */
  procedure initialize;
  
end pit;
/