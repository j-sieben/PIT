create or replace force view pit_ui_admin_par_realm as
select pre_id || ' (' || pre_description || ')' par_string_value
  from parameter_realm
  join parameter_vw
    on pre_id = to_char(par_string_value)
 where par_id = 'REALM' 
   and par_pgr_id = 'PIT';
 
 
comment on table pit_ui_admin_par is 'View to show the actually selected REALM';