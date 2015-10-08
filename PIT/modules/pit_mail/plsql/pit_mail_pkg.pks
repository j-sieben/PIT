create or replace package pit_mail_pkg
as
  /* Implementation package for type PIT_MAIL */
  
  
  procedure log (
    p_message in message_type);
  
  procedure initialize_module(
    self in out pit_mail);
  
end pit_mail_pkg;
/
