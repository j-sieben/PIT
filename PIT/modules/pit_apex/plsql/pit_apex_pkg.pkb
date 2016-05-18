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
  
  g_apex_triggered_context pit_pkg.context_type;
  c_chunk constant integer := 4000;
  g_session_language varchar2(64);
  g_fire_threshold number;

   /* HELPER */
   procedure initialize
   as
   begin
      select value
        into g_session_language
        from nls_session_parameters
       where parameter = 'NLS_LANGUAGE';
      
      g_fire_threshold := param.get_integer(c_fire_threshold, c_param_group);
      g_apex_triggered_context.log_level := param.get_integer(c_trg_fire_threshold, c_param_group);
      g_apex_triggered_context.trace_level := param.get_integer(c_trg_trace_threshold, c_param_group);
      g_apex_triggered_context.trace_timing := param.get_boolean(c_trg_trace_timing, c_param_group);
      g_apex_triggered_context.log_modules := param.get_string(c_trg_log_modules, c_param_group);
   end initialize;

   function get_message(
     p_message_name in varchar2,
     p_call_stack in call_stack_type)
     return message_type
   as
    l_method_name clob;
    l_msg_params clob;
    l_param msg_param;
    l_prefix varchar2(10);
   begin
    l_method_name := to_clob(p_call_stack.method_name);
    case when p_call_stack.params is not null then
      dbms_lob.createtemporary(l_msg_params, false, dbms_lob.call);
      for i in p_call_stack.params.first .. p_call_stack.params.last loop
        l_param := p_call_stack.params(i);
        dbms_lob.append(l_msg_params, l_param.p_param || ': ' || l_param.p_value || '; ');
      end loop;
    else
      l_msg_params := 'Ø';
    end case;
    return
      message_type(
        p_message_name => p_message_name,
        p_message_language => g_session_language,
        p_affected_id => null,
        p_session_id => p_call_stack.session_id,
        p_user_name => null,
        p_arg_list => msg_args(l_method_name, l_msg_params));
   end get_message;

  /* valid_environment checks whether module is called within a valid APEX
   * session environment
   */
  function valid_environment
    return boolean
  as
  begin
    return apex_application.get_session_id is not null;
  end valid_environment;


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
    case p_message.message_name
    when msg.PIT_CODE_ENTER then l_message := '=> ' || l_message;
    when msg.PIT_CODE_LEAVE then l_message := '<= ' || l_message;
    else null;
    end case;
      apex_debug.log_long_message(
        p_message => l_message,
        p_level => l_severity);
    end if;
  end debug_message;

  /* helper procedure to pass clob to APEX, using htp.print
   * clob is splitted into chunks of C_CHUNK bytes to circumvent the limitation
   * of http-streams of 32 KByte
   */
  procedure print_clob(
    p_text in clob)
  as
    l_idx integer := 1;
    l_amount integer := c_chunk;
    l_chunk varchar2(32767);
    l_length integer := dbms_lob.getlength(p_text);
  begin
    if valid_environment then
      while l_length > 0 and p_text is not null loop
        dbms_lob.read(
          lob_loc => p_text,
          amount => l_amount,
          offset => l_idx,
          buffer => l_chunk);
        l_idx := l_idx + l_amount;
        l_length := l_length - l_amount;
        htp.prn(l_chunk);
      end loop;      
    end if;
  end;


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
        debug_message(p_message);
        wwv_flow.show_error_message(dbms_lob.substr(p_message.message_text, 1, c_chunk));
      when pit.level_fatal then
        debug_message(p_message);
        wwv_flow.show_error_message(dbms_lob.substr(p_message.message_text, 1, c_chunk));
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
      l_message := get_message(msg.PIT_CODE_ENTER, p_call_stack);
      debug_message(l_message);
    end if;
  end enter;


  procedure leave(
    p_call_stack in call_stack_type)
  as
    l_message message_type;
  begin
    if valid_environment then
      l_message := get_message(msg.PIT_CODE_LEAVE, p_call_stack);
      debug_message(l_message);
    end if;
  end leave;
  
  
  procedure set_apex_triggered_context
  as
  begin
    if valid_environment then
      if v('DEBUG') = 'YES' then
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
      self.status := msg.PIT_MODULE_INSTANTIATED;
    else
      self.status := msg.PIT_FAIL_MODULE_INIT;
      self.stack  := 'Invalid APEX environment';
    end if;
  exception
    when others then
      self.status := msg.PIT_FAIL_MODULE_INIT;
      self.stack  := dbms_utility.format_error_stack;
  end initialize_module;

begin
   initialize;
end pit_apex_pkg;
/