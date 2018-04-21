create or replace view &APP_USER..dl_pit_message_language as
select pml_name, pml_display_name, pml_default_order
  from &INSTALL_USER..pit_message_language;
