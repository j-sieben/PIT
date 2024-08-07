create or replace type pit_apex under pit_module
(
   
  /** 
    Package: Output Modules.PIT_APEX.PIT_APEX
      Output module for an APEX environment. Extends <PIT_MODULE>.
   
    Author::
      Juergen Sieben, ConDeS GmbH
   */
  /** 
    Procedure: log_validation
      See <PIT_MODULE.log_validation>
   */
  overriding member procedure log_validation(
    self in out nocopy pit_apex,
    p_message in message_type),
  /** 
    Procedure: log_exception
      See <PIT_MODULE.log_exception>
   */
  overriding member procedure log_exception(
    self in out nocopy pit_apex,
    p_message in message_type),
  /** 
    Procedure: panic
      See <PIT_MODULE.panic>
   */
  overriding member procedure panic(
    self in out nocopy pit_apex,
    p_message in message_type),
  /** 
    Procedure: log_state
      See <PIT_MODULE.log_state>
   */
  overriding member procedure log_state(
    self in out nocopy pit_apex,
    p_log_state pit_log_state_type),
  /** 
    Procedure: print
      See <PIT_MODULE.print>
   */
  overriding member procedure print(
    self in out nocopy pit_apex,
    p_message in message_type),
  /** 
    Procedure: tweet
      See <PIT_MODULE.tweet>
   */
  overriding member procedure tweet(
    self in out nocopy pit_apex,
    p_message in message_type),
  /**
    Procedure: notify
      See <PIT_MODULE.notify>
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
    p_call_stack in pit_call_stack_type),
  /**
    Procedure: leave
      See <PIT_MODULE.leave>
   */
  overriding member procedure leave (
    self in out nocopy pit_apex,
    p_call_stack in pit_call_stack_type),
    
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
