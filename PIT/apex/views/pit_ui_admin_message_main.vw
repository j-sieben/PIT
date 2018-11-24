create or replace force view pit_ui_admin_message_main as
  with messages as(
       select pms.rowid row_id, pms_name, pms_pmg_name, pms_pml_name, pms_pse_id, pms_custom_error, dbms_lob.substr(pms_text, 4000, 1) pms_text
         from pit_message pms
         join pit_message_language_v
           on pms_pml_name = pml_name
        where pml_default_order = 10)
select row_id, 
       pms_name,
       pms_pmg_name,
       pml_display_name,
       pms_text, 
       pse_display_name,
       pms_custom_error
  from messages pms
  join pit_message_language pml
    on pms.pms_pml_name = pml.pml_name
  join pit_message_severity pse
    on pms.pms_pse_id = pse.pse_id;
