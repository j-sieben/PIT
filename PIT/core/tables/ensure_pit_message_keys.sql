declare
  l_count number;
begin
  select count(*) into l_count
    from user_constraints
   where table_name = 'PIT_MESSAGE'
     and constraint_name = 'PIT_MESSAGE_PK';
  if l_count = 0 then
    execute immediate
      'alter table pit_message add constraint pit_message_pk primary key (pms_name)';
  end if;

  select count(*) into l_count
    from user_indexes
   where index_name = 'PMS_CUSTOM_ERROR_U';
  if l_count = 0 then
    execute immediate q'[
      create unique index pms_custom_error_u on pit_message(
        case
          when coalesce(pms_custom_error, -20000) != -20000
          then pms_custom_error
          else null
        end)]';
  end if;
end;
/
