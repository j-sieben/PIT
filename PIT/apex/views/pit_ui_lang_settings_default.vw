create or replace force view pit_ui_lang_settings_default as
select 10 pml_id, pml_display_name, pml_name,
       (select listagg(pml_name, ':') within group (order by pml_default_order desc)
          from pit_message_language
         where pml_default_order > 10) pml_list
  from pit_message_language
 where pml_default_order = 10;