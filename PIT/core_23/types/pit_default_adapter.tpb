create or replace type body pit_default_adapter
as
  /** Implements the default adapter functionality to gather session information */
  
  /** Retrieves APEX session id and logged on user, detects whether APEX is in debug mode or not */
  member procedure get_session_details(
    self in out nocopy pit_default_adapter,
    p_user_name out nocopy varchar2,
    p_session_id out nocopy varchar2,
    p_required_context out nocopy varchar2)
  as
  begin
    p_user_name := user;
    p_session_id := coalesce(sys_context('USERENV', 'PROXY_USER'), sys_context('USERENV', 'CLIENT_IDENTIFIER'));
    p_required_context := null;
    if p_session_id is null then
      p_session_id := to_char(sys_context('USERENV','SID'));
      dbms_session.set_identifier(p_session_id);
    end if;
  end get_session_details;

  /** Costructor method */
  constructor function pit_default_adapter(
    self in out nocopy pit_default_adapter)
    return self as result
  as
  begin
    self.environment := 'DEFAULT';
    self.status := true;
    return;
  end pit_default_adapter;
end;
/
