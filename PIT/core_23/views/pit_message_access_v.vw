create or replace view pit_message_access_v as
select pms_name,
       pms_pmg_name,
       pmst_pml_name pms_pml_name,
       pmst_text pms_text,
       pmst_description pms_description,
       pms_pse_id,
       pmst_pmst_name pms_pmst_name,
       pms_custom_error,
       pms_active_error,
       pms_id
  from pit_message
  join pit_message_text
    on pmst_pms_name = pms_name;

comment on table pit_message_access_v is 'Access view for message administration preserving the former PIT_MESSAGE row structure.';
