create or replace force view pit_ui_list_active_for_page as
   with params as (
        select v('APP_PAGE_ID') page_id,
                v('APP_ID') application_id
          from dual)
 select /* NO_MERGE (p)*/ page_group
   from apex_application_pages a
natural join params p;
