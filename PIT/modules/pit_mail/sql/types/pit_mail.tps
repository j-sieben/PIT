create or replace  type pit_mail under pit_module(
  overriding member procedure log(
    p_message in message_type),
  constructor function pit_mail (
    self in out nocopy pit_mail)
    return self as result)
  final instantiable;
/
