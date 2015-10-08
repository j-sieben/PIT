create or replace
package body pit_console_pkg
as
  /* Konstanten und Variablen */
  c_param_group constant varchar2(20 char) := 'PIT';
  c_pit_console constant varchar2(20) := 'PIT_CONSOLE';
  c_fire_threshold constant varchar2(30 char) := c_pit_console || '_FIRE_THRESHOLD';
  c_enter_template constant varchar2(30 char) := c_pit_console || '_ENTER_TEMPLATE';
  c_leave_template constant varchar2(30 char) := c_pit_console || '_LEAVE_TEMPLATE';
  c_message_template constant varchar2(30 char) := c_pit_console || '_MSG_TEMPLATE';
  c_level_indicator  constant varchar2(30 char) := c_pit_console || '_LEVEL_INDICATOR';
  
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
    g_message_template := param.get_string(c_message_template, c_param_group);
    g_enter_template := param.get_string(c_enter_template, c_param_group);
    g_leave_template := param.get_string(c_leave_template, c_param_group);
    g_level_indicator := param.get_string(c_level_indicator, c_param_group);
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
    l_unit_name varchar2(61);
    l_indent varchar2(2000);
    l_indent_length number;
    l_timing varchar2(100);
    l_message varchar2(32767);
  begin
    -- Program unit
    l_unit_name := p_call_stack.module_name || '.' || p_call_stack.method_name;
    
    -- Indent
    l_indent_length := length(g_level_indicator);
    l_indent_length := (p_call_stack.call_level * l_indent_length) - l_indent_length;
    l_indent := lpad(g_level_indicator, l_indent_length, g_level_indicator);
    
    -- Timing
    if p_call_stack.trace_timing = 'Y' then
      l_timing := ' [wc=' || to_char(p_call_stack.wall_clock) ||
                  '; e=' || to_char(p_call_stack.elapsed) ||
                  '; e_cpu=' || to_char(p_call_stack.elapsed_cpu) ||
                  '; t=' || to_char(p_call_stack.total) ||
                  '; t_cpu=' || to_char(p_call_stack.total_cpu) || ']';
    end if;
    l_message :=
      replace(replace(replace(p_template, '#MESSAGE#', l_unit_name), '#TIMING#', l_timing), '#LEVEL#', l_indent);
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

  procedure initialize_module(
    self in out pit_console)
  as
  begin
    self.fire_threshold := param.get_integer(c_fire_threshold, c_param_group);
    self.status := msg.MODULE_INSTANTIATED;
  exception
    when others then
      self.status := msg.MODULE_INITIALIZATION_ERROR;
      self.stack := dbms_utility.format_error_stack;
  end initialize_module;

begin
  initialize;
end pit_console_pkg;
/