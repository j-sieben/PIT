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
    id in number,
    session_id in varchar2,
    user_name in varchar2,
    module_name in varchar2,
    method_name in varchar2,
    params in msg_params,
    call_level in integer,
    trace_timing in char)
    return self as result
  as
  begin
    self.id := id;
    self.session_id := session_id;
    self.module_name := module_name;
    self.method_name := method_name;
    self.params := params;
    self.user_name := user_name;
    self.call_level := call_level;
    self.trace_timing := trace_timing;
    if self.trace_timing = 'Y' then
      self.wall_clock := localtimestamp;
      self.elapsed := null;
      self.elapsed_cpu := null;
      self.total := interval '0' second;
      self.total_cpu := 0;
      self.last_resume_point := dbms_utility.get_time;
      self.total_cpu_point := dbms_utility.get_cpu_time;
      self.last_cpu_resume_point := dbms_utility.get_cpu_time;
    end if;
    return;
  end;
end;
/