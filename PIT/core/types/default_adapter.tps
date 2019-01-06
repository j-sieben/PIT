create or replace type default_adapter as object(
   environment &ORA_NAME_TYPE.,
   status &FLAG_TYPE.,
   member procedure get_session_details(
      self in out nocopy default_adapter,
      p_user_name out nocopy varchar2,
      p_session_id out nocopy varchar2),
   constructor function default_adapter(
      self in out nocopy default_adapter)
      return self as result
) not final;
/
