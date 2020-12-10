create or replace package pit_console_pkg
as
  
  /** Implementation package for type PIT_CONSOLE */
    
  /** Method to write log information to the console
   * %param  p_message Instance of MESSAGE_TYPE
   * %usage  Method implements the LOG member procedure of type PIT_CONSOLE and
   *         writes the message attributes to the console.
   */
  procedure log (
    p_message in message_type);
    
    
  /** Method to write state information to the console
   * %param  p_log_state Instance of LOG_STATE_TYPE
   * %usage  Method implements the LOG member procedure overload for LOG_STATE_TYPE and
   *         writes the key value pairs of MSG_PARAM to the console.
   */
  procedure log (
    p_log_state in log_state_type);


  /** Method to write call stack information on enter to the console
   * %param  p_call_stack  Instance of CALL_STACK_TYPE
   * %usage  Method implements the ENTER member procedure of type PIT_CONSOLE and
   *         writes the call stack type attributes to the console.
   */
  procedure enter(
    p_call_stack in call_stack_type);


  /** Method to write call stack information on leave to the console
   * %param  p_call_stack  Instance of CALL_STACK_TYPE
   * %usage  Method implements the LEAVE member procedure of type PIT_CONSOLE and
   *         writes the call stack type attributes to the console.
   */
  procedure leave(
    p_call_stack in call_stack_type);
    

  /** Method to write information about a context change to the console
   * %param  p_ctx  Instance of PIT_CONTEXT
   * %usage  Method implements the CONTEXT_CHANGED member procedure of type PIT_CONSOLE and
   *         writes the details of the active context to the console.
   */
  procedure context_changed(
    p_ctx in pit_context);

  
  /** Initialization method for PIT_CONSOLE output module
   * %usage  Method implements the parameterless constructor method of PIT_CONSOLE
   */
  procedure initialize_module(
    self in out pit_console);
end pit_console_pkg;
/
