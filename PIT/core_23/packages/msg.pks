/**
  Package: MSG
    Auto generated package holding constants for any PIT message.
    
    This package is generated each time you create a message using the UI application
    or if you call <PIT_ADMIN.create_message_package> explicitly.
    
  Attention:
    Don't edit this package manually, as any manual change will be overwritten
    next time you re-create it.
 */
begin
   -- for security reasons, make sure that package pit_admin is valid
   execute immediate 'alter package pit_admin compile';
   execute immediate 'alter package pit_admin compile body';
   
   pit_admin.create_message_package;
end;
/
