create or replace package pit_file_pkg
as
  
  /** Implementation package for type PIT_FILE */
    
  /** Method to write log information to a trace file
   * %param  p_message Instance of MESSAGE_TYPE
   * %usage  Method implements the LOG member procedure of type PIT_FILE and
   *         writes the message attributes to the console.
   */
  procedure log (
    p_message in message_type);
    
    
  /** Method to write state information to a trace file
   * %param  p_params Instance of MSG_PARAMS
   * %usage  Method implements the LOG member procedure overload for MSG_PARAMS of type PIT_FILE and
   *         writes the key value pairs of MSG_PARAM to a trace file.
   */
  procedure log (
    p_params in msg_params);
  
  
  /** Method to purge log information from tables PIT_TABLE_LOG, PIT_TABLE_CALL_STACK and PIT_TABLE_PARAMS
   * %param  p_date_until              Date up to which the log entries are to be deleted
   * %param [p_severity_greater_equal] Severity up to which the log entries are to be deleted
   * %usage  Method implements the PURGE member procedure of type PIT_File and
   *         erases the log file. It will not filter as set by P_DATE_UNTIL and P_SEVERITY_GREATER_EQUAL.
   */
  procedure purge;
  

  /** Method to write call stack information on enter to a trace file
   * %param  p_call_stack  Instance of CALL_STACK_TYPE
   * %usage  Method implements the ENTER member procedure of type PIT_FILE and
   *         writes the call stack type attributes to a trace file.
   */
  procedure enter(
    p_call_stack in call_stack_type);
  

  /** Method to write call stack information on leave to a trace file
   * %param  p_call_stack  Instance of CALL_STACK_TYPE
   * %usage  Method implements the LEAVE member procedure of type PIT_FILE and
   *         writes the call stack type attributes to a trace file.
   */
  procedure leave(
    p_call_stack in call_stack_type);

  
  /** Initialization method for PIT_FILE output module
   * %usage  Method implements the parameterless constructor method of PIT_FILE
   *         The output module is available if it is possible to open the trace file
   */
  procedure initialize_module(self in out pit_file);
  
end pit_file_pkg;
/

show errors
