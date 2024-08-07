create or replace package body ut_pit 
as

  /** Implementation of unit test for package PIT */
  
  
  type result_rec is record(
    log_count pls_integer := 0,
    state_count pls_integer := 0,
    enter_count pls_integer := 0,
    leave_count pls_integer := 0,
    print_count pls_integer := 0,
    notify_count pls_integer := 0,
    context_changed_count pls_integer := 0,
    message message_type,
    params msg_params,
    call_stack call_stack_type,
    context_instance pit_context);
    
  g_result result_rec;
  
  C_UT_OUT constant varchar2(128 byte) := 'PIT_UT';
  C_AFFECTED_ID constant varchar2(128 byte) := '123456';
  C_ERROR_CODE constant varchar2(128 byte) := '654321';
  C_DUMMY_TEXT constant varchar2(128 Byte) := 'Hello World';
  C_DUMMY_NUMBER constant number := 12345;
  C_DUMMY_DATE constant date := date '2020-02-29';
  C_STMT_WITH_RESULT constant varchar2(4000 byte) := q'^select sysdate from dual^';
  C_STMT_W_O_RESULT constant varchar2(4000 byte) := q'^select NULL from dual where null is not null^';
  
  
  /** Method increments an internal counter and returns the incremented value
   * %param  p_counter counter variable
   * %usage  Utility to wrap incrementation logic
   */
  function increment_counter(
    p_counter in out nocopy pls_integer)
  return pls_integer
  as
  begin
    return coalesce(p_counter, 0) + 1;
  end increment_counter;
  
  
  /** Method to write a test outcome to global G_RESULT type
   * %param  p_log              Flag to indicate whether a LOG event was raised
   * %param  p_state            Flag to indicate whether a LOG_STATE event was raised
   * %param  p_enter            Flag to indicate whether a ENTER event was raised
   * %param  p_leave            Flag to indicate whether a LEAVE event was raised
   * %param  p_print            Flag to indicate whether a PRINT event was raised
   * %param  p_notify           Flag to indicate whether a NOTIFY event was raised
   * %param  p_context_changed  Flag to indicate whether a CONTEXT_CHANGED event was raised
   * %param  p_message          MESSAGE_TYPE instance
   * %param  p_params           MSG_PARAMS instance
   * %param  p_call_stack       CALL_STACK_TYPE instance
   * %param  p_log_state        LOG_STATE_TYPE instance
   * %param  p_context          CONTEXT_TYPE instance
   * %usage  Is used to accept the output of a test run and make it available for expect functions of UT
   */
  procedure set_result(
    p_log in boolean default false,
    p_state in boolean default false,
    p_enter in boolean default false,
    p_leave in boolean default false,
    p_print in boolean default false,
    p_notify in boolean default false,
    p_context_changed in boolean default false,
    p_message in message_type default null,
    p_params in msg_params default null,
    p_call_stack in call_stack_type default null,
    p_log_state in log_state_type default null,
    p_context in pit_context default null)
  as
  begin
    if p_log then
      g_result.log_count := increment_counter(g_result.log_count);
    end if;
    if p_state then
      g_result.state_count := increment_counter(g_result.state_count);
    end if;
    if p_enter then
      g_result.enter_count := increment_counter(g_result.enter_count);
    end if;
    if p_leave then
      g_result.leave_count := increment_counter(g_result.leave_count);
    end if;
    if p_print then
      g_result.print_count := increment_counter(g_result.print_count);
    end if;
    if p_notify then
      g_result.notify_count := increment_counter(g_result.notify_count);
    end if;
    if p_context_changed then
      g_result.context_changed_count := increment_counter(g_result.context_changed_count);
    end if;
    g_result.message := p_message;
    g_result.params := p_params;
    g_result.call_stack := p_call_stack;
    g_result.log_state := p_log_state;
    g_result.context_instance := p_context;
  end set_result;
  
  
  /** Method to reset the last test result
   * %usage  Is used to clear the last test result
   */
  procedure reset_result
  as
  begin
    g_result := null;
  end reset_result;
  
  
  procedure before_all
  as
  begin
    pit.initialize;
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, C_UT_OUT);
  end before_all;
  
  
  procedure after_all
  as
  begin
    pit.initialize;
    reset_result;
  end after_all;
  
  
  procedure before_each
  as
  begin
    pit.initialize;
    reset_result;
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, C_UT_OUT);
  end before_each;
  
  
  procedure after_each
  as
    l_stack_depth pls_integer;
  begin
    pit.reset_context;
    l_stack_depth := pit_pkg.get_actual_call_stack_depth;
    if l_stack_depth > 0 then
      pit.raise_error(msg.PIT_PASS_MESSAGE, msg_args('Call Stack nicht korrekt bereinigt: ' || l_stack_depth));
    end if;
  end after_each;
  
  /** Helper Methods to check call stack */
  function b (
    p_value in number)
  return number
  as
    l_value number;
  begin
    pit.enter_detailed('B',
      p_params => msg_params(msg_param('p_value', to_char(p_value))));
    
    l_value := 1 / p_value;
    
    pit.leave_detailed(
      p_params => msg_params(msg_param('Result', to_char(l_value))));
    return l_value;
  end b;
  
  
  function a (
    p_value in number)
  return number
  as
    l_value number;
  begin
    pit.enter_optional('A',
      p_params => msg_params(msg_param('p_value', to_char(p_value))));
    
    l_value := b(p_value);
    
    pit.leave_optional(
      p_params => msg_params(msg_param('Result', to_char(l_value))));
    return l_value;
  end a;
  
  
  procedure long_op_nested(
    p_target in varchar2,
    p_sofar in number)
  as
  begin
    pit.long_op(
      p_target => p_target,
      p_sofar => p_sofar);
  end long_op_nested;

  --
  -- test log case log_normal_execution: Logging switched off but LOG still gives a message
  --
  procedure log_normal_execution 
  as
  begin
    pit.log(
      p_message_name => msg.PIT_PASS_MESSAGE,
      p_msg_args => msg_args(C_DUMMY_TEXT),
      p_affected_id => null,
      p_error_code => null,
      p_log_threshold => null,
      p_log_modules => C_UT_OUT);
      
    ut.expect(g_result.log_count).to_be_greater_than(0);
    ut.expect(g_result.message.message_name).to_equal(msg.PIT_PASS_MESSAGE);
  end log_normal_execution;

  --
  -- test log case log_not_set_before: The output module was not set before but logging still works
  --
  procedure log_not_set_before 
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, 'PIT_CONSOLE');
    pit.log(
      p_message_name => msg.PIT_PASS_MESSAGE,
      p_msg_args => msg_args(C_DUMMY_TEXT),
      p_affected_id => null,
      p_error_code => null,
      p_log_threshold => null,
      p_log_modules => C_UT_OUT);
      
    ut.expect(g_result.log_count).to_equal(1);
    ut.expect(g_result.message.message_name).to_equal(msg.PIT_PASS_MESSAGE);
  end log_not_set_before;

  --
  -- test log case log_as_second_module: LOG uses PIT_UT as second output module
  --
  procedure log_as_second_module 
  as
  begin
    pit.log(
      p_message_name => msg.PIT_PASS_MESSAGE,
      p_msg_args => msg_args(C_DUMMY_TEXT),
      p_affected_id => null,
      p_error_code => null,
      p_log_threshold => null,
      p_log_modules => 'PIT_CONSOLE:' || C_UT_OUT);
      
    ut.expect(g_result.log_count).to_equal(1);
    ut.expect(g_result.message.message_name).to_equal(msg.PIT_PASS_MESSAGE);
  end log_as_second_module;

  --
  -- test log case log_passes_error_code: Attribute ERROR_CODE is passed if explicitly set
  --
  procedure log_passes_error_code
  as
  begin
    pit.log(
      p_message_name => msg.PIT_PASS_MESSAGE,
      p_msg_args => msg_args(C_DUMMY_TEXT),
      p_affected_id => null,
      p_error_code => C_ERROR_CODE,
      p_log_threshold => null,
      p_log_modules => C_UT_OUT);
      
    ut.expect(g_result.message.error_code).to_equal(C_ERROR_CODE);
  end log_passes_error_code;

  --
  -- test log case log_filters_threshold: Threshold is set lower than the message. Expect to not log
  --
  procedure log_filters_threshold
  as
  begin
    pit.log(
      p_message_name => msg.PIT_PASS_MESSAGE,
      p_msg_args => msg_args(C_DUMMY_TEXT),
      p_affected_id => null,
      p_error_code => null,
      p_log_threshold => pit.LEVEL_DEBUG,
      p_log_modules => C_UT_OUT);
      
    ut.expect(g_result.message.message_name).to_be_null;
  end log_filters_threshold;

  --
  -- test log case log_passes_threshold: Threshold is set to the same severity than the message. Expect to log
  --
  procedure log_passes_threshold
  as
  begin
    pit.log(
      p_message_name => msg.PIT_PASS_MESSAGE,
      p_msg_args => msg_args(C_DUMMY_TEXT),
      p_affected_id => null,
      p_error_code => null,
      p_log_threshold => pit.LEVEL_ALL,
      p_log_modules => C_UT_OUT);
      
    ut.expect(g_result.message.message_name).to_equal(msg.PIT_PASS_MESSAGE);
  end log_passes_threshold;

  --
  -- test log case log_passes_affected_id: If set, LOG passes the affected id
  --
  procedure log_passes_affected_id 
  as
  begin
    pit.log(
      p_message_name => msg.PIT_PASS_MESSAGE,
      p_msg_args => msg_args(C_DUMMY_TEXT),
      p_affected_id => C_AFFECTED_ID,
      p_error_code => null,
      p_log_threshold => null,
      p_log_modules => C_UT_OUT);
      
    ut.expect(g_result.message.affected_id).to_equal(C_AFFECTED_ID);
  end log_passes_affected_id;
  

  --
  -- test log_state case log_normal_execution: LOG_STATE passes in parameters instance
  --
  procedure log_state_normal_execution 
  as
  begin
    pit.log_state(
      p_params => msg_params(
                    msg_param('Foo1', 'Test1'),
                    msg_param('Foo2', 'Test2')));
      
    ut.expect(g_result.log_count).to_be_greater_than(0);
    ut.expect(g_result.params.count).to_equal(2);
  end log_normal_execution;

  --
  -- test handle_exception_captures_error: If an error was raised, it is possible to capture it
  --
  procedure handle_exception_captures_error 
  as
    l_result  number;
  begin
    pit.enter_mandatory;
    l_result := a(0);
  exception
    when ZERO_DIVIDE then
      pit.handle_exception(msg.PIT_PASS_MESSAGE, msg_args(substr(sqlerrm, 12)), p_error_code => sqlcode);
      ut.expect(g_result.message.message_name).to_equal(msg.PIT_PASS_MESSAGE);
  end handle_exception_captures_error;

  --
  -- test handle_exception_passes_message: If no message is passed in, it reuses the last message created
  --
  procedure handle_exception_passes_message 
  as
  begin
    pit.raise_error(msg.SQL_ERROR, msg_args('Some error'));
  exception
    when msg.SQL_ERROR_ERR then
      pit.handle_exception;
      ut.expect(g_result.message.message_name).to_equal(msg.SQL_ERROR);
  end handle_exception_passes_message;

  --
  -- test handle_exception_passes_error_code: ...
  --
  procedure handle_exception_passes_error_code 
  as
    l_result  number;
  begin
    pit.enter_mandatory;
    l_result := a(0);
  exception
    when ZERO_DIVIDE then
      pit.handle_exception(msg.PIT_PASS_MESSAGE, msg_args(substr(sqlerrm, 12)), p_error_code => C_ERROR_CODE);
      ut.expect(g_result.message.error_code).to_equal(C_ERROR_CODE);
  end handle_exception_passes_error_code;

  --
  -- test handle_exception_passes_affected_id: ...
  --
  procedure handle_exception_passes_affected_id 
  as
    l_result  number;
  begin
    pit.enter_mandatory;
    l_result := a(0);
  exception
    when ZERO_DIVIDE then
      pit.handle_exception(msg.PIT_PASS_MESSAGE, msg_args(substr(sqlerrm, 12)), p_affected_id => C_AFFECTED_ID);
      ut.expect(g_result.message.affected_id).to_equal(C_AFFECTED_ID);
  end handle_exception_passes_affected_id;

  --
  -- test handle_exception_closes_stack: A call to SQL_EXCEPTION must maintain the call stack
  --
  procedure handle_exception_closes_stack
  as
    l_result  number;
  begin
    pit.set_context(pit.LEVEL_ERROR, 50, false, C_UT_OUT);
    pit.enter_mandatory;
    l_result := a(0);
  exception
    when ZERO_DIVIDE then
      pit.handle_exception(msg.PIT_PASS_MESSAGE, msg_args(substr(sqlerrm, 12)), p_affected_id => C_AFFECTED_ID);
      ut.expect(g_result.enter_count).to_equal(3);
      ut.expect(g_result.leave_count).to_equal(g_result.enter_count);
  end handle_exception_closes_stack;



  --
  -- test stop_throws_error: If an error was raised, it is possible to capture and rethrow it
  --
  procedure stop_throws_error 
  as
    l_result  number;
  begin
    pit.enter_mandatory;
    l_result := a(0);
  exception
    when ZERO_DIVIDE then
      pit.stop(msg.SQL_ERROR);
  end stop_throws_error;

  --
  -- test stop_passes_message: If no message is passed in, it reuses the last message created
  --
  procedure stop_passes_message 
  as
  begin
    begin
      pit.raise_error(msg.SQL_ERROR, msg_args(C_DUMMY_TEXT));
    exception
      when msg.SQL_ERROR_ERR then
        pit.stop;
    end;
  exception
    when msg.SQL_ERROR_ERR then
      ut.expect(g_result.message.message_name).to_equal(msg.SQL_ERROR);
  end stop_passes_message;

  --
  -- test stop_passes_error_code: ...
  --
  procedure stop_passes_error_code 
  as
    l_result  number;
  begin
    begin
      pit.enter_mandatory;
      l_result := a(0);
    exception
      when ZERO_DIVIDE then
        pit.handle_exception(msg.SQL_ERROR, p_error_code => C_ERROR_CODE);
    end;
  exception
    when msg.SQL_ERROR_ERR then
        ut.expect(g_result.message.error_code).to_equal(C_ERROR_CODE);
  end stop_passes_error_code;

  --
  -- test stop_passes_affected_id: ...
  --
  procedure stop_passes_affected_id 
  as
    l_divisor integer := 0;
    l_result  number;
  begin
    begin
      pit.enter_mandatory;
      l_result := a(0);
    exception
      when ZERO_DIVIDE then
        pit.stop(msg.SQL_ERROR, p_affected_id => C_AFFECTED_ID);
    end;
  exception
    when msg.SQL_ERROR_ERR then
      ut.expect(g_result.message.affected_id).to_equal(C_AFFECTED_ID);
  end stop_passes_affected_id;

  --
  -- test stop_closes_stack: A call to STOP must maintain the call stack
  --
  procedure stop_closes_stack
  as
    l_result  number;
  begin
    begin
      pit.set_context(pit.LEVEL_ERROR, pit.TRACE_ALL, false, C_UT_OUT);
      pit.enter_mandatory;
      l_result := a(0);
    exception
      when ZERO_DIVIDE then
        pit.stop(msg.SQL_ERROR);
    end;
  exception
    when msg.SQL_ERROR_ERR then
      ut.expect(g_result.enter_count).to_equal(3);
      ut.expect(g_result.enter_count).to_equal(g_result.leave_count);
  end stop_closes_stack;

  --
  -- test stop_closes_stack_completely: A call to STOP must close the call stack completely
  --
  procedure stop_closes_stack_completely
  as
    l_result  number;
  begin
    begin
      pit.set_context(pit.LEVEL_ERROR, pit.TRACE_ALL, false, C_UT_OUT);
      pit.enter_mandatory;
      l_result := a(0);
    exception
      when ZERO_DIVIDE then
        pit.stop(msg.SQL_ERROR);
    end;
  exception
    when msg.SQL_ERROR_ERR then
      ut.expect(g_result.enter_count).to_equal(3);
      ut.expect(g_result.enter_count).to_equal(g_result.leave_count);
  end stop_closes_stack_completely;

  --
  -- test enter_normally: Check that enter method is called
  --
  procedure enter_normally 
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_ALL, false, C_UT_OUT);
    pit.enter;
    ut.expect(g_result.enter_count).to_equal(1);
    pit.leave;
  end enter_normally;

  --
  -- test enter_level: Checks that an ENTER event is raised only if context settings allow for it
  --
  procedure enter_level
  as
  begin
    dbms_output.put_line('.  mandatory is not traced');
    reset_result;
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_OFF, false, C_UT_OUT);
    pit.enter(p_trace_level => pit.TRACE_MANDATORY);
    pit.enter_mandatory;
    ut.expect(coalesce(g_result.enter_count, 0)).to_equal(0);
    pit.leave_mandatory;
    pit.leave(p_trace_level => pit.TRACE_MANDATORY);
    dbms_output.put_line('.  mandatory is traced');
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_MANDATORY, false, C_UT_OUT);
    pit.enter(p_trace_level => pit.TRACE_MANDATORY);
    pit.enter_mandatory;
    pit.leave_mandatory;
    pit.leave(p_trace_level => pit.TRACE_MANDATORY);
    ut.expect(g_result.enter_count).to_equal(2);
    
    dbms_output.put_line('.  optional is not traced');
    reset_result;
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_MANDATORY, false, C_UT_OUT);
    pit.enter(p_trace_level => pit.TRACE_OPTIONAL);
    pit.enter_optional;
    ut.expect(coalesce(g_result.enter_count, 0)).to_equal(0);
    pit.leave_optional;
    pit.leave(p_trace_level => pit.TRACE_OPTIONAL);
    dbms_output.put_line('.  optional is traced');
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_OPTIONAL, false, C_UT_OUT);
    pit.enter(p_trace_level => pit.TRACE_OPTIONAL);
    pit.enter_optional;
    pit.leave_optional;
    pit.leave(p_trace_level => pit.TRACE_OPTIONAL);
    ut.expect(g_result.enter_count).to_equal(2);
    
    dbms_output.put_line('.  detailed is not traced');
    reset_result;
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_OPTIONAL, false, C_UT_OUT);
    pit.enter(p_trace_level => pit.TRACE_DETAILED);
    pit.enter_detailed;
    ut.expect(coalesce(g_result.enter_count, 0)).to_equal(0);
    pit.leave_detailed;
    pit.leave(p_trace_level => pit.TRACE_DETAILED);
    dbms_output.put_line('.  detailed is traced');
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_DETAILED, false, C_UT_OUT);
    pit.enter(p_trace_level => pit.TRACE_DETAILED);
    pit.enter_detailed;
    pit.leave_detailed;
    pit.leave(p_trace_level => pit.TRACE_DETAILED);
    ut.expect(g_result.enter_count).to_equal(2);
    
    dbms_output.put_line('.  all is not traced');
    reset_result;
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_DETAILED, false, C_UT_OUT);
    pit.enter(p_trace_level => pit.TRACE_ALL);
    ut.expect(coalesce(g_result.enter_count, 0)).to_equal(0);
    pit.leave(p_trace_level => pit.TRACE_ALL);
    dbms_output.put_line('.  all is traced');
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_ALL, false, C_UT_OUT);
    pit.enter(p_trace_level => pit.TRACE_ALL);
    pit.leave(p_trace_level => pit.TRACE_ALL);
    ut.expect(g_result.enter_count).to_equal(1);
  end enter_level;

  --
  -- test enter_passes_parameters: Passed in parameters are delivered to the output modules
  --
  procedure enter_passes_parameters
  as
  begin
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_ALL, false, C_UT_OUT);
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('Param_1', 'Value_1'),
                    msg_param('Param_2', 'Value_2')));
    ut.expect(g_result.call_stack.params.count).to_equal(2);
    pit.leave_mandatory;
  end enter_passes_parameters;

  --
  -- test enter_mandatory_sets_client_info: ENTER_MANDATORY will set client_info column to MODULE.ACTION
  --
  procedure enter_mandatory_sets_client_info
  as
  begin
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_MANDATORY, false, C_UT_OUT);
    pit.enter_mandatory(p_client_info => C_DUMMY_TEXT);
    ut.expect(sys_context('USERENV', 'CLIENT_INFO')).to_equal(C_DUMMY_TEXT);
    pit.leave_mandatory;
  end enter_mandatory_sets_client_info;

  --
  -- test enter_sets_module_action: Method sets and resets module and action
  --
  procedure enter_sets_module_action
  as
    l_result number;
  begin
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_ALL, false, C_UT_OUT);
    pit.enter_mandatory;
    ut.expect(sys_context('USERENV', 'MODULE')).to_equal('ut_pit');
    ut.expect(sys_context('USERENV', 'ACTION')).to_equal('enter_sets_module_action');
    l_result := a(1);
    ut.expect(sys_context('USERENV', 'MODULE')).to_equal('ut_pit');
    ut.expect(sys_context('USERENV', 'ACTION')).to_equal('enter_sets_module_action');
    pit.leave_mandatory;
  end enter_sets_module_action;

  --
  -- test leave_normally: Check that leave method is called
  --
  procedure leave_normally
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_ALL, false, C_UT_OUT);
    pit.enter;
    pit.leave;
    ut.expect(g_result.leave_count).to_equal(1);
  end leave_normally;

  --
  -- test leave_level: Checks that an LEAVE event is raised only if context settings allow for it
  --
  procedure leave_level
  as
  begin
    dbms_output.put_line('.  mandatory is not traced');
    reset_result;
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_OFF, false, C_UT_OUT);
    pit.enter(p_trace_level => pit.TRACE_MANDATORY);
    pit.enter_mandatory;
    ut.expect(coalesce(g_result.leave_count, 0)).to_equal(0);
    pit.leave_mandatory;
    pit.leave(p_trace_level => pit.TRACE_MANDATORY);
    dbms_output.put_line('.  mandatory is traced');
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_MANDATORY, false, C_UT_OUT);
    pit.enter(p_trace_level => pit.TRACE_MANDATORY);
    pit.enter_mandatory;
    pit.leave_mandatory;
    pit.leave(p_trace_level => pit.TRACE_MANDATORY);
    ut.expect(g_result.leave_count).to_equal(2);
    
    dbms_output.put_line('.  optional is not traced');
    reset_result;
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_MANDATORY, false, C_UT_OUT);
    pit.enter(p_trace_level => pit.TRACE_OPTIONAL);
    pit.enter_optional;
    ut.expect(coalesce(g_result.leave_count, 0)).to_equal(0);
    pit.leave_optional;
    pit.leave(p_trace_level => pit.TRACE_OPTIONAL);
    dbms_output.put_line('.  optional is traced');
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_OPTIONAL, false, C_UT_OUT);
    pit.enter(p_trace_level => pit.TRACE_OPTIONAL);
    pit.enter_optional;
    pit.leave_optional;
    pit.leave(p_trace_level => pit.TRACE_OPTIONAL);
    ut.expect(g_result.leave_count).to_equal(2);
    
    dbms_output.put_line('.  detailed is not traced');
    reset_result;
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_OPTIONAL, false, C_UT_OUT);
    pit.enter(p_trace_level => pit.TRACE_DETAILED);
    pit.enter_detailed;
    ut.expect(coalesce(g_result.leave_count, 0)).to_equal(0);
    pit.leave_detailed;
    pit.leave(p_trace_level => pit.TRACE_DETAILED);
    dbms_output.put_line('.  detailed is traced');
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_DETAILED, false, C_UT_OUT);
    pit.enter(p_trace_level => pit.TRACE_DETAILED);
    pit.enter_detailed;
    pit.leave_detailed;
    pit.leave(p_trace_level => pit.TRACE_DETAILED);
    ut.expect(g_result.leave_count).to_equal(2);
    
    dbms_output.put_line('.  all is not traced');
    reset_result;
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_DETAILED, false, C_UT_OUT);
    pit.enter(p_trace_level => pit.TRACE_ALL);
    ut.expect(coalesce(g_result.leave_count, 0)).to_equal(0);
    pit.leave(p_trace_level => pit.TRACE_ALL);
    dbms_output.put_line('.  all is traced');
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_ALL, false, C_UT_OUT);
    pit.enter(p_trace_level => pit.TRACE_ALL);
    pit.leave(p_trace_level => pit.TRACE_ALL);
    ut.expect(g_result.leave_count).to_equal(1);
  end leave_level;

  --
  -- test leave_passes_parameters: Passed in parameters are delivered to the output modules
  --
  procedure leave_passes_parameters
  as
  begin
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_ALL, false, C_UT_OUT);
    pit.enter_mandatory;
    pit.leave_mandatory(
      p_params => msg_params(
                    msg_param('Param_1', 'Value_1'),
                    msg_param('Param_2', 'Value_2')));
    ut.expect(g_result.call_stack.params.count).to_equal(2);
  end leave_passes_parameters;

  --
  -- test leave_resets_module_action: Method LEAVE nulls out module and action when stack is empty
  --
  procedure leave_resets_module_action
  as
    l_result number;
  begin
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_ALL, false, C_UT_OUT);
    pit.enter_mandatory;
    l_result := a(1);
    pit.leave_mandatory;
    ut.expect(sys_context('USERENV', 'MODULE')).to_be_null;
    ut.expect(sys_context('USERENV', 'ACTION')).to_be_null;
  end leave_resets_module_action;

  --
  -- test leave_get_timing: Method LEAVE captures timing information if required to do so
  --
  procedure leave_get_timing
  as
    l_result number;
  begin
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_ALL, true, C_UT_OUT);
    pit.enter_mandatory;
    l_result := a(1);
    pit.leave_mandatory;
    ut.expect(g_result.call_stack.wall_clock).to_be_not_null;
  end leave_get_timing;

  --
  -- test leave_dont_get_timing: Does not capture timing information if not requested to do so
  --
  procedure leave_dont_get_timing
  as
    l_result number;
  begin
    pit.set_context(pit.LEVEL_OFF, pit.TRACE_ALL, false, C_UT_OUT);
    pit.enter_mandatory;
    l_result := a(1);
    pit.leave_mandatory;
    ut.expect(g_result.call_stack.wall_clock).to_be_null;
  end leave_dont_get_timing;

  --
  -- test long_op_opname: This wrapper around DBMS_APPLICAITON_LONGOPS takes OP_NAME from call stack
  --
  procedure long_op_opname
  as
    l_cur sys_refcursor;
    l_test_case varchar2(32);
  begin
    select 'Test_' || ora_hash(to_char(systimestamp))
      into l_test_case
      from dual;
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_MANDATORY, false, C_UT_OUT);
    pit.enter_mandatory;
    for i in 1 .. 10 loop
      pit.long_op(
        p_target => l_test_case,
        p_sofar => i * 10,
        p_total => 100);
    end loop;
    pit.leave_mandatory;
    open l_cur for
      select null
        from v$session_longops
       where sid = sys_context('USERENV', 'SID')
         and target_desc = l_test_case
         and sofar = totalwork
         and opname = 'ut_pit.long_op_opname';
    ut.expect(l_cur).to_have_count(1);
  end long_op_opname;

  --
  -- test long_op_nested: Long op works if PIT was set on outer method
  --
  procedure long_op_nested
  as
    l_cur sys_refcursor;
    l_test_case varchar2(32);
  begin
    select 'Test_' || ora_hash(to_char(systimestamp))
      into l_test_case
      from dual;
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_MANDATORY, false, C_UT_OUT);
    pit.enter_mandatory;
    for i in 1 .. 10 loop
      long_op_nested(l_test_case, i * 10);
    end loop;
    open l_cur for
      select null
        from v$session_longops
       where sid = sys_context('USERENV', 'SID')
         and target_desc = l_test_case
         and sofar = totalwork
         and opname = 'ut_pit.long_op_nested';
    ut.expect(l_cur).to_have_count(1);
    pit.leave_mandatory;
  end long_op_nested;

  --
  -- test print_null_message: If no message name is passed in, a warning is emitted
  --
  procedure print_null_message
  as
  begin
    pit.set_context(pit.LEVEL_WARN, pit.TRACE_OFF, false, C_UT_OUT);
    pit.print(
      p_message_name => null,
      p_msg_args => null);
      
    ut.expect(coalesce(g_result.print_count, 0)).to_equal(0);
    ut.expect(g_result.log_count).to_equal(1);
    ut.expect(g_result.message.severity).to_equal(pit.LEVEL_WARN);
  end print_null_message;

  --
  -- test print_normal_execution: Passes messages to the output modules regardless of parameter settings
  --
  procedure print_normal_execution
  as
  begin
    pit.print(
      p_message_name => msg.PIT_PASS_MESSAGE,
      p_msg_args => msg_args(C_DUMMY_TEXT));
      
    ut.expect(g_result.print_count).to_be_greater_than(0);
    ut.expect(g_result.message.message_name).to_equal(msg.PIT_PASS_MESSAGE);
  end print_normal_execution;
  
  
  --
  -- test notify_normal_execution: Logging switched off but NOTIFY still gives a message
  --
  procedure notify_normal_execution 
  as
  begin
    pit.notify(
      p_message_name => msg.PIT_PASS_MESSAGE,
      p_msg_args => msg_args(C_DUMMY_TEXT),
      p_affected_id => null,
      p_log_threshold => null,
      p_log_modules => null);
      
    ut.expect(g_result.notify_count).to_be_greater_than(0);
    ut.expect(g_result.message.message_name).to_equal(msg.PIT_PASS_MESSAGE);
  end notify_normal_execution;

  --
  -- test notify_not_set_before: The output module was not set before but notifying still works
  --
  procedure notify_not_set_before 
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, 'PIT_CONSOLE');
    pit.notify(
      p_message_name => msg.PIT_PASS_MESSAGE,
      p_msg_args => msg_args(C_DUMMY_TEXT),
      p_affected_id => null,
      p_log_threshold => null,
      p_log_modules => C_UT_OUT);
      
    ut.expect(g_result.notify_count).to_equal(1);
    ut.expect(g_result.message.message_name).to_equal(msg.PIT_PASS_MESSAGE);
  end notify_not_set_before;

  --
  -- test notify_as_second_module: NOTIFY uses PIT_UT as second output module
  --
  procedure notify_as_second_module 
  as
  begin
    pit.notify(
      p_message_name => msg.PIT_PASS_MESSAGE,
      p_msg_args => msg_args(C_DUMMY_TEXT),
      p_affected_id => null,
      p_log_threshold => null,
      p_log_modules => 'PIT_CONSOLE:PIT_UT');
      
    ut.expect(g_result.notify_count).to_equal(1);
    ut.expect(g_result.message.message_name).to_equal(msg.PIT_PASS_MESSAGE);
  end notify_as_second_module;

  --
  -- test notify_filters_threshold: Threshold is set lower than the message. Expect to not notify
  --
  procedure notify_filters_threshold
  as
  begin
    pit.notify(
      p_message_name => msg.PIT_PASS_MESSAGE,
      p_msg_args => msg_args(C_DUMMY_TEXT),
      p_affected_id => null,
      p_log_threshold => pit.LEVEL_DEBUG,
      p_log_modules => C_UT_OUT);
      
    ut.expect(g_result.message.message_name).to_be_null;
  end notify_filters_threshold;

  --
  -- test notify_passes_threshold: Threshold is set to the same severity than the message. Expect to notify
  --
  procedure notify_passes_threshold
  as
  begin
    pit.notify(
      p_message_name => msg.PIT_PASS_MESSAGE,
      p_msg_args => msg_args(C_DUMMY_TEXT),
      p_affected_id => null,
      p_log_threshold => pit.LEVEL_ALL,
      p_log_modules => C_UT_OUT);
      
    ut.expect(g_result.message.message_name).to_equal(msg.PIT_PASS_MESSAGE);
  end notify_passes_threshold;

  --
  -- test notify_passes_affected_id: If set, NOTIFY passes the affected id
  --
  procedure notify_passes_affected_id 
  as
  begin
    pit.notify(
      p_message_name => msg.PIT_PASS_MESSAGE,
      p_msg_args => msg_args(C_DUMMY_TEXT),
      p_affected_id => C_AFFECTED_ID,
      p_log_threshold => null,
      p_log_modules => C_UT_OUT);
      
    ut.expect(g_result.message.affected_id).to_equal(C_AFFECTED_ID);
  end notify_passes_affected_id;

  --
  -- test get_message_text: creates an instance of type MESSAGE_TYPE and extracts the message text
  --
  procedure get_message_text
  as
    l_message varchar2(32767);
  begin
    l_message := pit.get_message_text(msg.PIT_PASS_MESSAGE, msg_args(C_DUMMY_TEXT));
    ut.expect(l_message).to_equal(C_DUMMY_TEXT);
  end get_message_text;

  --
  -- test get_message: Test to check whether an instance of MESSAGE_TYPE is created
  --
  procedure get_message
  as
    l_message message_type;
  begin
    l_message := pit.get_message(msg.PIT_PASS_MESSAGE, msg_args(C_DUMMY_TEXT));
    ut.expect(to_char(l_message.message_text)).to_equal(C_DUMMY_TEXT);
  end get_message;

  --
  -- test get_active_message: After having created a message, this method grants access to it
  --
  procedure get_active_message
  as
    l_message message_type;
  begin
    pit.set_context(pit.LEVEL_ALL, pit.TRACE_OFF, false, C_UT_OUT);
    pit.verbose(msg.PIT_PASS_MESSAGE, msg_args(C_DUMMY_TEXT));
    l_message := pit.get_active_message;
    ut.expect(to_char(l_message.message_text)).to_equal(C_DUMMY_TEXT);
  end get_active_message;

  --
  -- test assert_no_error: Call assertion method with TRUE does not raise an exception
  --
  procedure assert_no_error 
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, C_UT_OUT);
    pit.assert(true, msg.SQL_ERROR);
  end assert_no_error;

  --
  -- test assert_with_error: Call assertion method with FALSE raises an exception
  --
  procedure assert_with_error
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, C_UT_OUT);
    pit.assert(false, msg.SQL_ERROR);
  end assert_with_error;

  --
  -- test assert_null_throws_error: Call assertion method with NULL raises exception
  --
  procedure assert_null_throws_error
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, C_UT_OUT);
    pit.assert(null, msg.SQL_ERROR);
  end assert_null_throws_error;

  --
  -- test assert_passes_affected_id: An affected id passed into the message is sent
  --
  procedure assert_passes_affected_id
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, C_UT_OUT);
    pit.assert(null, msg.SQL_ERROR, p_affected_id => C_AFFECTED_ID);
  exception
    when msg.SQL_ERROR_ERR then
      pit.handle_exception;
      ut.expect(g_result.message.affected_id).to_equal(C_AFFECTED_ID);
  end assert_passes_affected_id;

  --
  -- test assert_passes_error_code: An error code passed into the message is sent
  --
  procedure assert_passes_error_code
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, C_UT_OUT);
    pit.assert(null, msg.SQL_ERROR, p_error_code => C_ERROR_CODE);
  exception
    when msg.SQL_ERROR_ERR then
      pit.handle_exception;
      ut.expect(g_result.message.error_code).to_equal(C_ERROR_CODE);
  end assert_passes_error_code;

  --
  -- test assert_is_null_no_error: Call assertion method with NULL does not raise an exception
  --
  procedure assert_is_null_no_error 
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, C_UT_OUT);
    pit.assert_is_null(to_char(null), msg.SQL_ERROR);
  end assert_is_null_no_error;

  --
  -- test assert_is_null_char_with_error: Call assertion method with TEXT raises an exception
  --
  procedure assert_is_null_char_with_error
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, C_UT_OUT);
    pit.assert_is_null(C_DUMMY_TEXT, msg.SQL_ERROR);
  end assert_is_null_char_with_error;

  --
  -- test assert_is_null_number_with_error: Call assertion method with NUMBER raises an exception
  --
  procedure assert_is_null_number_with_error
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, C_UT_OUT);
    pit.assert_is_null(C_DUMMY_NUMBER, msg.SQL_ERROR);
  end assert_is_null_number_with_error;

  --
  -- test assert_is_null_date_with_error: Call assertion method with DATE raises an exception
  --
  procedure assert_is_null_date_with_error
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, C_UT_OUT);
    pit.assert_is_null(C_DUMMY_DATE, msg.SQL_ERROR);
  end assert_is_null_date_with_error;

  --
  -- test assert_not_null_char_no_error: Call assertion method with TEXT does not raise an exception
  --
  procedure assert_not_null_char_no_error
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, C_UT_OUT);
    pit.assert_not_null(C_DUMMY_TEXT, msg.SQL_ERROR);
  end assert_not_null_char_no_error;

  --
  -- test assert_not_null_number_no_error: Call assertion method with NUMBER does not raise an exception
  --
  procedure assert_not_null_number_no_error
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, C_UT_OUT);
    pit.assert_not_null(C_DUMMY_NUMBER, msg.SQL_ERROR);
  end assert_not_null_number_no_error;

  --
  -- test assert_not_null_date_no_error: Call assertion method with DATE does not raise an exception
  --
  procedure assert_not_null_date_no_error
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, C_UT_OUT);
    pit.assert_not_null(C_DUMMY_DATE, msg.SQL_ERROR);
  end assert_not_null_date_no_error;

  --
  -- test assert_not_null_with_error: Call assertion method with NULL raises an exception
  --
  procedure assert_not_null_with_error
  as
  begin
    pit.set_context(pit.LEVEL_ERROR, pit.TRACE_OFF, false, C_UT_OUT);
    pit.assert_not_null(to_char(null), msg.SQL_ERROR);
  end assert_not_null_with_error;
  
  
  --
  -- test get_trans_item_name case 1: ...
  --
  procedure get_trans_item_name1 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item_name;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item_name1;

  --
  -- test get_trans_item_name case 2: ...
  --
  procedure get_trans_item_name2 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item_name;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item_name2;

  --
  -- test get_trans_item_name case 3: ...
  --
  procedure get_trans_item_name3 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item_name;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item_name3;

  --
  -- test get_trans_item_name case 4: ...
  --
  procedure get_trans_item_name4 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item_name;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item_name4;

  --
  -- test get_trans_item_name case 5: ...
  --
  procedure get_trans_item_name5 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item_name;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item_name5;

  --
  -- test get_trans_item_display_name case 1: ...
  --
  procedure get_trans_item_display_name1 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item_display_name;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item_display_name1;

  --
  -- test get_trans_item_display_name case 2: ...
  --
  procedure get_trans_item_display_name2 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item_display_name;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item_display_name2;

  --
  -- test get_trans_item_display_name case 3: ...
  --
  procedure get_trans_item_display_name3 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item_display_name;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item_display_name3;

  --
  -- test get_trans_item_display_name case 4: ...
  --
  procedure get_trans_item_display_name4 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item_display_name;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item_display_name4;

  --
  -- test get_trans_item_display_name case 5: ...
  --
  procedure get_trans_item_display_name5 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item_display_name;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item_display_name5;

  --
  -- test get_trans_item_description case 1: ...
  --
  procedure get_trans_item_description1 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item_description;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item_description1;

  --
  -- test get_trans_item_description case 2: ...
  --
  procedure get_trans_item_description2 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item_description;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item_description2;

  --
  -- test get_trans_item_description case 3: ...
  --
  procedure get_trans_item_description3 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item_description;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item_description3;

  --
  -- test get_trans_item_description case 4: ...
  --
  procedure get_trans_item_description4 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item_description;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item_description4;

  --
  -- test get_trans_item_description case 5: ...
  --
  procedure get_trans_item_description5 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item_description;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item_description5;

  --
  -- test get_trans_item case 1: ...
  --
  procedure get_trans_item1 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item1;

  --
  -- test get_trans_item case 2: ...
  --
  procedure get_trans_item2 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item2;

  --
  -- test get_trans_item case 3: ...
  --
  procedure get_trans_item3 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item3;

  --
  -- test get_trans_item case 4: ...
  --
  procedure get_trans_item4 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item4;

  --
  -- test get_trans_item case 5: ...
  --
  procedure get_trans_item5 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_trans_item;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_trans_item5;

  --
  -- test purge_log case 1: ...
  --
  procedure purge_log1 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.purge_log;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end purge_log1;

  --
  -- test purge_log case 2: ...
  --
  procedure purge_log2 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.purge_log;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end purge_log2;

  --
  -- test purge_log case 3: ...
  --
  procedure purge_log3 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.purge_log;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end purge_log3;

  --
  -- test purge_log case 4: ...
  --
  procedure purge_log4 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.purge_log;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end purge_log4;

  --
  -- test purge_log case 5: ...
  --
  procedure purge_log5 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.purge_log;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end purge_log5;

  --
  -- test purge_session_log case 1: ...
  --
  procedure purge_session_log1 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.purge_session_log;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end purge_session_log1;

  --
  -- test purge_session_log case 2: ...
  --
  procedure purge_session_log2 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.purge_session_log;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end purge_session_log2;

  --
  -- test purge_session_log case 3: ...
  --
  procedure purge_session_log3 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.purge_session_log;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end purge_session_log3;

  --
  -- test purge_session_log case 4: ...
  --
  procedure purge_session_log4 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.purge_session_log;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end purge_session_log4;

  --
  -- test purge_session_log case 5: ...
  --
  procedure purge_session_log5 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.purge_session_log;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end purge_session_log5;

  --
  -- test set_context case 1: ...
  --
  procedure set_context1 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.set_context;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_context1;

  --
  -- test set_context case 2: ...
  --
  procedure set_context2 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.set_context;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_context2;

  --
  -- test set_context case 3: ...
  --
  procedure set_context3 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.set_context;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_context3;

  --
  -- test set_context case 4: ...
  --
  procedure set_context4 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.set_context;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_context4;

  --
  -- test set_context case 5: ...
  --
  procedure set_context5 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.set_context;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_context5;

  --
  -- test reset_context case 1: ...
  --
  procedure reset_context1 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.reset_context;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end reset_context1;

  --
  -- test reset_context case 2: ...
  --
  procedure reset_context2 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.reset_context;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end reset_context2;

  --
  -- test reset_context case 3: ...
  --
  procedure reset_context3 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.reset_context;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end reset_context3;

  --
  -- test reset_context case 4: ...
  --
  procedure reset_context4 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.reset_context;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end reset_context4;

  --
  -- test reset_context case 5: ...
  --
  procedure reset_context5 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.reset_context;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end reset_context5;

  --
  -- test start_message_collection case 1: ...
  --
  procedure start_message_collection1 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.start_message_collection;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end start_message_collection1;

  --
  -- test start_message_collection case 2: ...
  --
  procedure start_message_collection2 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.start_message_collection;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end start_message_collection2;

  --
  -- test start_message_collection case 3: ...
  --
  procedure start_message_collection3 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.start_message_collection;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end start_message_collection3;

  --
  -- test start_message_collection case 4: ...
  --
  procedure start_message_collection4 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.start_message_collection;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end start_message_collection4;

  --
  -- test start_message_collection case 5: ...
  --
  procedure start_message_collection5 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.start_message_collection;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end start_message_collection5;

  --
  -- test stop_message_collection case 1: ...
  --
  procedure stop_message_collection1 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.stop_message_collection;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end stop_message_collection1;

  --
  -- test stop_message_collection case 2: ...
  --
  procedure stop_message_collection2 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.stop_message_collection;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end stop_message_collection2;

  --
  -- test stop_message_collection case 3: ...
  --
  procedure stop_message_collection3 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.stop_message_collection;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end stop_message_collection3;

  --
  -- test stop_message_collection case 4: ...
  --
  procedure stop_message_collection4 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.stop_message_collection;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end stop_message_collection4;

  --
  -- test stop_message_collection case 5: ...
  --
  procedure stop_message_collection5 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.stop_message_collection;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end stop_message_collection5;

  --
  -- test get_message_collection case 1: ...
  --
  procedure get_message_collection1 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_message_collection;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_message_collection1;

  --
  -- test get_message_collection case 2: ...
  --
  procedure get_message_collection2 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_message_collection;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_message_collection2;

  --
  -- test get_message_collection case 3: ...
  --
  procedure get_message_collection3 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_message_collection;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_message_collection3;

  --
  -- test get_message_collection case 4: ...
  --
  procedure get_message_collection4 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_message_collection;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_message_collection4;

  --
  -- test get_message_collection case 5: ...
  --
  procedure get_message_collection5 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_message_collection;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_message_collection5;

  --
  -- test get_modules case 1: ...
  --
  procedure get_modules1 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_modules;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_modules1;

  --
  -- test get_modules case 2: ...
  --
  procedure get_modules2 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_modules;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_modules2;

  --
  -- test get_modules case 3: ...
  --
  procedure get_modules3 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_modules;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_modules3;

  --
  -- test get_modules case 4: ...
  --
  procedure get_modules4 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_modules;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_modules4;

  --
  -- test get_modules case 5: ...
  --
  procedure get_modules5 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_modules;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_modules5;

  --
  -- test get_available_modules case 1: ...
  --
  procedure get_available_modules1 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_available_modules;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_available_modules1;

  --
  -- test get_available_modules case 2: ...
  --
  procedure get_available_modules2 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_available_modules;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_available_modules2;

  --
  -- test get_available_modules case 3: ...
  --
  procedure get_available_modules3 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_available_modules;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_available_modules3;

  --
  -- test get_available_modules case 4: ...
  --
  procedure get_available_modules4 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_available_modules;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_available_modules4;

  --
  -- test get_available_modules case 5: ...
  --
  procedure get_available_modules5 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_available_modules;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_available_modules5;

  --
  -- test get_active_modules case 1: ...
  --
  procedure get_active_modules1 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_active_modules;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_active_modules1;

  --
  -- test get_active_modules case 2: ...
  --
  procedure get_active_modules2 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_active_modules;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_active_modules2;

  --
  -- test get_active_modules case 3: ...
  --
  procedure get_active_modules3 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_active_modules;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_active_modules3;

  --
  -- test get_active_modules case 4: ...
  --
  procedure get_active_modules4 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_active_modules;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_active_modules4;

  --
  -- test get_active_modules case 5: ...
  --
  procedure get_active_modules5 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.get_active_modules;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_active_modules5;

  --
  -- test initialize case 1: ...
  --
  procedure initialize1 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.initialize;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end initialize1;

  --
  -- test initialize case 2: ...
  --
  procedure initialize2 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.initialize;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end initialize2;

  --
  -- test initialize case 3: ...
  --
  procedure initialize3 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.initialize;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end initialize3;

  --
  -- test initialize case 4: ...
  --
  procedure initialize4 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.initialize;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end initialize4;

  --
  -- test initialize case 5: ...
  --
  procedure initialize5 is
    l_actual   integer := 1;
    l_expected integer := 1;
  begin
    -- populate actual
    -- pit.initialize;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end initialize5;

end ut_pit;
/
