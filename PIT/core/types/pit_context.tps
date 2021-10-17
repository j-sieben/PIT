create type pit_context as object(
  /** 
    Type: pit_context
      Object to collect context settings
      
    Properties:
      log_level - Requested logging level
      trace_level - Requested tracing level
      trace_timing - Flag to indicate whether timing information must be captured
      log_modules - List of output modules to log to
   */
  log_level integer,
  trace_level integer,
  trace_timing &FLAG_TYPE.,
  log_modules varchar2(4000 byte),
  /**
    Function: to_string
      Method to cast the object to a string representation
   */
  member function to_string
    return varchar2
);
/