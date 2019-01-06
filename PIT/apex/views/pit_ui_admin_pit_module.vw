create or replace force view pit_ui_admin_pit_module as
select module_name,
       case module_available when &C_TRUE. then 'fa-check' else 'fa-times' end module_available,
       case module_active when &C_TRUE. then 'fa-check' else 'fa-times' end module_active
  from table(pit.get_modules);