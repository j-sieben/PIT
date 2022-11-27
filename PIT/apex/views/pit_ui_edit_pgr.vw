create or replace view pit_ui_edit_pgr as
select pgr_id, pgr_description, pgr_is_modifiable, coalesce(par_amount, 0) par_amount,
       case when par_pgr_id is not null then 'U' else 'UD' end allowed_operations
  from parameter_group
  left join (
       select par_pgr_id, count(*) par_amount
         from parameter_tab
        group by par_pgr_id)
    on pgr_id = par_pgr_id;
