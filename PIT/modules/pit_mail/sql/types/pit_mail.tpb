create or replace  type body pit_mail
as
  overriding member procedure log(
    p_message in message_type)
  as
  begin
    if p_message.severity <= fire_threshold then
      pit_mail_pkg.log(p_message);
    end if;
  end log;

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
