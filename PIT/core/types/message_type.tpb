create or replace type body message_type
as
  /** Implements the MESSAGE_TYPE functionality */
  
  /** Contructor method. Auto detects the required language */
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
    l_locale varchar2(100 byte);
    l_language varchar2(100 byte);
    l_territory varchar2(100 byte);
  begin
    select pms_text, pms_description, pms_pse_id, pms_active_error
      into self.message_text, self.message_description, self.severity, self.error_number
      from pit_message_v
     where pms_name = p_message_name;
     
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
      if upper(p_arg_list(1)) = 'FORMAT_ICU' then
        l_language := sys_context('USERENV', 'LANGUAGE');
        l_territory := substr(l_language, instr(l_language, '_') + 1, instr(l_language, '.') - instr(l_language, '_') - 1);
        l_language := substr(l_language, 1, instr(l_language, '_') -1);
        l_locale := utl_i18n.map_locale_to_iso(l_language, l_territory);
        self.message_text := message_type.format_icu(self.message_text, p_arg_list(2), l_locale);
      else
        for i in p_arg_list.first..p_arg_list.last loop
          self.message_text :=
            replace(self.message_text, '#' || i || '#', p_arg_list(i));
        end loop;
      end if;
    end if;
    
    return;
  end;
end;
/
