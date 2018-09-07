create or replace package body pit_test_pkg 
as

  C_FIRE_THRESHOLD constant pit_util.ora_name_type := 'PIT_TEST_FIRE_THRESHOLD';
  C_PARAM_GROUP constant pit_util.ora_name_type := 'PIT';
  C_OK constant varchar2(10) := 'OK';
  C_ERROR constant varchar2(10) := 'ERROR';
  C_DATE_FORMAT constant pit_util.ora_name_type := 'dd.mm.yyyy hh24:mi:ss';
  
  
  procedure log (
    p_message in message_type) 
  as
    C_COMPONENT constant varchar2(30) := 'LOG';
  begin
    insert into pit_test_table(message_id, component, outcome, message)
    values (p_message.id, C_COMPONENT, C_OK, p_message);
  end log;
  

  procedure print (
    p_message in message_type) 
  as
    C_COMPONENT constant varchar2(30) := 'PRINT';
  begin
    insert into pit_test_table(message_id, component, outcome, message)
    values (p_message.id, C_COMPONENT, C_OK, p_message);
  end print;
  

  procedure enter(
    p_call_stack in call_stack_type)
  as
    C_COMPONENT constant varchar2(30) := 'ENTER';
  begin
    insert into pit_test_table(message_id, component, outcome, call_stack)
    values (p_call_stack.id, C_COMPONENT, C_OK, p_call_stack);
  end enter;


  procedure leave(
    p_call_stack in call_stack_type) 
  as
    C_COMPONENT constant varchar2(30) := 'LEAVE';
  begin 
    insert into pit_test_table(message_id, component, outcome, call_stack)
    values (p_call_stack.id, C_COMPONENT, C_OK, p_call_stack);
  end leave;


  procedure purge_log(
    p_purge_date in date,
    p_severity_greater_equal in number default null) 
  as
    C_COMPONENT constant varchar2(30) := 'PURGE_LOG';
  begin
    insert into pit_test_table(message_id, component, outcome, params)
    values (pit_log_seq.nextval, C_COMPONENT, C_OK, 
            'Since: ' || to_char(p_purge_date, C_DATE_FORMAT) ||
            ', Level: ' || p_severity_greater_equal);
  end purge_log;


  procedure context_changed(
    p_ctx in pit_context)
  as
    C_COMPONENT constant varchar2(30) := 'CONTEXT_CHANGED';
    l_settings varchar2(2000);
    c_del constant pit_util.flag_type := '|';
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
    values (pit_log_seq.nextval, C_COMPONENT, C_OK, l_settings);
  end context_changed;


  procedure initialize_module(
    self in out nocopy pit_test) 
  as
    l_error pit_test_table.params%type;
    C_COMPONENT constant varchar2(30) := 'INITIALIZE_MODULE';
    pragma autonomous_transaction;
  begin
    self.fire_threshold := param.get_integer(C_FIRE_THRESHOLD, C_PARAM_GROUP);
    self.status := msg.PIT_MODULE_INSTANTIATED;
    insert into pit_test_table(message_id, component, outcome)
    values (pit_log_seq.nextval, C_COMPONENT, C_OK);
    commit;
  exception
    when others then
      l_error := substr(sqlerrm, 1, 2000);
      self.status := msg.PIT_FAIL_MODULE_INIT;
      self.stack := dbms_utility.format_error_stack;
      insert into pit_test_table(message_id, component, outcome, params)
      values (pit_log_seq.nextval, C_COMPONENT, C_ERROR, l_error);
      commit;
  end initialize_module;

end pit_test_pkg;
/