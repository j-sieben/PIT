create or replace package body pit_ut_pkg
as
  /* Konstanten und Variablen */
  subtype max_char is varchar2(32767);
  subtype sql_char is varchar2(4000 byte);
  subtype name_type is varchar2(128 byte);

  C_PARAM_GROUP constant name_type := 'PIT';
  C_PIT_UT constant name_type := 'PIT_UT';
  C_FIRE_THRESHOLD constant name_type := C_PIT_UT || '_FIRE_THRESHOLD';
  

  /* Initialization
   * %usage Reads several parameters into global variables
   */
  procedure initialize
  as
  begin
    null;
  end initialize;
  
  
  function format_call_stack(
    p_call_stack in call_stack_type)
  return varchar2
  as    
    l_unit_name varchar2(257 byte);
    l_indent varchar2(20 byte);
    l_timing varchar2(100);
    l_info pit_util.ora_name_type;
    l_message pit_util.max_char;
    l_postfix pit_util.max_char;
    l_param varchar2(1000);
    l_template sql_char := q'^(##LEVEL#) #MESSAGE##POSTFIX##INFO##TIMING#^';
    c_etc constant char(3 byte) := '...';
  begin
    -- Program unit
    l_unit_name := p_call_stack.module_name || '.' || p_call_stack.method_name;
    l_info := sys_context('USERENV', 'CLIENT_INFO');
    if l_info is not null then
      l_info := ' Client Info: ' || l_info;
    end if;

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
    l_message := replace(replace(replace(replace(replace(l_template, 
                   '#MESSAGE#', l_unit_name), 
                   '#POSTFIX#', l_postfix), 
                   '#TIMING#', l_timing), 
                   '#INFO#', l_info),
                   '#LEVEL#', p_call_stack.call_level);
    return l_message;
  end format_call_stack;
  

  /* Interface Implementierung */
  procedure log(
    p_message in message_type)
  as
    l_message max_char;
  begin
    l_message := 'Log: message_text: ' || p_message.message_text
              || ', error_number: ' || coalesce(to_char(p_message.error_number), '-')
              || ', error_code: ' || coalesce(p_message.error_code, '-')
              || ', affected_id: ' || coalesce(p_message.affected_id, '-');
    dbms_output.put_line(l_message);
    ut_pit.set_result(
      p_log => true,
      p_message => p_message);
  end log;
  
  
  procedure print(
    p_message in message_type)
  as
    l_message max_char;
  begin
    l_message := 'Print: message_text: ' || p_message.message_text;
    dbms_output.put_line(l_message);
    ut_pit.set_result(
      p_print => true,
      p_message => p_message);
  end print;
  
  
  procedure notify(
    p_message in message_type)
  as
    l_message max_char;
  begin
    l_message := 'Notify: message_text: ' || p_message.message_text
              || ', affected_id: ' || coalesce(p_message.affected_id, '-');
    dbms_output.put_line(l_message);
    ut_pit.set_result(
      p_notify => true,
      p_message => p_message);
  end notify;
  

  procedure enter(
    p_call_stack in call_stack_type)
  as
    l_call_stack max_char;
  begin
    dbms_output.put_line('Enter ' || format_call_stack(p_call_stack));
    ut_pit.set_result(
      p_enter => true,
      p_call_stack => p_call_stack);
  end enter;

  procedure leave(
    p_call_stack in call_stack_type)
  as
  begin
    dbms_output.put_line('Leave ' || format_call_stack(p_call_stack));
    ut_pit.set_result(
      p_leave => true,
      p_call_stack => p_call_stack);
  end leave;

  procedure context_changed(
    p_ctx in pit_context)
  as
  begin
    ut_pit.set_result(
      p_context_changed => true,
      p_context => p_ctx);
  end context_changed;

  procedure initialize_module(
    self in out pit_ut)
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
end pit_ut_pkg;
/
