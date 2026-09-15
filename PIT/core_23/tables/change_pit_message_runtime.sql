declare
  procedure execute_ddl(p_sql in varchar2) is
  begin
    execute immediate p_sql;
  exception
    when others then
      if sqlcode not in (-942, -1418, -2443, -904, -2264, -2275) then
        raise;
      end if;
  end execute_ddl;
begin
  execute_ddl(q'[delete from pit_message_text where pmt_pmst_name = 'SOURCE_COPY']');
  execute_ddl('alter table pit_message_text drop constraint pmt_pmst_name_fk');
  execute_ddl('alter table pit_message_text drop constraint pmt_pmst_name_nn');
  execute_ddl('alter table pit_message_text drop column pmt_pmst_name');
  execute_ddl('alter table pit_message drop constraint pms_id_u');
  execute_ddl('drop index pms_id_u');
  execute_ddl('alter table pit_message drop column pms_id cascade constraints');
  execute_ddl('alter table pit_mail_queue add constraint fk_pmq_pms_id foreign key(pmq_pms_id) references pit_message(pms_name) on delete cascade');
  execute_ddl('drop view pit_pmg_language_v');
  execute_ddl('drop view pit_pmg_default_language_v');
  execute_ddl('drop view pit_effective_group_language_v');
  execute_ddl('drop table pit_translation_scope cascade constraints purge');
  execute_ddl('drop table pit_message_status cascade constraints purge');
end;
/
