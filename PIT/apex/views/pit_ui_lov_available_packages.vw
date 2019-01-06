create or replace force view pit_ui_lov_available_packages as
select owner || '.' || object_name d, object_name r
  from all_objects
  join all_users on owner = username
 where object_type = 'PACKAGE'
   and oracle_maintained = 'N'
   and username not in ('APEX_LISTENER', 'APEX_REST_PUBLIC_USER');
