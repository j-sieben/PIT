
prompt &s1.Merge message severities
merge into pit_message_severity t
using (values (10, 'LEVEL_FATAL', 'MANDATORY'),
              (20, 'LEVEL_SEVERE', 'OPTIONAL'),
              (30, 'LEVEL_ERROR', 'OPTIONAL'),
              (40, 'LEVEL_WARN', 'NONE'),
              (50, 'LEVEL_INFO', 'NONE'),
              (60, 'LEVEL_DEBUG', 'NONE'),
              (70, 'LEVEL_ALL', 'NONE')) s (pse_id, pse_name, pse_requires_exception)
   on (t.pse_id = s.pse_id)
 when matched then update set
      t.pse_name = s.pse_name,
      t.pse_requires_exception = s.pse_requires_exception
 when not matched then insert(pse_id, pse_name, pse_pti_id, pse_requires_exception)
      values(s.pse_id, s.pse_name, s.pse_name, s.pse_requires_exception);

commit;

prompt &s1.Merge trace levels
merge into pit_trace_level t
using (values (10, 'TRACE_OFF'),
              (20, 'TRACE_MANDATORY'),
              (30, 'TRACE_OPTIONAL'),
              (40, 'TRACE_DETAILED'),
              (50, 'TRACE_ALL')) s (ptl_id, ptl_name)
   on (t.ptl_id = s.ptl_id)
 when matched then update set
      t.ptl_name = s.ptl_name
 when not matched then insert(ptl_id, ptl_name, ptl_pti_id)
      values(s.ptl_id, s.ptl_name, s.ptl_name);

commit;