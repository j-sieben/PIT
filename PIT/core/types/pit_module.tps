create or replace type pit_module as object(
  fire_threshold integer,
  status &ORA_NAME_TYPE.,
  stack varchar2(2000 byte),
  member procedure context_changed(
    self in out nocopy pit_module,
    p_ctx in pit_context),
  member procedure log(
    self in out nocopy pit_module,
    p_message in message_type),
  member procedure log(
    self in out nocopy pit_module,
    p_params in msg_params),
  member procedure print(
    self in out nocopy pit_module,
    p_message in message_type),
  member procedure notify(
    self in out nocopy pit_module,
    p_message in message_type),
  member procedure enter(
    self in out nocopy pit_module,
    p_call_stack call_stack_type),
  member procedure leave (
    self in out nocopy pit_module,
    p_call_stack call_stack_type),
  member procedure purge(
    self in out nocopy pit_module,
    p_purge_date in date default null,
    p_severity_greater_equal in integer default null)
) not final not instantiable;
/