create or replace package pit_table_pkg 
as
  /** Implementation package for type PIT_TABLE */
  
  
  /** Method to write log information to table PIT_TABLE_LOG
   * %param  p_message Instance of MESSAGE_TYPE to persist
   * %usage  Method implements the LOG member procedure of type PIT_TABLE and
   *         writes the message attributes to table.
   */
  procedure log(
    p_message in message_type);
  
  
  /** Method to purge log information from tables PIT_TABLE_LOG, PIT_TABLE_CALL_STACK and PIT_TABLE_PARAMS
   * %param  p_date_until              Date up to which the log entries are to be deleted
   * %param [p_severity_greater_equal] Severity up to which the log entries are to be deleted
   * %usage  Method implements the PURGE member procedure of type PIT_TABLE and
   *         removes entries from the tables according to the filter set by P_DATE_UNTIL and P_SEVERITY_GREATER_EQUAL.
   *         Entries from PIT_TABLE_CALL_STACK and PIT_TABLE_PARAMS are not filterd by P_SEVERITY_GREATER_EQUAL but only by date.
   */
  procedure purge(
    p_date_until in date,
    p_severity_greater_equal in number default null);
  
  
  /** Method to write call stack information on enter to tables PIT_TABLE_CALL_STACK and PIT_TABLE_PARAMS
   * %param  p_call_stack  Instance of CALL_STACK_TYPE to persist
   * %usage  Method implements the ENTER member procedure of type PIT_TABLE and
   *         writes the call stack type attributes to table.
   */
  procedure enter(
    p_call_stack in call_stack_type);
  
  
  /** Method to write call stack information on leave to tables PIT_TABLE_CALL_STACK and PIT_TABLE_PARAMS
   * %param  p_call_stack  Instance of CALL_STACK_TYPE to persist
   * %usage  Method implements the LEAVE member procedure of type PIT_TABLE and
   *         writes the call stack type attributes to table.
   */
  procedure leave(
    p_call_stack in call_stack_type);

  
  /** Initialization method for PIT_TABLE output module
   * %usage  Method implements the parameterless constructor method of PIT_TABLE
   */
  procedure initialize_module(
    self in out pit_table);
end pit_table_pkg;
/
