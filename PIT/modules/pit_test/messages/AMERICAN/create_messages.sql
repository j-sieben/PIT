begin
   pit_admin.merge_message('PIT_TEST', 'AMERICAN: #1#', 30, 'AMERICAN', null);
   pit_admin.create_message_package;
  commit;
  
  pit_admin.create_message_package;
end;
/


