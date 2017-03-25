begin
   pit_admin.merge_message('PIT_TEST', 'GERMAN: #1#', 30, 'GERMAN', null);
   pit_admin.create_message_package;
  commit;
  
  pit_admin.create_message_package;
end;
/


