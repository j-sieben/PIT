-- Run as the PIT owner after compiling PIT_UTIL specification and body.
set serveroutput on
whenever sqlerror exit failure rollback

declare
  l_stack varchar2(32767);
  l_filtered varchar2(32767);
  l_value number;

  procedure fail_here is
    l_zero number := 0;
  begin
    l_value := 1 / l_zero;
  end;

  procedure expect_contains(p_text varchar2, p_expected varchar2) is
  begin
    if p_text is null or instr(p_text, p_expected) = 0 then
      raise_application_error(-20000, 'Missing stack entry: ' || p_expected);
    end if;
  end;
begin
  begin
    fail_here;
  exception
    when zero_divide then
      l_stack := pit_util.get_error_stack;
      l_filtered := pit_util.get_error_stack(p_filter_backtrace => true);
      for i in 1 .. utl_call_stack.error_depth loop
        expect_contains(l_stack, utl_call_stack.error_msg(i));
        expect_contains(l_filtered, utl_call_stack.error_msg(i));
      end loop;
      for i in 1 .. utl_call_stack.backtrace_depth loop
        expect_contains(l_stack,
          lpad(to_char(utl_call_stack.backtrace_line(i), 'fm99999999'), 7) ||
          ' ' || utl_call_stack.backtrace_unit(i));
      end loop;
      dbms_output.put_line(l_stack);
  end;
  expect_contains(l_stack, '* Error Backtrace');
  dbms_output.put_line('PASS: original backtrace and error messages retained');
end;
/
