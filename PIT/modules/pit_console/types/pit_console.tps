create or replace type pit_console force under pit_module(
  /** 
    Package: Output Modules.PIT_CONSOLE.PIT_CONSOLE
      Output module to write to the console. Extends <PIT_MODULE>.
   */
  
  /** 
    Procedure: log
      See <PIT_MODULE.log>
   */
  overriding member procedure log(
    self in out nocopy pit_console,
    p_message in message_type),
    
  /**
    Procedure: log
      See <PIT_MODULE.log>
   */
  overriding member procedure log(
    self in out nocopy pit_console,
    p_log_state pit_log_state_type),
    
  /**
    Procedure: print
      See <PIT_MODULE.print>
   */
  overriding member procedure print(
    self in out nocopy pit_console,
    p_message in message_type),
    
  /**
    Procedure: notify
      See <PIT_MODULE.notify>*/
  overriding member procedure notify(
    self in out nocopy pit_console,
    p_message in message_type),
    
  /**
    Procedure: enter
      See <PIT_MODULE.enter>
   */
  overriding member procedure enter(
    self in out nocopy pit_console,
    p_call_stack pit_call_stack_type),
    
  /**
    Procedure: leave
      See <PIT_MODULE.leave>
   */
  overriding member procedure leave (
    self in out nocopy pit_console,
    p_call_stack pit_call_stack_type),
    
  /**
    Procedure: context_changed
      See <PIT_MODULE.context_changed>
   */
  overriding member procedure context_changed(
    self in out nocopy pit_console,
    p_ctx in pit_context_type),
    
  /** 
    Procedure: pit-console
      Contructor function to instantiate the output module.
   */
  constructor function pit_console (
    self in out nocopy pit_console)
    return self as result)
final instantiable;
/
