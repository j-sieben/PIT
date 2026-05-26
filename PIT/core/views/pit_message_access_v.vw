create or replace view pit_message_access_v as
select pms_name,
       pms_pmg_name,
       pmt_pml_name pms_pml_name,
       pms_pse_id,
       pmt_text pms_text,
       pmt_description pms_description,
       pms_custom_error pms_error
  from pit_message
  join pit_message_text
    on pms_name = pmt_pms_name;

comment on table pit_message_access_v is 'Access view for message administration.';
