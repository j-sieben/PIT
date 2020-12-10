create or replace type pit_default_adapter as object(
  /** Adapter code to be injected into the PIT installation. Detects session id and username */
  environment &ORA_NAME_TYPE.,
  status &FLAG_TYPE.,
  
  /** Method to retrieve the session details
   * %param  p_user_name         OUT parameter containing the user name  (CLIENT_IDENTIFIER)
   * %param  p_session_id        OUT parameter containing the session id (SID)
   * %param  p_required_context  OUT parameter indicating whether PIT should change context. Not used here
   * %usage  Method retrieves session related information. This adapter is used as a fallback solution
   *         if no other adapter is provided. It defaults to CLIENT_IDENTIFIER, SID and no required context
   */
  member procedure get_session_details(
    self in out nocopy pit_default_adapter,
    p_user_name out nocopy varchar2,
    p_session_id out nocopy varchar2,
    p_required_context out nocopy varchar2),
  
  /** Constructor method. Sets ENVIRONMENT to DEFAULT and STATUS to TRUE */
  constructor function pit_default_adapter(
    self in out nocopy pit_default_adapter)
    return self as result
) not final;
/
