create or replace view pit_message_v as
with deflt as (
       select pms_name, pms_pml_name, pms_pmg_name, pms_text, pms_description, pms_pse_id, 
              pms_active_error
         from pit_message
        where pms_id is not null),
     trans as (
       select pms_name, pms_pml_name, pms_text, pms_description
         from pit_message
         join pit_message_language_v
           on pms_pml_name = pml_name
        where pml_rank = 1)
select d.pms_name,
       d.pms_pmg_name,
       coalesce(t.pms_pml_name, d.pms_pml_name) pms_pml_name, 
       coalesce(t.pms_text, d.pms_text) pms_text, 
       coalesce(t.pms_description, d.pms_description) pms_description, 
       d.pms_pse_id,
       d.pms_active_error
  from deflt d
  left join trans t
    on d.pms_name = t.pms_name;
    
comment on table pit_message_v is 'PIT_MESSAGE values in the actual session language or default language, if no translation exists';