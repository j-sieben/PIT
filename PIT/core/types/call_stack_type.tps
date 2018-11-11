create or replace type call_stack_type is object (
  -- Attributes
  id number,
  session_id varchar2(64 byte),
  user_name varchar2(30 byte),
  module_name varchar2(30 byte),
  method_name varchar2(30 byte),
  params msg_params,
  wall_clock timestamp,
  elapsed integer,
  elapsed_cpu integer,
  total interval day to second,
  total_cpu integer,
  total_cpu_point integer,
  call_level integer,
  last_resume_point integer,
  last_cpu_resume_point integer,
  trace_level integer,
  trace_timing char(1),
  trace_settings varchar2(4000),
  member procedure pause,
  member procedure resume,
  member procedure leave,
  constructor function call_stack_type(
    self in out nocopy call_stack_type,
    p_session_id in varchar2,
    p_user_name in varchar2,
    p_module_name in varchar2,
    p_method_name in varchar2,
    p_params in msg_params,
    p_call_level in integer,
    p_trace_level in integer,
    p_trace_timing in char,
    p_trace_settings in varchar2)
    return self as result
)
final instantiable;
/
