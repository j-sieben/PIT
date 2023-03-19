create or replace force view pita_ui_lov_uttm_type as
select distinct column_value d, column_value r
  from table(utl_text_admin.get_template_types)
 order by r;
