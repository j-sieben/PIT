create or replace package pit
  authid current_user 
as
  /** Project:      PIT (www.github.com/j-sieben/PIT)
   *  Descriptioon: PIT-API package. Implements all functionality that is required to use PIT.
   *  @headcom
   */
   
  /* PACKAGE VARIABLE GETTER */
  /** Constant level_off
   * @usage  Getter function for debug level OFF
   */
  function level_off return number deterministic;
  /** Constant level_fatal
   * @usage  Getter function for debug level FATAL
   */
  function level_fatal return number deterministic;
  /** Constant level_error
   * @usage  Getter function for debug level ERROR
   */
  function level_error return number deterministic;
  /** Constant level_warn
   * @usage  Getter function for debug level WARN
   */
  function level_warn return number deterministic;
  /** Constant level_info
   * @usage  Getter function for debug level INFO
   */
  function level_info return number deterministic;
  /** Constant level_debug
   * @usage  Getter function for debug level DEBUG
   */
  function level_debug return number deterministic;
  /** Constant level_all
   * @usage  Getter function for debug level ALL
   */
  function level_all return number deterministic;
  
  
  /** Constant trace_off
   * @usage  Getter function for trace level OFF
   */
  function trace_off return number deterministic;
  /** Constant trace_mandatory
   * @usage  Getter function for trace level MANDATORY
   */
  function trace_mandatory return number deterministic;
  /** Constant trace_optional
   * @usage  Getter function for trace level OPTIONAL
   */
  function trace_optional return number deterministic;
  /** Constant trace_detailed
   * @usage  Getter function for trace level DETAILED
   */
  function trace_detailed return number deterministic;
  /** Constant trace_all
   * @usage  Getter function for trace level ALL
   */
  function trace_all return number deterministic;
    
    
  /** Contants TYPE_...
   * @usage  Getter for data type assertion function
   */
  function type_integer return varchar2 deterministic;
  
  function type_number return varchar2 deterministic;
    
  function type_date return varchar2 deterministic;
    
  function type_timestamp return varchar2 deterministic;
  
  function type_xml return varchar2 deterministic;
  
  
  /****************************** LOGGING AND DEBUGGING *********************************/
  /** Captures debug information, level verbose
   * @usage  Call this procedure to emit debug messages. Normal usage
   *         is to report verbose information that is useful for a detailled
   *         code insight on development and production systems.
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   */  
  procedure verbose(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null);
    
    
  /** Captures debug information, level debug
   * @usage  Call this procedure to emit debug messages. Normal usage
   *         is to report additional information that is useful in tracing a bug
   *         on development and production systems.
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   */
  procedure debug(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null);
    
    
  /** Captures debug information, level info
   * @usage  Call this procedure to emit info messages. Normal usage
   *         is to report information that is useful in normal operation
   *         on development and production systems. In contrast to Warn, ERROR
   *         and FATAL, this information will be reported more frequently on
   *         production systems.
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   */
  procedure info(
    p_message_name in varchar2,
    p_msg_args msg_args default null,
    p_affected_id in varchar2 default null);
    
    
  /** Captures debug information, level warn
   * @usage  Call this procedure to emit warning messages. Normal usage
   *         is to report uncommon behavior of the system which is not
   *         categorized as error, such as warning thresholds reached etc.
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   */
  procedure warn(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null);
    
    
  /** Captures debug information, level error
   * @usage  Call this procedure to emit error messages. Normal usage
   *         is to report errors which have occured but which are not seen
   *         as fatal for the application.
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   */
  procedure error(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
    
  /** Captures debug information, level fatal
   * @usage  Call this procedure to emit fatal error messages. Normal usage
   *         is to report errors which cause the application to abort operation.
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   */
  procedure fatal(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
  
  /** Logs a message regardless of the actual log settings.
   * @usage  Call this procedure to emit debug messages regardless of log settings.
   *         Use this method if you want to emit a message anyway or if you decide
   *         to emit a log message or not in code outside PIT.
   *         Optionally, set a list of modules that will become active for this
   *         method only. Modules set her will not remain active after this method.
   *         The context remains unchanged.
   * @param  p_message_name   Name of the message. Reference to package MSG
   * @param [p_msg_args]      Optional list of replacement information
   * @param [p_affected_id]   Optional id of an item a message relates to
   * @param [p_error_code]    Optional error code, usable by external applications
   * @param [p_log_threshold] Optional log level for the log process. Should the
   *                          severity of the requested message be higher than this level, it
   *                          won't get logged. If null, the message is logged if it's severity
   *                          is higher than the actual log level defined.
   * @param [p_log_modules]   Optional list of module names, separated by semicolon
   *                          that is used to log the message. If NULL, the list of
   *                          actually set modules is used.
   */
  procedure log(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null,
    p_log_threshold in number default null,
    p_log_modules in varchar2 default null); 
    
  
  /** Exception handler that handles an error and calls leave
   * @usage  Call this procedure in EXCEPTION handlers of your code.<br>
   *         <code>sql_exception</code> not only reports the error but handles it as well.
   *         This means that if you pass any error that occurred to this
   *         procedure, the error gets logged and handled.<br>
   *         <code>sql_exception</code> includes a call to <code>leave</code>,
   *         so there is no need to call <code>leave</code> explicitly.
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   * @param [p_params]       Instance of <code>msg_params</code> with a list of
   *                         key-value pairs representing parameter name and -value.
   */
  procedure sql_exception(
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null);
  
  
  /** Exception handler that handles an error, calls leave and re-raises the error
   * @usage  Call this procedure in EXCEPTION handlers of your code.<br>
   *         <code>stop</code> not only reports the error but handles it as well.
   *         This means that if you pass any error that occurred to this
   *         procedure, the error gets logged and handled.<br>
   *         <code>stop</code> includes a call to <code>leave</code>,
   *         so there is no need to call <code>leave</code> explicitly.
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   * @param [p_params]       Instance of <code>msg_params</code> with a list of
   *                         key-value pairs representing parameter name and -value.
   * @throws P_MESSAGE_NAME exception to stop further processing
   */
  procedure stop(
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null);
    
  
  /****************************** TRACING *********************************/
  
  /** Traces entering a method, level mandatory
   * @usage  Call this procedure to indicate the entrance to a method that
   *         always should be traced (should tracing be switched on).<br>
   *         Normal usage is to call this procedure within the major procedures
   *         for a given use case.
   * @param [p_action]      Under normal conditions the method name is auto detected.
   *                        It can be provided to enhance logging of inlined methods 
   *                        which don't show their correct line number anymore
   * @param [p_module]      Deprecated. For stability reasons, the package name is auto detected
   * @deprecated            Will be removed in a future version
   * @param [p_params]      Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   * @param [p_client_info] Optional value for CLIENT_INFO column of V$SESSION.
   */
  procedure enter_mandatory(
    p_action in varchar2 default null,
    p_module in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null);
    
    
  /** Traces entering a method, level optional
   * @usage  Call this procedure to indicate the entrance to a method that
   *         optionally should be traced (should tracing be switched on).<br>
   *         Normal usage is to call this procedure within detail procedures
   *         for a given use case.
   * @param [p_action]      Under normal conditions the method name is auto detected.
   *                        It can be provided to enhance logging of inlined methods 
   *                        which don't show their correct line number anymore
   * @param [p_module]      Deprecated. For stability reasons, the package name is auto detected
   * @deprecated            Will be removed in a future version
   * @param [p_params]      Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   * @param [p_client_info] Optional value for CLIENT_INFO column of V$SESSION.
   *                        This parameter exists in ENTER_MANDATORY only as this method automatically
   *                        sets DBMS_APPLICATION_INFO with the respective values
   */
  procedure enter_optional(
    p_action in varchar2 default null,
    p_module in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null);
    
    
  /** Traces entering a method, level detailed
   * @usage  Call this procedure to indicate the entrance to a method that
   *         should be traced on development only (should tracing be switched on).<br>
   *         Normal usage is to call this procedure within the helper procedures
   *         to allow for detailled performance analysis.
   * @param [p_action]      Under normal conditions the method name is auto detected.
   *                        It can be provided to enhance logging of inlined methods 
   *                        which don't show their correct line number anymore
   * @param [p_module]      Deprecated. For stability reasons, the package name is auto detected
   * @deprecated            Will be removed in a future version
   * @param [p_params]      Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   * @param [p_client_info] Optional value for CLIENT_INFO column of V$SESSION.
   *                        This parameter exists in ENTER_MANDATORY only as this method automatically
   *                        sets DBMS_APPLICATION_INFO with the respective values
   */
  procedure enter_detailed(
    p_action in varchar2 default null,
    p_module in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null);
    
    
  /** Traces entering a method
   * @usage  Call this procedure if you don't want to distinguish between
   *         trace levels or if you want to pass a trace level as a parameter
   *         from the environmental procedures.
   * @param [p_action]      Under normal conditions the method name is auto detected.
   *                        It can be provided to enhance logging of inlined methods 
   *                        which don't show their correct line number anymore
   * @param [p_module]      Deprecated. For stability reasons, the package name is auto detected
   * @deprecated            Will be removed in a future version
   * @param [p_params]      Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   * @param [p_trace_level] Optional inidcation of the trace level this method should use.
   *                        It's not recommended to use it, rather use the respective overloads.
   *                        This option is useful if you decide on the level dynamically.
   * @param [p_client_info] Optional value for CLIENT_INFO column of V$SESSION.
   */
  procedure enter(
    p_action in varchar2 default null,
    p_module in varchar2 default null,
    p_params in msg_params default null,
    p_trace_level in number default pit.trace_all,
    p_client_info in varchar2 default null);
  
  
  /** Traces leaving a method, level mandatory
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
   * @param [p_params]      Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   */
  procedure leave_mandatory(
    p_params in msg_params default null);
  
  
  /** Traces leaving a method, level optional
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
   * @param [p_params]      Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   */
  procedure leave_optional(
    p_params in msg_params default null);
  
  
  /** Traces leaving a method, level detailed
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
   * @param [p_params]      Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   */
  procedure leave_detailed(
    p_params in msg_params default null);
  
  
  /** Traces leaving a method, level variable
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
   * @param  p_trace_level  Optional trace level. References <code>trace_level</code><br>
   *                        defaults to <code>trace_all</code>.
   * @param [p_params]      Instance of <code>msg_params</code> with a list of
   *                        key-value pairs representing parameter name and -value.
   */
  procedure leave(
    p_trace_level in number default pit.trace_all,
    p_params in msg_params default null);
  
  
  /** Sets dbms_application_info.
   * @usage  Use this procedure to pass information about long operations to the
   *         database. If this task is completed, call this procedure with
   *         <code>p_sofar = p_total (or p_sofar = 100)</code> to allow for proper state cleansing.<br>
   *         If you call <code>sql_exception</code> or <code>stop</code>, the
   *         state will be cleaned as well.
   *         This method will work only if tracing is enabled, as it takes op_name from the call stack and persists
   *         the actual index with the call stack.
   * @param  p_target   Description of the operation. Max length is 32 byte.
   * @param  p_sofar    Percentage of the task completed (0 .. 100 or individual scale)
   * @param [p_total]   Amount of work to be done. Defaults to 100 (percent)
   * @param [p_units]   Unit of work, eg. "rows processed" or similar. Defaults to "iterations done"
   * @param [p_op_name] Optional indication of the task that is performed. If NULL, the package.method name is used.
   *                    Max length is 64 byte.
   */
  procedure long_op(
    p_target in varchar2,
    p_sofar in number,
    p_total in number default 100,
    p_units in varchar2 default null,
    p_op_name in varchar2 default null);
    
  
  /****************************** NOTIFICATION AND MESSAGES *********************************/
  
  /** Passes a message to the view layer.
   * @usage  Call this procedure to emit a message to the output modules.<br>
   *         Normal usage is to call the procedure if you want to display
   *         translated messages on the applications GUI. Therefore, this
   *         procedure needs to be implemented by the output module for your
   *         application environment.
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   */
  procedure print (
    p_message_name in varchar2,
    p_msg_args in msg_args default null);


  /** Notifies output modules
   * @usage  Use this method to notify output modules. This method is supposed to be used for
   *         immediate logging purposes, such as progress messages and the like. If you don't need
   *         this immediate mechanism, log or print may be alternatives.
   * @param  p_message_name   Name of the message. Reference to package MSG
   * @param [p_msg_args]      Optional list of replacement information
   * @param [p_affected_id]   Optional id of an item a message relates to
   * @param  p_log_threshold  Optional log level for the log process. Should the
   *                          severity of the requested message be higher than this level, it
   *                          won't get logged. If null, the message is logged if it's severity
   *                          is higher than the actual log level defined.
   * @param  p_log_modules    Optional list of colon-separated log modules to be
   *                          used for this log. If provided, the log message is broadcasted to 
   *                          this list of modules only. It won't affect the settings of the actual
   *                          log context. If null, the settings of the log context apply
   */
  procedure notify(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_log_threshold in number default null,
    p_log_modules in varchar2 default null);
  
  
  /** Retrieves the text of a given message and msg_args list
   * @usage  Call this function to get a translated message with replaced
   *         arguments for your usage within the code you write.<br>
   *         This function is a convenience function for you if you need to
   *         compose more complex content for the application that includes
   *         translated messages.
   *         Overloaded version with MSG_ARGS_CHAR to translate stored messages
   * @param  p_message_name  Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * %return Translated and parameterized message text as CLOB
   */
  function get_message_text(
    p_message_name in varchar2,
    p_msg_args in msg_args default null)
    return clob;
    
  function get_message_text(
    p_message_name in varchar2,
    p_msg_args in msg_args_char)
    return clob;
    
  
  /** Instantiates a <code>MESSAGE_TYPE</code> instance
   * %usage  Required to explicitly build an instance of MESSAGE_TYPE without directly using the type's constructor
   * %param  p_message_name  Name of the Message
   * %param [p_msg_args]     Optional list of message parameters
   * %param [p_affected_id]  Optional reference to an object the message relates to
   * %param [p_error_code]   Optional error code, usable by external applications
   * %return Instance of type MESSAGE_TYPE
   */
  function get_message(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
    return message_type;
    
  
  /** Retrieves the actually instantiated message instance
   * %usage  If a message was created, it is sometimes useful to get access to the actually created message,
   *         fi when building some logic on the error_code of the message. This method grants access to this message.
   * %return Instance of type MESSAGE_TYPE that has been instantiated by PIT before
   */
  function get_active_message
    return message_type;
    
    
  /****************************** ASSERTIONS *********************************/
  
  /** Asserts that <code>P_CONDITION</code> is true
   * @usage  Method for <em>Contract Driven Development</em><br>
   *         Use this procedure to check whether an expression evaluates to true.
   *         If the assertion fails, an error is thrown.<br>
   *         You may choose to throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_TRUE</code>
   *         is used.
   * @param  p_condition     Boolean expression to check.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   */
  procedure assert(
    p_condition in boolean,
    p_message_name in varchar2 default msg.ASSERT_TRUE,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
  
  
  /** Asserts that <code>P_CONDITION</code> is null. Overload for text expressions.
   * @usage  Method for <em>Contract Driven Development</em><br>
   *         Use this procedure to check whether an expression evaluates to true.
   *         If the assertion fails, an error is thrown.<br>
   *         You may choose to throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_IS_NULL</code>
   *         is used.
   * @param  p_condition     String expression to check.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   */
  procedure assert_is_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.ASSERT_IS_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
    
  /** Asserts that <code>P_CONDITION</code> is null. Overload for number expressions
   * @usage  Method for <em>Contract Driven Development</em><br>
   *         Use this procedure to check whether an expression evaluates to true.
   *         If the assertion fails, an error is thrown.<br>
   *         You may choose to throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_IS_NULL</code>
   *         is used.
   * @param  p_condition     Number expression to check.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   */
  procedure assert_is_null(
    p_condition in number,
    p_message_name in varchar2 default msg.ASSERT_IS_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
    
  /** Asserts that <code>P_CONDITION</code> is null. Overload for date expressions
   * @usage  Methods for <em>Contract Driven Development</em><br>
   *         Use this procedure to check whether an expression evaluates to true.
   *         If the assertion fails, an error is thrown.<br>
   *         You may choose to throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_IS_NULL</code>
   *         is used.
   * @param  p_condition     Date expression to check.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   */
  procedure assert_is_null(
    p_condition in date,
    p_message_name in varchar2 default msg.ASSERT_IS_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
  
  
  /** Asserts that <code>P_CONDITION</code> is not null. Overload for text expressions
   * @usage  Methods for <em>Contract Driven Development</em><br>
   *         Use this procedure to check whether an expression evaluates to true.
   *         If the assertion fails, an error is thrown.<br>
   *         You may choose to throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_NOT_NULL</code>
   *         is used.
   * @param  p_condition     String expression to check.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   */
  procedure assert_not_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.ASSERT_IS_NOT_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
    
  /** Asserts that <code>P_CONDITION</code> is not null. Overload for number expressions
   * @usage  Methods for <em>Contract Driven Development</em><br>
   *         Use this procedure to check whether an expression evaluates to true.
   *         If the assertion fails, an error is thrown.<br>
   *         You may choose to throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_NOT_NULL</code>
   *         is used.
   * @param  p_condition     Number expression to check.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   */
  procedure assert_not_null(
    p_condition in number,
    p_message_name in varchar2 default msg.ASSERT_IS_NOT_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
    
  /** Asserts that <code>P_CONDITION</code> is not null. Overload for date expression
   * @usage  Methods for <em>Contract Driven Development</em><br>
   *         Use this procedure to check whether an expression evaluates to true.
   *         If the assertion fails, an error is thrown.<br>
   *         You may choose to throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_NOT_NULL</code>
   *         is used.
   * @param  p_condition     Date expression to check.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   */
  procedure assert_not_null(
    p_condition in date,
    p_message_name in varchar2 default msg.ASSERT_IS_NOT_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
    
  /** Asserts that <code>P_STMT</code> returns at least one row. Overload for text statements.
   * @usage  Pass a select statement that is expected to return a row.
   *         If the statement does return a row, it will silently quit, otherwise
   *         it will throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_EXISTS</code>
   *         is used.
   * @param  p_stmt          SQL-statement that either returns rows or not.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   */
  procedure assert_exists(
    p_stmt in varchar2,
    p_message_name in varchar2 default msg.ASSERT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
    
  /** Asserts that <code>P_CURSOR</code> returns at least one row. Overload for cursor expressions.
   * @usage  Pass an opened cursor that is expected to return rows.
   *         If the cursor does return a row, it will silently quit, otherwise
   *         it will throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_EXISTS</code>
   *         is used.
   * @param  p_cursor        opened SYS_REFCURSOR instance that either returns rows or not.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   */
   procedure assert_exists(
     p_cursor in out nocopy sys_refcursor,
     p_message_name in varchar2 default msg.ASSERT_EXISTS,
     p_msg_args msg_args := null,
     p_affected_id in varchar2 default null,
     p_error_code in varchar2 default null);
    
    
  /** Asserts that <code>P_STMT</code> returns no rows. Ovlerload for text statements.
   * @usage  Pass a select statement that is expected to return no rows.
   *         If the statement does not return a row, it will silently quit, otherwise
   *         it will throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_NOT_EXISTS</code>
   *         is used.
   * @param  p_stmt          SQL-statement that either returns rows or not.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   */
  procedure assert_not_exists(
    p_stmt in varchar2,
    p_message_name in varchar2 default msg.ASSERT_NOT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null);
    
    
  /** Asserts that <code>P_CURSOR</code> returns no rows. Ovlerload for cursor expressions.
   * @usage  Pass an opened cursor that is expected to return no rows.
   *         If the cursor does not return a row, it will silently quit, otherwise
   *         it will throw a client specific error message. If this
   *         parameter is not set, a default message <code>msg.ASSERT_NOT_EXISTS</code>
   *         is used.
   * @param  p_cursor        opened SYS_REFCURSOR instance that either returns rows or not.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   */
   procedure assert_not_exists(
     p_cursor in out nocopy sys_refcursor,
     p_message_name in varchar2 default msg.ASSERT_NOT_EXISTS,
     p_msg_args msg_args := null,
     p_affected_id in varchar2 default null,
     p_error_code in varchar2 default null);
    
    
  /** Asserts that <code>P_VALUE</code> is of type <code>P_TYPE</code>. 
   * @usage  Pass a value as string and a datatype as defined at constants <code>TYPE_...</code>
   * @param  p_value         Value to check
   * @param  p_value         Expected data type. One of TYPE_... function values of this package
   * @param [p_format_mask]  Optional format mask to convert P_VALUE. If NULL, session default formats are used.
   * @param [p_message_name] Name of the message. Reference to package MSG
   * @param [p_msg_args]     Optional list of replacement information
   * @param [p_affected_id]  Optional id of an item a message relates to
   * @param [p_error_code]   Optional error code, usable by external applications
   */
   procedure assert_datatype(
     p_value in varchar2,
     p_type in varchar2,
     p_format_mask in varchar2 default null,
     p_message_name in varchar2 default msg.ASSERT_DATATYPE,
     p_msg_args msg_args := null,
     p_affected_id in varchar2 default null,
     p_error_code in varchar2 default null);
  
    
  /****************************** INTERNATIONALIZATION *********************************/
  /** Getter to read the default language PIT is installed at
   * @return Oracle language name of the default language
   */
  function get_default_language
    return varchar2;
    
    
  /** Retrieves a PIT translatable item (PTI) name in the session language.
   * %usage  This API is aimed towards PL/SQL code that needs direct access to the
   *         respective items without the need to declare a record variable.
   *         In SQL, view PIT_TRANSLATABLE_ITEM_V should be used to avoid expensive roundtrips between SQL and PL/SQL
   *         If access to more than one item is required, rather call the overloaded method returning a record.
   * %param  p_pti_pmg_name  Name of the message group the PTI belongs to
   * %param  p_pti_id        ID of the item to retreive translations for
   * %param [p_msg_args]     Optional MSG_ARGS object to adjust NAME or DISPLAY_NAME of the PTI
   * %param [p_pti_pml_name] Oracle language reference
   * %return Translated name of the PTI
   */
  function get_trans_item_name(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_msg_args msg_args default null,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
    return varchar2;  
    
    
  /** Retrieves a PIT translatable item (PTI) display name in the session language.
   * %usage  This API is aimed towards PL/SQL code that needs direct access to the
   *         respective items without the need to declare a record variable.
   *         In SQL, view PIT_TRANSLATABLE_ITEM_V should be used to avoid expensive roundtrips between SQL and PL/SQL
   *         If access to more than one item is required, rather call the overloaded method returning a record.
   * %param  p_pti_pmg_name  Name of the message group the PTI belongs to
   * %param  p_pti_id        ID of the item to retreive translations for
   * %param [p_msg_args]     Optional MSG_ARGS object to adjust NAME or DISPLAY_NAME of the PTI
   * %param [p_pti_pml_name] Oracle language reference
   * %return Translated display name of the PTI
   */
  function get_trans_item_display_name(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_msg_args msg_args default null,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
    return varchar2;  
    
    
  /** Retrieves a PIT translatable item (PTI) description in the session language.
   * %usage  This API is aimed towards PL/SQL code that needs direct access to the
   *         respective items without the need to declare a record variable.
   *         In SQL, view PIT_TRANSLATABLE_ITEM_V should be used to avoid expensive roundtrips between SQL and PL/SQL
   *         If access to more than one item is required, rather call the overloaded method returning a record.
   * %param  p_pti_pmg_name  Name of the message group the PTI belongs to
   * %param  p_pti_id        ID of the item to retreive translations for
   * %param [p_msg_args]     Optional MSG_ARGS object to adjust NAME or DISPLAY_NAME of the PTI
   * %param [p_pti_pml_name] Oracle language reference
   * %return Translated description of the PTI
   */
  function get_trans_item_description(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
    return CLOB;
    
    
  /** Retrieves a PIT translatable item (PTI) record containing name, display name and description in the session language.
   * %usage  This API is aimed towards PL/SQL code that needs direct access to the
   *         respective items without the need to declare a record variable.
   *         In SQL, view PIT_TRANSLATABLE_ITEM_V should be used to avoid expensive roundtrips between SQL and PL/SQL
   *         If access to more than one item is required, rather call the overloaded method returning a record.
   * %param  p_pti_pmg_name  Name of the message group the PTI belongs to
   * %param  p_pti_id        ID of the item to retreive translations for
   * %param [p_msg_args]     Optional MSG_ARGS object to adjust NAME or DISPLAY_NAME of the PTI
   * %param [p_pti_pml_name] Oracle language reference
   * %return Record, containing name, display name and description of the PTI
   */
  function get_trans_item(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_msg_args msg_args default null,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
    return pit_util.translatable_item_rec;
  
  
  /****************************** ADMINISTRATION AND CONTROL *********************************/
  
  /** Purges the message log. Overload to define <code>P_DATE_BEFORE</code> as date.
   * @usage  Call this procedure to clean up logging information. Only useful if
   *         your output modules support purging of log information, such as
   *         <code>PIT_TABLE</code> output module.
   * @param  p_date_until            Date to indicate up to when the log should be purged.
   * @param [p_severity_lower_equal] Optional severity level that controls which
   *                                 severity of messages shall be purged. Includes an message with a 
   *                                 severity passed in and greater
   */
  procedure purge_log(
    p_date_before in date,
    p_severity_lower_equal in number default null);
    
    
  /** Purges the message log. Overload to define <code>P_DATE_SINCE</code> as an amount of days to be kept.
   * @usage  Call this procedure to clean up logging information. Only useful if
   *         your output modules support purging of log information, such as
   *         <code>PIT_TABLE</code> output module.
   * @param  p_days_since            Number of days the logging should be kept.
   * @param [p_severity_lower_equal] Optional severity level that controls which
   *                                 severity of messages shall be purged. Includes an message with a 
   *                                 severity passed in and greater
   */
  procedure purge_log(
    p_days_before in number,
    p_severity_lower_equal in number default null);
  
  
  /** Purges session related message log.
   * @usage  Call this procedure to clean up logging information. Only useful if
   *         your output modules support purging of log information, such as
   *         <code>PIT_TABLE</code> output module.
   *         NOT YET IMPLEMENTED
   * @param [p_session_id] Optional session_id. If null, the active session is purged.
   */
  procedure purge_session_log(
    p_session_id in varchar2 default null);
  
  
  /** Sets the trace context for the active session. Overloaded to directly set the context components.
   * @usage  Call this procedure to dynamically change the debug settings
   *         to allow for dynamic debugging from within an application.<br>
   *         Normal usage is to specify that the active session only should be
   *         logged and/or traced. Set the options you wish and immediately
   *         these settings apply. To reset logging to the default call
   *         <code>reset_context</code>
   * @param  p_log_level    Requested log level
   * @param  p_trace_level  Requested stack level
   * @param  p_timing_on    Flag to indicate whehter timing information should be
   *                        captured.
   * @param  p_log_modules  Colon-separated list of output modules to be used.
   */
  procedure set_context(
    p_log_level in integer,
    p_trace_level in integer,
    p_trace_timing in boolean,
    p_log_modules in varchar2);
  
  
  /** Sets the trace context for the active session. Overloaded to directly set the context by means of a named context.
   * @usage  Call this procedure to set the active context to a predefined context.
   *         Contexts are defined as parameters with the name pattern
   *         CONTEXT_<Name> and a string value according to this pattern:
   *         [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST],
   *         fi: CONTEXT_FULL = '70|70|Y|PIT_CONSOLE:PIT_FILE'
   * @param  p_context_name  Name of the context to swithc to.
   */
  procedure set_context(
    p_context_name in varchar2);
    
  
  /** Resets the trace context for the active session to the default values
   * @usage Call this procedure to reset trace/debug setting to the default.<br>
   *        If <code>p_active_session_only</code> is true, other settings
   *        remain unchanged. If false, any active context cross session is set back
   *        to default. This option is useful to clean up any unwanted debugging.
   * @param p_active_session_only Flag to indicate whether the active session
   *        should be reset only.
   */
  procedure reset_context(
    p_active_session_only in boolean default true);
    
  
  /** Switches PIT collection mode on
   * %usage  Is used to set PIT to collect mode, where all messages are collected rather than thrown or processed immediate.
   *         This mode allows for validation methods to perfrom all internal validations prior to raising validation errors.
   */
  procedure start_message_collection;
  
  
  /** Switches PIT collection mode off
   * %usage  If called, the list of raised messages is examined.
   *         If at least one message of secverity C_LEVEL_FATAL is present, exception PIT_BULK_FATAL is raised. 
   *         If at least one message of secverity C_LEVEL_ERROR is present, exception PIT_BULK_ERROR is raised. 
   *         While processing these errors, use GET_COLLECTED_MESSAGES to retrieve a list of all collected messages
   */
  procedure stop_message_collection;
  
  
  /** Retrieves the collection of messages raised since setting PIT to collect mode
   * %usage  Is used to retrieve a list of all messages raised during the collect cycle. It implicitly terminates collection
   *         mode by calling <code>SET_COLLECT_MODE(FALSE)</code> if PIT is still in collection mode.
   *         Normal usage is terminating collection mode explicity and deal with the list of messages in the exception block.
   * %return Instance of <code>PIT_MESSAGE_TABLE</code>, a list of message instances
   */
  function get_message_collection
    return pit_message_table;
  
  
  /** Pipelined function to retrieve a list of all installed modules
   * @usage  Use this function if you require a list of all installed modules.
   * %return PIT_MODULE_LIST-type, List of modules, availabilty and active status
   */
  function get_modules
    return pit_module_list
    pipelined;
    
    
  /** Pipelined function to retrieve the list of available output modules
   * @usage  Helper function to get a list of available ourput modules.<br>
   *         Useful to populate a drop down list of output modules.
   * @return ARGS-type, name list of the available (successfully instantiated) modules
   */
  function get_available_modules
    return args 
    pipelined;
    
    
  /** Pipelined function to retrieve the list of active output modules
   * @usage  Helper function to get a list of active ourput modules.<br>
   *         Useful to populate a drop down list of output modules.
   * @return ARGS-type, name list of the actually active modules
   */
  function get_active_modules
    return args 
    pipelined;
    
  
  /** Re-initializes PIT
   * @usage  Initializes the package. Either called implicitly upon first
   *         instantiation or explicitly upon request. Calling this method is sometimes useful
   *         after changing PIT parameters or to clean up the call stack if the level indication ran out of sync.
   */
  procedure initialize;
  
end pit;
/