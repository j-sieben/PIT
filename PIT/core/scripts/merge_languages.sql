prompt &s1.Merge message languages
merge into pit_message_language m
using (select value pml_name, 
              case value 
              when '&DEFAULT_LANGUAGE.' then 10
              else 0 end pml_default_order,
              case value when 'GERMAN' then 'Deutsch'
              else initcap(value) end pml_display_name
         from v$nls_valid_values
        where parameter = 'LANGUAGE') v
   on (m.pml_name = v.pml_name)
 when not matched then insert (pml_name, pml_display_name, pml_default_order)
      values (v.pml_name, v.pml_display_name, v.pml_default_order);

commit;