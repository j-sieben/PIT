create or replace type default_adapter as object(
   environment varchar2(30),
   status char(1),
   member procedure get_session_details(
      p_user_name out varchar2,
      p_session_id out varchar2),
   constructor function default_adapter(
      self in out nocopy default_adapter)
      return self as result
) not final;
/
