create or replace package pit_test_pkg
  authid definer
as
  /* Implementation package for type PIT_TEST */
  
  procedure log (p_message in message_type);

  procedure print(p_message in message_type);

  procedure enter(p_call_stack in call_stack_type);

  procedure leave(p_call_stack in call_stack_type);

  procedure purge_log(p_purge_date in date);

  procedure context_changed;

  procedure initialize_module(self in out nocopy pit_test);
end pit_test_pkg;
/