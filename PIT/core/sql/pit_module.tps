create or replace type pit_module as object(
  fire_threshold number,
  status varchar2(30),
  stack varchar2(2000),
  member procedure context_changed(
    p_ctx in pit_context),
  member procedure context_changed,
  member procedure log(
    p_message in message_type),
  member procedure print(
    p_message in message_type),
  member procedure enter (
    p_call_stack call_stack_type),
  member procedure leave (
    p_call_stack call_stack_type),
  member procedure purge(
    p_purge_date in date default null)
) not final not instantiable;
/