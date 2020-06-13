
prompt &s1.Merge message severities
merge into pit_message_severity pse
using (select 10 pse_id, 'LEVEL_OFF' pse_name
         from dual
        union all
       select 20, 'LEVEL_FATAL' from dual union all
       select 30, 'LEVEL_ERROR' from dual union all
       select 40, 'LEVEL_WARN' from dual union all
       select 50, 'LEVEL_INFO' from dual union all
       select 60, 'LEVEL_DEBUG' from dual union all
       select 70, 'LEVEL_ALL' from dual) v
   on (pse.pse_id = v.pse_id)
 when not matched then insert(pse_id, pse_name, pse_pti_id)
      values(v.pse_id, v.pse_name, v.pse_name);

commit;

prompt &s1.Merge trace levels
merge into pit_trace_level pse
using (select 10 ptl_id, 'TRACE_OFF' ptl_name
         from dual
        union all
       select 20, 'TRACE_MANDATORY' from dual union all
       select 30, 'TRACE_OPTIONAL' from dual union all
       select 40, 'TRACE_DETAILED' from dual union all
       select 50, 'TRACE_ALL' from dual) v
   on (pse.ptl_id = v.ptl_id)
 when not matched then insert(ptl_id, ptl_name, ptl_pti_id)
      values(v.ptl_id, v.ptl_name, v.ptl_name);

commit;