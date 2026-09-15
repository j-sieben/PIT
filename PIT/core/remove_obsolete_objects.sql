prompt &h2.Remove obsolete CORE schema elements

declare
  function has_column(
    p_table_name in varchar2,
    p_column_name in varchar2)
    return boolean
  is
    l_count number;
  begin
    select count(*) into l_count
      from user_tab_columns
     where table_name = upper(p_table_name)
       and column_name = upper(p_column_name);
    return l_count > 0;
  end has_column;

  procedure drop_constraint(
    p_table_name in varchar2,
    p_constraint_name in varchar2,
    p_cascade in boolean default false)
  is
    l_count number;
  begin
    select count(*) into l_count
      from user_constraints
     where table_name = upper(p_table_name)
       and constraint_name = upper(p_constraint_name);
    if l_count > 0 then
      execute immediate 'alter table ' || p_table_name ||
                        ' drop constraint ' || p_constraint_name ||
                        case when p_cascade then ' cascade' end;
    end if;
  end drop_constraint;

  procedure drop_index(p_index_name in varchar2) is
    l_count number;
  begin
    select count(*) into l_count
      from user_indexes
     where index_name = upper(p_index_name);
    if l_count > 0 then
      execute immediate 'drop index ' || p_index_name;
    end if;
  end drop_index;

  procedure drop_column(
    p_table_name in varchar2,
    p_column_name in varchar2,
    p_cascade in boolean default false)
  is
  begin
    if has_column(p_table_name, p_column_name) then
      execute immediate 'alter table ' || p_table_name ||
                        ' drop column ' || p_column_name ||
                        case when p_cascade then ' cascade constraints' end;
    end if;
  end drop_column;

  procedure drop_view(p_view_name in varchar2) is
    l_count number;
  begin
    select count(*) into l_count
      from user_views
     where view_name = upper(p_view_name);
    if l_count > 0 then
      execute immediate 'drop view ' || p_view_name;
    end if;
  end drop_view;

  procedure drop_table(p_table_name in varchar2) is
    l_count number;
  begin
    select count(*) into l_count
      from user_tables
     where table_name = upper(p_table_name);
    if l_count > 0 then
      execute immediate 'drop table ' || p_table_name ||
                        ' cascade constraints purge';
    end if;
  end drop_table;
begin
  -- Remove the retired translation-status attribute only after its data was
  -- captured in PIT_MESSAGE_TEXT_MIG by PREPARE_PIT_MESSAGE_MIGRATION.SQL.
  if has_column('PIT_MESSAGE_TEXT', 'PMT_PMST_NAME') then
    execute immediate
      q'[delete from pit_message_text where pmt_pmst_name = 'SOURCE_COPY']';
  end if;
  drop_constraint('PIT_MESSAGE_TEXT', 'PMT_PMST_NAME_FK');
  drop_constraint('PIT_MESSAGE_TEXT', 'PMT_PMST_NAME_NN');
  drop_index('IDX_PMT_PMST_NAME_FK');
  drop_column('PIT_MESSAGE_TEXT', 'PMT_PMST_NAME');

  if has_column('PIT_MESSAGE', 'PMS_PML_NAME') then
    -- PMS_ID_U may still be referenced by an installed PIT_MAIL_QUEUE.
    drop_constraint('PIT_MESSAGE', 'PMS_ID_U', true);
    drop_constraint('PIT_MESSAGE', 'PIT_MESSAGE_PK');
    drop_constraint('PIT_MESSAGE', 'PMS_PML_NAME_FK');
    drop_constraint('PIT_MESSAGE', 'PMS_TEXT_NN');
    drop_constraint('PIT_MESSAGE', 'PMS_PMT_NAME_FK');
    drop_index('PIT_PMS_PML_NAME_FK_IDX');
    drop_index('PMS_CUSTOM_ERROR_U');
    drop_index('PMS_ID_U');

    drop_column('PIT_MESSAGE', 'PMS_ID', true);
    drop_column('PIT_MESSAGE', 'PMS_PML_NAME', true);
    drop_column('PIT_MESSAGE', 'PMS_TEXT');
    drop_column('PIT_MESSAGE', 'PMS_DESCRIPTION');
    drop_column('PIT_MESSAGE', 'PMS_PMT_NAME');
  end if;

  drop_view('PIT_PMG_LANGUAGE_V');
  drop_view('PIT_PMG_DEFAULT_LANGUAGE_V');
  drop_view('PIT_EFFECTIVE_GROUP_LANGUAGE_V');
  drop_table('PIT_TRANSLATION_SCOPE');
  drop_table('PIT_MESSAGE_STATUS');
end;
/
