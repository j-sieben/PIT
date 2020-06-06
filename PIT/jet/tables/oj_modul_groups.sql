create table oj_module_groups(
  ojmg_id varchar2(50 byte),
  ojmg_display_name varchar2(200 byte),
  ojmg_sort_seq number(5,0),
  ojmg_active char(1 byte) default on null 'Y',
  constraint pk_oj_module_group primary key (ojmg_id)
) organization index;

comment on table oj_module_groups is 'Grouping of oj_modules';
comment on column oj_module_groups.ojmg_id is 'Technical Key';
comment on column oj_module_groups.ojmg_display_name is 'Display name for UI purposes';
comment on column oj_module_groups.ojmg_sort_seq is 'Sort criteria for UI purposes';
comment on column oj_module_groups.ojmg_active is 'Flag to indicate whether group is in use';

merge into oj_module_groups t
using (select 'NAV_BAR' ojmg_id,
              'Navigation Bar' ojmg_display_name,
              10 ojmg_sort_seq,
              'Y' ojmg_active
         from dual) s
   on (t.ojmg_id = s.ojmg_id)
 when matched then update set
      t.ojmg_display_name = s.ojmg_display_name,
      t.ojmg_sort_seq = s.ojmg_sort_seq,
      t.ojmg_active = s.ojmg_active
 when not matched then insert (ojmg_id, ojmg_display_name, ojmg_sort_seq, ojmg_active)
      values (s.ojmg_id, s.ojmg_display_name, s.ojmg_sort_seq, s.ojmg_active);
      
commit;