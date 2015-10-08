begin
   pit_admin.merge_message('PIT_TEST', 'AMERICAN #1#', 30, 'AMERICAN', null);
   pit_admin.translate_message('PIT_TEST', 'GERMAN #1#', 'GERMAN');
   pit_admin.create_message_package;
  commit;
end;
/


