create or replace package pit_apex_pkg
  authid definer
as

  /**
    Package: Output Modules.PIT_APEX.PIT_APEX_PKG
      Implementation package for type <PIT_APEX>
      
      Notify functionality is based on the work of Daniel Hochleitner
      <On Github: https://github.com/Dani3lSun/apex-websocket-notify-bundle>
   
    Author::
      Juergen Sieben, ConDeS GmbH
   */
   
  /**
    Function: get_apex_triggered_context
      Method to retrieve the name of the context that is used for logging if APEX is set to DEBUG mode.
      Is called from the APEX session adapter <PIT_APEX_ADAPTER>
      
    Returns: 
      CONTEXT_APEX, the name of the APEX specific context. Context settings are set using the CONTEXT_APEX parameter
   */
  function get_apex_triggered_context
    return varchar2;
  
  
  /**
    Procedure: log
      Method to write log information to the APEX debug stack.
      Method implements the <PIT_APEX.log> member procedure and writes the message attributes to the APEX debug stack.
      
    Parameter:
      p_message - Instance of <MESSAGE_TYPE>
   */
  procedure log(
    p_message in message_type);


  /** 
    Procedure: log
      Method to write state information to the APEX debug stack.
      Method implements the <PIT_APEX.log> member procedure overload for <PIT_LOG_STATE_TYPE> and writes 
      the key value pairs of <MSG_PARAM> to the console.
      
    Parameter:
      p_log_state - Instance of <PIT_LOG_STATE_TYPE>
   */
  procedure log (
    p_log_state in pit_log_state_type);
  
  
  /** 
    Procedure: print
      Method to write general information to the APEX application.
      Method implements the <PIT_APEX.print> member procedure of type <PIT_APEX>
      and writes the message attributes to the APEX http stream.
      
    Parameter:
      p_message - Instance of <MESSAGE_TYPE>
   */
  procedure print(
    p_message in message_type);
  
  
  /** 
    Procedure: notify
      Method to write log information to the APEX application.
      
      Method implements the <PIT_MODULE.PIT_APEX.notify> member procedure and writes the message attributes to the APEX http stream.
      
      This method uses a web socket connection and should be used if a progress or other state information has to be shown
      at the apex application. It will take the session id parameter of <MESSAGE_TYPE> to route the message to the correct client.
      
    Attention::
      Not fully implemented yet.
      
    Parameter:
      p_message - Instance of <MESSAGE_TYPE>
   */
  procedure notify(
    p_message in message_type);


  /** 
    Procedure: enter
      Method to write call stack information on enter to the APEX debug stack.
      
      Method implements the <PIT_MODULE.PIT_APEX.enter> member procedure and writes the call stack type attributes 
      to the APEX debug stack. Requires an APEX log level of LEVEL5 or higher to show the entries.
      
    Parameter:
      p_call_stack - Instance of <PIT_CALL_STACK_TYPE>
   */
  procedure enter(
    p_call_stack in pit_call_stack_type);


  /** 
    Procedure: leave
      Method to write call stack information on leave to the APEX debug stack.
      
      Method implements the <PIT_MODULE.PIT_APEX.leave> member procedure and writes the call stack type attributes 
      to the APEX debug stack. Requires an APEX log level of LEVEL5 or higher to show the entries.
      
    Parameter:
      p_call_stack - Instance of <PIT_CALL_STACK_TYPE>
   */
  procedure leave(
    p_call_stack in pit_call_stack_type);

  
  /** 
    Procedure: initialize_module
      Initialization method for <PIT_MODULE.PIT_APEX> output module.
      
      Method implements the parameterless constructor method of <PIT_APEX>.
      This method marks the output module available only in an existing APEX environment.
   */
  procedure initialize_module(
    self in out nocopy pit_apex);
    
end pit_apex_pkg;
/
