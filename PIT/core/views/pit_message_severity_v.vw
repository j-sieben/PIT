create or replace view pit_message_severity_v as
select pse_id, pse_name, pti_display_name pse_display_name, pti_description pse_description, pse_requires_exception
  from pit_message_severity
  join pit_translatable_item_v
    on pse_pti_id = pti_id;
    
comment on table pit_message_severity_v is 'PIT_MESSAGE_SEVERITY values with translated name, display_name and description';