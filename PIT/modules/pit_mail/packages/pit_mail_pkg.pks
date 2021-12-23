create or replace package pit_mail_pkg
  authid definer
as

  /**
    Package: Output Modules.PIT_MAIL.PIT_MAIL_PKG
      Implementation package for type <PIT_MAIL>
      
      Notify functionality is based on the work of Daniel Hochleitner
      <On Github: https://github.com/Dani3lSun/apex-websocket-notify-bundle>
   
    Author::
      Juergen Sieben, ConDeS GmbH
   */
  
  /** 
    Procedure: send_daily
      Method sends messages of severity greater than LEVEL_FATAL on a daily basis.
      
      This method is called by a schedule to send all messages of severity <LEVEL_ERROR>
      as a daily report. This is a demo method, you may add similar methods for 
      different schedules easily by copying this method.
   */
  procedure send_daily;
    
  /** 
    Procedure: log
      Method to send log information per mail.
  
      The implementation ignores anything including than or milder than <EVEL_WARNING>.
      Fatal messages get sent by mail directly, whereas errors will be persisted 
      in a table to be sent to the administrator based on a database job.
      
    Parameters:
      p_message - Instance of <MESSAGE_TYPE>
   */
  procedure log (
    p_message in message_type);
  
  
  /**
    Procedure: purge
      Method to purge log information from table <PIT_MAIL_QUEUE> 
      according to the filter set by <P_DATE_UNTIL> and <P_SEVERITY_GREATER_EQUAL>.
      
    Parameters:
      p_date_until - Date up to which the log entries are to be deleted
      p_severity_greater_equal - Optional severity up to which the log entries are to be deleted
   */
  procedure purge(
    p_date_until in date,
    p_severity_greater_equal in number default null);

  
  /**
    Procedure: initialize
      Implements the parameterless constructor method for <PIT_MAIL> output module.
   */
  procedure initialize_module(
    self in out pit_mail);
  
end pit_mail_pkg;
/
