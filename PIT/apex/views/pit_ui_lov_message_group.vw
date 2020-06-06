create or replace force view pit_ui_lov_message_group as
select pmg.pmg_description d, pmg.pmg_name r, coalesce(m.has_message, 0) has_message, coalesce(t.has_translatable_item, 0) has_translatable_item
  from pit_message_group pmg
  left join (
       select pmg_name, count(*) has_message
         from pit_message_group
        where exists(
              select null
                from pit_message pms
               where pms_pmg_name = pmg_name)
        group by pmg_name) m
    on pmg.pmg_name = m.pmg_name
  left join (
       select pmg_name, count(*) has_translatable_item
         from pit_message_group
        where exists(
              select null
                from pit_translatable_item pti
               where pti_pmg_name = pmg_name)
        group by pmg_name) t
    on pmg.pmg_name = t.pmg_name;
