create or replace package body ut_pit_pkg
as

   /** Implementation of unit test for package PIT_PKG */

   --
   -- test initialize   --
   procedure initialize is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.initialize;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end initialize;

   --
   -- test log_event   --
   procedure log_event is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.log_event;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end log_event;

   --
   -- test log_specific   --
   procedure log_specific is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.log_specific;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end log_specific;

   --
   -- test enter   --
   procedure enter is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.enter;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end enter;

   --
   -- test leave   --
   procedure leave is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.leave;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end leave;

   --
   -- test long_op   --
   procedure long_op is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.long_op;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end long_op;

   --
   -- test purge_log   --
   procedure purge_log is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.purge_log;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end purge_log;

   --
   -- test print   --
   procedure print is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.print;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end print;

   --
   -- test notify   --
   procedure notify is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.notify;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end notify;

   --
   -- test raise_error   --
   procedure raise_error is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.raise_error;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end raise_error;

   --
   -- test handle_error   --
   procedure handle_error is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.handle_error;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end handle_error;

   --
   -- test get_message   --
   procedure get_message is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.get_message;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end get_message;

   --
   -- test get_active_message   --
   procedure get_active_message is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.get_active_message;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end get_active_message;

   --
   -- test check_datatype   --
   procedure check_datatype is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.check_datatype;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end check_datatype;

   --
   -- test get_message_text   --
   procedure get_message_text is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.get_message_text;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end get_message_text;

   --
   -- test get_trans_item   --
   procedure get_trans_item is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.get_trans_item;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end get_trans_item;

   --
   -- test get_context   --
   procedure get_context is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.get_context;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end get_context;

   --
   -- test set_context   --
   procedure set_context is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.set_context;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end set_context;

   --
   -- test reset_active_context   --
   procedure reset_active_context is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.reset_active_context;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end reset_active_context;

   --
   -- test reset_context   --
   procedure reset_context is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.reset_context;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end reset_context;

   --
   -- test set_collect_mode   --
   procedure set_collect_mode is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.set_collect_mode;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end set_collect_mode;

   --
   -- test get_collect_mode   --
   procedure get_collect_mode is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.get_collect_mode;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end get_collect_mode;

   --
   -- test get_message_collection   --
   procedure get_message_collection is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.get_message_collection;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end get_message_collection;

   --
   -- test get_actual_call_stack_depth   --
   procedure get_actual_call_stack_depth is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.get_actual_call_stack_depth;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end get_actual_call_stack_depth;

   --
   -- test get_modules   --
   procedure get_modules is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.get_modules;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end get_modules;

   --
   -- test get_active_modules   --
   procedure get_active_modules is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.get_active_modules;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end get_active_modules;

   --
   -- test get_available_modules   --
   procedure get_available_modules is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.get_available_modules;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end get_available_modules;

   --
   -- test report_module_status   --
   procedure report_module_status is
      l_actual   integer := 0;
      l_expected integer := 1;
   begin
      -- populate actual
      -- pit_pkg.report_module_status;

      -- populate expected
      -- ...

      -- assert
      ut.expect(l_actual).to_equal(l_expected);
   end report_module_status;

end ut_pit_pkg;
/
