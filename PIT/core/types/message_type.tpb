create or replace type body message_type
as
  /** Implements the MESSAGE_TYPE functionality */
  
  constructor function message_type(
    self in out nocopy message_type,
    p_message_name in varchar2,
    p_message_language in varchar2,
    p_affected_id in varchar2,
    p_error_code in varchar2,
    p_session_id in varchar2,
    p_schema_name in varchar2,
    p_user_name in varchar2,
    p_msg_args msg_args)
    return self as result
  as
  begin
    self := message_type(
              p_message_name => p_message_name,
              p_message_language => p_message_language,
              p_affected_ids => msg_params(msg_param('ID', p_affected_id)),
              p_error_code => p_error_code,
              p_session_id => p_session_id,
              p_schema_name => p_schema_name,
              p_user_name => p_user_name,
              p_msg_args => p_msg_args);
    self.affected_id := p_affected_id;
    return;
  end;

  /** Contructor method. Auto detects the required language */
  constructor function message_type(
    self in out nocopy message_type,
    p_message_name in varchar2,
    p_message_language in varchar2,
    p_affected_ids in msg_params,
    p_error_code in varchar2,
    p_session_id in varchar2,
    p_schema_name in varchar2,
    p_user_name in varchar2,
    p_msg_args msg_args)
    return self as result
  as
    C_FAILURE constant number := 1;
    l_locale &ORA_NAME_TYPE.;
    l_language &ORA_NAME_TYPE.;
    l_territory &ORA_NAME_TYPE.;
    l_status &FLAG_TYPE.;
    l_error_message varchar2(1000 byte);
    l_json_parameters pit_util.max_char;
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
     
    self.id := pit_drv_log_seq.nextval;
    self.message_name := p_message_name;    
    self.affected_ids := p_affected_ids;
    self.error_code := p_error_code;
    self.session_id := p_session_id;
    self.schema_name := p_schema_name;
    self.user_name := p_user_name;
    self.message_args := p_msg_args;
    
    pit_util.get_module_and_action(self.module, self.action);
    
    if sqlcode != 0 then
      self.message_text := replace(self.message_text, '#SQLERRM#', substr(sqlerrm, 12));
      self.stack := pit_util.get_call_stack;
      self.backtrace := pit_util.get_error_stack;
    end if;

    -- replace anchors with msg params
    if p_msg_args is not null then
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
    
    return;
  end;
end;
/
