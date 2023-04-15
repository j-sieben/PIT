create or replace package body pit_console_pkg
as

  /**
    Package: Output Modules.PIT_CONSOLE.PIT_CONSOLE_PKG Body
      Implements PIT_CONSOLE output module methods.

    Author::
      Juergen Sieben, ConDeS GmbH

      Published under MIT licence
   */
  /**
    Group: Package Constants
   */
  /**    
    Constants: Parameter Constants
      C_PARAM_GROUP - Parameter group of <PIT>
      C_PIT_CONSOLE - Parameter name prefix for <PIT_CONSOLE> parameters
      C_FIRE_THRESHOLD - Parameter name for the fire threshold
      C_ENTER_TEMPLATE - Parameter name for the ENTER-Template
      C_LEAVE_TEMPLATE - Parameter name for the LEAVE-Template
      C_MESSAGE_TEMPLATE - Parameter name for the MESSAGE-Template
      C_LEVEL_INDICATOR - Parameter name for the indent level indicator
   */
  C_PARAM_GROUP constant pit_util.ora_name_type := 'PIT';
  C_PIT_CONSOLE constant pit_util.ora_name_type := 'PIT_CONSOLE';
  C_FIRE_THRESHOLD constant pit_util.ora_name_type := C_PIT_CONSOLE || '_FIRE_THRESHOLD';
  C_ENTER_TEMPLATE constant pit_util.ora_name_type := C_PIT_CONSOLE || '_ENTER_TEMPLATE';
  C_LEAVE_TEMPLATE constant pit_util.ora_name_type := C_PIT_CONSOLE || '_LEAVE_TEMPLATE';
  C_MESSAGE_TEMPLATE constant pit_util.ora_name_type := C_PIT_CONSOLE || '_MSG_TEMPLATE';
  C_LEVEL_INDICATOR  constant pit_util.ora_name_type := C_PIT_CONSOLE || '_LEVEL_INDICATOR';

  g_message_template pit_util.max_sql_char;
  g_enter_template pit_util.max_sql_char;
  g_leave_template pit_util.max_sql_char;
  g_level_indicator pit_util.ora_name_type;


  /**
    Group: Helper Methods
   */
  /**
    Procedure: initialize
      Initialization, reads several parameters into global variables
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
    Procedure: print
      Helper to print a message to the console. Called to print a message text to the console, 
      reducing output to 32KByte to take limitations of <DBMS_OUTPUT> into account
      
    Parameter:
      p_message - Message to print to the console
   */
  procedure print(
    p_message in clob)
  as
  begin
    dbms_output.enable(buffer_size => 32767);
    -- reduce output to 32767 chars (limitation of put_line)
    dbms_output.put_line(dbms_lob.substr(p_message));
  end print;


  /** 
    Procedure print_call_stack
      Helper to print the content of a call stack. Templates are defined as parameters and referenced here to control
      the formatting of the call stack. After formatting, procedure <PRINT> is called to print the call stack.
      
    Parameters:
      p_call_stack - Instance of call stack to print
      p_template - Name of the template to be used to format the output.
   */
  procedure print_call_stack(
    p_call_stack in pit_call_stack_type,
    p_template in varchar2)
  as
    l_unit_name pit_util.small_char;
    l_indent pit_util.max_sql_char;
    l_indent_length binary_integer;
    l_timing pit_util.ora_name_type;
    l_message pit_util.max_char;
    l_postfix pit_util.max_char;
    l_param pit_util.max_sql_char;
    C_ETC constant pit_util.small_char := '...'; 
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
                        then substr(p_call_stack.params(i).p_value, 1, 49) || C_ETC
                        else p_call_stack.params(i).p_value end || '"';
        if length(l_postfix || l_param) < 2000 then
          l_postfix := l_postfix || l_param;
        else
          l_postfix := l_postfix || C_ETC;
          exit;
        end if;
      end loop;
      l_postfix := l_postfix || ']';
    end if;

    -- Timing
    if p_call_stack.trace_timing = pit_util.C_TRUE then
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
  

  /**
    Group: Interface 
   */
  /**
    Procedure: tweet
      see <PIT_CONSOLE_PKG.tweet>
   */
  procedure tweet(
    p_message in message_type)
  as
  begin
    print(replace(g_message_template, '#MESSAGE#', p_message.message_text));
  end tweet;
  
  
  /**
    Procedure: log
      see <PIT_CONSOLE_PKG.log>
   */
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
  
  
  /**
    Procedure: log
      see <PIT_CONSOLE_PKG.log>
   */
  procedure log(
    p_log_state in pit_log_state_type)
  as
  begin
    if p_log_state.params.count > 0 then
      dbms_output.put_line('-> State');
      for i in 1 .. p_log_state.params.count loop
        dbms_output.put_line('...' || p_log_state.params(i).p_param || ': ' || p_log_state.params(i).p_value);
      end loop;
      dbms_output.put_line('<- State');
    end if;
  end log;
  

  /**
    Procedure: enter
      see <PIT_CONSOLE_PKG.enter>
   */
  procedure enter(
    p_call_stack in pit_call_stack_type)
  as
  begin
    print_call_stack(p_call_stack, g_enter_template);
  end enter;
  

  /**
    Procedure: leave
      see <PIT_CONSOLE_PKG.leave>
   */
  procedure leave(
    p_call_stack in pit_call_stack_type)
  as
  begin
    print_call_stack(p_call_stack, g_leave_template);
  end leave;


  /**
    Procedure: context_changed
      see <PIT_CONSOLE_PKG.context_changed>
   */
  procedure context_changed(
    p_ctx in pit_context_type)
  as
    c_del constant varchar2(5) := ', ';
  begin
    dbms_output.put_line(
      pit.get_message_text(
        msg.PIT_CTX_CHANGED,
        msg_args(p_ctx.trace_settings)));
  end context_changed;


  /**
    Procedure: initialize_module
      see <PIT_CONSOLE_PKG.initialize_module>
   */
  procedure initialize_module(
    self in out nocopy pit_console)
  as
  begin
    self.fire_threshold := param.get_integer(C_FIRE_THRESHOLD, C_PARAM_GROUP);
    self.status := msg.PIT_MODULE_INSTANTIATED;
  exception
    when others then
      self.status := msg.PIT_FAIL_MODULE_INIT;
      self.stack := substr(sqlerrm, 12);
  end initialize_module;

begin
  initialize;
end pit_console_pkg;
/
