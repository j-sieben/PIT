create or replace package body pit
as
  /*************************** PACKAGE VARIABLES ********************************/
  g_module pit_util.ora_name_type;
  g_owner pit_util.ora_name_type;
  g_action pit_util.ora_name_type;
  g_lineno binary_integer;
  g_caller_t pit_util.ora_name_type;
  
  C_PASS_MESSAGE constant pit_util.ora_name_type := 'PIT_PASS_MESSAGE';
  
  /******************************* INTERFACE ************************************/
  
  procedure initialize
  as
  begin
    g_owner := user;
    pit_pkg.initialize;
  end initialize;
  
  
  function level_off
   return number
   deterministic
  as
  begin
    return 10;
  end level_off;
  
  
  function level_fatal
   return number
   deterministic
  as
  begin
    return 20;
  end level_fatal;
  
  
  function level_error
    return number
    deterministic
  as
  begin
    return 30;
  end level_error;
  
  
  function level_warn
    return number
    deterministic
  as
  begin
    return 40;
  end level_warn;
  
  
  function level_info
    return number
    deterministic
  as
  begin
    return 50;
  end level_info;
  
  
  function level_debug
    return number
    deterministic
  as
  begin
    return 60;
  end level_debug;
  
  
  function level_all
    return number
    deterministic
  as
  begin
    return 70;
  end level_all;
  
  
  function trace_off
    return number
    deterministic
  as
  begin
    return 10;
  end trace_off;
  
  
  function trace_mandatory
    return number
    deterministic
  as
  begin
    return 20;
  end trace_mandatory;
  
  
  function trace_optional
    return number
    deterministic
  as
  begin
    return 30;
  end trace_optional;
  
  
  function trace_detailed
    return number
    deterministic
  as
  begin
    return 40;
  end trace_detailed;
  
  
  function trace_all
   return number
   deterministic
  as
  begin
    return 50;
  end trace_all;
  
  
  /* DEBUGGING */
  procedure log(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null,
    p_log_threshold in number default null,
    p_module_list in varchar2 default null)
  as
  begin
    pit_pkg.log_specific(
      p_message_name => p_message_name,
      p_affected_id => p_affected_id,
      p_error_code => p_error_code,
      p_arg_list => p_arg_list,
      p_log_threshold => coalesce(p_log_threshold, pit.level_all),
      p_log_modules => p_module_list);
  end log;
  
    
  procedure verbose(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null)
  as
  begin
    $IF pit_admin.c_level_le_info $THEN
    pit_pkg.log_event(level_all, p_message_name, p_arg_list, p_affected_id, null);
    $ELSE
    null;
    $END
  end verbose;


  procedure debug(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null)
  as
  begin
    $IF pit_admin.c_level_le_debug $THEN
    pit_pkg.log_event(level_debug, p_message_name, p_arg_list, p_affected_id, null);
    $ELSE
    null;
    $END
  end debug;


  procedure info(
    p_message_name in varchar2,
    p_arg_list msg_args default null,
    p_affected_id in varchar2 default null)
  as
  begin
    $IF pit_admin.c_level_le_info $THEN
    pit_pkg.log_event(level_info, p_message_name, p_arg_list, p_affected_id, null);
    $ELSE
    null;
    $END
  end info;


  procedure warn(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null)
  as
  begin
    $IF pit_admin.c_level_le_warn $THEN
    pit_pkg.log_event(level_warn, p_message_name, p_arg_list, p_affected_id, null);
    $ELSE
    null;
    $END
  end warn;


  procedure error(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    pit_pkg.raise_error(level_error, p_message_name, p_arg_list, p_affected_id, p_error_code);
  end error;


  procedure fatal(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    pit_pkg.raise_error(level_fatal, p_message_name, p_arg_list, p_affected_id, p_error_code);
  end fatal;
  

  procedure sql_exception(
    p_message_name in varchar2 default null,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null)
  as
  begin
    pit_pkg.handle_error(level_error, p_message_name, p_arg_list, p_affected_id, p_error_code, p_params);
    leave;
  end sql_exception;


  procedure stop(
    p_message_name in varchar2 default null,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null)
  as
  begin
    pit_pkg.handle_error(level_fatal, p_message_name, p_arg_list, p_affected_id, p_error_code, p_params);
  end stop;
  
  
  function get_message_text(
    p_message_name in varchar2,
    p_arg_list in msg_args default null)
   return clob
  as
  begin
    return pit_pkg.get_message_text(p_message_name, p_arg_list);
  end get_message_text;
  
  
  function get_message(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
    return message_type
  as
  begin
    return pit_pkg.get_message(p_message_name, p_arg_list, p_affected_id, p_error_code);
  end get_message;
  
  
  function get_trans_item_name(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_arg_list msg_args default null,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
    return varchar2
  as
  begin
    return pit_pkg.get_trans_item(p_pti_pmg_name, p_pti_id, p_arg_list, p_pti_pml_name).pti_name;
  end get_trans_item_name; 
  
    
  function get_trans_item_display_name(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_arg_list msg_args default null,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
    return varchar2
  as
  begin
    return pit_pkg.get_trans_item(p_pti_pmg_name, p_pti_id, p_arg_list, p_pti_pml_name).pti_display_name;
  end get_trans_item_display_name; 
  
    
  function get_trans_item_description(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
    return clob
  as
  begin
    return pit_pkg.get_trans_item(p_pti_pmg_name, p_pti_id, null, p_pti_pml_name).pti_description;
  end get_trans_item_description; 
  
    
  function get_trans_item(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_arg_list msg_args default null,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
    return pit_util.translatable_item_rec
  as
  begin
    return pit_pkg.get_trans_item(p_pti_pmg_name, p_pti_id, p_arg_list, p_pti_pml_name);
  end get_trans_item; 
  

  procedure enter_mandatory(
    p_action in varchar2 default null,
    p_module in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null)
  as
  begin
    $IF pit_admin.c_trace_le_mandatory $THEN
    enter(p_action, p_module, p_params, trace_mandatory, p_client_info);
    $ELSE
    null;
    $END
  end enter_mandatory;
  
  
  procedure enter_optional(
    p_action in varchar2 default null,
    p_module in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null)
  as
  begin
    $IF pit_admin.c_trace_le_optional $THEN
    enter(p_action, p_module, p_params, trace_optional, p_client_info);
    $ELSE
    null;
    $END
  end enter_optional;
  
  
  procedure enter_detailed(
    p_action in varchar2 default null,
    p_module in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null)
  as
  begin
    $IF pit_admin.c_trace_le_detailed $THEN
    enter(p_action, p_module, p_params, trace_detailed, p_client_info);
    $ELSE
    null;
    $END
  end enter_detailed;


  procedure enter(
    p_action in varchar2 default null,
    p_module in varchar2 default null,
    p_params in msg_params default null,
    p_trace_level in number default pit.trace_all,
    p_client_info in varchar2 default null)
  as
  begin
    $IF pit_admin.c_trace_le_all $THEN
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
    -- starting with version 12c, UTL_CALL_STACK is used if parameters are not provided
    g_action := p_action;
    g_module := p_module;
    $END
    pit_pkg.enter(
       g_action, g_module, p_params, p_trace_level, p_client_info);
    $ELSE
    null;
    $END
  end enter;
  
  
  procedure leave_mandatory(
    p_params in msg_params default null)
  as
  begin
    $IF pit_admin.c_trace_le_mandatory $THEN
    leave(trace_mandatory, p_params);
    $ELSE
    null;
    $END
  end leave_mandatory;
  
  
  procedure leave_optional(
    p_params in msg_params default null)
  as
  begin
    $IF pit_admin.c_trace_le_optional $THEN
    leave(trace_optional, p_params);
    $ELSE
    null;
    $END
  end leave_optional;
  
  
  procedure leave_detailed(
    p_params in msg_params default null)
  as
  begin
    $IF pit_admin.c_trace_le_detailed $THEN
    leave(trace_detailed, p_params);
    $ELSE
    null;
    $END
  end leave_detailed;
  
  
  procedure leave(
    p_trace_level in number default pit.trace_all,
    p_params in msg_params default null)
  is
  begin
    $IF pit_admin.c_trace_le_all $THEN
    pit_pkg.leave(p_trace_level, p_params);
    $ELSE
    null;
    $END
  end leave;
  
  
  procedure long_op(
    p_target in varchar2,
    p_sofar in number,
    p_total in number default 100,
    p_units in varchar2 default null,
    p_op_name in varchar2)
  as
  begin
    pit_pkg.long_op(
      p_target => p_target,
      p_sofar => p_sofar,
      p_total => p_total,
      p_units => p_units,
      p_op_name => p_op_name);
  end long_op;
  
  
  procedure print(
    p_message_name in varchar2,
    p_arg_list msg_args default null)
  as
  begin
    pit_pkg.print(p_message_name, p_arg_list);
  end print;
  

  procedure notify(
    p_message_name in varchar2,
    p_arg_list in msg_args default null,
    p_affected_id in varchar2 default null,
    p_log_threshold in number default null,
    p_log_modules in varchar2 default null)
  as
  begin
    pit_pkg.notify(
      p_message_name => p_message_name,
      p_affected_id => p_affected_id,
      p_arg_list => p_arg_list,
      p_log_threshold => p_log_threshold,
      p_log_modules => p_log_modules);
  end notify;
  
  
  procedure purge_log(
    p_date_before in date,
    p_severity_greater_equal in number default null)
  as
  begin
    pit_pkg.purge_log(p_date_before, p_severity_greater_equal);
  end purge_log;
  
  
  procedure purge_log(
    p_days_before in number,
    p_severity_greater_equal in number default null)
  as
  begin
    purge_log(trunc(sysdate) - p_days_before, p_severity_greater_equal);
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
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    if not p_condition  or p_condition is null then
      pit.error(p_message_name, p_arg_list, p_affected_id, p_error_code);
    end if;
  end assert;
  
  
  procedure assert_is_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.ASSERT_IS_NULL,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    if p_condition is not null then
      pit.error(p_message_name, p_arg_list, p_affected_id, p_error_code);
    end if;
  end assert_is_null;
  
  
  procedure assert_is_null(
    p_condition in number,
    p_message_name in varchar2 default msg.ASSERT_IS_NULL,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    if p_condition is not null then
      pit.error(p_message_name, p_arg_list, p_affected_id, p_error_code);
    end if;
  end assert_is_null;
  
  
  procedure assert_is_null(
    p_condition in date,
    p_message_name in varchar2 default msg.ASSERT_IS_NULL,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    if p_condition is not null then
      pit.error(p_message_name, p_arg_list, p_affected_id, p_error_code);
    end if;
  end assert_is_null;
  
  
  procedure assert_not_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.ASSERT_IS_NOT_NULL,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    if p_condition is null then
      pit.error(p_message_name, p_arg_list, p_affected_id, p_error_code);
    end if;
  end assert_not_null;
  
  
  procedure assert_not_null(
    p_condition in number,
    p_message_name in varchar2 default msg.ASSERT_IS_NOT_NULL,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    if p_condition is null then
      pit.error(p_message_name, p_arg_list, p_affected_id, p_error_code);
    end if;
  end assert_not_null;
  
  
  procedure assert_not_null(
    p_condition in date,
    p_message_name in varchar2 default msg.ASSERT_IS_NOT_NULL,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    if p_condition is null then
      pit.error(p_message_name, p_arg_list, p_affected_id, p_error_code);
    end if;
  end assert_not_null;
  
  
  procedure assert_exists(
    p_stmt in varchar2,
    p_message_name in varchar2 default msg.ASSERT_EXISTS,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
    l_stmt pit_util.max_char := 'select 1 from dual where exists (#STMT#)';
  begin
    pit.assert_not_null(l_stmt);
    l_stmt := replace(l_stmt, '#STMT#', p_stmt);
    execute immediate l_stmt;
  exception
    when no_data_found then
      pit.error(p_message_name, p_arg_list, p_affected_id, p_error_code);
  end assert_exists;
    
    
  procedure assert_not_exists(
    p_stmt  in varchar2,
    p_message_name in varchar2 default msg.ASSERT_NOT_EXISTS,
    p_arg_list msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
    l_stmt pit_util.max_char := 'select 1 from dual where not exists (#STMT#)';
  begin
    pit.assert_not_null(l_stmt);
    l_stmt := replace(l_stmt, '#STMT#', p_stmt);
    execute immediate l_stmt;
  exception
    when no_data_found then
      pit.error(p_message_name, p_arg_list, p_affected_id, p_error_code);
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
  
  
  procedure set_context(
    p_context_name in varchar2)
  as
  begin
    pit_pkg.set_context(p_context_name);
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
  
  
  function get_modules
    return pit_module_list
    pipelined
  as
    cursor modules is
      select pit_module_meta(module_name, module_available, module_active) module
        from table(pit_pkg.get_modules);
  begin
    for m in modules loop
      pipe row (m.module);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
      null;
  end get_modules;
    
    
  function get_available_modules
    return args 
    pipelined
  as
    cursor modules is
      select column_value module
        from table(pit_pkg.get_active_modules);
  begin
    for m in modules loop
      pipe row (m.module);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
      null;
  end get_available_modules;
    
    
  function get_active_modules
    return args 
    pipelined
  as
    cursor modules is
      select column_value module
        from table(pit_pkg.get_active_modules);
  begin
    for m in modules loop
      pipe row (m.module);
    end loop;
    return;
  exception
    when NO_DATA_NEEDED then
      null;
  end get_active_modules;
  
  
begin
  initialize;
end pit;
/
