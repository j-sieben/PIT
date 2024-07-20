create or replace  type pit_mail under pit_module(
  
   
  /** 
    Package: Output Modules.PIT_MAIL.PIT_MAIL
      Output module to send debug messages per mail. Extends <PIT_MODULE>.
   
    Author::
      Juergen Sieben, ConDeS GmbH
   */
  
  /** 
    Procedure: log_exception
      See <PIT_MODULE.log_exception>
   */
  overriding member procedure log_exception(
    self in out nocopy pit_mail,
    p_message in message_type),
    
  /** 
    Procedure: panic
      See <PIT_MODULE.panic>
   */
  overriding member procedure panic(
    self in out nocopy pit_mail,
    p_message in message_type),
    
  /** 
    Procedure: purge_log
      See <PIT_MODULE.purge_log>
   */
  overriding member procedure purge_log(
    self in out nocopy pit_mail,
    p_purge_date in date,
    p_severity_greater_equal in integer default null),
    
  /** 
    Procedure: pit_mail
      Contructor function to instantiate the output module. Marks the module available only if the mail server can be reached.
   */
  constructor function pit_mail (
    self in out nocopy pit_mail)
    return self as result)
  final instantiable;
/
