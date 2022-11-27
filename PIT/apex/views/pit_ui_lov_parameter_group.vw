create or replace force view pit_ui_lov_parameter_group as
select pgr_id || ' (' || pgr_description || ')' d, pgr_id r
  from parameter_group
 order by r;
