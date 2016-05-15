create or replace type body message_type
as
  constructor function message_type(
    self in out nocopy message_type,
    message_name in varchar2,
    message_language in varchar2,
    affected_id in varchar2,
    session_id in varchar2,
    user_name in varchar2,
    arg_list msg_args)
    return self as result
  as
    cursor message_cur (p_message_name in varchar2) is
      select message_name, message_language, message_text, severity
        from (select session_id,
                     message_text, severity,
                     rank() over (order by l.default_order desc) ranking
                from message m
                join v_message_language l on m.message_language = l.name
               where m.message_name = p_message_name)
       where ranking = 1;
  begin
    for msg in message_cur(message_name) loop
      self.message_name := message_name;
      self.affected_id := affected_id;
      self.session_id := session_id;
      self.user_name := user_name;
      self.message_text := msg.message_text;
      self.severity := msg.severity;
      self.stack := dbms_utility.format_error_stack;
      self.backtrace := dbms_utility.format_error_backtrace;
    end loop;

    -- Platzhalter der Meldung durch Variablen ersetzen
    if arg_list is not null then
      for i in arg_list.first..arg_list.last loop
        self.message_text :=
          replace(self.message_text, '#' || i || '#', arg_list(i));
      end loop;
    end if;
    self.message_text := replace(self.message_text, '#SQLERRM#', sqlerrm);
    return;
  end;
end;
/