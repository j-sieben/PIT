create or replace type body pit_call_stack_type
as
  /** Implements the call stack type functionality */

  /** Method to pause the measurement of timing information */
  member procedure pause(
    self in out nocopy pit_call_stack_type)
  as
    now_time integer;
    now_cpu_time integer;
  begin
    if self.trace_timing = true then
      now_time := dbms_utility.get_time;
      now_cpu_time := dbms_utility.get_cpu_time;
      self.elapsed := self.elapsed + (now_time - self.last_resume_point);
      self.elapsed_cpu := self.elapsed_cpu + (now_cpu_time - self.last_cpu_resume_point);
    end if;
  end pause;

  /** Method to resume the measurement of timing information */
  member procedure resume(
    self in out nocopy pit_call_stack_type)
  as
  begin
    if self.trace_timing = true then
      self.last_resume_point := dbms_utility.get_time;
      self.last_cpu_resume_point := dbms_utility.get_cpu_time;
    end if;
  end resume;

  /** Method to collect timing information upon leaving a method */
  member procedure leave(
    self in out nocopy pit_call_stack_type)
  as
    now timestamp;
    now_time integer;
    now_cpu_time integer;
  begin
    if self.trace_timing = true then
      now := localtimestamp;
      now_time := dbms_utility.get_time;
      now_cpu_time := dbms_utility.get_cpu_time;
      self.elapsed := self.elapsed + (now_time - self.last_resume_point);
      self.elapsed_cpu := self.elapsed_cpu + (now_cpu_time - self.last_cpu_resume_point);
      self.total := now - self.wall_clock;
      self.total_cpu := now_cpu_time - self.total_cpu_point;
      self.wall_clock := now;
    end if;
  end leave;

  /** constructor function */
  constructor function pit_call_stack_type(
    self in out nocopy pit_call_stack_type,
    p_session_id in varchar2,
    p_user_name in varchar2,
    p_module_name in varchar2,
    p_method_name in varchar2,
    p_app_module in varchar2,
    p_app_action in varchar2,
    p_client_info in varchar2,
    p_params in msg_params,
    p_call_level in integer,
    p_trace_level in integer,
    p_trace_timing in char,
    p_trace_context in pit_context_type)
    return self as result
  as
    now_time integer;
    now_cpu_time integer;
  begin
    self.id := pit_log_seq.nextval;
    self.session_id := p_session_id;
    self.module_name := p_module_name;
    self.method_name := p_method_name;
    self.app_module := p_app_module;
    self.app_action := p_app_action;
    self.client_info := p_client_info;
    self.params := p_params;
    self.user_name := p_user_name;
    self.call_level := p_call_level;
    self.trace_level := p_trace_level;
    self.trace_timing := p_trace_timing;
    self.trace_context := p_trace_context;
    if self.trace_timing = true then
      now_time := dbms_utility.get_time;
      now_cpu_time := dbms_utility.get_cpu_time;
      self.wall_clock := localtimestamp;
      self.elapsed := 0;
      self.elapsed_cpu := 0;
      self.total := interval '0' second;
      self.total_cpu := 0;
      self.last_resume_point := now_time;
      self.total_cpu_point := now_cpu_time;
      self.last_cpu_resume_point := now_cpu_time;
    end if;
    return;
  end;
end;
/