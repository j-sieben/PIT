create or replace force view pita_ui_edit_pgr as
select pgr_id, pgr_description, pgr_is_modifiable, coalesce(par_amount, 0) par_amount,
       case when par_pgr_id is not null then 'U' else 'UD' end allowed_operations
  from table(pit_app_api.get_parameter_group_table)
  left join (
       select par_pgr_id, count(*) par_amount
         from table(pit_app_api.get_parameter_table)
        group by par_pgr_id)
    on pgr_id = par_pgr_id;
