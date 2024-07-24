create or replace force view pita_ui_lov_message_language as
select pml_display_name d, 
       pml_name r, 
       case when pml_default_order > 0 then pit_util.C_TRUE else pit_util.C_FALSE end pml_in_use,
       pml_default_order
  from table(pit_app_api.get_pit_message_language_table);
  
comment on table pita_ui_lov_message_language is 'LOV-View for PIT message language, orders by PML_DEFAULT_ORDER';
