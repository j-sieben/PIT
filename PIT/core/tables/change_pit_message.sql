declare
  l_has_old_columns number;
  l_has_status_column number;
  l_has_text_table number;
  l_has_mig_table number;
  l_has_pms_id number;
  l_has_text_column number;
  l_default_language pit_message_language.pml_name%type;
  
  procedure execute_ddl(
    p_sql in varchar2)
  as
  begin
    execute immediate p_sql;
  exception
    when others then
      null;
  end execute_ddl;
begin
  select count(*)
    into l_has_old_columns
    from user_tab_columns
   where table_name = 'PIT_MESSAGE'
     and column_name = 'PMS_PML_NAME';

  if l_has_old_columns > 0 then
    select count(*)
    into l_has_text_column
    from user_tab_columns
   where table_name = 'PIT_MESSAGE'
     and column_name = 'PMS_TEXT';

    select count(*)
    into l_has_status_column
    from user_tab_columns
   where table_name = 'PIT_MESSAGE'
     and column_name = 'PMS_pmt_NAME';

    select pml_name
    into l_default_language
    from pit_message_language
   where pml_default_order = 10;

    execute_ddl('drop table pit_message_text_mig purge');

    case when l_has_text_column = 1 and l_has_status_column = 1 then
      execute immediate q'[
      create table pit_message_text_mig as
      select pms_name pmt_pms_name,
             pms_pml_name pmt_pml_name,
             pms_text pmt_text,
             pms_description pmt_description,
             pms_pmt_name pmt_pmst_name
        from pit_message]';
    when l_has_text_column = 1 then
      execute immediate q'[
      create table pit_message_text_mig as
      select pms_name pmt_pms_name,
             pms_pml_name pmt_pml_name,
             pms_text pmt_text,
             pms_description pmt_description,
             case pms_pml_name
             when :default_language then 'SOURCE'
             else 'TRANSLATED' end pmt_pmst_name
        from pit_message]' using l_default_language;
    end case;

    execute immediate q'[
      delete from pit_message
       where rowid in (
             select rid
               from (select rowid rid,
                            row_number() over (
                              partition by pms_name
                              order by case pms_pml_name when :default_language then 0 else 1 end,
                                       pms_pml_name) rn
                       from pit_message)
              where rn > 1)]' using l_default_language;

    execute_ddl('alter table pit_message drop constraint pms_id_u');
    execute_ddl('alter table pit_message drop constraint pit_message_pk');
    execute_ddl('alter table pit_message drop constraint pms_pml_name_fk');
    execute_ddl('alter table pit_message drop constraint pms_text_nn');
    execute_ddl('alter table pit_message drop constraint pms_pmt_name_fk');
    execute_ddl('drop index pit_pms_pml_name_fk_idx');
    execute_ddl('drop index pms_custom_error_u');

    execute_ddl('alter table pit_message drop column pms_id cascade constraints');
    execute_ddl('alter table pit_message drop column pms_pml_name cascade constraints');
    execute_ddl('alter table pit_message drop column pms_text');
    execute_ddl('alter table pit_message drop column pms_description');
    execute_ddl('alter table pit_message drop column pms_pmt_name');

    select count(*)
      into l_has_pms_id
      from user_tab_columns
     where table_name = 'PIT_MESSAGE'
       and column_name = 'PMS_ID';

    if l_has_pms_id = 0 then
      execute immediate 'alter table pit_message add pms_id &ORA_NAME_TYPE. generated always as (case when pms_name is not null then pms_name end) virtual';
    end if;
    execute immediate 'alter table pit_message add constraint pit_message_pk primary key (pms_name)';
    execute immediate 'alter table pit_message add constraint pms_id_u unique (pms_id)';
    execute immediate q'[
    create unique index pms_custom_error_u on pit_message(
      case when coalesce(pms_custom_error, -20000) != -20000 then pms_custom_error end)]';

    select count(*)
      into l_has_text_table
      from user_tables
     where table_name = 'PIT_MESSAGE_TEXT';

    if l_has_text_column = 1 and l_has_text_table = 0 then
      execute immediate q'[
      create table pit_message_text(
         pmt_pms_name &ORA_NAME_TYPE.,
         pmt_pml_name &ORA_NAME_TYPE.,
         pmt_pmst_name &ORA_NAME_TYPE. constraint pmt_pmst_name_nn check(pmt_pmst_name is not null),
         pmt_text clob constraint pmt_text_nn check(pmt_text is not null),
         pmt_description clob,
         constraint pit_message_text_pk primary key(pmt_pms_name, pmt_pml_name),
         constraint pmt_pms_name_fk foreign key(pmt_pms_name)
            references pit_message(pms_name) on delete cascade,
         constraint pmt_pml_name_fk foreign key(pmt_pml_name)
            references pit_message_language(pml_name),
         constraint pmt_pmst_name_fk foreign key(pmt_pmst_name)
            references pit_message_status(pmst_name)
      )]';
      execute immediate 'create index idx_pmt_pml_name_fk on pit_message_text(pmt_pml_name)';
      execute immediate 'create index idx_pmt_pml_name_fk on pit_message_text(pmt_pml_name)';
    end if;

    if l_has_text_column = 1 then
      execute immediate q'[
      merge into pit_message_text t
      using (select pmt_pms_name,
                    pmt_pml_name,
                    pmt_text,
                    pmt_description,
                    pmt_pmst_name
               from pit_message_text_mig) s
         on (t.pmt_pms_name = s.pmt_pms_name
         and t.pmt_pml_name = s.pmt_pml_name)
       when matched then update set
            t.pmt_text = s.pmt_text,
            t.pmt_description = s.pmt_description,
            t.pmt_pmst_name = s.pmt_pmst_name
       when not matched then insert
            (pmt_pms_name, pmt_pml_name, pmt_text, pmt_description, pmt_pmst_name)
            values
            (s.pmt_pms_name, s.pmt_pml_name, s.pmt_text, s.pmt_description, s.pmt_pmst_name)]';

      execute immediate q'[comment on table pit_message_text is 'Language specific message text repository.']';
      execute immediate q'[comment on column pit_message_text.pmt_pms_name is 'Message name. Reference to PIT_MESSAGE.']';
      execute immediate q'[comment on column pit_message_text.pmt_pml_name is 'Language reference of the message text. Taken from Oracle v$nls_valid_values.']';
      execute immediate q'[comment on column pit_message_text.pmt_text is 'Message text. Positional replacement with pattern #n#.']';
      execute immediate q'[comment on column pit_message_text.pmt_description is 'Optional description to further describe the error or provide help on how to solve the issue.']';
      execute immediate q'[comment on column pit_message_text.pmt_pmst_name is 'Internal translation status. Reference to PIT_MESSAGE_STATUS.']';
    end if;

    execute_ddl('drop table pit_message_text_mig purge');
  end if;

  select count(*)
    into l_has_pms_id
    from user_tab_columns
   where table_name = 'PIT_MESSAGE'
     and column_name = 'PMS_ID';

  if l_has_pms_id = 0 then
    execute immediate 'alter table pit_message add pms_id &ORA_NAME_TYPE. generated always as (case when pms_name is not null then pms_name end) virtual';
  end if;

  execute_ddl('alter table pit_message add constraint pit_message_pk primary key (pms_name)');
  execute_ddl('alter table pit_message add constraint pms_id_u unique (pms_id)');
  execute_ddl(q'[
    create unique index pms_custom_error_u on pit_message(
      case
      when coalesce(pms_custom_error, -20000) != -20000
      then pms_custom_error
      else null end)]');

  select count(*)
    into l_has_text_table
    from user_tables
   where table_name = 'PIT_MESSAGE_TEXT';

  select count(*)
    into l_has_mig_table
    from user_tables
   where table_name = 'PIT_MESSAGE_TEXT_MIG';

  if l_has_text_table = 0 and l_has_mig_table = 1 then
    execute immediate q'[
      create table pit_message_text(
         pmt_pms_name &ORA_NAME_TYPE.,
         pmt_pml_name &ORA_NAME_TYPE.,
         pmt_text clob,
         pmt_description clob,
         pmt_pmst_name &ORA_NAME_TYPE.,
         constraint pit_message_text_pk primary key(pmt_pms_name, pmt_pml_name),
         constraint pmt_pms_name_fk foreign key(pmt_pms_name)
            references pit_message(pms_name) on delete cascade,
         constraint pmt_pml_name_fk foreign key(pmt_pml_name)
            references pit_message_language(pml_name),
         constraint pmt_pmst_name_fk foreign key(pmt_pmst_name)
            references pit_message_status(pmt_name),
         constraint pmt_text_nn check(pmt_text is not null),
         constraint pmt_pmst_name_nn check(pmt_pmst_name is not null)
      )]';
    execute immediate 'create index idx_pmt_pml_name_fk on pit_message_text(pmt_pml_name)';
    execute immediate q'[
      insert into pit_message_text(
             pmt_pms_name, pmt_pml_name, pmt_text, pmt_description, pmt_pmst_name)
      select pmt_pms_name, pmt_pml_name, pmt_text, pmt_description, pmt_pmst_name
        from pit_message_text_mig]';
    execute_ddl('drop table pit_message_text_mig purge');
  end if;
end;
/

comment on table pit_message is 'central log message repository in various languages.';
comment on column pit_message.pms_name is 'Unique message name. Used to reference the message as a constant in package MSG.';
comment on column pit_message.pms_pmg_name is 'Unique message group name. Reference to PIT_MESSAGE_GROUP.';
comment on column pit_message.pms_pse_id is 'Severity of the message. Reference to PIT_MESSAGE_SEVERITY';
comment on column pit_message.pms_custom_error is 'Optional pointer to an Oracle error number. If null, an exception will be generated. To define custom errors, use null.';
comment on column pit_message.pms_active_error is 'If a custom error number of -20000 is used, this field contains the actual error number as processed by PIT_ADMIN.CREATE_MESSAGE_PACKAGE.';
comment on column pit_message.pms_id is 'Virtual column as a surrogate primary key for references';
