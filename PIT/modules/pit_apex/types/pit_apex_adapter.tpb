create or replace type body pit_apex_adapter
as

  /** Implements the adapter functionality for the APEX environment */

  overriding member procedure get_session_details(
    p_user_name out varchar2,
    p_session_id out varchar2,
    p_required_context out nocopy varchar2)
  as
  begin
    p_user_name := apex_application.g_user;
    p_session_id := apex_application.g_instance; 
    -- If APEX is set to logging, adjust context to predefined log settings defined in PIT_APEX params
    p_required_context := pit_apex_pkg.get_apex_triggered_context;
  end get_session_details;
   
   
  constructor function pit_apex_adapter(
    self in out nocopy pit_apex_adapter)
    return self as result
  as
  begin
    if apex_application.get_session_id is not null then
      self.environment := 'APEX';
      $IF dbms_db_version.ver_le_19 $THEN
      self.status := pit_util.C_TRUE;
      $ELSIF dbms_db_version.ver_le_21 $THEN
      self.status := pit_util.C_TRUE;
      $ELSE
      self.status := true;
      $END
    else
      $IF dbms_db_version.ver_le_19 $THEN
      self.status := pit_util.C_FALSE;
      $ELSIF dbms_db_version.ver_le_21 $THEN
      self.status := pit_util.C_FALSE;
      $ELSE
      self.status := false;
      $END
    end if;
    return;
  end pit_apex_adapter;
end;
/
