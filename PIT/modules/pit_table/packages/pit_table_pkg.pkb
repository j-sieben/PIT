create or replace package body pit_table_pkg 
as
  C_FIRE_THRESHOLD constant varchar2(30 char) := 'PIT_TABLE_FIRE_THRESHOLD';
  C_PARAM_GROUP constant varchar2(20 char) := 'PIT';
  

  procedure log(
    p_message in message_type)
  as
  begin
    insert into pit_table_log
      (log_id, log_date, log_session_id, log_user_name, 
       log_message_text, log_message_name, log_message_args, 
       log_message_stack, log_message_backtrace, log_severity)
    values
      (p_message.id, localtimestamp, substr(p_message.session_id, 1, 64), substr(p_message.user_name, 1, 30),
       p_message.message_text, p_message.message_name, pit_util.cast_to_char_list(p_message.message_args), 
       p_message.stack, p_message.backtrace, p_message.severity);
  end log;


  procedure purge(
    p_date_until in date,
    p_severity_greater_equal in number default null)
  as
  begin
    delete from pit_table_log
     where log_date <= p_date_until
       and log_severity >= coalesce(p_severity_greater_equal, 0);
    delete from pit_table_call_stack
     where cls_log_date <= p_date_until;
  end;


  procedure enter(
    p_call_stack in call_stack_type)
  as
    l_id pls_integer;
    l_idx varchar2(127);
  begin
    insert into pit_table_call_stack
      (cls_id, cls_log_date, cls_call_level, cls_action, 
       cls_session_id, cls_user_name, cls_method_name, cls_module_name,
       cls_elapsed, cls_elapsed_cpu, cls_total_time, cls_total_time_cpu)
    values
      (p_call_stack.id, coalesce(p_call_stack.wall_clock, localtimestamp), p_call_stack.call_level, 'ENTER',
       substr(p_call_stack.session_id, 1, 64), substr(p_call_stack.user_name, 1, 30), p_call_stack.method_name, p_call_stack.module_name,
       p_call_stack.elapsed, p_call_stack.elapsed_cpu, p_call_stack.total, p_call_stack.total_cpu);
    
    if p_call_stack.params is not null then
      insert into pit_table_call_params(clp_cls_id, clp_param_name, clp_param_value)
      select p_call_stack.id, p_param, p_value
        from table(p_call_stack.params);
    end if;
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
    insert into pit_table_call_stack
      (cls_id, cls_log_date, cls_call_level, cls_action, 
       cls_session_id, cls_user_name, cls_module_name, cls_method_name,
       cls_elapsed, cls_elapsed_cpu, cls_total_time, cls_total_time_cpu)
    values
      (p_call_stack.id, coalesce(p_call_stack.wall_clock, localtimestamp), p_call_stack.call_level, 'LEAVE',
       p_call_stack.session_id, p_call_stack.user_name, p_call_stack.module_name, p_call_stack.method_name, 
       p_call_stack.elapsed, p_call_stack.elapsed_cpu, p_call_stack.total, p_call_stack.total_cpu);
    
    if p_call_stack.params is not null then
      insert into pit_table_call_params(clp_cls_id, clp_param_name, clp_param_value)
      select p_call_stack.id, p_param, p_value
        from table(p_call_stack.params);
    end if;
  end leave;


  procedure initialize_module(
    self in out pit_table)
  as
  begin
    self.fire_threshold := param.get_integer(C_FIRE_THRESHOLD, C_PARAM_GROUP);
    self.status := msg.PIT_MODULE_INSTANTIATED;
  exception
    when others then
      self.status := msg.PIT_FAIL_MODULE_INIT;
      self.stack  := dbms_utility.format_error_stack;
  end initialize_module;

end pit_table_pkg;
/

