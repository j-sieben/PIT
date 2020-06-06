create or replace force view pit_ui_lov_message_language as
select pml_display_name d, 
       pml_name r, 
       case when pml_default_order > 0 then 'Y' else 'N' end pml_in_use,
       pml_default_order
  from pit_message_language;
