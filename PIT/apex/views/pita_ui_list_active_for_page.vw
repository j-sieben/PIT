create or replace force view pita_ui_list_active_for_page as
   with params as (
        select /* no_merge */
               utl_apex.get_page_id page_id,
               utl_apex.get_application_id application_id
          from dual)
 select page_group
   from apex_application_pages a
natural join params p;
