merge into pit_test_table_result r
using (select 'TOGGLE_CONTEXT_1' test_id,
              1 sort_seq,
              'CONTEXT_CHANGED' component,          
              'CONTEXT_TEST_FULL' params   
         from dual 
       union all  
       select 'TOGGLE_CONTEXT_1', 2, 'ENTER', null from dual union all  
       select 'TOGGLE_CONTEXT_1', 3, 'LEAVE', null from dual union all  
       select 'TOGGLE_CONTEXT_1', 4, 'CONTEXT_CHANGED', 'CONTEXT_DEFAULT' from dual union all  
       select 'TOGGLE_CONTEXT_2', 1, 'CONTEXT_CHANGED', 'CONTEXT_TEST_LOG_ONLY' from dual union all
       select 'TOGGLE_CONTEXT_2', 2, 'CONTEXT_CHANGED', 'CONTEXT_TEST_FULL' from dual union all  
       select 'TOGGLE_CONTEXT_2', 3, 'ENTER', null from dual union all  
       select 'TOGGLE_CONTEXT_2', 4, 'LEAVE', null from dual union all  
       select 'TOGGLE_CONTEXT_2', 5, 'CONTEXT_CHANGED', 'CONTEXT_TEST_LOG_ONLY' from dual union all 
       select 'TOGGLE_CONTEXT_2', 6, 'CONTEXT_CHANGED', 'CONTEXT_DEFAULT' from dual union all  
       select 'TOGGLE_CONTEXT_3', 1, 'CONTEXT_CHANGED', 'CONTEXT_TEST_FULL' from dual union all  
       select 'TOGGLE_CONTEXT_3', 2, 'ENTER', null from dual union all   
       select 'TOGGLE_CONTEXT_3', 3, 'CONTEXT_CHANGED', 'CONTEXT_TEST_OFF' from dual union all  
       select 'TOGGLE_CONTEXT_3', 4, 'CONTEXT_CHANGED', 'CONTEXT_TEST_FULL' from dual union all  
       select 'TOGGLE_CONTEXT_3', 5, 'LEAVE', null from dual union all  
       select 'TOGGLE_CONTEXT_3', 6, 'CONTEXT_CHANGED', 'CONTEXT_DEFAULT' from dual union all  
       select 'TOGGLE_CONTEXT_4', 1, 'CONTEXT_CHANGED', 'CONTEXT_TEST_FULL' from dual union all  
       select 'TOGGLE_CONTEXT_4', 2, 'ENTER', null from dual union all
       select 'TOGGLE_CONTEXT_4', 3, 'CONTEXT_CHANGED', 'CONTEXT_TEST_FULL' from dual union all  
       select 'TOGGLE_CONTEXT_4', 4, 'LEAVE', null from dual) v
    on (r.test_id = v.test_id and r.sort_seq = v.sort_seq)
 when matched then update set
      r.component = v.component,
      r.params = v.params
 when not matched then insert(test_id, sort_seq, component, params)
      values (v.test_id, v.sort_seq, v.component, v.params);
      
commit;

