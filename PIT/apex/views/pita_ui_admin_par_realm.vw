create or replace force view pita_ui_admin_par_realm as
select pre_id || ' (' || pre_description || ')' par_string_value
  from table(pit_app_api.get_parameter_realm_table)
  join table(pit_app_api.get_parameter_table)
    on pre_id = to_char(par_string_value)
 where par_id = 'REALM' 
   and par_pgr_id = 'PIT';
 
 
comment on table pita_ui_admin_par is 'View to show the actually selected REALM';