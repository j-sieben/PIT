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

prompt &s1.Merge message severities
merge into pit_message_severity pse
using (select 10 pse_id, 'LEVEL_OFF' pse_name, 'Logging aus' pse_display_name
         from dual
        union all
       select 20, 'LEVEL_FATAL', 'Fataler Fehler' from dual union all
       select 30, 'LEVEL_ERROR', 'Fehler' from dual union all
       select 40, 'LEVEL_WARN', 'Warnung' from dual union all
       select 50, 'LEVEL_INFO', 'Information' from dual union all
       select 60, 'LEVEL_DEBUG', 'Debug-Meldung' from dual union all
       select 70, 'LEVEL_ALL', 'Alle' from dual) v
   on (pse.pse_id = v.pse_id)
 when matched then update set
      pse_display_name = v.pse_display_name
 when not matched then insert(pse_id, pse_name, pse_display_name)
      values(v.pse_id, v.pse_name, v.pse_display_name);

commit;

prompt &s1.Merge trace levels
merge into pit_trace_level pse
using (select 10 ptl_id, 'TRACE_OFF' ptl_name, 'Tracing aus' ptl_display_name
         from dual
        union all
       select 20, 'TRACE_MANDATORY', 'Verpflichtend' from dual union all
       select 30, 'TRACE_OPTIONAL', 'Optional' from dual union all
       select 40, 'TRACE_DETAILED', 'Detailliert' from dual union all
       select 50, 'TRACE_ALL', 'Alle' from dual) v
   on (pse.ptl_id = v.ptl_id)
 when matched then update set
      ptl_display_name = v.ptl_display_name
 when not matched then insert(ptl_id, ptl_name, ptl_display_name)
      values(v.ptl_id, v.ptl_name, v.ptl_display_name);

commit;