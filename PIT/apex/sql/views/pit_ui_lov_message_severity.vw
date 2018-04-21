create or replace view pit_ui_lov_message_severity as
select pse_display_name d, pse_id r
  from dl_pit_message_severity
 order by pse_id;
