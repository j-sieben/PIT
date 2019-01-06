create or replace type body apex_adapter
as
   overriding member procedure get_session_details(
      p_user_name out varchar2,
      p_session_id out varchar2)
   as
      l_id varchar2(64 byte) := sys_context('USERENV', 'CLIENT_IDENTIFIER');
   begin
      p_user_name := substr(l_id, 1, instr(l_id, ':') - 1);
      p_session_id := substr(l_id, instr(l_id, ':') + 1);
      -- If APEX is set to logging, adjust context to predefined log settings defined in PIT_APEX params
      pit_apex_pkg.set_apex_triggered_context;
   end get_session_details;
   
   constructor function apex_adapter(
      self in out nocopy apex_adapter)
      return self as result
   as
   begin
      if apex_application.get_session_id is not null then
         self.environment := 'APEX';
      else
         self.status := &C_FALSE.;
      end if;
      return;
   end apex_adapter;
end;
/
