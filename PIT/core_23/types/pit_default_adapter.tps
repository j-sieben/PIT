create or replace type pit_default_adapter force as object(
  /** 
    Type: pit_default_adapter
      Adapter code to be injected into the PIT installation. Detects session id and username 
    
    Properties:
      environment - Name indicating which adapter is used to capture informations
      status - Flag to indicate whether the module is ready to be used. If FALSE, it is skipped
   */
  environment &ORA_NAME_TYPE.,
  status boolean,
  
  /**
    Function: get_session_details
      Method to retrieve the session details.
      
      Method retrieves session related information. This adapter is used as a fallback solution
      if no other adapter is provided. It defaults to CLIENT_IDENTIFIER, SID and no required context
      
    Parameters:
      p_user_name - OUT parameter containing the user name  (CLIENT_IDENTIFIER)
      p_session_id - OUT parameter containing the session id (SID)
      p_required_context - OUT parameter indicating whether PIT should change context. Not used here
   */
  member procedure get_session_details(
    self in out nocopy pit_default_adapter,
    p_user_name out nocopy varchar2,
    p_session_id out nocopy varchar2,
    p_required_context out nocopy varchar2),
  
  /** 
    Function: pit_default_adapter
      Constructor method. Sets ENVIRONMENT to DEFAULT and STATUS to TRUE 
   */
  constructor function pit_default_adapter(
    self in out nocopy pit_default_adapter)
    return self as result
) not final;
/
