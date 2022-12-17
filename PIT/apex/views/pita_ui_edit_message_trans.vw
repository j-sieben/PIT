create or replace force view pita_ui_edit_message_trans as
select pms_name, pms_pml_name, pms_text
  from table(pit_app_api.get_pit_message_table)
 where pms_id is null;