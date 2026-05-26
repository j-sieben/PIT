prompt &s1.Merge message statuses
merge into pit_message_status t
using (select 'SOURCE' pmst_name, 'Message text maintained in the source language.' pmst_description from dual union all
       select 'SOURCE_COPY', 'Automatically generated copy of the source language message.' from dual union all
       select 'TRANSLATED', 'Message text maintained as explicit translation.' from dual union all
       select 'REVISION_REQUIRED', 'Explicit translation that needs review after source language changes.' from dual) s
   on (t.pmst_name = s.pmst_name)
 when matched then update set
      t.pmst_description = s.pmst_description
 when not matched then insert(pmst_name, pmst_description)
      values(s.pmst_name, s.pmst_description);

commit;
