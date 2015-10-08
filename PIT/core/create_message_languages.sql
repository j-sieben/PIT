
merge into message_language m
using (select value name, 
              case value 
              when 'GERMAN' then 50 
              when 'AMERICAN' then 10
              else 0 end default_order
         from v$nls_valid_values
        where parameter = 'LANGUAGE') v
   on (m.name = v.name)
 when not matched then insert (name, default_order)
      values (v.name, v.default_order);

commit;
