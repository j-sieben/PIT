create or replace package body pit_test_pkg 
as

  c_fire_threshold constant varchar2(30 char) := 'PIT_TEST_FIRE_THRESHOLD';
  c_param_group constant varchar2(20 char) := 'PIT';
  
  procedure log (
    p_message in message_type) 
  as
  begin
    insert into pit_test_table(message_id, component, outcome, message)
    values (p_message.message_name, 'LOG', 'OK', p_message);
  end log;

  procedure print (
    p_message in message_type) 
  as
  begin
    insert into pit_test_table(message_id, component, outcome, message)
    values (p_message.message_name, 'PRINT', 'OK', p_message);
  end print;

  procedure enter(
    p_call_stack in call_stack_type)
  as
  begin
    insert into pit_test_table(message_id, component, outcome, call_stack)
    values (p_call_stack.id, 'ENTER', 'OK', p_call_stack);
  end enter;

  procedure leave(
    p_call_stack in call_stack_type) 
  as
  begin
    insert into pit_test_table(message_id, component, outcome, call_stack)
    values (p_call_stack.id, 'LEAVE', 'OK', p_call_stack);
  end leave;

  procedure purge_log(
    p_purge_date in date) 
  as
  begin
    insert into pit_test_table(message_id, component, outcome, params)
    values (pit_log_seq.nextval, 'PURGE_LOG', 'OK', to_char(p_purge_date, 'dd.mm.yyyy'));
  end purge_log;

  procedure context_changed
  as
  begin
    insert into pit_test_table(message_id, component, outcome)
    values (pit_log_seq.nextval, 'CONTEXT_CHANGED', 'OK');
  end context_changed;

  procedure initialize_module(
    self in out nocopy pit_test) 
  as
    l_error pit_test_table.params%type;
  begin
    self.fire_threshold := param.get_integer(c_fire_threshold, c_param_group);
    self.status := msg.MODULE_INSTANTIATED;
    insert into pit_test_table(message_id, component, outcome)
    values (pit_log_seq.nextval, 'INITIALIZE_MODULE', 'OK');
  exception
    when others then
      l_error := substr(sqlerrm, 1, 2000);
      self.status := msg.MODULE_INITIALIZATION_ERROR;
      self.stack := dbms_utility.format_error_stack;
      insert into pit_test_table(component, outcome, params)
      values ('INITIALIZE_MODULE', 'ERROR', l_error);
  end initialize_module;

end pit_test_pkg;
/