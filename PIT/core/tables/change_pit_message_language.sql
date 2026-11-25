alter table pit_message_language add
  pml_effective_name &ORA_NAME_TYPE. default on null '&DEFAULT_LANGUAGE.';

declare
  l_has_message_text number;
  l_has_status number;
begin
  select count(*)
    into l_has_message_text
    from user_tab_columns
   where table_name = 'PIT_MESSAGE_TEXT'
     and column_name = 'PMT_PML_NAME';

  select count(*)
    into l_has_status
    from user_tab_columns
   where table_name = 'PIT_MESSAGE_TEXT'
     and column_name = 'PMT_PMST_NAME';

  if l_has_message_text > 0 and l_has_status > 0 then
    execute immediate q'[
      update pit_message_language l
         set pml_effective_name = pml_name
       where pml_name = '&DEFAULT_LANGUAGE.'
          or exists (
               select null
                 from pit_message_text t
                where t.pmt_pml_name = l.pml_name
                  and (t.pmt_pmst_name is null or t.pmt_pmst_name != 'SOURCE_COPY'))]';
  elsif l_has_message_text > 0 then
    execute immediate q'[
      update pit_message_language l
         set pml_effective_name = pml_name
       where pml_name = '&DEFAULT_LANGUAGE.'
          or exists (
               select null
                 from pit_message_text t
                where t.pmt_pml_name = l.pml_name)]';
  end if;
end;
/

alter table pit_message_language add constraint pml_effective_name_fk
  foreign key (pml_effective_name) references pit_message_language(pml_name);

comment on column pit_message_language.pml_effective_name is
  'Language containing the materialized runtime values for this session language.';
