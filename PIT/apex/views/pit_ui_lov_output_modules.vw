create or replace force view pit_ui_lov_output_modules as
select module_name d, module_name r
  from table(pit.get_modules);