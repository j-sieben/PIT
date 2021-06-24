create or replace package pit_apex_pkg
  authid definer
as
  /** Implementation package for type PIT_APEX
   *  Notify functionality is based on the work of Daniel Hochleitner
   *  https://github.com/Dani3lSun/apex-websocket-notify-bundle
   */
   
   
  /** Method to retrieve the name of the context that is used for logging if APEX is set to DEBUG mode
   * %return CONTEXT_APEX, the name of the APEX specific context. Context settings are set using the CONTEXT_APEX parameter
   * %usage  Is called from the APEX session adapter PIT_APEX_ADAPTER
   */
  function get_apex_triggered_context
    return varchar2;
  
  
  /** Method to write log information to the APEX debug stack
   * %param  p_message Instance of MESSAGE_TYPE
   * %usage  Method implements the LOG member procedure of type PIT_APEX and writes the message attributes to the APEX debug stack.
   */
  procedure log(
    p_message in message_type);


  /** Method to write state information to the APEX debug stack
   * %param  p_log_state Instance of LOG_STATE_TYPE
   * %usage  Method implements the LOG member procedure overload for LOG_STATE_TYPE and
   *         writes the key value pairs of MSG_PARAM to the console.
   */
  procedure log (
    p_log_state in log_state_type);
  
  
  /** Method to write general information to the APEX application
   * %param  p_message Instance of MESSAGE_TYPE
   * %usage  Method implements the PRINT member procedure of type PIT_APEX and writes the message attributes to the APEX http stream.
   */
  procedure print(
    p_message in message_type);
  
  
  /** Method to write log information to the APEX application
   * %param  p_message Instance of MESSAGE_TYPE
   * %usage  Method implements the NOTIFY member procedure of type PIT_APEX and writes the message attributes to the APEX http stream.
   *         This method uses a web socket connection and should be used if a progress or other state information has to be shown
   *         at the apex application. It will take the session id parameter of MESSAGE_TYPE to route the message to the correct client.
   *         ATTENTION: Not fully implemented yet.
   */
  procedure notify(
    p_message in message_type);


  /** Method to write call stack information on enter to the APEX debug stack
   * %param  p_call_stack  Instance of CALL_STACK_TYPE
   * %usage  Method implements the ENTER member procedure of type PIT_APEX and
   *         writes the call stack type attributes to the APEX debug stack.
   *         Requires an APEX log level of LEVEL5 or higher to show the entries
   */
  procedure enter(
    p_call_stack in call_stack_type);


  /** Method to write call stack information on leave to the APEX debug stack
   * %param  p_call_stack  Instance of CALL_STACK_TYPE
   * %usage  Method implements the LEAVE member procedure of type PIT_APEX and
   *         writes the call stack type attributes to the APEX debug stack.
   *         Requires an APEX log level of LEVEL5 or higher to show the entries
   */
  procedure leave(
    p_call_stack in call_stack_type);

  
  /** Initialization method for PIT_APEX output module
   * %usage  Method implements the parameterless constructor method of PIT_APEX.
   *         This method marks the output module available only in an existing APEX environment.
   */
  procedure initialize_module(
    self in out nocopy pit_apex);
    
end pit_apex_pkg;
/
