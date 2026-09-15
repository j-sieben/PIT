declare
  procedure rename_column(
    p_table_name in varchar2,
    p_old_name in varchar2,
    p_new_name in varchar2)
  is
    l_old_count number;
    l_new_count number;
  begin
    select count(*) into l_old_count
      from user_tab_columns
     where table_name = upper(p_table_name)
       and column_name = upper(p_old_name);
    select count(*) into l_new_count
      from user_tab_columns
     where table_name = upper(p_table_name)
       and column_name = upper(p_new_name);
    if l_old_count = 1 and l_new_count = 0 then
      execute immediate 'alter table if exists ' || p_table_name ||
                        ' rename column ' || p_old_name || ' to ' || p_new_name;
    elsif l_old_count = 1 and l_new_count = 1 then
      raise_application_error(-20000, 'Both legacy and current columns exist: ' ||
        p_table_name || '.' || p_old_name || ', ' || p_new_name || '.');
    end if;
  end rename_column;

  procedure rename_constraint(
    p_table_name in varchar2,
    p_old_name in varchar2,
    p_new_name in varchar2)
  is
    l_old_count number;
    l_new_count number;
  begin
    select count(*) into l_old_count
      from user_constraints
     where table_name = upper(p_table_name)
       and constraint_name = upper(p_old_name);
    select count(*) into l_new_count
      from user_constraints
     where table_name = upper(p_table_name)
       and constraint_name = upper(p_new_name);
    if l_old_count = 1 and l_new_count = 0 then
      execute immediate 'alter table if exists ' || p_table_name ||
                        ' rename constraint ' || p_old_name || ' to ' || p_new_name;
    elsif l_old_count = 1 and l_new_count = 1 then
      raise_application_error(-20000, 'Both legacy and current constraints exist: ' ||
        p_old_name || ', ' || p_new_name || '.');
    end if;
  end rename_constraint;

  procedure rename_index(
    p_old_name in varchar2,
    p_new_name in varchar2)
  is
    l_old_count number;
    l_new_count number;
  begin
    select count(*) into l_old_count from user_indexes
     where index_name = upper(p_old_name);
    select count(*) into l_new_count from user_indexes
     where index_name = upper(p_new_name);
    if l_old_count = 1 and l_new_count = 0 then
      execute immediate 'alter index if exists ' || p_old_name ||
                        ' rename to ' || p_new_name;
    elsif l_old_count = 1 and l_new_count = 1 then
      raise_application_error(-20000, 'Both legacy and current indexes exist: ' ||
        p_old_name || ', ' || p_new_name || '.');
    end if;
  end rename_index;
begin
  rename_column('PIT_MESSAGE_TEXT', 'PMST_PMS_NAME', 'PMT_PMS_NAME');
  rename_column('PIT_MESSAGE_TEXT', 'PMST_PML_NAME', 'PMT_PML_NAME');
  rename_column('PIT_MESSAGE_TEXT', 'PMST_TEXT', 'PMT_TEXT');
  rename_column('PIT_MESSAGE_TEXT', 'PMST_DESCRIPTION', 'PMT_DESCRIPTION');
  rename_column('PIT_MESSAGE_TEXT', 'PMST_PMST_NAME', 'PMT_PMST_NAME');
  rename_constraint('PIT_MESSAGE_TEXT', 'PMST_PMS_NAME_FK', 'PMT_PMS_NAME_FK');
  rename_constraint('PIT_MESSAGE_TEXT', 'PMST_PML_NAME_FK', 'PMT_PML_NAME_FK');
  rename_constraint('PIT_MESSAGE_TEXT', 'PMST_TEXT_NN', 'PMT_TEXT_NN');
  rename_constraint('PIT_MESSAGE_TEXT', 'PMST_PMST_NAME_FK', 'PMT_PMST_NAME_FK');
  rename_constraint('PIT_MESSAGE_TEXT', 'PMST_PMST_NAME_NN', 'PMT_PMST_NAME_NN');
  rename_index('IDX_PMST_PML_NAME_FK', 'IDX_PMT_PML_NAME_FK');
  rename_column('PIT_MESSAGE', 'PMS_PMST_NAME', 'PMS_PMT_NAME');
  rename_constraint('PIT_MESSAGE', 'PMS_PMST_NAME_FK', 'PMS_PMT_NAME_FK');
end;
/
