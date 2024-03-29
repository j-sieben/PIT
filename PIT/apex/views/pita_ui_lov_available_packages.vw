create or replace force view pita_ui_lov_available_packages as
select o.owner || '.' || o.object_name d, o.object_name r
  from all_objects o
  join all_users u 
    on o.owner = u.username
 where o.object_type = 'PACKAGE'
   and u.oracle_maintained = 'N'
   and u.username not in ('APEX_LISTENER', 'APEX_REST_PUBLIC_USER');
