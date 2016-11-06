create or replace view pit_ui_admin_message_main as
  with message_raw as(
       select distinct pms.rowid row_id, pms_name, pms_pml_name, pms_pse_id, pms_custom_error, dbms_lob.substr(pms_text, 4000, 1) pms_text, src.name pms_used_at,
              case when src.name like 'PIT%' or src.name in ('UTL_CONTEXT', 'PARAM', 'PARAM_ADMIN') then 'Y' else null end pms_is_system_message
         from pit_message pms
         join user_source src
           on instr(upper(text), pms_name) > 0),
       messages as (
       select row_id, pms_name, pms_pml_name, pms_pse_id, pms_custom_error, pms_text, 
              listagg(pms_is_system_message) within group (order by pms_is_system_message) pms_is_system_message,
              listagg(pms_used_at, ', ') within group (order by pms_used_at) pms_used_at
         from message_raw
        group by row_id, pms_name, pms_pml_name, pms_pse_id, pms_custom_error, pms_text)
select row_id, 
       pms_name,
       pml_display_name,
       pms_text, 
       pse_display_name,
       pms_custom_error,
       case when pms_is_system_message is not null then 'Y' else 'N' end pms_is_system_message,
       replace(replace(replace(pms_used_at, ', MSG'), 'MSG, '), 'MSG') pms_used_at
  from messages pms
  join pit_message_language pml
    on pms.pms_pml_name = pml.pml_name
  join pit_message_severity pse
    on pms.pms_pse_id = pse.pse_id;
