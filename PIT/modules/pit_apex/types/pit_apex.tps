create type pit_apex under pit_module
(
  /** 
    Type: PIT_MODULE.pit_apex
      Output module for an APEX environment 
   */
  
  /** 
    Procedure: log
      See <PIT_MODULE.log>
   */
  overriding member procedure log(
    self in out nocopy pit_apex,
    p_message in message_type),
  /** 
    Procedure: log
      See <PIT_MODULE.log>
   */
  overriding member procedure log(
    self in out nocopy pit_apex,
    p_log_state log_state_type),
  /** 
    Procedure: print
      See <PIT_MODULE.print>
   */
  overriding member procedure print(
    self in out nocopy pit_apex,
    p_message in message_type),
  /**
    Procedure: notify
      See <PIT_MODULE.notify>
      
    Attention::
      Not implemented yet
   */
  overriding member procedure notify(
    self in out nocopy pit_apex,
    p_message in message_type),
  /**
    Procedure: enter
      See <PIT_MODULE.enter>
   */
  overriding member procedure enter (
    self in out nocopy pit_apex,
    p_call_stack in call_stack_type),
  /**
    Procedure: leave
      See <PIT_MODULE.leave>
   */
  overriding member procedure leave (
    self in out nocopy pit_apex,
    p_call_stack in call_stack_type),
  /** 
    Procedure: pit_apex
      Contructor function to instantiate the output module. Marks the module available only if an APEX session exists.
   */
  constructor function pit_apex(
    self in out nocopy pit_apex) 
    return self as result
)
final instantiable;
/
