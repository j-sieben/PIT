declare
  l_has_old_layout number;
  l_has_text number;
  l_has_status number;
  l_default_language pit_message_language.pml_name%type;

  procedure drop_migration_table is
    l_count number;
  begin
    select count(*) into l_count
      from user_tables
     where table_name = 'PIT_MESSAGE_TEXT_MIG';
    if l_count > 0 then
      execute immediate 'drop table pit_message_text_mig purge';
    end if;
  end drop_migration_table;
begin
  select count(*) into l_has_old_layout
    from user_tab_columns
   where table_name = 'PIT_MESSAGE'
     and column_name = 'PMS_PML_NAME';

  if l_has_old_layout > 0 then
    select count(*) into l_has_text
      from user_tab_columns
     where table_name = 'PIT_MESSAGE'
       and column_name = 'PMS_TEXT';
    select count(*) into l_has_status
      from user_tab_columns
     where table_name = 'PIT_MESSAGE'
       and column_name = 'PMS_PMT_NAME';

    select pml_name into l_default_language
      from pit_message_language
     where pml_default_order = 10;

    drop_migration_table;

    if l_has_text = 1 and l_has_status = 1 then
      execute immediate q'[
        create table pit_message_text_mig as
        select pms_name pmt_pms_name,
               pms_pml_name pmt_pml_name,
               pms_text pmt_text,
               pms_description pmt_description,
               pms_pmt_name pmt_pmst_name
          from pit_message]';
    elsif l_has_text = 1 then
      execute immediate q'[
        create table pit_message_text_mig as
        select pms_name pmt_pms_name,
               pms_pml_name pmt_pml_name,
               pms_text pmt_text,
               pms_description pmt_description,
               case pms_pml_name
                 when :default_language then 'SOURCE'
                 else 'TRANSLATED'
               end pmt_pmst_name
          from pit_message]' using l_default_language;
    else
      raise_application_error(-20000,
        'Legacy PIT_MESSAGE layout contains PMS_PML_NAME but no PMS_TEXT column.');
    end if;

    execute immediate q'[
      delete from pit_message
       where rowid in (
             select rid
               from (select rowid rid,
                            row_number() over (
                              partition by pms_name
                              order by case pms_pml_name
                                         when :default_language then 0 else 1
                                       end,
                                       pms_pml_name) rn
                       from pit_message)
              where rn > 1)]' using l_default_language;
  end if;
end;
/
