prompt &h2.Remove obsolete CORE schema elements

-- Column and constraint existence is still checked explicitly: ALTER TABLE IF
-- EXISTS protects against a missing table, but does not compare its structure.
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
      execute immediate 'alter table if exists ' || p_table_name ||
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
      execute immediate 'drop index if exists ' || p_index_name;
    end if;
  end drop_index;

  procedure drop_column(
    p_table_name in varchar2,
    p_column_name in varchar2,
    p_cascade in boolean default false)
  is
  begin
    if has_column(p_table_name, p_column_name) then
      execute immediate 'alter table if exists ' || p_table_name ||
                        ' drop column ' || p_column_name ||
                        case when p_cascade then ' cascade constraints' end;
    end if;
  end drop_column;
begin
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
end;
/

drop view if exists pit_pmg_language_v;
drop view if exists pit_pmg_default_language_v;
drop view if exists pit_effective_group_language_v;
drop table if exists pit_translation_scope cascade constraints purge;
drop table if exists pit_message_status cascade constraints purge;
