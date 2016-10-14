create type pit_context as object(
  log_level integer,
  trace_level integer,
  trace_timing char(1),
  log_modules varchar2(4000),
  member function to_string
    return varchar2
);
/