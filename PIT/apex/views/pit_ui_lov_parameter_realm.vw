create or replace force view pit_ui_lov_parameter_realm as
select pre_id || ' (' || pre_description || ')' d, pre_id r, pre_is_active
  from parameter_realm
 order by r;

comment on table pit_ui_lov_parameter_realm is 'LOV view for table PARAMETER_REALM';