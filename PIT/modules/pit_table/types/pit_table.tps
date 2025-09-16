create or replace type pit_table under pit_module(
  
   
  /** 
    Package: Output Modules.PIT_TABLE.PIT_TABLE
      Output module for a log table. Extends <PIT_MODULE>.
   
    Author::
      Juergen Sieben, ConDeS GmbH
   */
  
  /** 
    Procedure: log_exception
      See <PIT_MODULE.log_exception>
   */
  overriding member procedure log_exception(
    self in out nocopy pit_table,
    p_message in message_type),
  
  /** 
    Procedure: panic
      See <PIT_MODULE.panic>
   */
  overriding member procedure panic(
    self in out nocopy pit_table,
    p_message in message_type),
  
  /** 
    Procedure: tweet
      See <PIT_MODULE.tweet>
   */
  overriding member procedure tweet(
    self in out nocopy pit_table,
    p_message in message_type),
  
  
  /** 
    Procedure: log_state
      See <PIT_MODULE.log>
   */
  overriding member procedure log_state(
    self in out nocopy pit_table,
    p_log_state in pit_log_state_type),
  
  /** 
    Procedure: enter
      See <PIT_MODULE.enter>
   */
  overriding member procedure enter (
    self in out nocopy pit_table,
    p_call_stack pit_call_stack_type),
    
  
  /** 
    Procedure: leave
      See <PIT_MODULE.leave>
   */
  overriding member procedure leave (
    self in out nocopy pit_table,
    p_call_stack pit_call_stack_type),
  
  
  /** 
    Procedure: purge_log
      See <PIT_MODULE.purge_log>
   */
  overriding member procedure purge_log(
    self in out nocopy pit_table,
    p_purge_date in date,
    p_severity_greater_equal in integer default null),
    
  /** 
    Procedure: pit_table
      Contructor function to instantiate the output module. Marks the module available only if an APEX session exists.
   */
  constructor function pit_table (
    self in out nocopy pit_table)
    return self as result
  )
  final instantiable;
/