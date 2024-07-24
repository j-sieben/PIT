create or replace force view pita_ui_lov_uttm_type as
select distinct uttm_type d, uttm_type r
  from utl_text_templates_v
 order by r;
