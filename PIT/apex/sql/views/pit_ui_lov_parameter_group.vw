create or replace view pit_ui_lov_parameter_group as
select pgr_id || ' (' || pgr_description || ')' d, pgr_id r
  from dl_parameter_group
 order by r;
