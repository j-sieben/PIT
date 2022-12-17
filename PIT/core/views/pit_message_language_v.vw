
/**
  View: pit_message_language_v
    View to present all message languages available.
    
  Fields:
    pml_name - Name of the message language
    pml_default_order - Order of the message language
    pml_rank - Ranking information of the langauges
 */
create or replace view pit_message_language_v as
with data as(
       select pml_name, pml_display_name, pml_default_order
         from pit_message_language
        where case when pml_default_order > 0 then pml_default_order else 1 end > 0
       union all
       select pml_name, pml_display_name, 100
         from pit_message_language
        where pml_name = substr(sys_context('USERENV', 'LANGUAGE'), 1, instr(sys_context('USERENV', 'LANGUAGE'), '_') -1))
select pml_name, pml_display_name, pml_default_order, rank() over (order by pml_default_order desc) pml_rank
  from data;
    
comment on table pit_message_language_v is 'PIT_MESSAGE_LANGUAGE values with all available translations and default language';