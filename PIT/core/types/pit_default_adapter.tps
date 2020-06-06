create or replace type pit_default_adapter as object(
   environment &ORA_NAME_TYPE.,
   status &FLAG_TYPE.,
   member procedure get_session_details(
      self in out nocopy pit_default_adapter,
      p_user_name out nocopy varchar2,
      p_session_id out nocopy varchar2,
      p_required_context out nocopy varchar2),
   constructor function pit_default_adapter(
      self in out nocopy pit_default_adapter)
      return self as result
) not final;
/
