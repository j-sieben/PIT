
prompt &s1.Merge message severities
merge into pit_message_severity t
using (select 10 pse_id, 'LEVEL_FATAL' pse_name, 'MANDATORY' pse_requires_exception
         from dual
        union all
       select 20, 'LEVEL_SEVERE', 'OPTIONAL' from dual union all
       select 30, 'LEVEL_ERROR', 'OPTIONAL' from dual union all
       select 40, 'LEVEL_WARN', 'NONE' from dual union all
       select 50, 'LEVEL_INFO', 'NONE' from dual union all
       select 60, 'LEVEL_DEBUG', 'NONE' from dual union all
       select 70, 'LEVEL_ALL', 'NONE' from dual) s
   on (t.pse_id = s.pse_id)
 when matched then update set
      t.pse_name = s.pse_name,
      t.pse_requires_exception = s.pse_requires_exception
 when not matched then insert(pse_id, pse_name, pse_pti_id, pse_requires_exception)
      values(s.pse_id, s.pse_name, s.pse_name, s.pse_requires_exception);

commit;

prompt &s1.Merge trace levels
merge into pit_trace_level t
using (select 10 ptl_id, 'TRACE_OFF' ptl_name
         from dual
        union all
       select 20, 'TRACE_MANDATORY' from dual union all
       select 30, 'TRACE_OPTIONAL' from dual union all
       select 40, 'TRACE_DETAILED' from dual union all
       select 50, 'TRACE_ALL' from dual) s
   on (t.ptl_id = s.ptl_id)
 when matched then update set
      t.ptl_name = s.ptl_name
 when not matched then insert(ptl_id, ptl_name, ptl_pti_id)
      values(s.ptl_id, s.ptl_name, s.ptl_name);

commit;