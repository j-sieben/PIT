create or replace
package body pit_file_pkg
as
  /* Konstanten und Variablen */
  type param_tab is table of pit_util.ora_name_type
    index by pit_util.ora_name_type;
  g_param_list param_tab;
  
  C_PARAM_GROUP constant pit_util.ora_name_type := 'PIT';
  C_PIT_FILE constant pit_util.ora_name_type := 'PIT_FILE';
  C_FIRE_THRESHOLD constant pit_util.ora_name_type := C_PIT_FILE || '_FIRE_THRESHOLD';
  C_OUT_DIRECTORY constant pit_util.ora_name_type := C_PIT_FILE || '_DIRECTORY';
  C_FILE_NAME constant pit_util.ora_name_type := C_PIT_FILE || '_FILE_NAME';
  C_ENTER_TEMPLATE constant pit_util.ora_name_type := C_PIT_FILE || '_ENTER_TEMPLATE';
  C_LEAVE_TEMPLATE constant pit_util.ora_name_type := C_PIT_FILE || '_LEAVE_TEMPLATE';
  C_MESSAGE_TEMPLATE constant pit_util.ora_name_type := C_PIT_FILE || '_MSG_TEMPLATE';
  C_LEVEL_INDICATOR  constant pit_util.ora_name_type := C_PIT_FILE || '_LEVEL_INDICATOR';
  
  C_WRITE_APPEND constant pit_util.flag_type := 'A';  
  C_WRITE_REPLACE constant pit_util.flag_type := 'W';
  C_ENTER_FLAG constant varchar2(5) := '> ';
  C_LEAVE_FLAG constant varchar2(5) := '< ';
  C_LEVEL_SIGN constant char(1) := '.';
  
  g_dir varchar2(2000);
  g_filename varchar2(100);
  g_trc_file utl_file.file_type;
  g_message_template varchar2(2000);
  g_enter_template varchar2(2000);
  g_leave_template varchar2(2000);
  g_level_indicator varchar2(100);
  
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

  
  /* Helper method to open the log file.
   * %param p_write_mode flag according to UTL_FILE to control how a file has to be opened
   * %usage Is called to prepare the log file for writing.
   */
  procedure open_file(
    p_write_mode in char)
  as
  begin
    if not utl_file.is_open(g_trc_file) then
      g_trc_file := utl_file.fopen(g_dir, g_filename, p_write_mode);
    end if;
  end open_file;
  
  
  /* Helper to close the log file.
   * %usage Is called to close the log file and release the resources
   */
  procedure close_file
  as
  begin
    if utl_file.is_open(g_trc_file) then
      utl_file.fclose(g_trc_file);
    end if;
  end close_file;
  
  
  /* Helper to write text to the log file
   * %param p_text Text that is appended to the log file
   * %usage Is called to append text to the log file
   */
  procedure write_to_file(
    p_text in varchar2)
  as
  begin
    utl_file.put_line(g_trc_file, p_text, true);
  end write_to_file;
  
  
  /* Helper to format call stack entries to write them to the log file
   * %param p_call_stack Instance of call stack to be printed
   * %param p_template Name of the template to be used to format the output.
   * %usage Templates are defined as parameters and referenced here to control
   *        the formatting of the call stack. After formatting, procedure WRITE_TO_FILE
   *        is called to append the call stack to the log file.
   */
  procedure write_call_stack(
    p_call_stack in call_stack_type,
    p_template in varchar2)
  as
    l_unit_name varchar2(61);
    l_indent varchar2(2000);
    l_indent_length binary_integer;
    l_timing varchar2(100);
    l_message pit_util.max_char;
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
    write_to_file(l_message);
  end write_call_stack;
  
    
  /* INTERFACE */  
  procedure log(
    p_message in message_type)
  as
  begin
    write_to_file(replace(g_message_template, '#MESSAGE#', p_message.message_text));
    if p_message.backtrace is not null then
      write_to_file(p_message.stack);
      write_to_file(p_message.backtrace);
    end if;
  end log;
  
  
  procedure purge
  as
  begin
    close_file;
    open_file(C_WRITE_REPLACE);
    write_to_file('');
    close_file;
    open_file(C_WRITE_APPEND);
  end purge;
  
  
  procedure enter(
    p_call_stack in call_stack_type)
  as
  begin
    write_call_stack(p_call_stack, g_enter_template);
  end enter;
  
  
  procedure leave(
    p_call_stack in call_stack_type)
  as
  begin
    write_call_stack(p_call_stack, g_leave_template);
  end leave;
  
  
  procedure initialize_module(
    self in out pit_file)
  as
  begin
    g_dir := param.get_string(C_OUT_DIRECTORY, C_PARAM_GROUP);
    g_filename := param.get_string(C_FILE_NAME, C_PARAM_GROUP);
    -- Test
    open_file(C_WRITE_APPEND);
    self.fire_threshold := param.get_integer(C_FIRE_THRESHOLD, C_PARAM_GROUP);
    self.status := msg.PIT_MODULE_INSTANTIATED;
  exception
    when others then
      -- KEINEN Fehler werfen, da in Initialisierungsphase!
      self.fire_threshold := pit.level_off;
      self.status := msg.PIT_FAIL_MODULE_INIT;
      self.stack := dbms_utility.format_error_stack;
  end initialize_module;

begin
  initialize;
end pit_file_pkg;
/

show errors
