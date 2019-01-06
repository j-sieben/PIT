create type pit_context as object(
  log_level integer,
  trace_level integer,
  trace_timing &FLAG_TYPE.,
  log_modules varchar2(4000 byte),
  member function to_string
    return varchar2
);
/