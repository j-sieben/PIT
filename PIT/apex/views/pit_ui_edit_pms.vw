create or replace view pit_ui_edit_pms as
select pms_name,
       pms_pmg_name,
       pms_pml_name,
       pms_text,
       pms_description,
       pms_pse_id,
       pms_custom_error,
       pms_active_error,
       pms_id
  from pit_message;