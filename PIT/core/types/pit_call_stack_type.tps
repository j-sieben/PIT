create or replace type pit_call_stack_type
  authid definer
is object (
  /**
    Type: pit_call_stack_type
      Is used to collect a call stack entry
      
    Properties:
      id - Technical key
      module_name - Name of the unit (such as a package) that performed the action
      method_name - Name of the method that performed the action
      app_module - Optional application module
      app_action - Optional application action
      client_info - Identifier of the client and other information
      session_id - ID of the session. Might be the ID of the database session or a virtual session ID, such as an APEX session ID
      long_op_idx - Actual index of a long op
      long_op_sno - Internal information for dbms_application_info for repetitive calls to long_op. 
      params - Instance of <msg_params> holding parameters of the method call
      wall_clock - Timestamp when the method was called
      elapsed - Time in hsec the database spent within this method
      elapsed_cpu - CPU time in hsec the database spent within this method
      total - Time in hsec the database spent within this method including the sub methods called from this method
      total_cpu - CPU time in hsec the database spent within this method including the sub methods called from this method
      total_cpu_point - tbd
      call_level - Recursion counter of the nested depth of method calls
      last_resume_point - If a sub method is called, call stack puts the time spent her to catch on when the method returns
      last_resume_point_cpu - If a sub method is called, call stack puts the time spent her to catch on when the method returns
      trace_level - Level of the call stack entry
      trace_timing - Flag to indicate whether timining information is required
      trace_context - context name for this call stack entry. Used for toggle functionality
   */
  -- Attributes
  id integer,
  user_name &ORA_NAME_TYPE.,
  module_name &ORA_NAME_TYPE.,
  method_name &ORA_NAME_TYPE.,
  app_module varchar2(128 byte),
  app_action varchar2(128 byte),
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
  trace_timing &FLAG_TYPE.,
  trace_context pit_context_type,
  /** 
    Procedure: pause
      Method to pause the clock for the actual method 
   */
  member procedure pause(
    self in out nocopy pit_call_stack_type),
  /** 
    Procedure: resume
      Method resumes measuring time for the actual method 
   */
  member procedure resume(
    self in out nocopy pit_call_stack_type),
  /** 
    Procedure: leave
      Method to collect timing information upon leaving the method 
   */
  member procedure leave(
    self in out nocopy pit_call_stack_type),
  /** 
    Function: call_stack_type
      Constructor function
      
    Parameters:
      p_session_id - ID of the session. Might be the ID of the database session or a virtual session ID, such as an APEX session ID
      p_user_name - Name of the user performing the action. Might be the technical database user or a virtual user such as the APEX user
      p_module_name - Name of the unit (such as a package) that performed the action
      p_method_name - Name of the method that performed the action
      p_app_module - Application module the method belongs to
      p_app_action - Appplication action the method is part of. May be a use case or comparable
      p_client_info - additional information about the client
      p_params - List of parameter passed into the method
      p_call_level - Actual call level.
      p_trace_level - Actual trace level
      p_trace_timing - Flag to indicate whether timining information is required
      p_trace_context - context instance of type <pit_context_type> for this call stack entry. Used for toggle functionality
   */
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
)
final instantiable;
/