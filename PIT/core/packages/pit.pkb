create or replace package body pit
as

  /** PIT-API package. Implements the API that is required to use PIT. */
   
   
  /*************************** PACKAGE VARIABLES ********************************/
  g_module pit_util.ora_name_type;
  g_owner pit_util.ora_name_type;
  g_lineno binary_integer;
  
  
  /******************************* INTERFACE ************************************/
  
  procedure initialize
  as
  begin
    g_owner := user;
    pit_internal.initialize;
  end initialize;
  
  
  function level_off
  return binary_integer
   deterministic
  as
  begin
    return pit_internal.C_LEVEL_OFF;
  end level_off;
  
  
  function level_fatal
  return binary_integer
    deterministic
  as
  begin
    return pit_internal.C_LEVEL_FATAL;
  end level_fatal;
  
  
  function level_error
    return binary_integer
    deterministic
  as
  begin
    return pit_internal.C_LEVEL_ERROR;
  end level_error;
  
  
  function level_warn
  return binary_integer
    deterministic
  as
  begin
    return pit_internal.C_LEVEL_WARN;
  end level_warn;
  
  
  function level_info
  return binary_integer
    deterministic
  as
  begin
    return pit_internal.C_LEVEL_INFO;
  end level_info;
  
  
  function level_debug
    return binary_integer
    deterministic
  as
  begin
    return pit_internal.C_LEVEL_DEBUG;
  end level_debug;
  
  
  function level_all
  return binary_integer
    deterministic
  as
  begin
    return pit_internal.C_LEVEL_ALL;
  end level_all;
  
  
  function trace_off
  return binary_integer
    deterministic
  as
  begin
    return pit_internal.C_TRACE_OFF;
  end trace_off;
  
  
  function trace_mandatory
  return binary_integer
    deterministic
  as
  begin
    return pit_internal.C_TRACE_MANDATORY;
  end trace_mandatory;
  
  
  function trace_optional
  return binary_integer
    deterministic
  as
  begin
    return pit_internal.C_TRACE_OPTIONAL;
  end trace_optional;
  
  
  function trace_detailed
  return binary_integer
    deterministic
  as
  begin
    return pit_internal.C_TRACE_DETAILED;
  end trace_detailed;
  
  
  function trace_all
  return binary_integer
    deterministic
  as
  begin
    return pit_internal.C_TRACE_ALL;
  end trace_all;
  
  
  /** Getter for package constants to enable their usage in SQL
   */
  function type_integer
    return varchar2
  as
  begin
    return pit_internal.C_TYPE_INTEGER;
  end type_integer;  
  
  function type_number
    return varchar2
  as
  begin
    return pit_internal.C_TYPE_NUMBER;
  end type_number;  
    
  function type_date
    return varchar2
  as
  begin
    return pit_internal.C_TYPE_DATE;
  end type_date;  
    
  function type_timestamp
    return varchar2
  as
  begin
    return pit_internal.C_TYPE_TIMESTAMP;
  end type_timestamp;  
  
  function type_xml
    return varchar2
  as
  begin
    return pit_internal.C_TYPE_XML;
  end type_xml;  
  
  
  /****************************** LOGGING AND DEBUGGING *********************************/
  function get_log_level
    return binary_integer
  as
  begin
    return pit_internal.get_log_level;
  end get_log_level;
  
  
  function check_log_level_greater_equal(
    p_log_level in pls_integer)
    return boolean
  as
  begin
    return pit_internal.check_log_level_greater_equal(p_log_level);
  end check_log_level_greater_equal;
  
  
  function get_trace_level
    return binary_integer
  as
  begin
    return pit_internal.get_trace_level;
  end get_trace_level;
  
  
  function check_trace_level_greater_equal(
    p_trace_level in pls_integer)
    return boolean
  as
  begin
    return pit_internal.check_trace_level_greater_equal(p_trace_level);
  end check_trace_level_greater_equal;
  
  
  procedure log(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null,
    p_log_threshold in number default null,
    p_log_modules in varchar2 default null)
  as
  begin
    pit_internal.log_specific(
      p_message_name => p_message_name,
      p_affected_id => p_affected_id,
      p_error_code => p_error_code,
      p_msg_args => p_msg_args,
      p_log_threshold => coalesce(p_log_threshold, pit.level_all),
      p_log_modules => p_log_modules);
  end log;
  
  
  procedure log_state(
    p_params msg_params,
    p_severity in pls_integer default null)
  as
  begin
    pit_internal.log_state(
      p_params => p_params,
      p_severity => p_severity);
  end log_state;
  
    
  procedure verbose(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null)
  as
  begin
    $IF pit_admin.c_level_le_info $THEN
    pit_internal.log_event(level_all, p_message_name, p_msg_args, p_affected_id, null);
    $ELSE
    -- Logging disallowed by conditional compilation
    null;
    $END
  end verbose;


  procedure debug(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null)
  as
  begin
    $IF pit_admin.c_level_le_debug $THEN
    pit_internal.log_event(level_debug, p_message_name, p_msg_args, p_affected_id, null);
    $ELSE
    -- Logging disallowed by conditional compilation
    null;
    $END
  end debug;


  procedure info(
    p_message_name in varchar2,
    p_msg_args msg_args default null,
    p_affected_id in varchar2 default null)
  as
  begin
    $IF pit_admin.c_level_le_info $THEN
    pit_internal.log_event(level_info, p_message_name, p_msg_args, p_affected_id, null);
    $ELSE
    -- Logging disallowed by conditional compilation
    null;
    $END
  end info;


  procedure warn(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null)
  as
  begin
    $IF pit_admin.c_level_le_warn $THEN
    pit_internal.log_event(level_warn, p_message_name, p_msg_args, p_affected_id, null);
    $ELSE
    -- Logging disallowed by conditional compilation
    null;
    $END
  end warn;


  procedure error(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    pit_internal.raise_error(level_error, p_message_name, p_msg_args, p_affected_id, p_error_code);
  end error;


  procedure fatal(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    pit_internal.raise_error(level_fatal, p_message_name, p_msg_args, p_affected_id, p_error_code);
  end fatal;
  

  procedure sql_exception(
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null)
  as
  begin
    pit_internal.handle_error(level_error, p_message_name, p_msg_args, p_affected_id, p_error_code, p_params);
    leave;
  end sql_exception;
  

  procedure handle_exception(
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null)
  as
  begin
    pit_internal.handle_error(level_error, p_message_name, p_msg_args, p_affected_id, p_error_code, p_params);
    leave;
  end handle_exception;


  procedure stop(
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null)
  as
  begin
    pit_internal.handle_error(level_fatal, p_message_name, p_msg_args, p_affected_id, p_error_code, p_params);
  end stop;


  procedure reraise_exception(
    p_message_name in varchar2 default null,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null,
    p_params in msg_params default null)
  as
  begin
    pit_internal.handle_error(level_fatal, p_message_name, p_msg_args, p_affected_id, p_error_code, p_params);
  end reraise_exception;
  
  
  /****************************** TRACING *********************************/

  procedure enter_mandatory(
    p_action in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null)
  as
  begin
    $IF pit_admin.c_trace_le_mandatory $THEN
    enter(p_action, p_params, trace_mandatory, p_client_info);
    $ELSE
    -- Tracing disallowed by conditional compilation
    null;
    $END
  end enter_mandatory;
  
  
  procedure enter_optional(
    p_action in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null)
  as
  begin
    $IF pit_admin.c_trace_le_optional $THEN
    enter(p_action, p_params, trace_optional, p_client_info);
    $ELSE
    -- Tracing disallowed by conditional compilation
    null;
    $END
  end enter_optional;
  
  
  procedure enter_detailed(
    p_action in varchar2 default null,
    p_params in msg_params default null,
    p_client_info in varchar2 default null)
  as
  begin
    $IF pit_admin.c_trace_le_detailed $THEN
    enter(p_action, p_params, trace_detailed, p_client_info);
    $ELSE
    -- Tracing disallowed by conditional compilation
    null;
    $END
  end enter_detailed;


  procedure enter(
    p_action in varchar2 default null,
    p_params in msg_params default null,
    p_trace_level in number default pit.trace_all,
    p_client_info in varchar2 default null)
  as
  begin
    $IF pit_admin.c_trace_le_all $THEN
    -- starting with version 12c, UTL_CALL_STACK is used if parameters are not provided
    pit_internal.enter(
       p_action, p_params, p_trace_level, p_client_info);
    $ELSE
    -- Tracing disallowed by conditional compilation
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
    -- Tracing disallowed by conditional compilation
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
    -- Tracing disallowed by conditional compilation
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
    -- Tracing disallowed by conditional compilation
    null;
    $END
  end leave_detailed;
  
  
  procedure leave(
    p_trace_level in number default pit.trace_all,
    p_params in msg_params default null)
  is
  begin
    $IF pit_admin.c_trace_le_all $THEN
    pit_internal.leave(p_trace_level, p_params);
    $ELSE
    -- Tracing disallowed by conditional compilation
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
    pit_internal.long_op(
      p_target => p_target,
      p_sofar => p_sofar,
      p_total => p_total,
      p_units => p_units,
      p_op_name => p_op_name);
  end long_op;
  
  /****************************** NOTIFICATION AND MESSAGES *********************************/
  
  procedure print(
    p_message_name in varchar2,
    p_msg_args msg_args default null)
  as
  begin
    pit_internal.print(p_message_name, p_msg_args);
  end print;
  

  procedure notify(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_log_threshold in number default null,
    p_log_modules in varchar2 default null)
  as
  begin
    pit_internal.notify(
      p_message_name => p_message_name,
      p_affected_id => p_affected_id,
      p_msg_args => p_msg_args,
      p_log_threshold => p_log_threshold,
      p_log_modules => p_log_modules);
  end notify;
  
  
  function get_message_text(
    p_message_name in varchar2,
    p_msg_args in msg_args default null)
  return clob
  as
  begin
    return pit_internal.get_message_text(p_message_name, p_msg_args);
  end get_message_text;
    
    
  function get_message_text(
    p_message_name in varchar2,
    p_msg_args in msg_args_char)
    return clob
  as
    l_msg_args msg_args;
  begin
    l_msg_args := pit_util.cast_to_msg_args(p_msg_args);
    return get_message_text(
      p_message_name => p_message_name,
      p_msg_args => l_msg_args);
  end get_message_text;
  
  
  function get_message(
    p_message_name in varchar2,
    p_msg_args in msg_args default null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  return message_type
  as
  begin
    return pit_internal.get_message(p_message_name, p_msg_args, p_affected_id, p_error_code);
  end get_message;
  
  
  function get_active_message
    return message_type
  as
  begin
    return pit_internal.get_active_message;
  end get_active_message;
  
  
  /****************************** ASSERTIONS *********************************/
  procedure assert(
    p_condition in boolean,
    p_message_name in varchar2 default msg.ASSERT_TRUE,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    if not p_condition or p_condition is null then
      pit.error(p_message_name, p_msg_args, p_affected_id, p_error_code);
    end if;
  end assert;
  
  
  procedure assert_is_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.ASSERT_IS_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    if p_condition is not null then
      pit.error(p_message_name, p_msg_args, p_affected_id, p_error_code);
    end if;
  end assert_is_null;
  
  
  procedure assert_is_null(
    p_condition in number,
    p_message_name in varchar2 default msg.ASSERT_IS_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    if p_condition is not null then
      pit.error(p_message_name, p_msg_args, p_affected_id, p_error_code);
    end if;
  end assert_is_null;
  
  
  procedure assert_is_null(
    p_condition in date,
    p_message_name in varchar2 default msg.ASSERT_IS_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    if p_condition is not null then
      pit.error(p_message_name, p_msg_args, p_affected_id, p_error_code);
    end if;
  end assert_is_null;
  
  
  procedure assert_not_null(
    p_condition in varchar2,
    p_message_name in varchar2 default msg.ASSERT_IS_NOT_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    if p_condition is null then
      pit.error(p_message_name, p_msg_args, p_affected_id, p_error_code);
    end if;
  end assert_not_null;
  
  
  procedure assert_not_null(
    p_condition in number,
    p_message_name in varchar2 default msg.ASSERT_IS_NOT_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    if p_condition is null then
      pit.error(p_message_name, p_msg_args, p_affected_id, p_error_code);
    end if;
  end assert_not_null;
  
  
  procedure assert_not_null(
    p_condition in date,
    p_message_name in varchar2 default msg.ASSERT_IS_NOT_NULL,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
  begin
    if p_condition is null then
      pit.error(p_message_name, p_msg_args, p_affected_id, p_error_code);
    end if;
  end assert_not_null;
  
 
  procedure assert_exists(
    p_stmt in varchar2,
    p_message_name in varchar2 default msg.ASSERT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
    l_stmt varchar2(32767) := 'select count(*) from (#STMT#) where rownum = 1';
    l_count number;
  begin
    pit.assert_not_null(l_stmt);
    l_stmt := replace(l_stmt, '#STMT#', p_stmt);
    execute immediate l_stmt into l_count;
    if l_count = 0 then
       pit.error(p_message_name, p_msg_args, p_affected_id, p_error_code);
    end if;
  end assert_exists;
  
  
  procedure assert_exists(
    p_cursor in out nocopy sys_refcursor,
    p_message_name in varchar2 default msg.ASSERT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
    l_id number;
    l_cnt number;
  begin
    l_id := dbms_sql.to_cursor_number(p_cursor);
    l_cnt := dbms_sql.fetch_rows(l_id);
    dbms_sql.close_cursor(l_id);
 
    if l_cnt = 0 then
       pit.error(p_message_name, p_msg_args, p_affected_id, p_error_code);
    end if;
  exception
    when others then
      if dbms_sql.is_open(l_id) then
        dbms_sql.close_cursor(l_id);
      end if;
      raise;
  end assert_exists;
  
  
  procedure assert_not_exists(
    p_stmt  in varchar2,
    p_message_name in varchar2 default msg.ASSERT_NOT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
    l_stmt varchar2(32767) := 'select count(*) from (#STMT#) where rownum = 1';
    l_count number;
  begin
    pit.assert_not_null(l_stmt);
    l_stmt := replace(l_stmt, '#STMT#', p_stmt);
    execute immediate l_stmt into l_count;
    if l_count = 1 then
       pit.error(p_message_name, p_msg_args, p_affected_id, p_error_code);
    end if;
  end assert_not_exists;
  
  
  procedure assert_not_exists(
    p_cursor in out nocopy sys_refcursor,
    p_message_name in varchar2 default msg.ASSERT_NOT_EXISTS,
    p_msg_args msg_args := null,
    p_affected_id in varchar2 default null,
    p_error_code in varchar2 default null)
  as
    l_id number;
    l_cnt number;
  begin
    l_id := dbms_sql.to_cursor_number(p_cursor);
    l_cnt := dbms_sql.fetch_rows(l_id);
    dbms_sql.close_cursor(l_id);
    
    if l_cnt > 0 then
      pit.error(p_message_name, p_msg_args, p_affected_id, p_error_code);
    end if;
  exception
    when others then
      if dbms_sql.is_open(l_id) then
        dbms_sql.close_cursor(l_id);
      end if;
      raise;
  end assert_not_exists;
  
  
  procedure assert_datatype(
     p_value in varchar2,
     p_type  in varchar2,
     p_format_mask in varchar2 default null,
     p_message_name in varchar2 default msg.ASSERT_DATATYPE,
     p_msg_args msg_args := null,
     p_affected_id in varchar2 default null,
     p_error_code in varchar2 default null,
     p_accept_null in boolean default true)
  as
    l_msg_args msg_args;
  begin
    if p_message_name = msg.ASSERT_DATATYPE then 
      l_msg_args := msg_args(p_value, p_type);
    else 
      l_msg_args := p_msg_args;
    end if;
    
    assert(
      p_condition => pit_internal.check_datatype(p_value, p_type, p_format_mask, p_accept_null),
      p_message_name => p_message_name,
      p_msg_args => l_msg_args,
      p_affected_id => p_affected_id,
      p_error_code => p_error_code);
  end assert_datatype;
  
  
  /****************************** INTERNATIONALIZATION *********************************/
  function get_default_language
    return varchar2
  as
  begin
    return pit_util.C_DEFAULT_LANGUAGE;
  end get_default_language;
  
  
  function get_trans_item_name(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_msg_args msg_args default null,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
  return varchar2
  as
  begin
    return pit_internal.get_trans_item(p_pti_pmg_name, p_pti_id, p_msg_args, p_pti_pml_name).pti_name;
  end get_trans_item_name; 
  
    
  function get_trans_item_display_name(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_msg_args msg_args default null,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
  return varchar2
  as
  begin
    return pit_internal.get_trans_item(p_pti_pmg_name, p_pti_id, p_msg_args, p_pti_pml_name).pti_display_name;
  end get_trans_item_display_name; 
  
    
  function get_trans_item_description(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
  return clob
  as
  begin
    return pit_internal.get_trans_item(p_pti_pmg_name, p_pti_id, null, p_pti_pml_name).pti_description;
  end get_trans_item_description; 
  
    
  function get_trans_item(
    p_pti_pmg_name in pit_message_group.pmg_name%type,
    p_pti_id in pit_translatable_item.pti_id%type,
    p_msg_args msg_args default null,
    p_pti_pml_name in pit_message_language.pml_name%type := null)
  return pit_util.translatable_item_rec
  as
  begin
    return pit_internal.get_trans_item(p_pti_pmg_name, p_pti_id, p_msg_args, p_pti_pml_name);
  end get_trans_item; 
  
  
  /****************************** ADMINISTRATION AND CONTROL *********************************/
  
  procedure purge_log(
    p_date_before in date,
    p_severity_lower_equal in number default null)
  as
  begin
    pit_internal.purge_log(p_date_before, p_severity_lower_equal);
  end purge_log;
  
  
  procedure purge_log(
    p_days_before in number,
    p_severity_lower_equal in number default null)
  as
  begin
    purge_log(trunc(sysdate) - p_days_before, p_severity_lower_equal);
  end purge_log;
  
  
  procedure purge_session_log(
    p_session_id in varchar2 default null)
  as
  begin
    -- TODO: IMPLEMENTATION
    null;
  end purge_session_log;
  
  
  procedure set_context(
    p_log_level in integer,
    p_trace_level in integer,
    p_trace_timing in boolean,
    p_log_modules in varchar2)
  as
    l_context pit_util.context_type;
  begin
    l_context.log_level := p_log_level;
    l_context.trace_level := p_trace_level;
    l_context.trace_timing := p_trace_timing;
    l_context.module_list := p_log_modules;
    pit_internal.set_context(l_context);
  end set_context;
  
  
  procedure set_context(
    p_context_name in varchar2)
  as
    l_context pit_util.context_type;
  begin
    l_context.context_name := p_context_name;
    pit_internal.set_context(l_context);
  end set_context;
  
  
  procedure set_context_value(
    p_name in varchar2,
    p_value in varchar2)
   as
   begin
     pit_internal.set_context_value(p_name, p_value);
   end set_context_value;
  
  
  function get_context_value(
    p_name in varchar2)
    return varchar2
  as
  begin
    return pit_internal.get_context_value(p_name);
  end get_context_value;
  
  
  procedure reset_context(
    p_active_session_only in boolean default true)
  as
  begin
    if p_active_session_only then
      pit_internal.reset_active_context;
    else
      pit_internal.reset_context;
    end if;
  end reset_context;
  
  
  function get_context
    return pit_util.context_type
  as
  begin
    return pit_internal.get_context;
  end get_context;
  
  
  procedure start_message_collection
  as
  begin
    if not pit_internal.get_collect_mode then
      pit_internal.set_collect_mode(true);
    end if;
  end start_message_collection;
  
  
  procedure stop_message_collection
  as
  begin
    if pit_internal.get_collect_mode then
      pit_internal.set_collect_mode(false);
    end if;
  end stop_message_collection;
  
  
  function has_no_bulk_error
    return boolean
  as
  begin
    return pit_internal.get_collect_least_severity > pit_internal.C_LEVEL_ERROR;
  end has_no_bulk_error;
  
  
  function has_no_bulk_fatal
    return boolean
  as
  begin
    return pit_internal.get_collect_least_severity > pit_internal.C_LEVEL_FATAL;
  end has_no_bulk_fatal;
  
  
  function get_message_collection
    return pit_message_table
  as
  begin
    return pit_internal.get_message_collection;
  end get_message_collection;
  
  
  function get_modules
  return pit_module_list
    pipelined
  as
    cursor modules is
      select pit_module_meta(module_name, module_available, module_active, module_stack) module
        from table(pit_internal.get_modules);
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
        from table(pit_internal.get_available_modules);
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
        from table(pit_internal.get_active_modules);
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
