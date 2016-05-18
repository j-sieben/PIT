create or replace type body call_stack_type
as
  member procedure pause
  as
    now_time integer;
    now_cpu_time integer;
  begin
    if self.trace_timing = 'Y' then
      now_time := dbms_utility.get_time;
      now_cpu_time := dbms_utility.get_cpu_time;
      self.elapsed := coalesce(self.elapsed, 0)
                   + (now_time - self.last_resume_point);
      self.elapsed_cpu := coalesce(self.elapsed_cpu, 0)
                       + (now_cpu_time - self.last_cpu_resume_point);
    end if;
  end pause;

  member procedure resume
  as
  begin
    if self.trace_timing = 'Y' then
      self.last_resume_point := dbms_utility.get_time;
      self.last_cpu_resume_point := dbms_utility.get_cpu_time;
    end if;
  end resume;

  member procedure leave
  as
    now timestamp;
    now_time integer;
    now_cpu_time integer;
  begin
    if self.trace_timing = 'Y' then
      now := localtimestamp;
      now_time := dbms_utility.get_time;
      now_cpu_time := dbms_utility.get_cpu_time;
      self.elapsed := coalesce(self.elapsed, 0)
                   + (now_time - self.last_resume_point);
      self.elapsed_cpu := coalesce(self.elapsed_cpu, 0)
                       + (now_cpu_time - self.last_cpu_resume_point);
      self.total := now - self.wall_clock;
      self.total_cpu := now_cpu_time - self.total_cpu_point;
      self.wall_clock := now;
    end if;
  end leave;

  constructor function call_stack_type(
    self in out nocopy call_stack_type,
    p_session_id in varchar2,
    p_user_name in varchar2,
    p_module_name in varchar2,
    p_method_name in varchar2,
    p_params in msg_params,
    p_call_level in integer,
    p_trace_timing in char,
    p_trace_settings in varchar2)
    return self as result
  as
    now_time integer;
    now_cpu_time integer;
  begin
    now_time := dbms_utility.get_time;
    now_cpu_time := dbms_utility.get_cpu_time;
    self.id := pit_log_seq.nextval;
    self.session_id := p_session_id;
    self.module_name := p_module_name;
    self.method_name := p_method_name;
    self.params := p_params;
    self.user_name := p_user_name;
    self.call_level := p_call_level;
    self.trace_timing := p_trace_timing;
    self.trace_settings := p_trace_settings;
    if self.trace_timing = 'Y' then
      self.wall_clock := localtimestamp;
      self.elapsed := null;
      self.elapsed_cpu := null;
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