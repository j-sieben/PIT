alter session set current_schema=sys;

declare
  l_workspace_id number;
  l_application_id number;
begin
  select workspace_id 
    into l_workspace_id
    from apex_workspaces
   where workspace = '&APEX_WS.';
    
  begin
    select application_id
      into l_application_id
      from apex_applications
     where alias = 'PIT_ADMIN';
    apex_application_install.set_application_id(l_application_id);
  exception
    when NO_DATA_FOUND then
      apex_application_install.generate_application_id;
  end;
  
  --apex_application_install.set_application_id(103);
  apex_application_install.set_workspace_id(l_workspace_id);
  apex_application_install.generate_offset;
  apex_application_install.set_schema( '&INSTALL_USER.' );
exception 
  when no_data_found then 
    dbms_output.put_line('No workspace found named &APEX_WS.');
    raise;
end;
/