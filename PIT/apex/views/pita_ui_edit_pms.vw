create or replace force view pita_ui_edit_pms as
select pms_name,
       pms_pmg_name,
       pms_pml_name,
       pms_text,
       pms_description,
       pms_pse_id,
       case
         when pms_custom_error = -20000 then 'CUSTOM' 
         when pms_custom_error != -20000 then 'ORACLE'
         else 'NONE'
       end pms_error_type,
       pms_custom_error,
       pms_active_error,
       pms_id
  from table(pit_app_api.get_pit_message_table);