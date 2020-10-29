create or replace  type pit_mail under pit_module(
  overriding member procedure log(
    self in out nocopy pit_mail,
    p_message in message_type),
  overriding member procedure purge(
    self in out nocopy pit_mail,
    p_purge_date in date,
    p_severity_greater_equal in integer default null),
  constructor function pit_mail (
    self in out nocopy pit_mail)
    return self as result)
  final instantiable;
/
