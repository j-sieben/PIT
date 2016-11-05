create or replace view pit_ui_lov_available_packages as
select owner || '.' || object_name d, object_name r
  from all_objects
 where object_type = 'PACKAGE'
   and owner not in ('SYS', 'XDB', 'DBSNMP', 'ORACLE_OCM', 'GSMADMIN_INTERNAL', 'SYSTEM', 'WMSYS', 'CTXSYS', 'ORDSYS', 'ORDPLUGINS', 'MDSYS', 'LBACSYS', 'DVSYS', 'SBA', 'DVF')
   and owner not like 'APEX%';
