create or replace force view pita_ui_lov_message_severity as
select pse_display_name d, pse_id r
  from table(pit_app_api.get_pit_message_severity_table)
 order by pse_id;
