create or replace view v_message as
select message_name, message_text, severity
  from message m
  join v_message_language v
    on m.message_language = v.name;