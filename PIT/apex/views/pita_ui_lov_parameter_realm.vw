create or replace force view pita_ui_lov_parameter_realm as
select pre_id || ' (' || pre_description || ')' d, pre_id r, pre_is_active
  from table(pit_app_api.get_parameter_realm_table)
 order by r;

comment on table pita_ui_lov_parameter_realm is 'LOV view for table PARAMETER_REALM';