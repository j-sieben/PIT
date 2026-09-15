prompt &h2.Verify CORE schema

declare
  l_errors varchar2(32767);
  l_count number;

  procedure add_error(p_error in varchar2) is
  begin
    l_errors := l_errors || case when l_errors is not null then chr(10) end ||
                '- ' || p_error;
  end add_error;

  procedure require_column(
    p_table_name in varchar2,
    p_column_name in varchar2)
  is
    l_count number;
  begin
    select count(*) into l_count
      from user_tab_columns
     where table_name = upper(p_table_name)
       and column_name = upper(p_column_name);
    if l_count = 0 then
      add_error('Missing column ' || p_table_name || '.' || p_column_name);
    end if;
  end require_column;

  procedure reject_column(
    p_table_name in varchar2,
    p_column_name in varchar2)
  is
    l_count number;
  begin
    select count(*) into l_count
      from user_tab_columns
     where table_name = upper(p_table_name)
       and column_name = upper(p_column_name);
    if l_count > 0 then
      add_error('Obsolete column remains: ' || p_table_name || '.' || p_column_name);
    end if;
  end reject_column;

  procedure require_constraint(
    p_table_name in varchar2,
    p_constraint_name in varchar2)
  is
    l_count number;
  begin
    select count(*) into l_count
      from user_constraints
     where table_name = upper(p_table_name)
       and constraint_name = upper(p_constraint_name)
       and status = 'ENABLED';
    if l_count = 0 then
      add_error('Missing or disabled constraint ' || p_constraint_name);
    end if;
  end require_constraint;

begin
  require_column('PIT_MESSAGE', 'PMS_NAME');
  require_column('PIT_MESSAGE_TEXT', 'PMT_PMS_NAME');
  require_column('PIT_MESSAGE_TEXT', 'PMT_PML_NAME');
  require_column('PIT_MESSAGE_TEXT', 'PMT_TEXT');
  require_column('PIT_MESSAGE_LANGUAGE', 'PML_EFFECTIVE_NAME');

  reject_column('PIT_MESSAGE', 'PMS_ID');
  reject_column('PIT_MESSAGE', 'PMS_PML_NAME');
  reject_column('PIT_MESSAGE', 'PMS_TEXT');
  reject_column('PIT_MESSAGE_TEXT', 'PMT_PMST_NAME');

  require_constraint('PIT_MESSAGE', 'PIT_MESSAGE_PK');
  require_constraint('PIT_MESSAGE_TEXT', 'PIT_MESSAGE_TEXT_PK');
  require_constraint('PIT_MESSAGE_LANGUAGE', 'PML_EFFECTIVE_NAME_FK');

  select count(*) into l_count
    from user_objects
   where object_name in (
         'PIT_MESSAGE_STATUS', 'PIT_TRANSLATION_SCOPE',
         'PIT_PMG_LANGUAGE_V', 'PIT_PMG_DEFAULT_LANGUAGE_V',
         'PIT_EFFECTIVE_GROUP_LANGUAGE_V', 'PIT_MESSAGE_TEXT_MIG');
  if l_count > 0 then
    add_error(l_count || ' obsolete or temporary CORE objects remain');
  end if;

  for obj in (
    select object_name, object_type
      from user_objects
     where object_name in (
           'MSG', 'PIT', 'PIT_ADMIN', 'PIT_UTIL', 'PIT_CONTEXT',
           'PIT_CALL_STACK', 'PIT_INTERNAL', 'PIT_MESSAGE_ACCESS_V',
           'PIT_MESSAGE_MV', 'PIT_TRANSLATABLE_ITEM_MV')
       and status != 'VALID'
     order by object_name, object_type)
  loop
    add_error('Invalid CORE object: ' || obj.object_type || ' ' ||
              obj.object_name);
  end loop;

  if l_errors is not null then
    raise_application_error(-20000, 'CORE schema verification failed:' ||
      chr(10) || l_errors);
  end if;
end;
/
