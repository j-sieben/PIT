create or replace package body pit_file_pkg
as

  /**
    Package: Output Modules.PIT_FILE.PIT_FILE_PKG Body
      Implements MODULE.PIT_FILE output module methods

    Author::
      Juergen Sieben, ConDeS GmbH

      Published under MIT licence
   */
   
  /**
    Group: Constants and global variables 
  */
  
  /**
    Constants: Parameter constants
      C_PARAM_GROUP - Parameter group of <PIT>
      C_PIT_FILE - Prefix for parameter names
      C_FIRE_THRESHOLD - Parameter name for the fire threshold
      C_OUT_DIRECTORY - Parameter name for the directory object to write to
      C_FILE_NAME - Parameter name for the file name of the trace file
      C_ENTER_TEMPLATE - Parameter name for the ENTER-Template
      C_LEAVE_TEMPLATE - Parameter name for the LEAVE-Template
      C_MESSAGE_TEMPLATE - Parameter name for the MESSAGE_TYPE-Template
      C_LEVEL_INDICATOR - Parameter name for the level indicator
   */
  C_PARAM_GROUP constant pit_util.ora_name_type := 'PIT';
  C_PIT_FILE constant pit_util.ora_name_type := 'PIT_FILE';
  C_FIRE_THRESHOLD constant pit_util.ora_name_type := C_PIT_FILE || '_FIRE_THRESHOLD';
  C_OUT_DIRECTORY constant pit_util.ora_name_type := C_PIT_FILE || '_DIRECTORY';
  C_FILE_NAME constant pit_util.ora_name_type := C_PIT_FILE || '_FILE_NAME';
  C_ENTER_TEMPLATE constant pit_util.ora_name_type := C_PIT_FILE || '_ENTER_TEMPLATE';
  C_LEAVE_TEMPLATE constant pit_util.ora_name_type := C_PIT_FILE || '_LEAVE_TEMPLATE';
  C_MESSAGE_TEMPLATE constant pit_util.ora_name_type := C_PIT_FILE || '_MSG_TEMPLATE';
  C_LEVEL_INDICATOR  constant pit_util.ora_name_type := C_PIT_FILE || '_LEVEL_INDICATOR';
  
  C_WRITE_APPEND constant pit_util.sign_type := 'A';  
  C_WRITE_REPLACE constant pit_util.sign_type := 'W';
  C_ENTER_FLAG constant varchar2(5) := '> ';
  C_LEAVE_FLAG constant varchar2(5) := '< ';
  C_LEVEL_SIGN constant pit_util.sign_type := '.';
  C_CR constant varchar2(2) := chr(10);
  
  g_dir varchar2(2000);
  g_filename varchar2(100);
  g_trc_file utl_file.file_type;
  g_message_template varchar2(2000);
  g_state_template varchar2(2000);
  g_enter_template varchar2(2000);
  g_leave_template varchar2(2000);
  g_level_indicator varchar2(100);
  
  /**
    Procedure: initialize
      Initialization method.
      
      Is called by <INITIALIZE_MODULE> and reads several parameters into global variables
   */
  procedure initialize
  as
  begin
    g_message_template := param.get_string(C_MESSAGE_TEMPLATE, C_PARAM_GROUP);
    g_enter_template := param.get_string(C_ENTER_TEMPLATE, C_PARAM_GROUP);
    g_leave_template := param.get_string(C_LEAVE_TEMPLATE, C_PARAM_GROUP);
    g_level_indicator := param.get_string(C_LEVEL_INDICATOR, C_PARAM_GROUP);
  end initialize;

  
  /**
    Group: Helper Methods
   */
  /** 
    Procedure: open_file
      Helper method to open the log file. Is called to prepare the log file for writing.
      
    Parameter:
      p_write_mode - Flag according to UTL_FILE to control how a file has to be opened
   */
  procedure open_file(
    p_write_mode in char)
  as
  begin
    if not utl_file.is_open(g_trc_file) then
      g_trc_file := utl_file.fopen(g_dir, g_filename, p_write_mode);
    end if;
  end open_file;
  
  
  /** 
    Procedure: close_file
      Helper to close the log file. Is called to close the log file and release the resources.
   */
  procedure close_file
  as
  begin
    if utl_file.is_open(g_trc_file) then
      utl_file.fclose(g_trc_file);
    end if;
  end close_file;
  
  
  /** 
    Procedure write_to_file
      Helper to write text to the log file
      
    Parameter:
      p_text - Text that is appended to the log file.
   */
  procedure write_to_file(
    p_text in varchar2)
  as
  begin
    utl_file.put_line(g_trc_file, p_text, true);
  end write_to_file;
  
  
  /** 
    Procedure: write_call_stack
      Helper to format call stack entries to write them to the log file.
      
      Templates are defined as parameters and referenced here to control the formatting of the call stack. 
      After formatting, procedure <WRITE_TO_FILE> is called to append the call stack to the log file.
      
    Parameters:
      p_call_stack - Instance of <PIT_CALL_STACK> to be printed
      p_template - Name of the template to be used to format the output.
   */
  procedure write_call_stack(
    p_call_stack in pit_call_stack_type,
    p_template in varchar2)
  as
    l_unit_name pit_util.ora_name_type;
    l_indent pit_util.max_sql_char;
    l_indent_length pls_integer;
    l_timing pit_util.small_char;
    l_message pit_util.max_char;
  begin
    -- Program unit
    l_unit_name := p_call_stack.module_name || '.' || p_call_stack.method_name;
    
    -- Indent
    l_indent_length := length(g_level_indicator);
    l_indent_length := (p_call_stack.call_level * l_indent_length) - l_indent_length;
    l_indent := lpad(g_level_indicator, l_indent_length, g_level_indicator);
    
    -- Timing
    $IF dbms_db_version.ver_le_19 $THEN
    if p_call_stack.trace_timing = pit_util.C_TRUE then
    $ELSIF dbms_db_version.ver_le_21 $THEN
    if p_call_stack.trace_timing = pit_util.C_TRUE then
    $ELSE
    if p_call_stack.trace_timing then
    $END
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
  
  
  /**
    Group: Interface
   */
  /**
    Procedure: log_exception
      see <pit_file_pkg.log_exception>
   */
  procedure log_exception(
    self in out nocopy pit_file,
    p_message in message_type)
  as
  begin
    write_to_file(replace(g_message_template, '#MESSAGE#', p_message.message_text));
    if p_message.backtrace is not null then
      write_to_file(p_message.stack);
      write_to_file(p_message.backtrace);
    end if;
  end log_exception;
  
  
  /**
    Procedure: panic
      see <pit_file_pkg.panic>
   */
  procedure panic(
    self in out nocopy pit_file,
    p_message in message_type)
  as
  begin
    write_to_file(replace(g_message_template, '#MESSAGE#', p_message.message_text));
    if p_message.backtrace is not null then
      write_to_file(p_message.stack);
      write_to_file(p_message.backtrace);
    end if;
  end panic;
  
  
  /**
    Procedure: tweet
      see <pit_file_pkg.tweet>
   */
  procedure tweet(
    self in out nocopy pit_file,
    p_message in message_type)
  as
  begin
    write_to_file(replace(g_message_template, '#MESSAGE#', p_message.message_text));
  end tweet;
  
  
  /**
    Procedure: log_state
      see <pit_file_pkg.log_state>
   */
  procedure log_state(
    self in out nocopy pit_file,
    p_log_state in pit_log_state_type)
  as
    l_position pls_integer;
    l_state_start pit_util.max_sql_char;
    l_state_end pit_util.max_sql_char;
    l_state pit_util.max_char;
    C_ANCHOR constant pit_util.small_char := '#STATE#';
    C_PREFIX constant pit_util.small_char := '-  ';
  begin
    if p_log_state.params.count > 0 then
      l_position := instr(g_state_template, C_ANCHOR);
      l_state_start := substr(g_state_template, 1, l_position - 1);
      l_state_end := substr(g_state_template, l_position + length(C_ANCHOR));
          
      write_to_file(l_state_start);
      for i in 1 .. p_log_state.params.count loop
        write_to_file(C_PREFIX || p_log_state.params(i).p_param || ': ' || p_log_state.params(i).p_value || C_CR);
      end loop;
      write_to_file(l_state_end);
    end if;
  end log_state;
  
  
  /**
    Procedure: purge_log
      see <pit_file_pkg.purge_log>
   */
  procedure purge_log(
    self in out nocopy pit_file,
    p_purge_date in date,
    p_severity_greater_equal in integer default null)
  as
  begin
    close_file;
    open_file(C_WRITE_REPLACE);
    write_to_file('');
    close_file;
    open_file(C_WRITE_APPEND);
  end purge_log;
  
  
  /**
    Procedure: enter
      see <pit_file_pkg.enter>
   */
  procedure enter(
    self in out nocopy pit_file,
    p_call_stack in pit_call_stack_type)
  as
  begin
    write_call_stack(p_call_stack, g_enter_template);
  end enter;
  
  
  /**
    Procedure: leave
      see <pit_file_pkg.leave>
   */
  procedure leave(
    self in out nocopy pit_file,
    p_call_stack in pit_call_stack_type)
  as
  begin
    write_call_stack(p_call_stack, g_leave_template);
  end leave;
  
  
  /**
    Procedure: initialize_module
      see <pit_file_pkg.initialize_module>
   */
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
      -- DO NOT throw an error, because in initialization phase!
      self.status := msg.PIT_FAIL_MODULE_INIT;
      self.stack := substr(sqlerrm, 12);
  end initialize_module;

begin
  initialize;
end pit_file_pkg;
/

show errors
