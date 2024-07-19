prompt &s1.Merge message languages
merge into pit_message_language t
using (select value pml_name, 
              case value 
              when '&DEFAULT_LANGUAGE.' then 10
              else 0 end pml_default_order,
              case value when 'GERMAN' then 'Deutsch'
              else initcap(value) end pml_display_name
         from v$nls_valid_values
        where parameter = 'LANGUAGE') s
   on (t.pml_name = s.pml_name)
 when matched then update set
      t.pml_default_order = s.pml_default_order,
      t.pml_display_name = s.pml_display_name
 when not matched then insert (pml_name, pml_display_name, pml_default_order)
      values (s.pml_name, s.pml_display_name, s.pml_default_order);

commit;