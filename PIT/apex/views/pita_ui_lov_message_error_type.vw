create or replace view pita_ui_lov_message_error_type as
select case substr(pti_id, 6)
         when 'NONE' then 1
         when 'CUSTOM' then 2
         when 'ORACLE' then 3
         else 4 end pmet_sort_seq,
       substr(pti_id, 6) pmet_id,
       pti_display_name pmet_display_name
  from pit_translatable_item_v
 where pti_pmg_name = 'PITA'
   and pti_id like 'PMET%';
