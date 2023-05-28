
/**
  View: pit_message_language_v
    View to present all message languages available.
    
  Fields:
    pml_name - Name of the message language
    pml_default_order - Order of the message language
    pml_rank - Ranking information of the langauges
 */
create or replace view pit_message_language_v as
with available_languages as(
       select pml_name, pml_display_name, pml_default_order
         from pit_message_language),
     session_language as(
       select pml_name, pml_display_name, 100 pml_default_order
         from pit_message_language
        where pml_name = substr(sys_context('USERENV', 'LANGUAGE'), 1, instr(sys_context('USERENV', 'LANGUAGE'), '_') -1))
select a.pml_name, a.pml_display_name, coalesce(a.pml_default_order, s.pml_default_order) pml_default_order, rank() over (order by coalesce(s.pml_default_order, a.pml_default_order) desc) pml_rank
  from available_languages a
  left join session_language s
    on a.pml_name = s.pml_name;
    
comment on table pit_message_language_v is 'PIT_MESSAGE_LANGUAGE values with all available translations and default language';