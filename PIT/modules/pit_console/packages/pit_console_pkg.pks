create or replace package pit_console_pkg
  authid definer
  accessible by (type PIT_CONSOLE)
as
  
  /**
    Package: Output Modules.PIT_CONSOLE.PIT_CONSOLE_PKG
      Implementation package for type <PIT_CONSOLE>. Extends <PIT_MODULE>
   
    Author::
      Juergen Sieben, ConDeS GmbH
   */
    
  /** 
    Procedure: tweet
      Method to write lightweight developers comments to the output modules
      
    Parameter:
      p_message - Instance of PIT_TWEET message
   */
  procedure tweet (
    p_message in message_type);
    
  /** 
    Procedure: log_validation
      Method to write validation information to the console
      Method implements the <PIT_CONSOLE>.log_validation member procedure and  writes the message attributes to the console.
      
    Parameter:
      p_message - Instance of <MESSAGE_TYPE>
   */
  procedure log_validation (
    p_message in message_type);
    
  /** 
    Procedure: log_exception
      Method to write validation information to the console
      Method implements the <PIT_CONSOLE>.log_exception member procedure and  writes the message attributes to the console.
      
    Parameter:
      p_message - Instance of <MESSAGE_TYPE>
   */
  procedure log_exception (
    p_message in message_type);
    
  /** 
    Procedure: panic
      Method to write validation information to the console
      Method implements the <PIT_CONSOLE>.panic member procedure and  writes the message attributes to the console.
      
    Parameter:
      p_message - Instance of <MESSAGE_TYPE>
   */
  procedure panic (
    p_message in message_type);
    
    
  /** 
    Procedure: log_state
      Method to write state information to the console
      Method implements the <PIT_CONSOLE>.log_state member procedure overload and writes the key value pairs of <MSG_PARAM> to the console.
      
    Parameter:
      p_log_state - Instance of <PIT_LOG_STATE_TYPE>
   */
  procedure log_state (
    p_log_state in pit_log_state_type);


  /**
    Procedure: enter
      Method to write call stack information on enter to the console
      Method implements the <PIT_CONSOLE> enter member procedure and writes the call stack type attributes to the console.
      
    Parameter:
      p_call_stack - Instance of <PIT_CALL_STACK_TYPE>
   */
  procedure enter(
    p_call_stack in pit_call_stack_type);


  /**
    Procedure: leave
      Method to write call stack information on leave to the console
      Method implements the <PIT_CONSOLE> leave member procedure and writes the call stack type attributes to the console.
      
    Parameter:
      p_call_stack - Instance of <PIT_CALL_STACK_TYPE>
   */
  procedure leave(
    p_call_stack in pit_call_stack_type);
    

  /**
    Procedure: context_changed
      Method to write information about a context change to the console
      Method implements the <PIT_CONSOLE> context_changed member procedure and writes the details of the active context to the console.
    
    Parameter:
      p_ctx - Instance of <PIT_CONTEXT>
   */
  procedure context_changed(
    p_ctx in pit_context_type);

  
  /**
    Procedure: initialize_module
      Initialization method for <PIT_CONSOLE> output module.
      Method implements the parameterless constructor method of <PIT_CONSOLE>
   */
  procedure initialize_module(
    self in out nocopy pit_console);
end pit_console_pkg;
/
