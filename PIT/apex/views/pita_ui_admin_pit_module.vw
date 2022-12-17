create or replace force view pita_ui_admin_pit_module as
select module_name module_id, module_name, module_stack,
       case module_available when pit_util.c_true then 'fa-check' else 'fa-times' end module_available,
       case module_active when pit_util.c_true then 'fa-check' else 'fa-times' end module_active
  from table(pit.get_modules);