create or replace package pit_table_pkg
  authid definer
as

  /**
    Package: Output Modules.PIT_TABLE.PIT_TABLE_PKG
      Implementation package for type <PIT_TABLE>
   
    Author::
      Juergen Sieben, ConDeS GmbH
   */
   
  
  /** 
    Procedure: log_exception 
      See: <PIT_CONSOLE.log_exception>
   */
  procedure log_exception(
    p_message in message_type);
   
  
  /** 
    Procedure: panic 
      See: <PIT_CONSOLE.panic>
   */
  procedure panic(
    p_message in message_type);
   
  
  /** 
    Procedure: tweet 
      See: <PIT_CONSOLE.tweet>
   */
  procedure tweet(
    p_message in message_type);
    
  
  /**
    Procedure: log_state
      See: <PIT_CONSOLE.log_state>
   */
  procedure log_state(
    p_log_state pit_log_state_type);
  
  
  /** 
    Procedure: purge_log 
      See: <PIT_CONSOLE.purge_log>
   */
  procedure purge_log(
    p_date_until in date,
    p_severity_greater_equal in number default null);
  
  
  /**
    Procedure: enter 
      See: <PIT_CONSOLE.enter>
   */
  procedure enter(
    p_call_stack in pit_call_stack_type);
  
  
  /** 
    Procedure: leave 
      See: <PIT_CONSOLE.leave>
   */
  procedure leave(
    p_call_stack in pit_call_stack_type);

  
  /**
    Procedure: initialize_module 
      Method implements the parameterless constructor method of <PIT_TABLE>.
   */
  procedure initialize_module(
    self in out pit_table);
end pit_table_pkg;
/
