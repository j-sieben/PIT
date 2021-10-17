create or replace type pit_module as object(
  /** 
    Type: pit_module
      Abstract output module for PIT.
    
    Properties:
      fire_threshold - Log level above which the module does not react anymore. Is used to control the amount of 
                       messages processed by the respective module
      status - Status indicating whether this module can be used or not
      stack - If this module is unusable, this property contains information about the reason.
   */
  fire_threshold integer,
  status &ORA_NAME_TYPE.,
  stack varchar2(2000 byte),
  /**
    Procedure: context_changed
      Method is raised if the context settings have changed 
      
    Parameter: 
      p_ctx - Instance of <pit_context> with the information about the new context.
   */
  member procedure context_changed(
    self in out nocopy pit_module,
    p_ctx in pit_context),
  /** 
    Procedure: log
      Method is called for debugging, error handling and the like
      
    Parameter: 
      p_message - Instance of <message_type>, the message to log
   */
  member procedure log(
    self in out nocopy pit_module,
    p_message in message_type),
  /** 
    Procedure: context_changed
      Overloaded logging method to log the state of variables passed in 
      
    Parameter: 
      p_log_state - Instance of <log_state_type> with the key and values to log
   */
  member procedure log(
    self in out nocopy pit_module,
    p_log_state in log_state_type),
  /** 
    Procedure: print
      Method to print a message to the target. Is not fenced in by log or trace settings 
      
    Parameter: 
      p_message - Instance of <message_type>, the message to print.
   */
  member procedure print(
    self in out nocopy pit_module,
    p_message in message_type),
  /** 
    Procedure: notify
      Method to notify changes. Aimed towards state changes and other leight weight messages 
      
    Parameter: 
      p_message - Instance of <message_type>, the message to notify.
   */
  member procedure enter(
    self in out nocopy pit_module,
    p_message in message_type),
  /** 
    Procedure: context_changed
      Method is called if PIT recognizes that the code entered a method 
      
    Parameter: 
      p_call_stack - Instance of <call_stack_type> with the call stack information
   */
  member procedure enter(
    self in out nocopy pit_module,
    p_call_stack call_stack_type),
  /** 
    Procedure: leave
      Method is called if PIT recognizes that the code left a method 
      
    Parameter: 
      p_call_stack - Instance of <call_stack_type> with the call stack information
   */
  member procedure leave (
    self in out nocopy pit_module,
    p_call_stack call_stack_type),
  /** 
    Procedure: context_changed
      Method is called to purge a message stack. Useful for output modules persisting messages 
      
    Parameter: 
      p_purge_date - Date, before which all entries have to be purged
      p_severity_greater_equal - Optional level to further filter the log entries to purge
   */
  member procedure purge(
    self in out nocopy pit_module,
    p_purge_date in date default null,
    p_severity_greater_equal in integer default null)
) not final not instantiable;
/