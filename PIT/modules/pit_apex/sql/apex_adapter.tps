create or replace type apex_adapter under default_adapter(
   overriding member procedure get_session_details(
      p_user_name out varchar2,
      p_session_id out varchar2),
   constructor function apex_adapter(
      self in out nocopy apex_adapter)
      return self as result
);
/
