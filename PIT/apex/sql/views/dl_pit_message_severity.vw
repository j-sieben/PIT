create or replace view &APP_USER..dl_pit_message_severity as
select pse_id, pse_name, pse_display_name
  from &INSTALL_USER..pit_message_severity;
