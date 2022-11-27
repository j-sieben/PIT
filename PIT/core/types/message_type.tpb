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
    p_msg_args msg_args)
    return self as result
  as
    C_FAILURE constant number := 1;
    l_locale varchar2(100 byte);
    l_language varchar2(100 byte);
    l_territory varchar2(100 byte);
    l_status number(1, 0);
    l_error_message varchar2(1000 byte);
    l_json_parameters varchar2(32767 byte);
    -- Cursor to detect replacement anchors and separate their inner structure
    cursor anchor_cur(p_message_text in varchar2) is
      with regex as(
             select '#' anchor_char,
                    '|' anchor_separator,
                    '\#[A-Z0-9].*?\#' anchor_regex,
                    '[^\|]+' anchor_name_regex,
                    '(.*?)(\||$)' anchor_part_regex,
                    q'^[0-9]+$^' valid_anchor_regex
               from dual),
           anchors as (
              select trim(anchor_char from regexp_substr(p_message_text, anchor_regex, 1, level)) replacement_string,
                     anchor_char, anchor_name_regex, anchor_part_regex, valid_anchor_regex
                from regex
             connect by level <= regexp_count(p_message_text, anchor_char) / 2),
           parts as(
             select anchor_char || replacement_string || anchor_char as replacement_string,
                    upper(regexp_substr(replacement_string, anchor_name_regex, 1, 1)) anchor,
                    regexp_substr(replacement_string, anchor_part_regex, 1, 2, null, 1) prefix,
                    regexp_substr(replacement_string, anchor_part_regex, 1, 3, null, 1) postfix,
                    regexp_substr(replacement_string, anchor_part_regex, 1, 4, null, 1) null_value,
                    valid_anchor_regex
               from anchors)
      select replacement_string, anchor, prefix, postfix, null_value,
             case when regexp_instr(anchor, valid_anchor_regex) > 0 then 1 else 0 end valid_anchor_name
        from parts
       where anchor is not null;
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
    self.message_args := p_msg_args;
    
    if sqlcode != 0 then
      self.message_text := replace(self.message_text, '#SQLERRM#', substr(sqlerrm, 12));
      self.stack := pit_util.get_call_stack;
      self.backtrace := pit_util.get_error_stack;
    end if;

    -- replace anchors with msg params
    if p_msg_args is not null then
      if upper(p_msg_args(1)) = 'FORMAT_ICU' then
        l_language := sys_context('USERENV', 'LANGUAGE');
        l_territory := substr(l_language, instr(l_language, '_') + 1, instr(l_language, '.') - instr(l_language, '_') - 1);
        l_language := substr(l_language, 1, instr(l_language, '_') -1);
        l_locale := utl_i18n.map_locale_to_iso(l_language, l_territory);
        if p_msg_args.count = 2 then
          l_json_parameters := p_msg_args(2);
        else
          l_json_parameters := '{';
          for i in 2 .. p_msg_args.count loop
            if mod(i, 2) = 0 then
              if i > 2 then
                l_json_parameters := l_json_parameters || ',';
              end if;
              l_json_parameters := l_json_parameters || '"' || p_msg_args(i) || '":"' || p_msg_args(i+1) || '"';
            end if;
          end loop;
          l_json_parameters := l_json_parameters || '}';
        end if;
        self.message_text := message_type.format_icu(self.message_text, l_json_parameters, l_locale, l_status, l_error_message);
        if l_status = C_FAILURE then
            raise_application_error(-20000, l_error_message);
        end if;
      else
        for a in anchor_cur(self.message_text) loop
          if a.valid_anchor_name = 1 then
            if p_msg_args.count >= a.anchor then
              if p_msg_args(a.anchor) is not null then
                self.message_text := replace(self.message_text, a.replacement_string, a.prefix || p_msg_args(a.anchor) || a.postfix);
              else
                self.message_text := replace(self.message_text, a.replacement_string, a.null_value);
              end if;
            end if;
          end if;
        end loop;
      end if;
    end if;
    
    return;
  end;
end;
/
