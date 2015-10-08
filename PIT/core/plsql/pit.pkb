create or replace package body pit
as
  /*************************** PACKAGE VARIABLES ********************************/
  g_module varchar2(30);
  g_owner varchar2(30);
  g_action varchar2(30);
  g_lineno number;
  g_caller_t varchar2(30);
  
  /******************************* INTERFACE ************************************/
  
  procedure initialize
  as
  begin
    g_owner := user;
    pit_pkg.initialize;
  end initialize;
  
  
  function level_off
   return number
  as
  begin
    return 10;
  end level_off;
  
  
  function level_fatal
   return number
  as
  begin
    return 20;
  end level_fatal;
  
  
  function level_error
    return number
  as
  begin
    return 30;
  end level_error;
  
  
  function level_warn
   return number
  as
  begin
    return 40;
  end level_warn;
  
  
  function level_info
   return number
  as
  begin
    return 50;
  end level_info;
  
  
  function level_debug
   return number
  as
  begin
    return 60;
  end level_debug;
  
  
  function level_all
   return number
  as
  begin
    return 70;
  end level_all;
  
  
  function trace_off
   return number
  as
  begin
    return 10;
  end trace_off;
  
  
  function trace_mandatory
   return number
  as
  begin
    return 20;
  end trace_mandatory;
  
  
  function trace_optional
   return number
  as
  begin
    return 30;
  end trace_optional;
  
  
  function trace_detailed
   return number
  as
  begin
    return 40;
  end trace_detailed;
  
  
  function trace_all
   return number
  as
  begin
    return 50;
  end trace_all;
  
  
  /* DEBUGGING */
  procedure verbose(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null)
  as
  begin
    pit_pkg.log(level_all, p_message_name, p_affected_id, p_arg_list);
  end verbose;


  procedure debug(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null)
  as
  begin
    pit_pkg.log(level_debug, p_message_name, p_affected_id, p_arg_list);
  end debug;


  procedure info(
    p_message_name in varchar2,
    p_arg_list msg_args default null,
    p_affected_id in varchar2 default null)
  as
  begin
    pit_pkg.log(level_info, p_message_name, p_affected_id, p_arg_list);
  end info;


  procedure warn(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null)
  as
  begin
    pit_pkg.log(level_warn, p_message_name, p_affected_id, p_arg_list);
  end warn;


  procedure error(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null)
  as
  begin
    pit_pkg.log(level_error, p_message_name, p_affected_id, p_arg_list);
  end error;


  procedure fatal(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null)
  as
  begin
    pit_pkg.log(level_fatal, p_message_name, p_affected_id, p_arg_list);
  end fatal;
  
  
  procedure log(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null,
    p_log_threshold in number default null,
    p_log_modules in varchar2 default null)
  as
  begin
    pit_pkg.log(
      p_message_name => p_message_name,
      p_affected_id => p_affected_id,
      p_arg_list => p_arg_list,
      p_log_threshold => p_log_threshold,
      p_log_modules => p_log_modules);
  end log;
  

  procedure sql_exception(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null)
  as
  begin
    if p_message_name = msg.FATAL_ERROR_OCCURRED then
       stop(p_message_name, p_arg_list);
    else
       pit_pkg.log(level_error, p_message_name, p_affected_id, p_arg_list);
       leave;
    end if;
  end sql_exception;


  procedure stop(
    p_message_name in varchar2,
    p_arg_list in msg_args := null,
    p_affected_id in varchar2 default null)
  as
  begin
    pit_pkg.log(level_fatal, p_message_name, p_affected_id, p_arg_list);
    pit_pkg.raise_error(msg.FATAL_ERROR_OCCURRED, null);
  end stop;
  
  
  function get_message_text(
    p_message_name in varchar2,
    p_arg_list in msg_args default null)
   return clob
  as
    l_message message_type;
  begin
    l_message := pit_pkg.get_message(p_message_name, null, p_arg_list);
    return l_message.message_text;
  end get_message_text;
  

  procedure enter_mandatory(
    p_action in varchar2 default null,
    p_module in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null)
  as
  begin
    enter(p_action, p_module, p_params, trace_mandatory);
  end enter_mandatory;
  
  
  procedure enter_optional(
    p_action in varchar2 default null,
    p_module in varchar2 default null,
    p_params in msg_params default null)
  as
  begin
    enter(p_action, p_module, p_params, trace_optional);
  end enter_optional;
  
  
  procedure enter_detailed(
    p_action in varchar2 default null,
    p_module in varchar2 default null,
    p_params in msg_params default null)
  as
  begin
    enter(p_action, p_module, p_params, trace_detailed);
  end enter_detailed;


  procedure enter(
    p_action in varchar2 default null,
    p_module in varchar2 default null,
    p_params in msg_params default null,
    p_trace_level in number default pit.trace_all,
    p_client_info in varchar2 default null)
  as
  begin
    $IF dbms_db_version.ver_le_11 $THEN
    -- Nicht zu PIT_PKG verschieben, um korrekten Namen zu erhalten
    if p_action is not null then
      g_action := p_action;
      g_module := p_module;
    else
      owa_util.who_called_me(
        owner => g_owner,
        name => g_action,
        lineno => g_lineno,
        caller_t => g_module);
      g_action := g_action || '#' || to_char(g_lineno);
    end if;
    $ELSE
    -- Ab Version 12 UTL_CALL_STACK in PIT_PKG nutzen
    g_action := p_action;
    g_module := p_module;
    $END
    pit_pkg.enter(
       g_action, g_module, p_params, p_trace_level, p_client_info);
  end enter;
  
  
  procedure leave_mandatory
  as
  begin
    leave(trace_mandatory);
  end leave_mandatory;
  
  
  procedure leave_optional
  as
  begin
    leave(trace_optional);
  end leave_optional;
  
  
  procedure leave_detailed
  as
  begin
    leave(trace_detailed);
  end leave_detailed;
  
  
  procedure leave(
    p_trace_level in number default pit.trace_all)
  is
  begin
    pit_pkg.leave(p_trace_level);
  end leave;
  
  
  procedure long_op(
    p_operation in varchar2,
    p_sofar in number,
    p_total in number default 100)
  as
  begin
    /*TODO: Implementation required */
    null;
  end long_op;
  
  
  procedure print(
    p_message_name in varchar2,
    p_arg_list msg_args default null)
  as
  begin
    pit_pkg.print(p_message_name, p_arg_list);
  end print;
  
  
  
  procedure purge_log(
    p_date_before in date)
  as
  begin
    pit_pkg.purge(p_date_before);
  end purge_log;
  
  
  procedure purge_log(
    p_days_before in number)
  as
  begin
    purge_log(trunc(sysdate) - p_days_before);
  end purge_log;
  
  
  procedure purge_session_log(
    p_session_id in varchar2 default null)
  as
  begin
    -- TODO: IMPLEMENTATION
    null;
  end purge_session_log;
  
  
  /* ASSERTION */
  procedure assert(
    p_condition in boolean,
    p_message_name in varchar2 default msg.ASSERT_TRUE,
    p_arg_list msg_args := null)
  as
  begin
    if not p_condition then
       pit.error(p_message_name, p_arg_list);
       raise msg.ASSERTION_FAILED_ERR;
    end if;
  end assert;
  
  
  procedure assert_is_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.ASSERT_IS_NULL,
    p_arg_list msg_args := null)
  as
  begin
    if p_condition is not null then
       pit.error(p_message_name, p_arg_list);
       raise msg.ASSERTION_FAILED_ERR;
    end if;
  end assert_is_null;
  
  
  procedure assert_is_null(
    p_condition in number,
    p_message_name in varchar2 default msg.ASSERT_IS_NULL,
    p_arg_list msg_args := null)
  as
  begin
    if p_condition is not null then
       pit.error(p_message_name, p_arg_list);
       raise msg.ASSERTION_FAILED_ERR;
    end if;
  end assert_is_null;
  
  
  procedure assert_is_null(
    p_condition in date,
    p_message_name in varchar2 default msg.ASSERT_IS_NULL,
    p_arg_list msg_args := null)
  as
  begin
    if p_condition is not null then
       pit.error(p_message_name, p_arg_list);
       raise msg.ASSERTION_FAILED_ERR;
    end if;
  end assert_is_null;
  
  
  procedure assert_not_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.ASSERT_IS_NOT_NULL,
    p_arg_list msg_args := null)
  as
  begin
    if p_condition is null then
       pit.error(p_message_name, p_arg_list);
       raise msg.ASSERTION_FAILED_ERR;
    end if;
  end assert_not_null;
  
  
  procedure assert_not_null(
    p_condition in number,
    p_message_name in varchar2 default msg.ASSERT_IS_NOT_NULL,
    p_arg_list msg_args := null)
  as
  begin
    if p_condition is null then
       pit.error(p_message_name, p_arg_list);
       raise msg.ASSERTION_FAILED_ERR;
    end if;
  end assert_not_null;
  
  
  procedure assert_not_null(
    p_condition in date,
    p_message_name in varchar2 default msg.ASSERT_IS_NOT_NULL,
    p_arg_list msg_args := null)
  as
  begin
    if p_condition is null then
       pit.error(p_message_name, p_arg_list);
       raise msg.ASSERTION_FAILED_ERR;
    end if;
  end assert_not_null;
  
  
  procedure assert_exists(
    p_stmt  in varchar2,
    p_message_name in varchar2 default msg.ASSERT_EXISTS,
    p_arg_list   msg_args := null)
  as
    l_stmt varchar2(32767) := 'select * from (#STMT#)';
  begin
    pit.assert_not_null(l_stmt);
    l_stmt := replace(l_stmt, '#STMT#', p_stmt);
    execute immediate l_stmt;
  exception
    when no_data_found then
       pit.error(p_message_name, p_arg_list);
       raise msg.ASSERTION_FAILED_ERR;
    when others then
       pit.sql_exception(msg.SQL_ERROR);
  end assert_exists;
    
    
  procedure assert_not_exists(
    p_stmt  in varchar2,
    p_message_name in varchar2 default msg.ASSERT_NOT_EXISTS,
    p_arg_list   msg_args := null)
  as
    l_stmt varchar2(32767) := 'select * from (#STMT#)';
    l_result sys_refcursor;
  begin
    pit.assert_not_null(l_stmt);
    l_stmt := replace(l_stmt, '#STMT#', p_stmt);
    execute immediate l_stmt into l_result;
    pit.error(p_message_name, p_arg_list);
    raise msg.ASSERTION_FAILED_ERR;
  exception
    when no_data_found then
       null;
    when others then
       pit.sql_exception(msg.SQL_ERROR);
  end assert_not_exists;
  
  
  /* Context Maintenance */
  procedure set_context(
  p_log_level in integer,
  p_trace_level in integer,
  p_trace_timing in boolean,
  p_module_list in varchar2)
  as
  begin
    pit_pkg.set_context(
      p_log_level,
      p_trace_level,
      p_trace_timing,
      p_module_list);
  end set_context;
  
  
  procedure reset_context(
    p_active_session_only in boolean default true)
  as
  begin
    if p_active_session_only then
      pit_pkg.reset_active_context;
    else
      pit_pkg.reset_context;
    end if;
  end reset_context;
  
  
  function get_module_list
   return args pipelined
  as
    cursor modules is
      select column_value
        from table(pit_pkg.get_active_modules);
  begin
    for module in modules loop
       pipe row (module.column_value);
    end loop;
    return;
  exception
    when no_data_needed then
      null;
  end get_module_list;
  
  
begin
  initialize;
end pit;
/
