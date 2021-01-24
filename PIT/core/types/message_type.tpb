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
    C_FAILURE constant number := 1;
    l_locale varchar2(100 byte);
    l_language varchar2(100 byte);
    l_territory varchar2(100 byte);
    l_status number(1, 0);
    l_error_message varchar2(1000 byte);
    l_json_parameters varchar2(32767 byte);
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
        if p_arg_list.count = 2 then
          l_json_parameters := p_arg_list(2);
        else
          l_json_parameters := '{';
          for i in 2 .. p_arg_list.count loop
            if mod(i, 2) = 0 then
              if i > 2 then
                l_json_parameters := l_json_parameters || ',';
              end if;
              l_json_parameters := l_json_parameters || '"' || p_arg_list(i) || '":"' || p_arg_list(i+1) || '"';
            end if;
          end loop;
          l_json_parameters := l_json_parameters || '}';
        end if;
        self.message_text := message_type.format_icu(self.message_text, l_json_parameters, l_locale, l_status, l_error_message);
        if l_status = C_FAILURE then
            raise_application_error(-20000, l_error_message);
        end if;
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
