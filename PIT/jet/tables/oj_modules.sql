create table oj_modules(
  ojmo_id varchar2(50 byte),
  ojmo_ojmg_id varchar2(50 byte) constraint nn_ojmo_ojmg_id not null,
  ojmo_ojro_id varchar2(50 byte),
  ojmo_pti_id varchar2(128 byte) constraint nn_ojmo_name not null,
  ojmo_pti_pmg_name varchar2(128 byte),
  ojmo_css varchar2(200 byte),
  ojmo_sort_seq number(5,0),
  constraint pk_oj_modules primary key(ojmo_id, ojmo_ojmg_id),
  constraint fk_ojmo_ojmg_id foreign key(ojmo_ojmg_id)
    references oj_module_groups(ojmg_id),
  constraint fk_ojmo_ojro_id foreign key(ojmo_ojro_id)
    references oj_roles(ojro_id),
  constraint fk_ojmo_pti foreign key(ojmo_pti_id, ojmo_pti_pmg_name)
    references pit_translatable_item(pti_uid, pti_upmg)
) organization index;

comment on table oj_modules is 'Oracle Jet module metadata';
comment on column oj_modules.ojmo_id is 'Technical Key, is used as ID in ojet in lower case.';
comment on column oj_modules.ojmo_ojmg_id is 'Technical Key, reference to OJ_MODULE_GROUPS.';
comment on column oj_modules.ojmo_ojro_id is 'Optional reference to OJ_ROLES, restricts module to a role.';
comment on column oj_modules.ojmo_pti_id is 'Display name of the module, Reference to PIT_TRANSLATABLE_ITEM';
comment on column oj_modules.ojmo_pti_pmg_name is 'Translatable group, Reference to PIT_TRANSLATABLE_ITEM';
comment on column oj_modules.ojmo_css is 'CSS-Attributes of the module.';
comment on column oj_modules.ojmo_sort_seq is 'Sort order.';

merge into oj_modules t
using (select 'HOME' ojmo_id,
              'NAV_BAR' ojmo_ojmg_id,
              null ojmo_ojro_id,
              'PAGE_HOME' ojmo_pti_id,
              'PIT' ojmo_pti_pmg_name,
              'oj-navigationlist-item-icon demo-icon-font-24 demo-home-icon-24' ojmo_css,
              10 ojmo_sort_seq
         from dual
        union all
       select 'MESSAGES', 'NAV_BAR', null, 'PAGE_MESSAGES', 'PIT', 'oj-navigationlist-item-icon demo-icon-font-24 demo-chart-icon-24', 20 from dual union all
       select 'PARAMETERS', 'NAV_BAR', null, 'PAGE_PARAMETERS', 'PIT', 'oj-navigationlist-item-icon demo-icon-font-24 demo-fire-icon-24', 30 from dual union all
       select 'TRANSLATABLES', 'NAV_BAR', null, 'PAGE_TRANSLATABLES', 'PIT', 'oj-navigationlist-item-icon demo-icon-font-24 demo-people-icon-24', 40 from dual union all
       select 'ADMINISTRATION', 'NAV_BAR', null, 'PAGE_ADMINISTRATION', 'PIT', 'oj-navigationlist-item-icon demo-icon-font-24 demo-chart-icon-24', 50 from dual) s
   on (t.ojmo_id = s.ojmo_id and t.ojmo_ojmg_id = s.ojmo_ojmg_id)
 when matched then update set
      t.ojmo_ojro_id = s.ojmo_ojro_id,
      t.ojmo_pti_id = s.ojmo_pti_id,
      t.ojmo_pti_pmg_name = s.ojmo_pti_pmg_name,
      t.ojmo_css = s.ojmo_css,
      t.ojmo_sort_seq = s.ojmo_sort_seq
 when not matched then insert (ojmo_id, ojmo_ojmg_id, ojmo_ojro_id, ojmo_pti_id, ojmo_pti_pmg_name, ojmo_css, ojmo_sort_seq)
      values (s.ojmo_id, s.ojmo_ojmg_id, s.ojmo_ojro_id, s.ojmo_pti_id, s.ojmo_pti_pmg_name, s.ojmo_css, s.ojmo_sort_seq);
      
commit;