create type pit_apex under pit_module
(
  /** Output module for an APEX environment */
  
  /** Method incorporates any log information into the APEX debug stack */
  overriding member procedure log(
    self in out nocopy pit_apex,
    p_message in message_type),
  /** Method logs state to the APEX debug stack*/
  overriding member procedure log(
    self in out nocopy pit_apex,
    p_log_state log_state_type),
  /** Method writes the message to the http stream. This will incorporate the message text into the response */
  overriding member procedure print(
    self in out nocopy pit_apex,
    p_message in message_type),
  /** Method for light weigt information to the APEX application using WebSocket protocol. Not implemented yet */
  overriding member procedure notify(
    self in out nocopy pit_apex,
    p_message in message_type),
  /** Method includes call stack information into the debug stack from APEX */
  overriding member procedure enter (
    self in out nocopy pit_apex,
    p_call_stack in call_stack_type),
  /** APEX does not trace exiting methods. This method nevertheless creates an entry in the debug stack
      to support showing out parameters with calculated values */
  overriding member procedure leave (
    self in out nocopy pit_apex,
    p_call_stack in call_stack_type),
  /** Constructor method. Detects whether an APEX environment is present. If not, it renders the module unusable */
  constructor function pit_apex(
    self in out nocopy pit_apex) 
    return self as result
)
final instantiable;
/
