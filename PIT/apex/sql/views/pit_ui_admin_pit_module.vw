create or replace view pit_ui_admin_pit_module as
select module_name,
       case module_available when 'Y' then '<i class="fa fa-check"/' else '<i class="fa fa-times"/>' end module_available,
       case module_active when 'Y' then '<i class="fa fa-check"/' else '<i class="fa fa-times"/>' end module_active
  from table(pit.get_modules);