create or replace package pit
as
 
  
  level_fatal constant binary_integer := 10;
  level_severe constant binary_integer := 20;
  level_error constant binary_integer := 30;
  level_warn constant binary_integer := 40;
  level_info constant binary_integer := 50;
  level_debug constant binary_integer := 60;
  level_all constant binary_integer := 70;
  
  trace_off constant binary_integer := 10;
  trace_mandatory constant binary_integer := 20;
  trace_optional constant binary_integer := 30;
  trace_detailed constant binary_integer := 40;
  trace_all constant binary_integer := 50;

end;
/