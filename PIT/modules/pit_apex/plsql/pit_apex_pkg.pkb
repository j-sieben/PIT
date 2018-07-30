create or replace package body pit_apex_pkg
as
  /**
    Author       : $Author: juergen $
    Created      : 03.05.2010
    Last Changed : $LastChangedDate: 2014-05-04 18:39:38 +0200 (So, 04 Mai 2014) $
    Revision     : $Revision: 1008 $
    HeadURL      : $HeadURL: svn+ssh://juergen@176.9.99.236/home/svn/repos/src/kismon/plsql/param_admin.pks $
    ID           : $Id: param_admin.pks 1008 2014-05-04 16:39:38Z juergen $
    Purpose      : PIT-Modul zur Ausgabe innerhalb von APEX-Anwendungen
  */

  /* CONSTANTS AND VARIABLES */
  c_param_group    constant varchar2(20 char) := 'PIT';
  c_fire_threshold constant varchar2(30 char) := 'PIT_APEX_FIRE_THRESHOLD';
  c_trg_fire_threshold constant varchar2(30 char) := 'PIT_APEX_TRG_FIRE_THRESHOLD';
  c_trg_trace_threshold constant varchar2(30 char) := 'PIT_APEX_TRG_TRACE_THRESHOLD';
  c_trg_trace_timing constant varchar2(30 char) := 'PIT_APEX_TRG_TRACE_TIMING';
  c_trg_log_modules constant varchar2(30 char) := 'PIT_APEX_TRG_LOG_MODULES';
  c_yes constant varchar2(3 byte) := 'YES';
  
  g_apex_triggered_context pit_pkg.context_type;
  c_chunk_size constant integer := 8192;
  g_fire_threshold number;

  /* HELPER */
  procedure initialize
  as
  begin
    g_fire_threshold := param.get_integer(c_fire_threshold, c_param_group);
    g_apex_triggered_context.log_level := param.get_integer(c_trg_fire_threshold, c_param_group);
    g_apex_triggered_context.trace_level := param.get_integer(c_trg_trace_threshold, c_param_group);
    g_apex_triggered_context.trace_timing := param.get_boolean(c_trg_trace_timing, c_param_group);
    g_apex_triggered_context.log_modules := param.get_string(c_trg_log_modules, c_param_group);
  end initialize;
  

  /* valid_environment checks whether module is called within a valid APEX
   * session environment
   */
  function valid_environment
    return boolean
  as
  begin
    return apex_application.get_session_id is not null;
  end valid_environment;
  
  
  /* helper function to convert MSG_PARAMS into NAME-VALUE-Pairs
   * odd position number returns name of the parameter
   * even position number returns value of the parameter
   */
  function get_msg_param(
    p_call_stack in call_stack_type,
    p_position in number)
    return varchar2
  as
    l_position number;
  begin
    l_position := round((p_position - 0.25)/2);
    if p_call_stack.params.exists(l_position) then
      if mod(p_position, 2) = 1 then
        return p_call_stack.params(l_position).p_param;
      else
        return p_call_stack.params(l_position).p_value;
      end if;
    else
      return null;
    end if;
  end get_msg_param;


  /* debug_message forwards messages to the APEX debug stack, if
   * - log_level PIT_APEX_FIRE_THRESHOLD is reached
   * - APEX-logging is activated
   */
  procedure debug_message(
    p_message in message_type)
  as
    l_severity binary_integer range 1..7;
    l_message varchar2(32767);
  begin
    if valid_environment then
      l_severity := round(p_message.severity/10);
      if p_message.stack is not null then
        l_message := dbms_lob.substr(p_message.message_text, 30000, 1)
                  || chr(10)
                  || substr(p_message.stack, 1, 200)
                  || chr(10)
                  || substr(p_message.backtrace, 1, 2550);
      else
        l_message := dbms_lob.substr(p_message.message_text, 32760, 1);
      end if;
      
      apex_debug.log_long_message(
        p_message => l_message,
        p_level => l_severity);
    end if;
  end debug_message;
  
  
  /* helper to add error messages to the apex error stack
   */
  procedure log_error(
    p_message in message_type)
  as
  begin
    if valid_environment then
      if p_message.affected_id is not null and regexp_like(p_message.affected_id, '^P[0-9]+_') then
        apex_error.add_error(
          p_message => p_message.message_text,
          p_additional_info => null,
          p_page_item_name => p_message.affected_id,
          p_display_location => apex_error.c_inline_with_field_and_notif);
      else
        apex_error.add_error(
          p_message => p_message.message_text,
          p_additional_info => null,
          p_display_location => apex_error.c_inline_with_field_and_notif);
      end if;
    end if;
  end log_error;
  

  /* helper procedure to pass clob to APEX, using htp.p
   * clob is splitted into chunks of c_chunk_size bytes to circumvent the limitation
   * of http-streams of 32 KByte
   */
  procedure print_clob(
    p_text in clob)
  as
    l_offset integer := 1;
    l_amount integer := c_chunk_size;
    l_chunk varchar2(32767);
    l_length integer := dbms_lob.getlength(p_text);
  begin
    if valid_environment then
      while l_length > 0 and p_text is not null loop
        dbms_lob.read(
          lob_loc => p_text,
          amount => l_amount,
          offset => l_offset,
          buffer => l_chunk);
        l_offset := l_offset + l_amount;
        l_length := l_length - l_amount;
        sys.htp.p(l_chunk);
      end loop;      
    end if;
  end print_clob;


  /* INTERFACE */
  procedure log(
    p_message in message_type)
  as
    error_count integer;
  begin
    if valid_environment then
      -- Entscheidungsbaum zur Ausgabe der einzelnen Schweregrade
      case p_message.severity
      when pit.level_all then
        debug_message(p_message);
      when pit.level_debug then
        debug_message(p_message);
      when pit.level_info then
        debug_message(p_message);
      when pit.level_warn then
        debug_message(p_message);
        apex_application.g_notification := p_message.message_text;
        apex_application.g_print_success_message := null;
      when pit.level_error then
        log_error(p_message);
      when pit.level_fatal then
        debug_message(p_message);
        log_error(p_message);
        wwv_flow.g_unrecoverable_error := true;
      else
        -- Level off
        null;
      end case;
    end if;
  end log;


  procedure print(
    p_message in message_type)
  as
  begin
    print_clob(p_message.message_text);
  end;


  procedure enter(
    p_call_stack in call_stack_type)
  is
    l_message message_type;
    l_message_language varchar2(64);
    l_param_list varchar2(32767);
    l_next_param varchar2(32767);
  begin
    if valid_environment then
      apex_debug.enter( 
        p_routine_name => p_call_stack.module_name || '.' || p_call_stack.method_name, 
        p_name01 => get_msg_param(p_call_stack, 1), 
        p_value01 => get_msg_param(p_call_stack, 2), 
        p_name02 => get_msg_param(p_call_stack, 3), 
        p_value02 => get_msg_param(p_call_stack, 4), 
        p_name03 => get_msg_param(p_call_stack, 5), 
        p_value03 => get_msg_param(p_call_stack, 6), 
        p_name04 => get_msg_param(p_call_stack, 7), 
        p_value04 => get_msg_param(p_call_stack, 8), 
        p_name05 => get_msg_param(p_call_stack, 9), 
        p_value05 => get_msg_param(p_call_stack, 10), 
        p_name06 => get_msg_param(p_call_stack, 11), 
        p_value06 => get_msg_param(p_call_stack, 12),  
        p_name07 => get_msg_param(p_call_stack, 13), 
        p_value07 => get_msg_param(p_call_stack, 14), 
        p_name08 => get_msg_param(p_call_stack, 15), 
        p_value08 => get_msg_param(p_call_stack, 16), 
        p_name09 => get_msg_param(p_call_stack, 17), 
        p_value09 => get_msg_param(p_call_stack, 18), 
        p_name10 => get_msg_param(p_call_stack, 19),  
        p_value10 => get_msg_param(p_call_stack, 20));
      debug_message(l_message);
    end if;
  end enter;


  procedure leave(
    p_call_stack in call_stack_type)
  as
    l_message message_type;
  begin
    null;
  end leave;
  
  
  procedure set_apex_triggered_context
  as
  begin
    if valid_environment then
      if v('DEBUG') = c_yes then
        pit_pkg.set_context(g_apex_triggered_context);
      else
        pit.reset_context;
      end if;
    end if;
  end set_apex_triggered_context;


  procedure initialize_module(
    self in out pit_apex)
  as
  begin
    if valid_environment then
      self.fire_threshold := g_fire_threshold;
      self.status := msg.pit_module_instantiated;
    else
      self.status := msg.pit_fail_module_init;
      self.stack  := 'Invalid APEX environment';
    end if;
  exception
    when others then
      self.status := msg.pit_fail_module_init;
      $if dbms_db_version.ver_le_11 $then
      self.stack := dbms_utility.format_error_backtrace;
      $else
      self.stack := dbms_utility.format_error_stack;
      $end
  end initialize_module;

begin
   initialize;
end pit_apex_pkg;
/