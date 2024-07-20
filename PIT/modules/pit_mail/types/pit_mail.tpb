create or replace  type body pit_mail
as

  /** Implementation of output module PIT_MAIL */
  
  
  overriding member procedure log_exception(
    self in out nocopy pit_mail,
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
      pit_mail_pkg.log_exception(p_message);
    end if;
  end log_exception;
  
  
  overriding member procedure panic(
    self in out nocopy pit_mail,
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
      pit_mail_pkg.panic(p_message);
    end if;
  end panic;
  
  
  overriding member procedure purge_log(
    self in out nocopy pit_mail,
    p_purge_date in date,
    p_severity_greater_equal in integer default null)
  as
  begin
    pit_mail_pkg.purge_log(p_purge_date, p_severity_greater_equal);
  end purge_log;
  
  
  constructor function pit_mail (
    self in out nocopy pit_mail)
    return self as result
  as
  begin
    pit_mail_pkg.initialize_module(self);
    return;
  end pit_mail;
end;
/
