create or replace force view pit_ui_lov_uttm_type as
select distinct uttm_type d, uttm_type r
  from utl_text_templates
 where uttm_type != 'INTERNAL'
 order by r;
