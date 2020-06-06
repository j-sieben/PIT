create table oj_roles(
  ojro_id varchar2(50 byte),
  ojro_display_name varchar2(200 byte),
  ojro_sort_seq number(5,0),
  ojro_active char(1 byte) default on null 'Y',
  constraint pk_oj_roles primary key (ojro_id)
) organization index;

comment on table oj_roles is 'Roles for the PIT UI';
comment on column oj_roles.ojro_id is 'Technical Key';
comment on column oj_roles.ojro_display_name is 'Display name for UI purposes';
comment on column oj_roles.ojro_sort_seq is 'Sort criteria for UI purposes';
comment on column oj_roles.ojro_active is 'Flag to indicate whether role is in use';

merge into oj_roles t
using (select 'ADMINISTRATOR' ojro_id,
              'Administrator' ojro_display_name,
              10 ojro_sort_seq,
              'Y' ojro_active
         from dual
        union all
       select 'USER', 'User', 20, 'Y' from dual) s
   on (t.ojro_id = s.ojro_id)
 when matched then update set
      t.ojro_display_name = s.ojro_display_name,
      t.ojro_sort_seq = s.ojro_sort_seq,
      t.ojro_active = s.ojro_active
 when not matched then insert (ojro_id, ojro_display_name, ojro_sort_seq, ojro_active)
      values (s.ojro_id, s.ojro_display_name, s.ojro_sort_seq, s.ojro_active);
      
commit;