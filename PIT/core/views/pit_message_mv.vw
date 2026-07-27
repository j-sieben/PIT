begin
  execute immediate 'drop materialized view pit_message_mv';
exception
  when others then
    if sqlcode != -12003 then
      raise;
    end if;
end;
/

create materialized view pit_message_mv
  build immediate
  refresh complete on demand
as
with effective_languages as (
       select distinct pml_effective_name pml_name
         from pit_message_language)
select m.pms_name,
       m.pms_pmg_name,
       l.pml_name pms_pml_name,
       case when t.pmt_pms_name is not null then t.pmt_text else d.pmt_text end pms_text,
       case when t.pmt_pms_name is not null then t.pmt_description else d.pmt_description end pms_description,
       m.pms_pse_id,
       m.pms_custom_error,
       m.pms_active_error
  from pit_message m
 cross join effective_languages l
  join pit_message_text d
    on d.pmt_pms_name = m.pms_name
   and d.pmt_pml_name = '&DEFAULT_LANGUAGE.'
  left join pit_message_text t
    on t.pmt_pms_name = m.pms_name
   and t.pmt_pml_name = l.pml_name;

create unique index pit_message_mv_pk on pit_message_mv(pms_name, pms_pml_name);

comment on materialized view pit_message_mv is
  'Published message texts for every effective runtime language.';
