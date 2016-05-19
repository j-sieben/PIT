create or replace package body pit_test_pkg 
as

  c_fire_threshold constant varchar2(30 char) := 'PIT_TEST_FIRE_THRESHOLD';
  c_param_group constant varchar2(20 char) := 'PIT';
  c_ok constant varchar2(10) := 'OK';
  c_error constant varchar2(10) := 'ERROR';
  c_date_format constant varchar2(30) := 'dd.mm.yyyy hh24:mi:ss';
  
  
  procedure log (
    p_message in message_type) 
  as
    c_component constant varchar2(30) := 'LOG';
  begin
    insert into pit_test_table(message_id, component, outcome, message)
    values (p_message.id, c_component, c_ok, p_message);
  end log;
  

  procedure print (
    p_message in message_type) 
  as
    c_component constant varchar2(30) := 'PRINT';
  begin
    insert into pit_test_table(message_id, component, outcome, message)
    values (p_message.id, c_component, c_ok, p_message);
  end print;
  

  procedure enter(
    p_call_stack in call_stack_type)
  as
    c_component constant varchar2(30) := 'ENTER';
  begin
    insert into pit_test_table(message_id, component, outcome, call_stack)
    values (p_call_stack.id, c_component, c_ok, p_call_stack);
  end enter;


  procedure leave(
    p_call_stack in call_stack_type) 
  as
    c_component constant varchar2(30) := 'LEAVE';
  begin 
    insert into pit_test_table(message_id, component, outcome, call_stack)
    values (p_call_stack.id, c_component, c_ok, p_call_stack);
  end leave;


  procedure purge_log(
    p_purge_date in date,
    p_severity_greater_equal in number default null) 
  as
    c_component constant varchar2(30) := 'PURGE_LOG';
  begin
    insert into pit_test_table(message_id, component, outcome, params)
    values (pit_log_seq.nextval, c_component, c_ok, 
            'Since: ' || to_char(p_purge_date, c_date_format) ||
            ', Level: ' || p_severity_greater_equal);
  end purge_log;


  procedure context_changed(
    p_ctx in pit_context)
  as
    c_component constant varchar2(30) := 'CONTEXT_CHANGED';
    l_settings varchar2(2000);
    c_del constant char(1 byte) := '|';
  begin      
    l_settings := 
      p_ctx.log_level || c_del ||
      p_ctx.trace_level || c_del ||
      p_ctx.trace_timing || c_del ||
      p_ctx.log_modules;
    begin
      select parameter_id
        into l_settings
        from parameter
       where (parameter_id like 'CONTEXT_TEST%'
          or parameter_id = 'CONTEXT_DEFAULT')
         and to_char(string_value) = l_settings;
    exception
      when no_data_found then null;
    end;
    insert into pit_test_table(message_id, component, outcome, params)
    values (pit_log_seq.nextval, c_component, c_ok, l_settings);
  end context_changed;


  procedure initialize_module(
    self in out nocopy pit_test) 
  as
    l_error pit_test_table.params%type;
    c_component constant varchar2(30) := 'INITIALIZE_MODULE';
    pragma autonomous_transaction;
  begin
    self.fire_threshold := param.get_integer(c_fire_threshold, c_param_group);
    self.status := msg.PIT_MODULE_INSTANTIATED;
    insert into pit_test_table(message_id, component, outcome)
    values (pit_log_seq.nextval, c_component, c_ok);
    commit;
  exception
    when others then
      l_error := substr(sqlerrm, 1, 2000);
      self.status := msg.PIT_FAIL_MODULE_INIT;
      self.stack := dbms_utility.format_error_stack;
      insert into pit_test_table(message_id, component, outcome, params)
      values (pit_log_seq.nextval, c_component, c_error, l_error);
      commit;
  end initialize_module;

end pit_test_pkg;
/