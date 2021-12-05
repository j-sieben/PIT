create type pit_table under pit_module(
  /** Output module to write messages to a table */
  
  /** Method to insert debug and error message into table PIT_TABLE_LOG */
  overriding member procedure log(
    p_message in message_type),
  
  /** Method to insert state information into table PIT_TABLE_PARAMS */
  overriding member procedure log(
    p_log_state in pit_log_state_type),
    
  /** Method to write call stack information into table PIT_TABLE_CALL_STACK / PIT_TABLE_PARAMS */
  overriding member procedure enter (
    p_call_stack pit_call_stack_type),
    
  /** Method to write call stack information into table PIT_TABLE_CALL_STACK / PIT_TABLE_PARAMS */
  overriding member procedure leave (
    p_call_stack pit_call_stack_type),
    
  /** Method to clean up log tables based on purge date and/or severity */
  overriding member procedure purge(
    p_purge_date in date,
    p_severity_greater_equal in integer default null),
    
  /** Constructor function */
  constructor function pit_table (
    self in out nocopy pit_table)
    return self as result
  )
  final instantiable;
/