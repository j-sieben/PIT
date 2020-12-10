create or replace type pit_module as object(
  /** Abstract output module for PIT. */
  fire_threshold integer,
  status &ORA_NAME_TYPE.,
  stack varchar2(2000 byte),
  /** Method is raised if the context settings have changed */
  member procedure context_changed(
    self in out nocopy pit_module,
    p_ctx in pit_context),
  /** Method is called for debugging, error handling and the like */
  member procedure log(
    self in out nocopy pit_module,
    p_message in message_type),
  /** Overloaded logging method to log the state of variables passed in */
  member procedure log(
    self in out nocopy pit_module,
    p_log_state in log_state_type),
  /** Method to print a message to the target. Is not fenced in by log or trace settings */
  member procedure print(
    self in out nocopy pit_module,
    p_message in message_type),
  /** Method to notify changes. Aimed towards state changes and other leight weight messages */
  member procedure notify(
    self in out nocopy pit_module,
    p_message in message_type),
  /** Method is called if PIT recognizes that the code entered a method */
  member procedure enter(
    self in out nocopy pit_module,
    p_call_stack call_stack_type),
  /** Method is called if PIT recognizes that the code left a method */
  member procedure leave (
    self in out nocopy pit_module,
    p_call_stack call_stack_type),
  /** Method is called to purge a message stack. Useful for output modules persisting messages */
  member procedure purge(
    self in out nocopy pit_module,
    p_purge_date in date default null,
    p_severity_greater_equal in integer default null)
) not final not instantiable;
/