create or replace package body pit_test
as

   procedure initialize
   as
   begin
      pit.initialize;
   end initialize;

   /* Funktionen auf tieferer Schachtelungsebene */
   procedure do_something_3(
      p_param varchar2)
   as
      resultat number;
   begin
      pit.enter('do_something_3');
      resultat := 1/0;
      pit.leave('do_something_3');
   exception
      when ZERO_DIVIDE then
         pit.sql_exception(msg.SQL_ERROR, msg_args(sqlerrm));
      when others then
         pit.stop(msg.SQL_ERROR);
   end do_something_3;


   procedure do_something_2(
      p_param varchar2)
   as
      resultat number;
   begin
      pit.enter('do_something_2');
      for i in 1 .. 10000 loop
         select i
           into resultat
           from dual;
      end loop;
      do_something_3(p_param);
      pit.leave('do_something_2');
   end do_something_2;


   procedure do_something_1(
      p_param varchar2)
   as
   begin
      pit.enter('do_something_1');
      --dbms_lock.sleep(1);
      do_something_2(p_param);
      pit.leave('do_something_1');
   exception
     when others then
       pit.sql_exception(msg.SQL_ERROR, msg_args(sqlerrm));
   end do_something_1;

   /* Interface */
   procedure run_test
   as
   begin
      pit.initialize;
      pit.enter('run_test');
      do_something_1('Test');
      pit.leave;
   end run_test;
   
   procedure run_performance_test
   as
   begin
      pit.enter('Performance Test');
      pit.set_context(
         p_log_level => 70,
         p_trace_level => 70,
         p_trace_timing => true,
         p_module_list => 'PIT_TABLE,PIT_CONSOLE');
      for i in 1 .. 1000 loop
         pit.enter('Iteration ' || i);
         pit.debug(msg.PARAMETER_IS_NULL, msg_args(to_char(i)));
         pit.leave('Iteration ' || i);
      end loop;
      pit.leave('Performance Test');
   end run_performance_test;

begin
   initialize;
end;
/