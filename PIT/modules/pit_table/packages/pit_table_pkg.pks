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
    Procedure: log 
      Method implmenents the <PIT_TABLE.log> method to write log information to table <PIT_TABLE_LOG>.
      
    Parameters:
      p_message - Instance of <message_type> to persist
   */
  procedure log(
    p_message in message_type);
    
  
  /**
    Procedure: log 
      Method implmenents the <PIT_TABLE.log> method to write log information to table <PIT_TABLE_PARAMS>.
      Overloaded version to log a <p_log_state_type> instance.
      
    Parameters:
      p_log_state - Instance of <pit_log_state_type> to persist
   */
  procedure log(
    p_log_state pit_log_state_type);
  
  
  /** 
    Procedure: purge 
      Method implmenents the <PIT_TABLE.purge> method to purge log information from tables <PIT_TABLE_LOG>, <PIT_TABLE_CALL_STACK> and <PIT_TABLE_PARAMS>
      
    Parameters:
      p_date_until - Date up to which the log entries are to be deleted
      p_severity_greater_equal - Optional severity up to which the log entries are to be deleted
   */
  procedure purge(
    p_date_until in date,
    p_severity_greater_equal in number default null);
  
  
  /**
    Procedure: enter 
      Method implmenents the <PIT_TABLE.enter> method to write the call stack type attributes to tables <PIT_TABLE_CALL_STACK> and <PIT_TABLE_PARAMS>.
      
    Parameters:
      p_call_stack - Instance of <pit_call_stack_type> to persist
   */
  procedure enter(
    p_call_stack in pit_call_stack_type);
  
  
  /** 
    Procedure: leave 
      Method implmenents the <PIT_TABLE.leave> method to write the call stack type attributes to tables <PIT_TABLE_CALL_STACK> and <PIT_TABLE_PARAMS>.
      
    Parameters:
      p_call_stack - Instance of <pit_call_stack_type> to persist
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
