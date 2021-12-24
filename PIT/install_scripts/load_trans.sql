/*
  Script to install PIT
  Usage:
  Call this script directly with the required parameters.
  
  Parameters:
  - LANGUAGE: Oracle language name of the language to install.
*/

@init/init.sql &1.

prompt
prompt &section.
prompt &h1.PIT language translation &DEFAULT_LANGUAGE. at user &PIT_USER.

prompt &s1.Register translation
begin
  pit_admin.register_translation('&DEFAULT_LANGUAGE.');
end;
/

prompt &s1.Messages
@core/messages/&DEFAULT_LANGUAGE./MessageGroup_PIT.sql
@modules/pit_apex/messages/&DEFAULT_LANGUAGE./MessageGroup_PIT.sql
--@modules/pit_aq/messages/&DEFAULT_LANGUAGE./MessageGroup_PIT.sql
@modules/pit_mail/messages/&DEFAULT_LANGUAGE./MessageGroup_PIT.sql
--@modules/pit_test/messages/&DEFAULT_LANGUAGE./MessageGroup_PIT.sql

prompt &s1.Translatable Items
@core/messages/&DEFAULT_LANGUAGE./TranslatableItemGroup_PIT.sql

prompt
prompt &section.
prompt &h1.Finished PIT translation

commit;

exit