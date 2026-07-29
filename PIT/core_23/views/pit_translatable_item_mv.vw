begin
  execute immediate 'drop materialized view pit_translatable_item_mv';
exception
  when others then
    if sqlcode != -12003 then
      raise;
    end if;
end;
/

create materialized view pit_translatable_item_mv
  build immediate
  refresh complete on demand
as
with effective_languages as (
       select distinct pml_effective_name pml_name
         from pit_message_language)
select d.pti_pmg_name,
       d.pti_id,
       l.pml_name pti_pml_name,
       case when t.pti_id is not null then t.pti_name else d.pti_name end pti_name,
       case when t.pti_id is not null then t.pti_display_name else d.pti_display_name end pti_display_name,
       case when t.pti_id is not null then t.pti_description else d.pti_description end pti_description
  from pit_translatable_item d
 cross join effective_languages l
  left join pit_translatable_item t
    on t.pti_id = d.pti_id
   and t.pti_pmg_name = d.pti_pmg_name
   and t.pti_pml_name = l.pml_name
 where d.pti_pml_name = '&DEFAULT_LANGUAGE.';

create unique index pit_translatable_item_mv_pk
  on pit_translatable_item_mv(pti_id, pti_pmg_name, pti_pml_name);

comment on materialized view pit_translatable_item_mv is
  'Published translatable items for every effective runtime language.';
