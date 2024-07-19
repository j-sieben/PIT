create or replace type pit_module force 
  authid definer
as object(
  /** 
    Package: PIT_MODULE
      Abstract output module for PIT.
      
      IMPORTANT: Output modules must not throw exceptions. If an exception is necessary,
      you need to catch to prevent it from being thrown. This is necessary to guarantee that
      all modules fire if they have to.
    
    Properties:
      fire_threshold - Log level above which the module does not react anymore. Is used to control the amount of 
                       messages processed by the respective module
      status - Status indicating whether this module can be used or not
      stack - If this module is unusable, this property contains information about the reason.
   */
  fire_threshold integer,
  status varchar2(128 byte),
  stack varchar2(2000 byte),
  
  /**
    Procedure: context_changed
      Method is raised if the context settings have changed 
      
    Parameter: 
      p_ctx - Instance of <pit_context> with the information about the new context.
   */
  member procedure context_changed(
    self in out nocopy pit_module,
    p_ctx in pit_context_type),
    
  /** 
    Procedure: tweet
      Method is called for lightweight developer output
      
    Parameter: 
      p_message - Instance of PIT_TWEET message
   */
  member procedure tweet(
    self in out nocopy pit_module,
    p_message in message_type),
    
  /** 
    Procedure: log_validation
      Method is called as a areaction on validation outcomes. enables PIT
      to react differently on validation messages in comparison to error messages.
      Is called from pit.handle_validation.
      
    Parameter: 
      p_message - Instance of <message_type>, the message to log
   */
  member procedure log_validation(
    self in out nocopy pit_module,
    p_message in message_type),
    
  /** 
    Procedure: log_exception
      Method is called for debugging, error handling and the like.
      Is called from pit.handle_exception
      
    Parameter: 
      p_message - Instance of <message_type>, the message to log
   */
  member procedure log_exception(
    self in out nocopy pit_module,
    p_message in message_type),
    
  /** 
    Procedure: log_state
      Overloaded logging method to log the state of variables passed in.
      Is called from pit.log_state
      
    Parameter: 
      p_log_state - Instance of <pit_log_state_type> with the key and values to log
   */
  member procedure log_state(
    self in out nocopy pit_module,
    p_log_state in pit_log_state_type),
    
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
      Method to notify outout modules. Leightweight message.
      
    Parameter:
      p_message - Instance of <message_type>, the message to pass as a notification
   */
  member procedure notify (
    self in out nocopy pit_module,
    p_message in message_type),
    
  /** 
    Procedure: enter
      Method is called if PIT recognizes that the code enters a method 
      
    Parameter: 
      p_call_stack - Instance of <pit_call_stack_type> with the call stack information
   */
  member procedure enter (
    self in out nocopy pit_module,
    p_call_stack pit_call_stack_type),
    
  /** 
    Procedure: leave
      Method is called if PIT recognizes that the code left a method 
      
    Parameter: 
      p_call_stack - Instance of <pit_call_stack_type> with the call stack information
   */
  member procedure leave (
    self in out nocopy pit_module,
    p_call_stack pit_call_stack_type),
    
  /** 
    Procedure: purge_log
      Method is called to purge a message stack. Useful for output modules persisting messages 
      
    Parameter: 
      p_purge_date - Date, before which all entries have to be purged
      p_severity_greater_equal - Optional level to further filter the log entries to purge
   */
  member procedure purge_log(
    self in out nocopy pit_module,
    p_purge_date in date default null,
    p_severity_greater_equal in integer default null),
    
  /** 
    Procedure: panic
      Method is called if an unexpected, unrecoverable error has occured.
      
    Parameter: 
      p_message - Instance of <message_type>, the message to log
   */
  member procedure panic(
    self in out nocopy pit_module,
    p_message in message_type)
) not final not instantiable;
/