create or replace  type pit_mail under pit_module(
  
  /** Output module to send debug messages per mail */
  
  /** Method to send messages with a severity higher than the PIT_MAIL fire threshold per mail
   * %usage  The implementation ignores anything including than or milder than LEVE_WARNING.
   *         Fatal messages get sent by mail directly, whereas errors will be persisted in a table
   *         to be sent to the administrator based on a database job
   */
  overriding member procedure log(
    self in out nocopy pit_mail,
    p_message in message_type),

  /** Method to purge any unsent messages from the mail queue */
  overriding member procedure purge(
    self in out nocopy pit_mail,
    p_purge_date in date,
    p_severity_greater_equal in integer default null),

  /** Constructor function. If the mail server is unreachable, it renders the module unusable */
  constructor function pit_mail (
    self in out nocopy pit_mail)
    return self as result)
  final instantiable;
/
