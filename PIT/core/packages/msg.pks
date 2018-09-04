begin
   -- for security reasons, make sure that package pit_admin is valid
   execute immediate 'alter package pit_admin compile';
   execute immediate 'alter package pit_admin compile body';
   
   pit_admin.create_message_package;
end;
/
