create or replace type call_stack_type
  authid definer
is object (
  -- Attributes
  id integer,
  user_name &ORA_NAME_TYPE.,
  module_name &ORA_NAME_TYPE.,
  method_name &ORA_NAME_TYPE.,
  app_module varchar2(48 byte),
  app_action varchar2(32 byte),
  client_info varchar2(64 byte),
  session_id varchar2(64 byte),
  long_op_idx integer,
  long_op_sno integer,
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
  trace_settings varchar2(4000 byte),
  member procedure pause(
    self in out nocopy call_stack_type),
  member procedure resume(
    self in out nocopy call_stack_type),
  member procedure leave(
    self in out nocopy call_stack_type),
  constructor function call_stack_type(
    self in out nocopy call_stack_type,
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
    p_trace_settings in varchar2)
    return self as result
)
final instantiable;
/