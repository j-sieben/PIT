create or replace force view pita_ui_edit_pmg as
select pmg_name, pmg_description, pmg_error_prefix, pmg_error_postfix,
       coalesce(pmg_amount, 0) pmg_amount, case when pmg_amount is not null then 'U' else 'UD' end allowed_operations
  from table(pit_app_api.get_pit_message_group_table)
  left join (
       select pms_pmg_name, count(*) pmg_amount
         from table(pit_app_api.get_pit_message_table)
        group by pms_pmg_name)
    on pmg_name = pms_pmg_name;

comment on table pita_ui_edit_pmg is 'UI-View for application page EDIT_PMG';
