-- Run as the PIT owner with PIT_TABLE installed. All test DML is rolled back.
set serveroutput on
whenever sqlerror exit failure rollback

declare
  l_message message_type;
  l_count number;
  l_value varchar2(4000);
  l_state pit_log_state_type;

  procedure expect_count(p_expected number, p_label varchar2) is
  begin
    select count(*) into l_count from pit_table_params where ptp_id = l_message.id;
    if l_count != p_expected then
      raise_application_error(-20000, p_label || ': expected ' || p_expected || ', got ' || l_count);
    end if;
  end;

  procedure new_message(p_ids msg_params, p_id varchar2 default null) is
  begin
    l_message := pit_internal.get_message(
      p_message_name => 'PIT_SQL_ERROR', p_msg_args => null,
      p_affected_id => p_id, p_affected_ids => p_ids,
      p_error_code => null, p_read_only => false);
    l_message.creation_time := timestamp '1000-01-01 00:00:00';
    l_message.severity := pit.LEVEL_INFO;
  end;
begin
  savepoint affected_ids_test;
  new_message(null, '42');
  pit_table_pkg.log_exception(l_message);
  expect_count(1, 'single ID');
  select ptp_param_value into l_value from pit_table_params
   where ptp_id = l_message.id and ptp_param_name = 'ID';
  if l_value != '42' then raise_application_error(-20000, 'single ID value'); end if;

  new_message(msg_params(msg_param('ORDER_ID', '42'), msg_param('CUSTOMER_ID', '7')), 'ignored');
  pit_table_pkg.panic(l_message);
  expect_count(2, 'multiple IDs and collection precedence');

  new_message(msg_params(), 'ignored');
  pit_table_pkg.tweet(l_message);
  expect_count(0, 'empty collection precedence');

  new_message(null);
  pit_table_pkg.log_exception(l_message);
  expect_count(0, 'no IDs');

  new_message(msg_params(
    msg_param('ID', cast(null as varchar2)), msg_param('ID', 'first'),
    msg_param('ID', 'second'), msg_param(null, 'unnamed'), cast(null as msg_param)));
  pit_table_pkg.log_exception(l_message);
  expect_count(1, 'duplicates and null entries');
  select ptp_param_value into l_value from pit_table_params where ptp_id = l_message.id;
  if l_value != 'first' then raise_application_error(-20000, 'duplicate selection'); end if;
  select count(*) into l_count from pit_table_params
   where ptp_id = l_message.id and ptp_log_date = l_message.creation_time
     and ptp_pse_id = l_message.severity;
  if l_count != 1 then raise_application_error(-20000, 'parent timestamp/severity'); end if;

  -- A later parameter timestamp must not leave an orphan at the purge boundary.
  update pit_table_params set ptp_log_date = timestamp '1000-01-02 00:00:00'
   where ptp_id = l_message.id;
  pit_table_pkg.purge_log(date '1000-01-01', pit.LEVEL_INFO);
  expect_count(0, 'purge parent boundary');
  select count(*) into l_count from pit_table_log where log_id = l_message.id;
  if l_count != 0 then raise_application_error(-20000, 'parent not purged'); end if;

  l_state := pit_log_state_type(pit.LEVEL_DEBUG,
    msg_params(msg_param('NULL_STATE', cast(null as varchar2)), msg_param('STATE', 'value')));
  pit_table_pkg.log_state(l_state);
  select count(*) into l_count from pit_table_params where ptp_id = l_state.id;
  if l_count != 2 then raise_application_error(-20000, 'state parameter regression'); end if;
  update pit_table_params set ptp_log_date = timestamp '1000-01-01 00:00:00'
   where ptp_id = l_state.id;
  pit_table_pkg.purge_log(date '1000-01-01', pit.LEVEL_DEBUG);
  select count(*) into l_count from pit_table_params where ptp_id = l_state.id;
  if l_count != 0 then raise_application_error(-20000, 'state severity boundary'); end if;

  rollback to affected_ids_test;
  dbms_output.put_line('PIT_TABLE affected IDs: passed');
exception
  when others then
    rollback to affected_ids_test;
    raise;
end;
/
