create or replace package pit_ut_pkg
  authid definer
as
  
  /** Implementation package for type PIT_UT 
   *  This output module is used for unit tests only and writes messages to the UT_PIT package. This way, the outcome of 
   *  unit tests can be automatically checked by the UTPLSQL framework
   */
    
    
  /** Method to pass log information to UT_PIT.SET_RESULT
   * %param  p_message  Instance of MESSAGE_TYPE
   * %usage  Method implements the LOG member procedure of type PIT_UT and
   *         passes the message instance to UT_PIT.SET_RESULT.
   */
  procedure log (
    p_message in message_type);
    
    
  /** Method to pass state information to UT_PIT.SET_RESULT
   * %param  p_message  Instance of MESSAGE_TYPE
   * %usage  Method implements the LOG member procedure overload with MSG_PARAMS of type PIT_UT and
   *         passes the MSG_PARAMS instance to UT_PIT.SET_RESULT.
   */
  procedure log (
    p_params in msg_params);
    
    
  /** Method to pass general information to UT_PIT.SET_RESULT
   * %param  p_message  Instance of MESSAGE_TYPE
   * %usage  Method implements the PRINT member procedure of type PIT_UT and
   *         passes the message instance to UT_PIT.SET_RESULT.
   */
  procedure print (
    p_message in message_type);
    
    
  /** Method to pass notification information to UT_PIT.SET_RESULT
   * %param  p_message  Instance of MESSAGE_TYPE
   * %usage  Method implements the NOTIFY member procedure of type PIT_UT and
   *         passes the message instance to UT_PIT.SET_RESULT.
   */
  procedure notify (
    p_message in message_type);
    

  /** Method to pass enter information to UT_PIT.SET_RESULT
   * %param  p_call_stack  Instance of CALL_STACK_TYPE
   * %usage  Method implements the ENTER member procedure of type PIT_UT and
   *         passes the CALL_STACK_TYPE instance to UT_PIT.SET_RESULT.
   */
  procedure enter(
    p_call_stack in call_stack_type);
    

  /** Method to pass leave information to UT_PIT.SET_RESULT
   * %param  p_call_stack  Instance of CALL_STACK_TYPE
   * %usage  Method implements the LEAVE member procedure of type PIT_UT and
   *         passes the CALL_STACK_TYPE instance to UT_PIT.SET_RESULT.
   */
  procedure leave(
    p_call_stack in call_stack_type);
    
  /** Method to pass context change information to UT_PIT.SET_RESULT
   * %param  p_ctx  Instance of PIT_CONTEXT
   * %usage  Method implements the CONTEXT_CHANGE member procedure of type PIT_UT and
   *         passes the PIT_CONTEXT instance to UT_PIT.SET_RESULT.
   */
  procedure context_changed(
    p_ctx in pit_context);
    

  /** Method to pass initialize information to UT_PIT.SET_RESULT
   * %param  p_message  Instance of MESSAGE_TYPE
   * %usage  Method implements the INITIALIZE_MODULE member procedure of type PIT_UT and
   *         passes the status of PIT_UT to UT_PIT.SET_RESULT.
   */
  procedure initialize_module(
    self in out pit_ut);
end pit_ut_pkg;
/
