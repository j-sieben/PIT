create or replace type body message_type
as
  constructor function message_type(
    self in out nocopy message_type,
    p_message_name in varchar2,
    p_message_language in varchar2,
    p_affected_id in varchar2,
    p_error_code in varchar2,
    p_session_id in varchar2,
    p_user_name in varchar2,
    p_arg_list msg_args)
    return self as result
  as
  begin
    select pms_text, pms_description, pms_pse_id, error_number
      into self.message_text, self.message_description, self.severity, self.error_number
      from (select pms_pml_name, pms_text, pms_description, pms_pse_id, pms_active_error error_number,
                   rank() over (order by l.pml_default_order desc) ranking
              from pit_message m
              join pit_message_language_v l on m.pms_pml_name = l.pml_name
             where m.pms_name = p_message_name)
     where ranking = 1;
    self.id := pit_log_seq.nextval;
    self.message_name := p_message_name;
    self.affected_id := p_affected_id;
    self.error_code := p_error_code;
    self.session_id := p_session_id;
    self.user_name := p_user_name;
    self.message_args := p_arg_list;
    if sqlcode != 0 then
      self.message_text := replace(self.message_text, '#SQLERRM#', substr(sqlerrm, 11));
      self.stack := pit_util.get_call_stack;
      self.backtrace := pit_util.get_error_stack;
    end if;

    -- replace anchors with msg params
    if p_arg_list is not null then
      for i in p_arg_list.first..p_arg_list.last loop
        self.message_text :=
          replace(self.message_text, '#' || i || '#', p_arg_list(i));
      end loop;
    end if;
    return;
  end;
end;
/