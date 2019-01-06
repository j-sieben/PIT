create or replace view pit_translatable_item_v as
select pti_pmg_name, pti_id, pti_name, pti_display_name, pti_description
  from (select pti_pmg_name, pti_id, pti_name, pti_display_name, pti_description,
               rank() over (order by pml_default_order desc) ranking
          from pit_translatable_item
          join pit_message_language
            on pti_pml_name = pml_name
         where -- try to find available translation or fallback to default language
               pml_name = substr(sys_context('USERENV', 'LANGUAGE'), 1, instr(sys_context('USERENV', 'LANGUAGE'), '_') -1)
            or pml_default_order = 10)
 where ranking = 1;