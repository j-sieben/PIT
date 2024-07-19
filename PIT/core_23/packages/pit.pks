create or replace package pit
  authid current_user
as

  /**
    Package: PIT
      PIT-API package. Declares the API that is required to use PIT.

    Author::
      Juergen Sieben, ConDeS GmbH

      Published under MIT licence
   */

  /**
    Group: Public Constants
   */
  /**
    Constants: Trace and log level constants
      Constants are implemented as functions to allow for accesss from SQL.

      LEVEL_FATAL - Log severity of fatal errors
      LEVEL_SEVERE - Log severity of severe errors
      LEVEL_ERROR - Log severity of "normal" errors
      LEVEL_WARN - Log severity for warn messages
      LEVEL_INFO - Log severity for informational messages
      LEVEL_DEBUG - Log severity for debugging messages
      LEVEL_ALL - Log level for verbose messages
      TRACE_OFF - Trace level to switch tracing off
      TRACE_MANDATORY - Trace level for important procedure calls
      TRACE_OPTIONAL - Trace level for package internal procedure calls

   */
  function level_fatal return binary_integer deterministic;
  function level_severe return binary_integer deterministic;
  function level_error return binary_integer deterministic;
  function level_warn return binary_integer deterministic;
  function level_info return binary_integer deterministic;
  function level_debug return binary_integer deterministic;
  function level_all return binary_integer deterministic;

  function trace_off return binary_integer deterministic;
  function trace_mandatory return binary_integer deterministic;
  function trace_optional return binary_integer deterministic;
  function trace_detailed return binary_integer deterministic;
  function trace_all return binary_integer deterministic;

  /**
    Constants: Formatting constants
      Constants are partly implemented as functions to allow for accesss from SQL.

      FORMAT_ICO - Parameter value to indicate that a message has to be formatted using ICU functionality
      TRACE_DETAILED - Trace level for package internal helper procedures
      TYPE_INTEGER - Constant for type checks
      TYPE_NUMBER - Constant for type checks
      TYPE_DATE - Constant for type checks
      TYPE_TIMESTAMP - Constant for type checks
      TYPE_XML - Constant for type checks
  */
  format_icu constant pit_util.ora_name_type := 'FORMAT_ICU';

  function type_integer return varchar2 deterministic;
  function type_number return varchar2 deterministic;
  function type_date return varchar2 deterministic;
  function type_timestamp return varchar2 deterministic;
  function type_xml return varchar2 deterministic;


  /**
    Group: Logging and Debugging methods
   */
  /**
    Function: get_active_context
      Method returns an instance of <PIT_CONTEXT_TYPE> that is actually in use.

    Returns:
      Context object that is actually active.
   */
  function get_active_context
    return pit_context_type;


  /**
    Function: get_log_level
      Method returns the actually set log level.

    Returns:
      Log level that is actually active.
   */
  function get_log_level
    return binary_integer;


  /**
    Function: check_log_level_greater_equal
      Method checks whether the actually valid log level is greater or equal to P_LOG_LEVEL

      Allows external code to check whether PIT is in a given log level. This is useful
      to run logic only if it would be logged anyway.

    Parameter:
      p_log_level - Severity to check, one of the constants <LEVEL_OFF> .. <LEVEL_ALL>

    Returns:
      TRUE, if the acutally valid log level is greater or equal to P_LOG_LEVEL, FALSE otherwise
   */
  function check_log_level_greater_equal(
    p_log_level in binary_integer)
    return boolean;


  /**
    Function: get_trace_level
      Method returns the actually set trace level.

    Returns:
      Trace level that is actually active.
   */
  function get_trace_level
    return binary_integer;


  /**
    Function check_trace_level_greater_equal
      Method checks whether the actually valid trace level is greater or equal to P_TRACE_LEVEL

      Allows external code to check whether PIT is in a given trace level. This is useful
      to run logic only if it would be traced anyway.

    Parameter:
      p_severity - Severity to check, one of the constants <TRACE_OFF> .. <TRACE_ALL>

    Returns:
      TRUE, if the acutally valid log level is greater or equal to <p_trace_level>, FALSE otherwise
   */
  function check_trace_level_greater_equal(
    p_trace_level in binary_integer)
    return boolean;


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
    Procedure: verbose
      Captures debug information, level <level_verbose>

      Call this procedure to emit debug messages. Normal usage
      is to report verbose information that is useful for a detailled
      code insight on development and production systems.

    Parametes:
      p_message_name - Name of the message. Reference to package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
   */
  procedure verbose(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null);


  /**
    Procedure: debug
      Captures debug information, level <level_debug>

      Call this procedure to emit debug messages. Normal usage
      is to report debug information that is useful for a detailled
      code insight on development and production systems.

    Parametes:
      p_message_name - Name of the message. Reference to package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
   */
  procedure debug(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null);


  /**
    Procedure: info
      Captures debug information, level <level_info>

      Call this procedure to emit info messages. Normal usage
      is to report information that is useful in normal operation
      on development and production systems. In contrast to Warn, ERROR
      and FATAL, this information will be reported less frequently on
      production systems.

    Parametes:
      p_message_name - Name of the message. Reference to package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
   */
  procedure info(
    p_message_name in varchar2,
    p_msg_args msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null);


  /**
    Procedure: warn
      Captures debug information, level <level_warn>

      Call this procedure to emit warning messages. Normal usage
      is to report uncommon behavior of the system which is not
      categorized as error, such as warning thresholds reached etc.

    Parametes:
      p_message_name - Name of the message. Reference to package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
   */
  procedure warn(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null);


  /**
    Procedure: error
      Captures debug information, level <level_error>

      Call this procedure to emit error messages. Normal usage
      is to report errors which have occured but which are not seen
      as fatal for the application.

    Parametes:
      p_message_name - Name of the message. Reference to package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code -  Optional error code, usable by external applications
   */
  procedure error(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null);


  /**
    Procedure: fatal
      Captures debug information, level <level_fatal>

      Call this procedure to emit fatal error messages. Normal usage
      is to report errors which cause the application to abort operation.

    Parametes:
      p_message_name - Name of the message. Reference to package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code -  Optional error code, usable by external applications
   */
  procedure fatal(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null);


  /**
    Procedure: log
      Logs a message regardless of the actual log settings.

      Call this procedure to emit debug messages regardless of log settings.
      Use this method if you want to emit a message anyway or if you decide
      to emit a log message or not in code outside PIT.

      Optionally, set a list of modules that will become active for this
      method only. Modules set her will not remain active after this method.
      The context remains unchanged.

    Parameters:
      p_message_name - Name of the message. Reference to package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Optional error code, usable by external applications
      p_log_threshold - Optional log level for the log process. Should the
                        severity of the requested message be higher than this level, it
                        won't get logged. If null, the message is logged if it's severity
                        is higher than the actual log level defined.
      p_log_modules - Optional list of module names, separated by semicolon
                      that is used to log the message. If NULL, the list of
                      actually set modules is used.
   */
  procedure log(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_log_threshold in number default null,
    p_log_modules in varchar2 default null);


  /**
    Procedure: log_state
      Log method to log the state of variables without relation to methods <ENTER> or <LEAVE>

      This method is useful if you want to log the state of several variables within a method.
      This way, you can report the status of variables without the requirement to create
      distinct messages for those. This adds flexibility and reduces administrative workload.

    Parameters:
      p_params - Instance of <MSG_PARAMS>, containing the variable names and values to log
      p_severity - Log level of the state message. Values get logged only if the actual
                   log settings are lower (mor severe) or equal to P_SEVERITY.
                   If NULL, parameter LOG_STATE_THRESHOLD controls whether the params get logged or not
   */
  procedure log_state(
    p_params msg_params,
    p_severity in binary_integer default null);


  /**
    Procedure: sql_exception
      Exception handler that handles an error and calls leave

      Call this procedure in EXCEPTION handlers of your code.
      <csql_exception> not only reports the error but handles it as well.
      This means that if you pass any error that occurred to this
      procedure, the error gets logged and handled.

      <sql_exception> includes a call to <leave>, so there is no need to call <leave> explicitly.
    Parameters:
      p_message_name - Name of the message. Reference to package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Optional error code, usable by external applications
      p_params - Instance of <msg_params> with a list of key-value pairs representing parameter name and -value.

    Deprecated:: Use pit.handle_exception instead
   */
  procedure sql_exception(
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null);


  /**
    Procedure: handle_exception
      Exception handler that handles an error and calls leave

      Call this procedure in EXCEPTION handlers of your code.
      <csql_exception> not only reports the error but handles it as well.
      This means that if you pass any error that occurred to this
      procedure, the error gets logged and handled.

      <handle_exception> includes a call to <leave>, so there is no need to call <leave> explicitly.
    Parameters:
      p_message_name - Name of the message. Reference to package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Optional error code, usable by external applications
      p_params - Instance of <msg_params> with a list of key-value pairs representing parameter name and -value.
   */
  procedure handle_exception(
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null);


  /**
    Procedure: stop
      Exception handler that handles an error, calls leave and re-raises the error

      Call this procedure in EXCEPTION handlers of your code.

      <stop> not only reports the error but handles it as well. This means that if you pass
      any error that occurred to this procedure, the error gets logged and handled.

      <stop> includes a call to <leave>, so there is no need to call <leave> explicitly.

    Parameters:
      p_message_name - Name of the message. Reference to package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Optional error code, usable by external applications
      p_params - Instance of <msg_params> with a list of key-value pairs representing parameter name and -value.

    Errors:
      <P_MESSAGE_NAME> - exception to stop further processing. If no message name is passed in,
                         the last raised message is used
   */
  procedure stop(
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null);


  /**
    Procedure: raise_exception
      Exception handler that handles an error, calls leave and re-raises the error. It is a synonym for <stop>
   */
  procedure reraise_exception(
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null);


  /**
    Group: Tracing methods
   */

  /**
    Procedure: enter_mandatory
      Traces entering a method, level <trace_mandatory>

      Call this procedure to indicate the entrance to a method that
      always should be traced (should tracing be switched on).<

      Normal usage is to call this procedure within the major procedures for a given use case.

    Parameters:
      p_action - Optional. Under normal conditions the method name is auto detected.
                 It can be provided to enhance logging of inlined methods
                 which don't show their correct line number anymore (due to code inlining)
      p_params - Optional instance of <msg_params> with a list of key-value pairs representing parameter name and -value.
      p_client_info - Optional value for CLIENT_INFO column of V$SESSION.
   */
  procedure enter_mandatory(
    p_action in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null);


  /**
    Procedure: enter_optional
      Traces entering a method, level <trace_optional>

      Call this procedure to indicate the entrance to a method that
      optionally should be traced (should tracing be switched on).

      Normal usage is to call this procedure within detail procedures for a given use case.

    Parameters:
      p_action - Optional. Under normal conditions the method name is auto detected.
                 It can be provided to enhance logging of inlined methods
                 which don't show their correct line number anymore (due to code inlining)
      p_params - Optional instance of <msg_params> with a list of key-value pairs representing parameter name and -value.
      p_client_info - Optional value for CLIENT_INFO column of V$SESSION.
   */
  procedure enter_optional(
    p_action in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null);


  /**
    Procedure: enter_detailed
      Traces entering a method, level <trace_detailed>

      Call this procedure to indicate the entrance to a method that
      should be traced on development only (should tracing be switched on).

      Normal usage is to call this procedure within the helper procedures
      to allow for detailled performance analysis.

    Parameters:
      p_action - Optional. Under normal conditions the method name is auto detected.
                 It can be provided to enhance logging of inlined methods
                 which don't show their correct line number anymore (due to code inlining)
      p_params - Optional instance of <msg_params> with a list of key-value pairs representing parameter name and -value.
      p_client_info - Optional value for CLIENT_INFO column of V$SESSION.
   */
  procedure enter_detailed(
    p_action in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null);


  /**
    Procedure: enter
      Traces entering a method, level <trace_all> or <p_trace_level>

      Call this procedure if you don't want to distinguish between
      trace levels or if you want to pass a trace level as a parameter
      from the environmental procedures.

    Parameters:
      p_action - Optional. Under normal conditions the method name is auto detected.
                 It can be provided to enhance logging of inlined methods
                 which don't show their correct line number anymore (due to code inlining)
      p_params - Optional instance of <msg_params> with a list of key-value pairs representing parameter name and -value.
      p_trace_level - Optional inidcation of the trace level this method should use.
                      It's not recommended to use it, rather use the respective overloads.
                      This option is useful if you decide on the level dynamically.
      p_client_info - Optional value for CLIENT_INFO column of V$SESSION.
   */
  procedure enter(
    p_action in varchar2 default null,
    p_params in msg_params default null,
    p_trace_level in number default pit.trace_all,
    p_client_info in varchar2 default null);


  /**
    Procedure: leave_mandatory
      Traces leaving a method, level <trace_mandatory>

      Call this procedure if you leave a method.

      No call to this procedure is required in exception< blocks
      if you called <handle_exception> or <stop>/<reraise_exception> within
      the exception block, as these procedures handle this call.

    Attention::
      It's important to make sure that any possible exit point of a method first calls
      this procedure to make sure that the call stack is correctlymaintained.

      Also, make sure that the stack level corresponds to the respective
      enter method to avoid call stack confusion if the trace level is set to a lower level.

    Parameter:
      p_params - Instance of <msg_params> with a list of key-value pairs representing parameter name and -value.
   */
  procedure leave_mandatory(
    p_params in msg_params default null);


  /**
    Procedure: leave_optional
      Traces leaving a method, level <trace_optional>

      Call this procedure if you leave a method.

      No call to this procedure is required in exception< blocks
      if you called <handle_exception> or <stop>/<reraise_exception> within
      the exception block, as these procedures handle this call.

    Attention::
      It's important to make sure that any possible exit point of a method first calls
      this procedure to make sure that the call stack is correctlymaintained.

      Also, make sure that the stack level corresponds to the respective
      enter method to avoid call stack confusion if the trace level is set to a lower level.

    Parameter:
      p_params - Instance of <msg_params> with a list of key-value pairs representing parameter name and -value.
   */
  procedure leave_optional(
    p_params in msg_params default null);


  /**
    Procedure: leave_detailed
      Traces leaving a method, level <trace_detailed>

      Call this procedure if you leave a method.

      No call to this procedure is required in exception< blocks
      if you called <handle_exception> or <stop>/<reraise_exception> within
      the exception block, as these procedures handle this call.

    Attention::
      It's important to make sure that any possible exit point of a method first calls
      this procedure to make sure that the call stack is correctlymaintained.

      Also, make sure that the stack level corresponds to the respective
      enter method to avoid call stack confusion if the trace level is set to a lower level.

    Parameter:
      p_params - Instance of <msg_params> with a list of key-value pairs representing parameter name and -value.
   */
  procedure leave_detailed(
    p_params in msg_params default null);


  /**
    Procedure: leave
      Traces leaving a method, level <trace_all> o <p_trace_level>

      Call this procedure if you leave a method.

      No call to this procedure is required in exception< blocks
      if you called <handle_exception> or <stop>/<reraise_exception> within
      the exception block, as these procedures handle this call.

    Attention::
      It's important to make sure that any possible exit point of a method first calls
      this procedure to make sure that the call stack is correctlymaintained.

      Also, make sure that the stack level corresponds to the respective
      enter method to avoid call stack confusion if the trace level is set to a lower level.

    Parameter:
      p_trace_level - Optional trace level. Defaults to <trace_all>.
      p_params - Instance of <msg_params> with a list of key-value pairs representing parameter name and -value.
   */
  procedure leave(
    p_trace_level in number default pit.trace_all,
    p_params in msg_params default null);


  /**
    Procedure: long_op
      Sets dbms_application_info.

      Use this procedure to pass information about long operations to the database.
      If this task is completed, call this procedure with

      > p_sofar = p_total (or p_sofar = 100)

      to allow for proper state cleansing.

      If you call <handle_exception> or <stop>, the state will be cleaned as well.

      This method will work only if tracing is enabled, as it takes the method name
      from the call stack and persists the actual index with the call stack.

      If you plan to call it in a loop you may only pass in the required parameters, all
      other values are taken from the first call.

    Parameters:
      p_sofar - Percentage of the task completed (0 .. 100 or individual scale)
      p_total - Amount of work to be done. Defaults to 100 (percent)
      p_target - Description of the operation. Max length is 32 byte.
      p_units - Unit of work, eg. "rows processed" or similar. Defaults to "iterations done"
      p_op_name - Optional indication of the task that is performed. If NULL, the package.method name is used.
                  Max length is 64 byte.
   */
  procedure long_op(
    p_sofar in number,
    p_total in number default 100,
    p_target in varchar2 default null,
    p_units in varchar2 default null,
    p_op_name in varchar2 default null);


  /**
    Group: Notification and message methods
   */
  /**
    Procedure: print
      Passes a message to the view layer.

      Call this procedure to emit a message to the output modules.

      Normal usage is to call the procedure if you want to display translated messages
      on the applications GUI. Therefore, this procedure needs to be implemented
      by the output module for your application environment.

    Parameters:
      p_message_name - Name of the message. Reference to package MSG
      p_msg_args - Optional list of replacement information
   */
  procedure print (
    p_message_name in varchar2,
    p_msg_args in msg_args default null);


  /**
    Procedure: notify
      Notifies output modules

      Use this method to notify output modules. This method is supposed to be used for
      immediate logging purposes, such as progress messages and the like. If you don't need
      this immediate mechanism, <log> or <print> may be alternatives.

    Parameters:
      p_message_name - Name of the message. Reference to package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
      p_log_threshold - Optional log level for the log process. Should the
                        severity of the requested message be higher than this level, it
                        won't get logged. If null, the message is logged if it's severity
                        is higher than the actual log level defined.
      p_log_modules - Optional list of colon-separated log modules to be
                      used for this log. If provided, the log message is broadcasted to
                      this list of modules only. It won't affect the settings of the actual
                      log context. If null, the settings of the log context apply
   */
  procedure notify(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_log_threshold in number default null,
    p_log_modules in varchar2 default null);


  /**
    Function: get_message_text
      Retrieves the text of a given message and msg_args list.

      Call this function to get a translated message with replaced
      arguments for your usage within the code you write.

      This function is a convenience function for you if you need to
      compose more complex content for the application that includes translated messages.

      Overloaded version with <MSG_ARGS_CHAR> to translate stored messages

    Parameters:
      p_message_name  Name of the message. Reference to package <MSG>
      p_msg_args - Optional list of replacement information

    Returns:
      Translated and parameterized message text as CLOB
   */
  function get_message_text(
    p_message_name in varchar2,
    p_msg_args in msg_args default null)
    return clob;

  /**
    Function: get_message_text

      Overloaded version with <MSG_ARGS_CHAR> parameter to translate stored messages.
      (It is not allowed to store a nested table with a collection of CLOB yet).

    Parameters:
      p_message_name  Name of the message. Reference to package <MSG>
      p_msg_args - Optional list of replacement information

    Returns:
      Translated and parameterized message text as CLOB
   */
  function get_message_text(
    p_message_name in varchar2,
    p_msg_args in msg_args_char)
    return clob;


  /**
    Function: get_message
      Instantiates a <MESSAGE_TYPE> instance.

      Required to explicitly build an instance of <MESSAGE_TYPE> without directly using the type's constructor.

    Parameters:
      p_message_name - Name of the Message
      p_msg_args - Optional list of message parameters
      p_affected_id - Optional reference to an object the message relates to
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Optional error code, usable by external applications

    Returns:
      Instance of type <MESSAGE_TYPE>
   */
  function get_message(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null)
    return message_type;


  /**
    Function: get_active_message
      Retrieves the actually instantiated message instance.

      If a message was created, it is sometimes useful to get access to the actually created message,
      fi when building some logic on the error_code of the message. This method grants access to this message.

    Returns:
      Instance of type <MESSAGE_TYPE> that has been instantiated by PIT before
   */
  function get_active_message
    return message_type;


  /**
    Function: get_active_message_text
      Retrieves the message text of the actually instantiated message instance.

      If a message was created, it is sometimes useful to get access to the actually created message,
      fi when building some logic on the error_code of the message. This method grants access to this message.

    Returns:
      Message text that has been instantiated by PIT before
   */
  function get_active_message_text
    return clob;


  /**
    Group: Assertion methods
   */
  /**
    Procedure: assert
      Asserts that <P_CONDITION> is true.

      Use this procedure to check whether an expression evaluates to true.

      If the assertion fails, an error is thrown. You may choose to throw a client
      specific error message. If this parameter is not set, a default message <msg.PIT_ASSERT_TRUE> is used.

    Parameters:
      p_condition  - Boolean expression to check.
      p_message_name - Optional name of the message. Defaults to <msg.PIT_ASSERT_TRUE>. References package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Optional error code, usable by external applications and to distinguish
                     several occurences of the same message.
      p_severity - Optional severity, overrides the message severity. If NULL,
                   the message severity takes precedence, if (and only if) its
                   severity is more severe than <pit.LEVEL_ERROR>.
   */
  procedure assert(
    p_condition in boolean,
    p_message_name in varchar2 default msg.PIT_ASSERT_TRUE,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);


  /**
    Procedure: assert_is_null
      Asserts that <P_CONDITION> is null. Overload for VARCHAR2 expressions.

      Use this procedure to check whether an expression is NULL.

      If the assertion fails, an error is thrown. You may choose to throw a client
      specific error message. If this parameter is not set, a default message <msg.PIT_ASSERT_IS_NULL>
      is used.

    Parameters:
      p_condition  - Boolean expression to check.
      p_message_name - Optional name of the message. Defaults to <msg.PIT_ASSERT_IS_NULL>. References package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Optional error code, usable by external applications and to distinguish
                     several occurences of the same message.
      p_severity - Optional severity, overrides the message severity. If NULL,
                   the message severity takes precedence, if (and only if) its
                   severity is more severe than <pit.LEVEL_ERROR>.
   */
  procedure assert_is_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);


  /**
    Procedure: assert_is_null
      Asserts that <P_CONDITION> is null. Overload for NUMBER expressions.
   */
  procedure assert_is_null(
    p_condition in number,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);


  /**
    Procedure: assert_is_null
      Asserts that <P_CONDITION> is null. Overload for DATE expressions.
   */
  procedure assert_is_null(
    p_condition in date,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);


  /**
    Procedure: assert_is_null
      Asserts that <P_CONDITION> is not null. Overload for VARCHAR2 expressions.

      Use this procedure to check whether an expression is not NULL.

      If the assertion fails, an error is thrown. You may choose to throw a client
      specific error message. If this parameter is not set, a default message <msg.PIT_ASSERT_IS_NOT_NULL>
      is used.

    Parameters:
      p_condition  - Boolean expression to check.
      p_message_name - Optional name of the message. Defaults to <msg.PIT_ASSERT_IS_NOT_NULL>. References package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Optional error code, usable by external applications and to distinguish
                     several occurences of the same message.
      p_severity - Optional severity, overrides the message severity. If NULL,
                   the message severity takes precedence, if (and only if) its
                   severity is more severe than <pit.LEVEL_ERROR>.
   */
  procedure assert_not_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NOT_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);


  /**
    Procedure: assert_is_null
      Asserts that <P_CONDITION> is not null. Overload for NUMBER expressions.
   */
  procedure assert_not_null(
    p_condition in number,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NOT_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);


  /**
    Procedure: assert_is_null
      Asserts that <P_CONDITION> is not null. Overload for DATE expressions.
   */
  procedure assert_not_null(
    p_condition in date,
    p_message_name in varchar2 default msg.PIT_ASSERT_IS_NOT_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);


  /**
    Procedure: assert_exists
      Asserts that <P_STMT> returns at least one row. Overload for text statements.

      Pass a select statement that is expected to return a row.
      If the statement does return a row, it will silently quit, otherwise
      it will throw a client specific error message. If this
      parameter is not set, a default message <msg.PIT_ASSERT_EXISTS>
      is used.

    Parameters:
      p_stmt - SQL-statement that either returns rows or not.
      p_message_name - Optional name of the message. Defaults to <msg.PIT_ASSERT_EXISTS>. References package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Optional error code, usable by external applications and to distinguish
                     several occurences of the same message.
      p_severity - Optional severity, overrides the message severity. If NULL,
                   the message severity takes precedence, if (and only if) its
                   severity is more severe than <pit.LEVEL_ERROR>.
   */
  procedure assert_exists(
    p_stmt in varchar2,
    p_message_name in varchar2 default msg.PIT_ASSERT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);


  /**
    Procedure: assert_exists
      Asserts that <P_CURSOR> returns at least one row. Overload for SYS_REFCURSOR.
   */
  procedure assert_exists(
    p_cursor in out nocopy sys_refcursor,
    p_message_name in varchar2 default msg.PIT_ASSERT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);


  /**
    Procedure: assert_not_exists
      Asserts that <P_STMT> does not return a row. Overload for text statements.

      Pass a select statement that is expected to return no row.
      If the statement does return no row, it will silently quit, otherwise it will throw
      a client specific error message. If this parameter is not set, a default message <msg.PIT_ASSERT_NOT_EXISTS>
      is used.

    Parameters:
      p_stmt - SQL-statement that either returns rows or not.
      p_message_name - Optional name of the message. Defaults to <msg.PIT_ASSERT_NOT_EXISTS>. References package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Optional error code, usable by external applications and to distinguish
                     several occurences of the same message.
      p_severity - Optional severity, overrides the message severity. If NULL,
                   the message severity takes precedence, if (and only if) its
                   severity is more severe than <pit.LEVEL_ERROR>.
   */
  procedure assert_not_exists(
    p_stmt in varchar2,
    p_message_name in varchar2 default msg.PIT_ASSERT_NOT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);


  /**
    Procedure: assert_not_exists
      Asserts that <P_CURSOR> does not return a row. Overload for SYS_REFCURSOR.
   */
  procedure assert_not_exists(
    p_cursor in out nocopy sys_refcursor,
    p_message_name in varchar2 default msg.PIT_ASSERT_NOT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_affected_ids in msg_params default null,
    p_error_code in varchar2 default null,
    p_severity in binary_integer default null);


  /**
    Procedure: assert_datatype
      Asserts that <P_VALUE> can be casted to type <P_TYPE>.

      Pass a value as string and a datatype as defined at constants <TYPE_...>

    Parameters:
      p_value - Value to check
      p_value - Expected data type. One of <TYPE_...> function values of this package.
      p_format_mask - Optional format mask to convert <P_VALUE>. If NULL, session default formats are used.
      p_message_name - Name of the message. Reference to package <MSG>
      p_msg_args - Optional list of replacement information
      p_affected_id - Optional id of an item a message relates to
      p_affected_ids - Optional list of parameters a message relates to
      p_error_code - Optional error code, usable by external applications and to distinguish
                     several occurences of the same message.
      p_accept_null - Optional flag to indicate whether a value must be present. Defaults to TRUE, allowing NULL values.
                      If set to FALSE, <P_VALUE> must contain a valueFALSE.
      p_severity - Optional severity, overrides the message severity. If NULL,
                   the message severity takes precedence, if (and only if) its
                   severity is more severe than <pit.LEVEL_ERROR>.
   */
   procedure assert_datatype(
     p_value in varchar2,
     p_type in varchar2,
     p_format_mask in varchar2 default null,
     p_message_name in varchar2 default msg.PIT_ASSERT_DATATYPE,
     p_msg_args msg_args := null,
     p_affected_id in varchar2 default null,
     p_affected_ids in msg_params default null,
     p_error_code in varchar2 default null,
     p_accept_null in boolean default true,
     p_severity in binary_integer default null);


  /**
    Group: I18N methods
   */
  /**
    Function: get_default_language
      Getter to read the default language PIT is installed at

      Returns:
        Oracle language name of the default language
   */
  function get_default_language
    return varchar2;


  /**
    Function: get_trans_item_name
      Retrieves a PIT translatable item (PTI) name in the session language.

      This API is aimed towards PL/SQL code that needs direct access to the respective items without
      the need to declare a record variable. In SQL, view <PIT_TRANSLATABLE_ITEM_V> should be used
      to avoid expensive roundtrips between SQL and PL/SQL.

      If access to more than one item is required, rather call the overloaded method returning a record.

    Parameters:
      p_pti_pmg_name - Name of the message group the PTI belongs to
      p_pti_id - ID of the item to retreive translations for
      p_msg_args - Optional <MSG_ARGS> object to replace anchors in the NAME property of the PTI
      p_pti_pml_name - Oracle language reference

    Returns:
      Translated name of the PTI
   */
  function get_trans_item_name(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_msg_args msg_args default null,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
    return varchar2;


  /**
    Function: get_trans_item_display_name
      Retrieves a PIT translatable item (PTI) display name in the session language.

      This API is aimed towards PL/SQL code that needs direct access to the respective items without
      the need to declare a record variable. If access to more than one item is required, rather call
      the overloaded method returning a record.

    Attention::
      In SQL, view <PIT_TRANSLATABLE_ITEM_V> should be used to avoid expensive roundtrips between SQL and PL/SQL.

    Parameters:
      p_pti_pmg_name - Name of the message group the PTI belongs to
      p_pti_id - ID of the item to retreive translations for
      p_msg_args - Optional <MSG_ARGS> object to replace anchors in the DISPLAY_NAME property of the PTI
      p_pti_pml_name - Oracle language reference

    Returns:
      Translated display name of the PTI
   */
  function get_trans_item_display_name(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_msg_args msg_args default null,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
    return varchar2;


  /**
    Function: get_trans_item_description
      Retrieves a PIT translatable item (PTI) description text in the session language.

      This API is aimed towards PL/SQL code that needs direct access to the respective items without
      the need to declare a record variable. If access to more than one item is required, rather call
      the overloaded method returning a record.

    Attention::
      In SQL, view <PIT_TRANSLATABLE_ITEM_V> should be used to avoid expensive roundtrips between SQL and PL/SQL.

    Parameters:
      p_pti_pmg_name - Name of the message group the PTI belongs to
      p_pti_id - ID of the item to retreive translations for
      p_pti_pml_name - Oracle language reference

    Returns:
      Translated display name of the PTI
   */
  function get_trans_item_description(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
    return CLOB;


  /**
    Function: get_trans_item
      Retrieves a PIT translatable item (PTI) record containing name, display name and description in the session language.

    Attention::
      In SQL, view <PIT_TRANSLATABLE_ITEM_V> should be used to avoid expensive roundtrips between SQL and PL/SQL.

    Parameters:
      p_pti_pmg_name - Name of the message group the PTI belongs to
      p_pti_id - ID of the item to retreive translations for
      p_msg_args - Optional <MSG_ARGS> object to replace anchors in the NAME and DISPLAY_NAME properties of the PTI
      p_pti_pml_name - Oracle language reference

    Returns:
      Record of type <PIT_UTIL.translatable_item_rec>, containing name, display name and description of the PTI
   */
  function get_trans_item(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_msg_args msg_args default null,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
    return pit_util.translatable_item_rec;


  /**
    Group: Control methods
   */

  /**
    Procedure: purge_log
      Purges the message log. Overload to define <P_DATE_BEFORE> as date.

      Call this procedure to clean up logging information. Only useful if your output modules support
      purging of log information, such as <PIT_TABLE> output module.

    Parameters:
      p_date_until - Date to indicate up to when the log should be purged.
      p_severity_lower_equal - Optional severity level that controls which severity of messages shall be purged.
                               Includes a message with a severity passed in and greater.
   */
  procedure purge_log(
    p_date_before in date,
    p_severity_lower_equal in number default null);


  /**
    Procedure: purge_log
      Purges the message log. Overload to define <P_DAYS_BEFORE> as number of days in the past.
   */
  procedure purge_log(
    p_days_before in number,
    p_severity_lower_equal in number default null);


  /**
    Procedure: purge_session_log
      Purges session related message log.

      Call this procedure to clean up logging information. Only useful if your output modules support
      purging of log information, such as <PIT_TABLE> output module.

    Parameter:
      p_session_id - Optional session_id. If null, the active session is purged.
   */
  procedure purge_session_log(
    p_session_id in varchar2 default null);


  /**
    Procedure: set_context
      Sets the trace context for the active session. Overloaded to directly set the context components.

      Call this procedure to dynamically change the debug settings to allow for dynamic debugging from within an application.

      Normal usage is to specify that the active session only should be logged and/or traced. Set the options you wish and immediately
      these settings apply. To reset logging to the default call <reset_context>

    Parameters:
      p_log_level - Requested log level
      p_trace_level - Requested stack level
      p_timing_on - Flag to indicate whehter timing information should be captured.
      p_log_modules - Colon-separated list of output modules to be used.
   */
  procedure set_context(
    p_log_level in integer,
    p_trace_level in integer,
    p_trace_timing in boolean,
    p_log_modules in varchar2);


  /**
    Procedure: set_context
      Sets the trace context for the active session. Overloaded to directly set the context by means of a named context.

      Call this procedure to set the active context to a predefined context. Contexts are defined as parameters
      with the name pattern

      --- SQL
      CONTEXT_<Name>
      ---

      and a string value according to this pattern:

      --- SQL
      [LOG_LEVEL|TRACE_LEVEL|TRACE_TIMING_FLAG (Y,N)|MODULE_LIST],
      ---

      Example:

      --- SQL
      CONTEXT_FULL = '70|70|Y|PIT_CONSOLE:PIT_FILE'
      ---

    Parameter:
      p_context_name - Name of the context to swithc to.
   */
  procedure set_context(
    p_context_name in varchar2);


  /*
    Procedure: set_context_value
      Method to set a context value eplicitly.

      Is used to persist arbitrary values at the context. This allows for maintaining information such as
      a test flag in a cross session aware manner. Setting an attribute to NULL eliminates this attribute from the context.

    Parameters:
      p_name - Name of the attribute to set
      p_value - Value to set, VARCHAR2 up to 4000 bytes.
   */
 procedure set_context_value(
   p_name in varchar2,
   p_value in varchar2);


  /*
    Function: get_context_value
      Method to get a context value eplicitly.

      Is used to retrieves sert values from the context. This allows for maintaining
      information such as a test flag in a cross session aware manner.

    Parameters:
      p_name - Name of the attribute to get

    Returns:
      Value of the attribute <P_NAME>
   */
  function get_context_value(
    p_name in varchar2)
    return varchar2;


  /**
    Procedure: reset_context
      Resets the trace context for the active session to the default values.

      If <p_active_session_only> is true, other settings remain unchanged. If false, any active context
      cross session is set back to default. This option is useful to clean up any unwanted debugging.

    Parameter:
      p_active_session_only Flag to indicate whether the active session should be reset only. Defaults to TRUE.
   */
  procedure reset_context(
    p_active_session_only in boolean default true);


  /**
    Procedure: start_message_collection
      Switches PIT collection mode on

      Is used to set PIT to collect mode, where all messages are collected rather than thrown or processed immediate.
      This mode allows for validation methods to perfrom all internal validations prior to raising validation errors.
   */
  procedure start_message_collection;


  /**
    Procedure: stop_message_collection
      Switches PIT collection mode off

      If called, the list of raised messages is examined.

      - If at least one message of secverity C_LEVEL_FATAL is present, exception PIT_BULK_FATAL is raised.
      - If at least one message of secverity C_LEVEL_ERROR is present, exception PIT_BULK_ERROR is raised.

      To process the errors, use <get_message_collection> to retrieve a list of all collected messages.
   */
  procedure stop_message_collection;


  /**
    Function: has_no_bulk_error
      Method to check whether no error has occurred yet.

      Is used to check that no exception has occured during collection mode.
      This is useful to control wether further validations do make sense.

    Returns:
      TRUE, if no error or fatal error has occured yet, FALSE otherwise
   */
  function has_no_bulk_error
    return boolean;


  /**
    Function: has_no_bulk_fatal
      Method to check whether no fatal error has occurred yet.

      Is used to check that no exception has occured during collection mode.
      This is useful to control wether further validations do make sense.

    Returns:
      TRUE, if no fatal error has occured yet, FALSE otherwise
   */
  function has_no_bulk_fatal
    return boolean;


  /**
    Function: get_message_collection
      Retrieves the collection of messages raised since setting PIT to collect mode.

      Is used to retrieve a list of all messages raised during the collect cycle. It implicitly terminates collection
      mode by calling <stop_message_collection> if PIT is still in collection mode.

      Normal usage is terminating collection mode explicity and deal with the list of messages in the exception block.

    Returns:
    Instance of <PIT_MESSAGE_TABLE>, a list of message instances.
   */
  function get_message_collection
    return pit_message_table;


  /**
    Function: get_modules
      Pipelined function to retrieve a list of all installed modules.

    Returns:
      <PIT_MODULE_LIST>, list of modules, availabilty and active status
   */
  function get_modules
    return pit_module_list
    pipelined;


  /**
    Function: get_available_modules
      Pipelined function to retrieve the list of available output modules.

      An output module may be unavailable because the environment does not allow for them,
      fi an APEX output module without an APEX session environment.

      Useful to populate a drop down list of output modules.

    Returns:
      <ARGS>, name list of the available (successfully instantiated) modules
   */
  function get_available_modules
    return pit_args
    pipelined;


  /**
    Function: get_active_modules
      Pipelined function to retrieve the list of active output modules

      An available output module can be inactive due to context settings.
      Useful to populate a drop down list of output modules.

    Returns:
      <ARGS>, name list of the actually active modules
   */
  function get_active_modules
    return pit_args
    pipelined;


  /**
    Procedure: initialize
      Re-initializes PIT

      Either called implicitly upon first instantiation or explicitly upon request.
      Calling this method is sometimes useful after changing PIT parameters or
      to clean up the call stack if the level indication ran out of sync.
   */
  procedure initialize;

end pit;
/