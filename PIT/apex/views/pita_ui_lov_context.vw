create or replace force view pita_ui_lov_context as
select par_id d, replace(par_id, 'CONTEXT_') r
  from parameter_tab
 where par_pgr_id = 'PIT'
   and par_id like 'CONTEXT%';
   
comment on table pita_ui_lov_context is 'LOV view to show all existing contexts. Prefix is removed to adhere to conventions in PIT_ADMIN';