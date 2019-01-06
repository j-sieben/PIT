create or replace package body pit_console_pkg
as
  /* Konstanten und Variablen */
  C_PARAM_GROUP constant varchar2(20 char) := 'PIT';
  C_PIT_CONSOLE constant varchar2(20) := 'PIT_CONSOLE';
  C_FIRE_THRESHOLD constant varchar2(30 char) := C_PIT_CONSOLE || '_FIRE_THRESHOLD';
  C_ENTER_TEMPLATE constant varchar2(30 char) := C_PIT_CONSOLE || '_ENTER_TEMPLATE';
  C_LEAVE_TEMPLATE constant varchar2(30 char) := C_PIT_CONSOLE || '_LEAVE_TEMPLATE';
  C_MESSAGE_TEMPLATE constant varchar2(30 char) := C_PIT_CONSOLE || '_MSG_TEMPLATE';
  C_LEVEL_INDICATOR  constant varchar2(30 char) := C_PIT_CONSOLE || '_LEVEL_INDICATOR';

  g_message_template varchar2(2000);
  g_enter_template varchar2(2000);
  g_leave_template varchar2(2000);
  g_level_indicator varchar2(10);

  /* Initialization
   * %usage Reads several parameters into global variables
   */
  procedure initialize
  as
  begin
    g_message_template := param.get_string(C_MESSAGE_TEMPLATE, C_PARAM_GROUP);
    g_enter_template := param.get_string(C_ENTER_TEMPLATE, C_PARAM_GROUP);
    g_leave_template := param.get_string(C_LEAVE_TEMPLATE, C_PARAM_GROUP);
    g_level_indicator := param.get_string(C_LEVEL_INDICATOR, C_PARAM_GROUP);
  end initialize;

  /* Helper to print a message to the console
   * %param p_message Message to print to the console
   * %usage Called to forward a message text to the console, reducing output to 32KByte
   *        to take limitations of dbms_output into account
   */
  procedure print(
    p_message in clob)
  as
  begin
    dbms_output.enable(buffer_size => 32767);
    -- reduce output to 32767 chars (limitation of put_line)
    dbms_output.put_line(dbms_lob.substr(p_message));
  end print;


  /* Helper to print the content of a call stack
   * %param p_call_stack Instance of call stack to print
   * %param p_template Name of the template to be used to format the output.
   * %usage Templates are defined as parameters and referenced here to control
   *        the formatting of the call stack. After formatting, procedure PRINT
   *        is called to print the call stack.
   */
  procedure print_call_stack(
    p_call_stack in call_stack_type,
    p_template in varchar2)
  as
    l_unit_name varchar2(257 byte);
    l_indent varchar2(2000);
    l_indent_length binary_integer;
    l_timing varchar2(100);
    l_message pit_util.max_char;
    l_postfix pit_util.max_char;
    l_param varchar2(1000);
    c_etc constant char(1 char) := '…';
  begin
    -- Program unit
    l_unit_name := p_call_stack.module_name || '.' || p_call_stack.method_name;

    -- Indent
    l_indent_length := length(g_level_indicator);
    l_indent_length := (p_call_stack.call_level * l_indent_length) - l_indent_length;
    l_indent := lpad(g_level_indicator, l_indent_length, g_level_indicator);
    
    -- Parameters
    if p_call_stack.params is not null then
      l_postfix := ' [';
      for i in p_call_stack.params.first .. p_call_stack.params.last loop
        l_param := case i when 1 then null else '; ' end 
                || p_call_stack.params(i).p_param || '="' 
                || case when length(p_call_stack.params(i).p_value) > 49 
                        then substr(p_call_stack.params(i).p_value, 1, 49) || c_etc
                        else p_call_stack.params(i).p_value end || '"';
        if length(l_postfix || l_param) < 2000 then
          l_postfix := l_postfix || l_param;
        else
          l_postfix := l_postfix || c_etc;
          exit;
        end if;
      end loop;
      l_postfix := l_postfix || ']';
    end if;

    -- Timing
    if p_call_stack.trace_timing = 'Y' then
      l_timing := ' [wc=' || to_char(p_call_stack.wall_clock) ||
                  '; e=' || to_char(p_call_stack.elapsed) ||
                  '; e_cpu=' || to_char(p_call_stack.elapsed_cpu) ||
                  '; t=' || to_char(p_call_stack.total) ||
                  '; t_cpu=' || to_char(p_call_stack.total_cpu) || ']';
    end if;
    l_message :=
      replace(replace(replace(replace(p_template, '#MESSAGE#', l_unit_name), '#POSTFIX#', l_postfix), '#TIMING#', l_timing), '#LEVEL#', l_indent);
    print(l_message);
  end print_call_stack;

  /* Interface Implementierung */
  procedure log(
    p_message in message_type)
  as
  begin
    print(replace(g_message_template, '#MESSAGE#', p_message.message_text));
    if p_message.stack is not null then
      print(p_message.stack);
      print(p_message.backtrace);
    end if;
  end log;

  procedure enter(
    p_call_stack in call_stack_type)
  as
  begin
    print_call_stack(p_call_stack, g_enter_template);
  end enter;

  procedure leave(
    p_call_stack in call_stack_type)
  as
  begin
    print_call_stack(p_call_stack, g_leave_template);
  end leave;

  procedure context_changed(
    p_ctx in pit_context)
  as
    c_del constant varchar2(5) := ', ';
  begin
    dbms_output.put_line(
      pit.get_message_text(
        msg.CTX_CHANGED,
        msg_args(p_ctx.to_string())));
  end context_changed;

  procedure initialize_module(
    self in out pit_console)
  as
  begin
    self.fire_threshold := param.get_integer(C_FIRE_THRESHOLD, C_PARAM_GROUP);
    self.status := msg.PIT_MODULE_INSTANTIATED;
  exception
    when others then
      self.status := msg.PIT_FAIL_MODULE_INIT;
      self.stack := dbms_utility.format_error_stack;
  end initialize_module;

begin
  initialize;
end pit_console_pkg;
/
