create or replace package body pit_table_pkg 
as
  /** 
    Package: Output Modules.PIT_TABLE.PIT_TABLE_PKG Body
      Implementation package for type <PIT_TABLE>
   
    Author:: 
      Juergen Sieben, ConDeS GmbH
      
      Published under MIT licence
   */

  C_FIRE_THRESHOLD constant varchar2(30 char) := 'PIT_TABLE_FIRE_THRESHOLD';
  C_PARAM_GROUP constant varchar2(20 char) := 'PIT';
  
  /**
    Group: Helper Methods
   */
   /**
    Procedure: persist_params
      Helper method to write to table <PIT_TABLE_PARAMS>. 
      Is used to wrap the insert operation on <PIT_TABLE_PARAMS>, used by several methods
      
    Parameters:
      p_id - ID of the entry, taken from <PIT_CALL_STACK_TYPE> or <PIT_LOG_STATE_TYPE>
      p_pse_id - Severity of the entry. 70 if CALL_STACK entry
      p_params - Instance of <MSG_PARAMS>
   */
  procedure persist_params(
    p_id in pit_table_params.ptp_id%type,
    p_pse_id in pit_table_params.ptp_pse_id%type,
    p_params in msg_params)
  as
  begin
    if p_params is not null then
      insert into pit_table_params(ptp_id, ptp_pse_id, ptp_log_date, ptp_param_name, ptp_param_value)
      select p_id, p_pse_id, localtimestamp, p_param, p_value
        from table(p_params)
       where p_param is not null;
    end if;
  end persist_params;
  

  /**
    Group: Public method implementations
   */
  /**
    Procedure: log_exception
      See <pit_table_pkg.log_exception>
   */
  procedure log_exception(
    p_message in message_type)
  as
  begin
    insert into pit_table_log
      (log_id, log_date, log_session_id, log_user_name, 
       log_message_text, log_message_name, log_message_args, 
       log_message_stack, log_message_backtrace, log_severity)
    values
      (p_message.id, p_message.creation_time, substr(p_message.session_id, 1, 64), substr(p_message.user_name, 1, 30),
       p_message.message_text, p_message.message_name, pit_util.cast_to_msg_args_char(p_message.message_args), 
       p_message.stack, p_message.backtrace, p_message.severity);
  end log_exception;
  
  
  /**
    Procedure: panic
      See <pit_table_pkg.panic>
   */
  procedure panic(
    p_message in message_type)
  as
  begin
    insert into pit_table_log
      (log_id, log_date, log_session_id, log_user_name, 
       log_message_text, log_message_name, log_message_args, 
       log_message_stack, log_message_backtrace, log_severity)
    values
      (p_message.id, p_message.creation_time, substr(p_message.session_id, 1, 64), substr(p_message.user_name, 1, 30),
       p_message.message_text, p_message.message_name, pit_util.cast_to_msg_args_char(p_message.message_args), 
       p_message.stack, p_message.backtrace, p_message.severity);
  end panic;
  
  
  /**
    Procedure: log_state
      See <pit_table_pkg.log_state>
   */
  procedure log_state(
    p_log_state pit_log_state_type)
  as
  begin
    persist_params(p_log_state.id, p_log_state.severity, p_log_state.params);
  end log_state;
  

  /**
    Procedure: purge_log
      See <pit_table_pkg.purge_log>
   */
  procedure purge_log(
    p_date_until in date,
    p_severity_greater_equal in number default null)
  as
  begin
    delete from pit_table_log
     where log_date <= p_date_until
       and log_severity >= coalesce(p_severity_greater_equal, 0);
    delete from pit_table_call_stack
     where cls_log_date <= p_date_until;
    delete from pit_table_params
     where ptp_log_date <= p_date_until
       and ptp_pse_id > coalesce(p_severity_greater_equal, 0);
  end purge_log;


  /**
    Procedure: enter
      See <pit_table_pkg.enter>
   */
  procedure enter(
    p_call_stack in pit_call_stack_type)
  as
  begin
    insert into pit_table_call_stack
      (cls_id, cls_log_date, cls_call_level, cls_action, 
       cls_session_id, cls_user_name, cls_method_name, cls_module_name,
       cls_elapsed, cls_elapsed_cpu, cls_total_time, cls_total_time_cpu)
    values
      (p_call_stack.id, coalesce(p_call_stack.wall_clock, localtimestamp), p_call_stack.call_level, 'ENTER',
       substr(p_call_stack.session_id, 1, 64), substr(p_call_stack.user_name, 1, 30), p_call_stack.method_name, p_call_stack.module_name,
       p_call_stack.elapsed, p_call_stack.elapsed_cpu, p_call_stack.total, p_call_stack.total_cpu);
    
    persist_params(p_call_stack.id, pit.LEVEL_DEBUG, p_call_stack.params);
  end enter;


  /**
    Procedure: leave
      See <pit_table_pkg.leave>
   */
  procedure leave(
    p_call_stack in pit_call_stack_type)
  as
  begin
    insert into pit_table_call_stack
      (cls_id, cls_log_date, cls_call_level, cls_action, 
       cls_session_id, cls_user_name, cls_module_name, cls_method_name,
       cls_elapsed, cls_elapsed_cpu, cls_total_time, cls_total_time_cpu)
    values
      (p_call_stack.id, coalesce(p_call_stack.wall_clock, localtimestamp), p_call_stack.call_level, 'LEAVE',
       p_call_stack.session_id, p_call_stack.user_name, p_call_stack.module_name, p_call_stack.method_name, 
       p_call_stack.elapsed, p_call_stack.elapsed_cpu, p_call_stack.total, p_call_stack.total_cpu);
    
    persist_params(p_call_stack.id, pit.LEVEL_DEBUG, p_call_stack.params);
  end leave;


  /**
    Procedure: initialize_module
      See <pit_table_pkg.initialize_module>
   */
  procedure initialize_module(
    self in out pit_table)
  as
  begin
    self.fire_threshold := param.get_integer(C_FIRE_THRESHOLD, C_PARAM_GROUP);
    self.status := msg.PIT_MODULE_INSTANTIATED;
  exception
    when others then
      self.status := msg.PIT_FAIL_MODULE_INIT;
      self.stack  := substr(sqlerrm, 12);
  end initialize_module;

end pit_table_pkg;
/

