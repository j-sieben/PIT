create or replace force view pit_ui_lov_parameter_type as
select pat_description d, pat_id r
  from parameter_type
 order by r;
