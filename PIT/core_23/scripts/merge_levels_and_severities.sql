
prompt &s1.Merge message severities
merge into pit_message_severity t
using (values (10, 'LEVEL_OFF'),
              (20, 'LEVEL_FATAL'),
              (30, 'LEVEL_ERROR'),
              (40, 'LEVEL_WARN'),
              (50, 'LEVEL_INFO'),
              (60, 'LEVEL_DEBUG'),
              (70, 'LEVEL_ALL')) s (pse_id, pse_name)
   on (t.pse_id = s.pse_id)
 when not matched then insert(pse_id, pse_name, pse_pti_id)
      values(s.pse_id, s.pse_name, s.pse_name);

commit;

prompt &s1.Merge trace levels
merge into pit_trace_level t
using (values (10, 'TRACE_OFF'),
              (20, 'TRACE_MANDATORY'),
              (30, 'TRACE_OPTIONAL'),
              (40, 'TRACE_DETAILED'),
              (50, 'TRACE_ALL')) s (ptl_id, ptl_name)
   on (t.ptl_id = s.ptl_id)
 when not matched then insert(ptl_id, ptl_name, ptl_pti_id)
      values(s.ptl_id, s.ptl_name, s.ptl_name);

commit;