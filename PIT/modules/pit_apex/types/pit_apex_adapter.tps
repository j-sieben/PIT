create or replace type pit_apex_adapter under pit_default_adapter(
  overriding member procedure get_session_details(
    p_user_name out varchar2,
    p_session_id out varchar2,
    p_required_context out nocopy varchar2),
  constructor function pit_apex_adapter(
    self in out nocopy pit_apex_adapter)
    return self as result
);
/
