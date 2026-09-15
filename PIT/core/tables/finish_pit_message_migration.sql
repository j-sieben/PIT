declare
  l_source_count number;
  l_target_count number;
begin
  select count(*) into l_source_count
    from user_tables
   where table_name = 'PIT_MESSAGE_TEXT_MIG';

  if l_source_count > 0 then
    execute immediate q'[
      merge into pit_message_text t
      using (select pmt_pms_name, pmt_pml_name, pmt_text, pmt_description
               from pit_message_text_mig
              where pmt_pmst_name is null
                 or pmt_pmst_name != 'SOURCE_COPY') s
         on (t.pmt_pms_name = s.pmt_pms_name
         and t.pmt_pml_name = s.pmt_pml_name)
       when matched then update set
            t.pmt_text = s.pmt_text,
            t.pmt_description = s.pmt_description
       when not matched then insert
            (pmt_pms_name, pmt_pml_name, pmt_text, pmt_description)
            values
            (s.pmt_pms_name, s.pmt_pml_name, s.pmt_text, s.pmt_description)]';

    execute immediate q'[
      select count(*)
        from pit_message_text_mig
       where pmt_pmst_name is null
          or pmt_pmst_name != 'SOURCE_COPY']'
      into l_source_count;
    execute immediate q'[
      select count(*)
        from pit_message_text t
       where exists (
             select null
               from pit_message_text_mig m
              where m.pmt_pms_name = t.pmt_pms_name
                and m.pmt_pml_name = t.pmt_pml_name
                and (m.pmt_pmst_name is null
                  or m.pmt_pmst_name != 'SOURCE_COPY'))]'
      into l_target_count;

    if l_target_count != l_source_count then
      raise_application_error(-20000,
        'PIT_MESSAGE_TEXT migration validation failed: expected ' ||
        l_source_count || ' rows, found ' || l_target_count || '.');
    end if;

    execute immediate 'drop table pit_message_text_mig purge';
  end if;
end;
/
