create or replace package body pit_table_pkg 
as
  c_fire_threshold constant varchar2(30 char) := 'PIT_TABLE_FIRE_THRESHOLD';
  c_param_group    constant varchar2(20 char) := 'PIT';

  procedure log(
    p_message in message_type)
  as
  begin
    insert into pit_log
      (log_id, log_date, session_id, user_name, 
       msg_text, msg_stack, msg_backtrace, severity)
    values
      (pit_log_seq.nextval, localtimestamp, 
       substr(p_message.session_id, 1, 64), substr(p_message.user_name, 1, 30),
       p_message.message_text, p_message.stack, p_message.backtrace, p_message.severity);
  end log;


  procedure purge(
    p_date_until in date,
    p_severity_greater_equal in number default null)
  as
  begin
    delete from pit_log
     where log_date <= p_date_until
       and severity >= coalesce(p_severity_greater_equal, 0);
    delete from pit_call_stack
     where wall_clock <= p_date_until;
  end;


  procedure enter(
    p_call_stack in call_stack_type)
  as
    l_id pls_integer;
    l_idx varchar2(127);
  begin
    insert into pit_call_stack
      (id, call_level, action, session_id, user_name, method_name, module_name,
       wall_clock, elapsed, elapsed_cpu, total_time, total_time_cpu)
    values
      (p_call_stack.id, p_call_stack.call_level, 'ENTER',
       substr(p_call_stack.session_id, 1, 64), substr(p_call_stack.user_name, 1, 30),
       p_call_stack.method_name, p_call_stack.module_name,
       p_call_stack.wall_clock, p_call_stack.elapsed,
       p_call_stack.elapsed_cpu, p_call_stack.total, p_call_stack.total_cpu);
  end enter;


  procedure leave(
    p_call_stack in call_stack_type)
  as
    l_elapsed varchar2(40);
    l_owner varchar2(30);
    l_name varchar2(30);
    l_lineno number;
    l_caller_t varchar2(30);
    l_idx varchar2(127);
  begin
    insert into pit_call_stack
      (id, call_level, action, session_id, user_name, method_name, module_name,
       wall_clock, elapsed, elapsed_cpu, total_time, total_time_cpu)
    values
      (p_call_stack.id, p_call_stack.call_level, 'LEAVE',
       p_call_stack.session_id, p_call_stack.user_name,
       p_call_stack.method_name, p_call_stack.module_name,
       p_call_stack.wall_clock, p_call_stack.elapsed,
       p_call_stack.elapsed_cpu, p_call_stack.total, p_call_stack.total_cpu);
  end leave;


  procedure initialize_module(
    self in out pit_table)
  as
  begin
    self.fire_threshold := param.get_integer(c_fire_threshold, c_param_group);
    self.status := msg.PIT_MODULE_INSTANTIATED;
  exception
    when others then
      self.status := msg.PIT_FAIL_MODULE_INIT;
      self.stack  := dbms_utility.format_error_stack;
  end initialize_module;

end pit_table_pkg;
/

