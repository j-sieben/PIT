create or replace package pit_file_pkg
  authid definer
  accessible by (type PIT_FILE)
as

  /**
    Package: Output Modules.PIT_FILE.PIT_FILE_PKG
      Implementation package for type <PIT_AFILE>
   
    Author::
      Juergen Sieben, ConDeS GmbH
   */
    
  /**
    Procedure: log_exception
      See <PIT_MODULE.log_exception>
   */
  procedure log_exception (
    self in out nocopy pit_file,
    p_message in message_type);
    
    
  /**
    Procedure: panic
      See <PIT_MODULE.panic>
   */
  procedure panic (
    self in out nocopy pit_file,
    p_message in message_type);
    
    
  /**
    Procedure: tweet
      See <PIT_MODULE.tweet>
   */
  procedure tweet (
    self in out nocopy pit_file,
    p_message in message_type);
    
    
  /**
    Procedure: log_state
      See <PIT_MODULE.log_state>
   */
  procedure log_state (
    self in out nocopy pit_file,
    p_log_state in pit_log_state_type);
    
    
  /**
    Procedure: purge_log
      See <PIT_MODULE.purge_log>
   */
  procedure purge_log(
    self in out nocopy pit_file,
    p_purge_date in date,
    p_severity_greater_equal in integer default null);
    
    
  /**
    Procedure: enter
      See <PIT_MODULE.enter>
   */
  procedure enter(
    self in out nocopy pit_file,
    p_call_stack in pit_call_stack_type);
    
    
  /**
    Procedure: leave
      See <PIT_MODULE.leave>
   */
  procedure leave(
    self in out nocopy pit_file,
    p_call_stack in pit_call_stack_type);
    
    
  /**
    Procedure: initialize_module
      Method implements the parameterless <pit_file> constructor of type PIT_FILE. The output module is available if it is possible to open the trace file.
      
    Parameter:
      p_call_stack - Instance of <CALL_STACK_TYPE>
   */
  procedure initialize_module(
    self in out pit_file);
  
end pit_file_pkg;
/

show errors
