create or replace force view pita_ui_lov_message_group as
select pmg.pmg_description d, pmg.pmg_name r, coalesce(m.has_message, 0) has_message, coalesce(t.has_translatable_item, 0) has_translatable_item
  from table(pit_app_api.get_pit_message_group_table) pmg
  left join (
       select pmg_name, count(*) has_message
         from table(pit_app_api.get_pit_message_group_table)
        where exists(
              select null
                from table(pit_app_api.get_pit_message_table) pms
               where pms_pmg_name = pmg_name)
        group by pmg_name) m
    on pmg.pmg_name = m.pmg_name
  left join (
       select pmg_name, count(*) has_translatable_item
         from table(pit_app_api.get_pit_message_group_table)
        where exists(
              select null
                from pit_translatable_item_v pti
               where pti_pmg_name = pmg_name)
        group by pmg_name) t
    on pmg.pmg_name = t.pmg_name;


comment on table pita_ui_lov_message_group is 'LOV-View for PIT message groups';