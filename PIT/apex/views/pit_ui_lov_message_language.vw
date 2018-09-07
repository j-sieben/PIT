create or replace force view pit_ui_lov_message_language as
select pml.pml_display_name d, 
       pml.pml_name r, 
       case when pms.pml_name is not null then 'Y' else 'N' end pml_in_use,
       pml.pml_default_order
  from pit_message_language pml
  left join (
       select pml_name 
         from pit_message_language
        where pml_default_order > 0) pms
    on pml.pml_name = pms.pml_name;
