create or replace type pit_context_type force as object(
  /** 
    Type: pit_context
      Object to collect context settings
      
    Properties:
      log_level - Requested logging level
      trace_level - Requested tracing level
      trace_timing - Flag to indicate whether timing information must be captured
      log_modules - List of output modules to log to
   */
  context_name &ORA_NAME_TYPE.,
  log_level integer,
  trace_level integer,
  trace_timing boolean,
  log_modules pit_args,
  trace_settings varchar2(4000 byte),
  allow_toggle boolean,
  broadcast_context_switch boolean,
  
  /**
    Function: pit_context_type
      Parameterless constructor method to create a new instance
   */
  constructor function pit_context_type(
    self in out nocopy pit_context_type)
  return self as result,  
  
  /**
    Function: pit_context_type
      Method to create a new instance
      
    Parameters:
      p_settings - String formatted as log_level|trace_level|trace_timing|list of output modules
   */
  constructor function pit_context_type(
    self in out nocopy pit_context_type,
    p_context_name in varchar2,
    p_settings varchar2)
  return self as result,
  
  /**
    Function: pit_context_type
      Method to create a new instance
      
    Parameters:
      p_settings - String formatted as log_level|trace_level|trace_timing|list of output modules
   */
  constructor function pit_context_type(
    self in out nocopy pit_context_type,
    p_settings varchar2)
  return self as result
);
/