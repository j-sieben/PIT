create or replace type pit_module as object(
  fire_threshold integer,
  status &ORA_NAME_TYPE.,
  stack varchar2(2000 byte),
  member procedure context_changed(
    p_ctx in pit_context),
  member procedure context_changed,
  member procedure log(
    p_message in message_type),
  member procedure print(
    p_message in message_type),
  member procedure notify(
    p_message in message_type),
  member procedure enter (
    p_call_stack call_stack_type),
  member procedure leave (
    p_call_stack call_stack_type),
  member procedure purge(
    p_purge_date in date default null,
    p_severity_greater_equal in integer default null)
) not final not instantiable;
/