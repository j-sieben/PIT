create or replace type body pit_context
as
  /** Implementation of PIT_CONTEXT */
  
  /** Method casts the settings as a string */
  member function to_string
    return varchar2
  as
    c_del char(1 byte) := '|';
  begin
    return log_level || c_del 
        || trace_level || c_del 
        || trace_timing || c_del 
        || log_modules;
  end to_string;
end;
/
    