create or replace view pit_message_v as
select pms_name, pms_text, pms_pse_id
  from pit_message m
  join pit_message_language_v v
    on m.pms_pml_name = v.pml_name;
    
comment on table pit_message_v is 'PIT_MESSAGE values in the actual session language or default language, if no translation exists';