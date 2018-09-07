create or replace force view pit_ui_lov_context as
select par_id d, par_id r
  from parameter_tab
 where par_pgr_id = 'PIT'
   and par_id like 'CONTEXT%';