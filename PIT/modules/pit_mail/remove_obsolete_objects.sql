declare
  l_count number;
begin
  -- Remove a legacy FK with the current name if it still references PMS_ID.
  select count(*) into l_count
    from user_constraints child
    join user_constraints parent
      on parent.constraint_name = child.r_constraint_name
     and parent.owner = child.r_owner
    join user_cons_columns parent_column
      on parent_column.constraint_name = parent.constraint_name
     and parent_column.owner = parent.owner
   where child.table_name = 'PIT_MAIL_QUEUE'
     and child.constraint_name = 'FK_PMQ_PMS_ID'
     and parent.table_name = 'PIT_MESSAGE'
     and parent_column.column_name != 'PMS_NAME';

  if l_count > 0 then
    execute immediate
      'alter table pit_mail_queue drop constraint fk_pmq_pms_id';
  end if;
end;
/

@&tools.check_has_constraint pit_mail_queue fk_pmq_pms_id tools/null.sql &table_dir.add_pit_mail_queue_message_fk.sql
