create or replace view pit_message_v as
select pms_name,
       pms_pmg_name,
       pmst_pml_name pms_pml_name,
       pmst_text pms_text,
       pmst_description pms_description,
       pms_pse_id,
       pms_custom_error,
       pms_active_error
  from pit_message
  join pit_message_text
    on pmst_pms_name = pms_name
  join pit_pmg_language_v
    on pms_pmg_name = ptsc_pmg_name
   and pmst_pml_name = pml_name;
    
comment on table pit_message_v is 'PIT_MESSAGE values in the actual session language or default language, if no translation exists';
