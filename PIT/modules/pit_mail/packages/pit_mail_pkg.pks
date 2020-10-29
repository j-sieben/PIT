create or replace package pit_mail_pkg
as
  
  /** Implementation package for type PIT_MAIL */
  
  /** Method sends messages of severity greater than LEVEL_FATAL on a daily basis
   * %usage  This method is called by a schedule to send all messages of severity LEVEL_ERROR
   *         as a daily report. This is a demo method, you may add similar methods for
   *         different schedules easily by copying this method.
   */
  procedure send_daily;
  
    
  /** Method to send log information per mail
   * %param  p_message Instance of MESSAGE_TYPE
   * %usage  Method implements the LOG member procedure of type PIT_MAIL and
   *         writes the message attributes to the console.
   */
  procedure log (
    p_message in message_type);
  
  
  /** Method to purge log information from table PIT_MAIL_QUEUE
   * %param  p_date_until              Date up to which the log entries are to be deleted
   * %param [p_severity_greater_equal] Severity up to which the log entries are to be deleted
   * %usage  Method implements the PURGE member procedure of type PIT_MAIL and
   *         removes entries from the table according to the filter set by P_DATE_UNTIL and P_SEVERITY_GREATER_EQUAL.
   */
  procedure purge(
    p_date_until in date,
    p_severity_greater_equal in number default null);

  
  /** Initialization method for PIT_MAIL output module
   * %usage  Method implements the parameterless constructor method of PIT_MAIL
   */
  procedure initialize_module(
    self in out pit_mail);
  
end pit_mail_pkg;
/
