create or replace  type pit_mail under pit_module(
  
   
  /** 
    Package: Output Modules.PIT_MAIL.PIT_MAIL
      Output module to send debug messages per mail. Extends <PIT_MODULE>.
   
    Author::
      Juergen Sieben, ConDeS GmbH
   */
  
  /** 
    Procedure: log
      See <PIT_MODULE.log>
   */
  overriding member procedure log(
    self in out nocopy pit_mail,
    p_message in message_type),
  
  /** 
    Procedure: purge
      See <PIT_MODULE.purge>
   */
  overriding member procedure purge(
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
