create or replace type pit_apex_adapter under pit_default_adapter(

  /** 
    Package: Output Modules.PIT_APEX.PIT_APEX_ADAPTER
   
    Author::
      Juergen Sieben, ConDeS GmbH
   */
  /**
    Procedure: get_session_details
      Method derives user name and session id from the APEX environment, if available and harmonizes PIT logging with APEX.
      
      This method detects the APEX session id, logged on user and debug status.
      
      - If no APEX environment is present, this method is in unusable state and PIT falls back to the default adapter.
      - If APEX is in debug mode, PIT will switch on debuggin as well. The settings can be controlled by setting
        the respective PIT_APEX_TRG... parameters.
        
    Parameters:
      p_user_name - User actually logged on at the active APEX application
      p_session_id - Session Id of the APEX session
      p_required_context - If APEX is set to debug, this parameter will contain the name of a context as given by 
                           <PIT_APEX_PKG.GET_APEX_TRIGGERED_CONTEXT>.
                           This way, PIT will switch on logging for the actual session if APEX mandates for it.
   */
  overriding member procedure get_session_details(
    p_user_name out varchar2,
    p_session_id out varchar2,
    p_required_context out nocopy varchar2),
    

  /**
    Function: pit_apex_adapter
      Constructor method. It will mark this adapter as valid if an APEX session context is detected and invalid if not.
   */
   constructor function pit_apex_adapter(
    self in out nocopy pit_apex_adapter)
    return self as result
);
/
