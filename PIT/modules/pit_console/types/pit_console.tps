create or replace type pit_console force under pit_module(
  /** Output module to write to the console */
  
  /** Method logs entries to the console.*/
  overriding member procedure log(
    self in out nocopy pit_console,
    p_message in message_type),
    
  /** Method writes variable state to the console */
  overriding member procedure log(
    self in out nocopy pit_console,
    p_log_state log_state_type),
    
  /** Method writes informational messages to the console */
  overriding member procedure print(
    self in out nocopy pit_console,
    p_message in message_type),
    
  /** Method writes lightweigt notifications to the console */
  overriding member procedure notify(
    self in out nocopy pit_console,
    p_message in message_type),
    
  /** Method writes entering a method to the console, including parameter values */
  overriding member procedure enter(
    self in out nocopy pit_console,
    p_call_stack call_stack_type),
    
  /** Method writes leaving a method to the console, including out parameter values */
  overriding member procedure leave (
    self in out nocopy pit_console,
    p_call_stack call_stack_type),
    
  /** Method logs if a context is changed */
  overriding member procedure context_changed(
    self in out nocopy pit_console,
    p_ctx in pit_context),
    
  /** Constructor function */
  constructor function pit_console (
    self in out nocopy pit_console)
    return self as result)
final instantiable;
/
