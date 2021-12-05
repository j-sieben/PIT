create or replace package ut_pit_pkg 
  authid definer
as

   /** Test Suite for PIT_PKG */

   --%suite(test_pit_pkg)
   --%suitepath(alltests)
   
   --%context(Method initialize)

   --%test(... removes CONTEXT_ACTIVE from GLOBAL_CONTEXT)
   procedure initialize;
   
   --%endcontext

   --%test
   procedure log_event;

   --%test
   procedure log_specific;

   --%test
   procedure enter;

   --%test
   procedure leave;

   --%test
   procedure long_op;

   --%test
   procedure purge_log;

   --%test
   procedure print;

   --%test
   procedure notify;

   --%test
   procedure raise_error;

   --%test
   procedure handle_error;

   --%test
   procedure get_message;

   --%test
   procedure get_active_message;

   --%test
   procedure check_datatype;

   --%test
   procedure get_message_text;

   --%test
   procedure get_trans_item;

   --%test
   procedure get_context;

   --%test
   procedure set_context;

   --%test
   procedure reset_active_context;

   --%test
   procedure reset_context;

   --%test
   procedure set_collect_mode;

   --%test
   procedure get_collect_mode;

   --%test
   procedure get_message_collection;

   --%test
   procedure get_actual_call_stack_depth;

   --%test
   procedure get_modules;

   --%test
   procedure get_active_modules;

   --%test
   procedure get_available_modules;

   --%test
   procedure report_module_status;

end ut_pit_pkg;
/
