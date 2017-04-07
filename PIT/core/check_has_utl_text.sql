column script new_value SCRIPT

select nvl2(object_name, 'null.sql', '&1.') script
  from dual
  left join
       (select object_name
          from all_objects
         where owner = '&INSTALL_USER.'
           and object_type = 'PACKAGE'
           and object_name = 'UTL_TEXT')
    on null is null;

@&script.

