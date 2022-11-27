create or replace package pit_console_pkg
as
  
  /**
    Package: Output Modules.PIT_CONSOLE.PIT_CONSOLE_PKG
      Implementation package for type <PIT_CONSOLE>. Extends <PIT_MODULE>
   
    Author::
      Juergen Sieben, ConDeS GmbH
   */
    
  /** 
    Procedure: log
      Method to write log information to the console
      Method implements the <PIT_CONSOLE> log member procedure and  writes the message attributes to the console.
      
    Parameter:
      p_message - Instance of <MESSAGE_TYPE>
   */
  procedure log (
    p_message in message_type);
    
    
  /** 
    Procedure: log
      Method to write state information to the console
      Method implements the <PIT_CONSOLE> log member procedure overload and writes the key value pairs of <MSG_PARAM> to the console.
      
    Parameter:
      p_log_state - Instance of <PIT_LOG_STATE_TYPE>
   */
  procedure log (
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
    self in out pit_console);
end pit_console_pkg;
/
