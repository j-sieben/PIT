create or replace force view pita_ui_lov_parameter_type as
select pat_description d, pat_id r
  from table(pit_app_api.get_parameter_type_table)
 order by r;
