create or replace force view pita_ui_lov_parameter_group as
select pgr_id || ' (' || pgr_description || ')' d, pgr_id r
  from table(pit_app_api.get_parameter_group_table)
 order by r;
