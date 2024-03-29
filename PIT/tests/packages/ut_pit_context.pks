  create or replace package ut_pit_context
    authid definer
  as
  
  /* generated by utPLSQL for SQL Developer on 2021-11-18 15:14:28 */
  
  --%suite(ut_pit_context)
  --%suitepath(pit_context_tests)
  
  --%beforeall
  procedure before_all;
  
  --%beforeeach
  procedure before_each;
  
  --%aftereach
  procedure after_each;
  
  --%afterall
  procedure after_all;

  
  --%context (Method INITIALIZE)
  
  --%test(... instantiates output modules and makes them available)
  procedure initialize_out_modules;
  
  --%test(... sets output modules active)
  procedure activate_out_modules;
  
  --%test(... sets context to active context if defined in globally accessed context)
  procedure set_predefined_context;
  
  --%endcontext
  
  --%context(Method GET_CONTEXT)
  
  --%test(... gets the default context if the package was initialized)
  procedure get_default_context;
  
  --%test(... gets the active context if it is given by a globally accessed context)
  procedure get_active_context;
  
  --%test(... gets the name of an explicitly requested context)
  procedure get_named_context;
  
  --%test(... throws an exception if a non existing context is requested)
  --%throws(NO_DATA_FOUND)
  procedure get_non_existing_context;
  
  --%endcontext
  
  --%context(Method SET_CONTEXT)
  
  --%test(... set the active context based on a named context)
  procedure set_named_context;
  
  --%test(... set the active context based on a short name of context fi. debug instead of CONTEXT_DEBUG)
  procedure set_short_named_context;
  
  --%test(... set the active context based on a named context and persists change in global context)
  procedure set_named_context_globally;
  
  --%test(... resets an active context to default settings)
  procedure set_default_context;
  
  --%test(... resets an active context to default settings and persists change in global contex)
  procedure set_default_context_globally;
  
  --%test(... set the active context based on a named context twice, second time no change is reported)
  procedure set_named_context_twice;
  
  --%test(... set the active context based on explicit settings without a predefined context name)
  procedure set_explicit_context;
  
  --%test(... set the active context based on a settings string without a predefined context name)
  procedure set_explicit_string_context;
  
  --%test(... set the active context with an invalid log level)
  --%throws(pit_context.invalid_log_level)
  procedure set_invalid_log_level_context;
  
  --%test(... set the active context with an invalid trace level)
  --%throws(pit_context.invalid_trace_level)
  procedure set_invalid_trace_level_context;
  
  --%test(... set the active context with an invalid trace flag)
  --%throws(pit_context.invalid_trace_flag)
  procedure set_invalid_trace_flag_context;
  
  --%test(... set the active context with an invalid log module)
  --%throws(pit_context.unknown_log_module)
  procedure set_invalid_log_module_context;
  
  --%endcontext
  
  --%context(Method GET/SET_VALUE)
  
  --%test(... sets a value in the local or global storage and retrieves it again)
  procedure set_value;
  
  --%test(... sets a value in the global context)
  procedure set_value_globally;
  
  --%test(... clears a value in the local or global storage)
  procedure set_value_null;
  
  --%test(... clears a value in the global context by removing it)
  procedure set_value_null_globally;
  
  --%test(... reads a value from the global context if set by another session)
  procedure get_value_globally;
  
  --%test(... updates a saved value from the global context if changed by another session)
  procedure get_changed_value_globally;
  
  --%test(... updates a saved value from the global context if removed by another session)
  procedure get_deleted_value_globally;
  
  --%endcontext
  
  --%context(Method LOG_ME)
  
  --%test(... decides to log if the settings mandate for it)
  procedure log_me;
  
  --%test(... decides to not log if the settings mandate for it)
  procedure do_not_log_me;
  
  --%endcontext
  
  --%context(Method TRACE_ME)
  
  --%test(... decides to trace if the settings mandate for it)
  procedure trace_me;
  
  --%test(... decides to not trace if the settings mandate for it)
  procedure do_not_trace_me;
  
  --%endcontext
  
  --%context(Method TRACE_TIMING)
  
  --%test(... decides to trace timing if the settings mandate for it)
  procedure trace_timing;
  
  --%test(... decides to not trace timing if the settings mandate for it)
  procedure do_not_trace_timing;
  
  --%endcontext
  
  --%context(Method GET_LOG/TRACE_LEVEL)
  
  --%test(... retrieves the actually set log level)
  procedure get_log_level;
  
  --%test(... retrieves the actually set trace level)
  procedure get_trace_level;
  
  --%endcontext
  
end ut_pit_context;
/
