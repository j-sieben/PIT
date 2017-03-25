column script new_value SCRIPT
select case when object_name is null 
            then '&1.' 
            else 'null.sql' end script
  from all_objects
 where owner = '&INSTALL_USER.'
   and object_type = 'PACKAGE'
   and object_name = 'UTL_TEXT'
 group by case when object_name is null 
            then '&1.' 
            else 'null.sql' end;
  
@&script.