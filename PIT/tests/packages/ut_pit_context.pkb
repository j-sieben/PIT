create or replace package body ut_pit_context is

  /* generated by utPLSQL for SQL Developer on 2021-11-18 15:14:28 */
  C_GLOBAL_CONTEXT constant pit_util.ora_name_type := 'PIT_CTX_' || $$PLSQL_UNIT_OWNER;
  C_CONTEXT_DEFAULT constant pit_util.ora_name_type := 'CONTEXT_DEFAULT';
  C_CONTEXT_ACTIVE constant pit_util.ora_name_type := 'CONTEXT_ACTIVE';
  C_CONTEXT_DEBUG constant pit_util.ora_name_type := 'CONTEXT_DEBUG';
  
  procedure skip_test
  as
  begin
    dbms_output.put_line('Test skipped, no globally accessed context available');
  end skip_test;
  
  
  procedure before_all
  as
  begin
    $IF pit_admin.C_HAS_GLOBAL_CONTEXT $THEN
    utl_context.clear_value(C_GLOBAL_CONTEXT, C_CONTEXT_ACTIVE);
    $END
    null;
  end before_all;
  
  
  procedure before_each
  as
  begin
    pit_context.initialize;
  end before_each;
  
  
  procedure after_each
  as
  begin
    $IF pit_admin.C_HAS_GLOBAL_CONTEXT $THEN
    utl_context.clear_value(C_GLOBAL_CONTEXT, C_CONTEXT_ACTIVE);
    $END
    null;
  end after_each;
  
  
  procedure after_all
  as
  begin
    null;
  end after_all;
  
  --
  -- test initialize   --
  procedure initialize_out_modules 
  as
    l_cursor sys_refcursor;
  begin
    open l_cursor for select * from table(pit.get_available_modules);
    ut.expect( l_cursor ).not_to_be_empty();
  end initialize_out_modules;
  
  
  procedure activate_out_modules 
  as
    l_cursor sys_refcursor;
  begin
    open l_cursor for select * from table(pit.get_active_modules);
    ut.expect( l_cursor ).not_to_be_empty();
  end activate_out_modules;
  
  
  procedure set_predefined_context
  as
    l_context_name pit_util.ora_name_type;
  begin
    $IF pit_admin.C_HAS_GLOBAL_CONTEXT $THEN
    utl_context.set_value(C_GLOBAL_CONTEXT, C_CONTEXT_ACTIVE, '70|50|Y|PIT_CONSOLE');
    select column_value
      into l_context_name
      from table(pit.get_active_modules);
    ut.expect( l_context_name ).to_equal('PIT_CONSOLE');
    $ELSE
    skip_test;
    $END
  end set_predefined_context;
  
  
  --
  -- test get_context   --
  procedure get_default_context is
    l_context pit_context_type;
  begin
    -- populate actual
    l_context := pit_context.get_context;
    ut.expect( l_context.context_name ).to_equal(C_CONTEXT_DEFAULT);
  end get_default_context;
  
  --
  -- test get_context   --
  procedure get_active_context is
    l_context pit_context_type;
  begin
    $IF pit_admin.C_HAS_GLOBAL_CONTEXT $THEN
    utl_context.set_value(C_GLOBAL_CONTEXT, C_CONTEXT_ACTIVE, '70|50|Y|PIT_CONSOLE');
    l_context := pit_context.get_context;
    ut.expect( l_context.context_name).to_equal(C_CONTEXT_ACTIVE);
    ut.expect( l_context.log_modules(1)).to_equal('PIT_CONSOLE');
    $ELSE
    skip_test;
    $END
  end get_active_context;
  
  --
  -- test get_context   --
  procedure get_named_context is
    l_context pit_context_type;
  begin
    -- populate actual
    l_context := pit_context.get_context(C_CONTEXT_DEBUG);
    ut.expect( l_context.context_name ).to_equal(C_CONTEXT_DEBUG);
  end get_named_context;
  
  --
  -- test get_context   --
  procedure get_non_existing_context is
    l_context pit_context_type;
  begin
    -- populate actual
    l_context := pit_context.get_context('FOO');
  end get_non_existing_context;
  
  --
  -- test set_context   --
  procedure set_named_context is
    l_context pit_context_type;
    l_context_has_changed boolean;
  begin
    -- populate actual
    pit_context.set_context(
      p_context_name => C_CONTEXT_DEBUG,
      p_context_has_changed => l_context_has_changed);
    l_context := pit_context.get_context;
    ut.expect( l_context.context_name ).to_equal(C_CONTEXT_DEBUG);
    ut.expect( l_context_has_changed ).to_be_true();
  end set_named_context;
  
  --
  -- test set_context   --
  procedure set_short_named_context is
    l_context pit_context_type;
    l_context_has_changed boolean;
  begin
    -- populate actual
    pit_context.set_context(
      p_context_name => 'debug',
      p_context_has_changed => l_context_has_changed);
    l_context := pit_context.get_context;
    ut.expect( l_context.context_name ).to_equal(C_CONTEXT_DEBUG);
    ut.expect( l_context_has_changed ).to_be_true();
  end set_short_named_context;
  
  
  --
  -- test set_context   --
  procedure set_named_context_globally is
    l_context pit_context_type;
    l_context_has_changed boolean;
    l_cursor sys_refcursor;
  begin
    $IF pit_admin.C_HAS_GLOBAL_CONTEXT $THEN
    -- populate actual
    pit_context.set_context(
      p_context_name => C_CONTEXT_DEBUG,
      p_context_has_changed => l_context_has_changed);
    l_context := pit_context.get_context;
    ut.expect( l_context.context_name ).to_equal(C_CONTEXT_DEBUG);
    ut.expect( l_context_has_changed ).to_be_true();
    open l_cursor for 
      select * 
        from global_context
       where namespace = C_GLOBAL_CONTEXT;
    ut.expect( l_cursor ).not_to_be_empty();
    $ELSE
    skip_test;
    $END
  end set_named_context_globally;
  
  
  --
  -- test set_context   --
  procedure set_default_context is
    l_context pit_context_type;
    l_context_has_changed boolean;
  begin
    -- populate actual
    pit_context.set_context(
      p_context_name => C_CONTEXT_DEBUG,
      p_context_has_changed => l_context_has_changed);
    pit_context.set_context(
      p_context_name => C_CONTEXT_DEFAULT,
      p_context_has_changed => l_context_has_changed);
    l_context := pit_context.get_context;
    ut.expect( l_context.context_name ).to_equal(C_CONTEXT_DEFAULT);
    ut.expect( l_context_has_changed ).to_be_true();
  end set_default_context;
  
  
  --
  -- test set_context   --
  procedure set_default_context_globally is
    l_context pit_context_type;
    l_context_has_changed boolean;
    l_cursor sys_refcursor;
  begin
    $IF pit_admin.C_HAS_GLOBAL_CONTEXT $THEN
    -- populate actual
    pit_context.set_context(
      p_context_name => C_CONTEXT_DEBUG,
      p_context_has_changed => l_context_has_changed);
    l_context := pit_context.get_context;
    pit_context.set_context(
      p_context_name => C_CONTEXT_DEFAULT,
      p_context_has_changed => l_context_has_changed);
    l_context := pit_context.get_context;
    ut.expect( l_context.context_name ).to_equal(C_CONTEXT_DEFAULT);
    ut.expect( l_context_has_changed ).to_be_true();
    open l_cursor for 
      select * 
        from global_context
       where namespace = C_GLOBAL_CONTEXT;
    ut.expect( l_cursor ).to_be_empty();
    $ELSE
    skip_test;
    $END
  end set_default_context_globally;
  
  
  --
  -- test set_context   --
  procedure set_named_context_twice is
    l_context pit_context_type;
    l_context_has_changed boolean;
  begin
    -- populate actual
    pit_context.set_context(
      p_context_name => C_CONTEXT_DEBUG,
      p_context_has_changed => l_context_has_changed);
    pit_context.set_context(
      p_context_name => C_CONTEXT_DEBUG,
      p_context_has_changed => l_context_has_changed);
    l_context := pit_context.get_context;
    ut.expect( l_context.context_name ).to_equal(C_CONTEXT_DEBUG);
    ut.expect( l_context_has_changed ).to_be_false();
  end set_named_context_twice;
  
  
  --
  -- test set_context   --
  procedure set_explicit_context is
    l_context pit_context_type;
    l_context_has_changed boolean;
  begin
    -- populate actual
    pit_context.set_context(
      p_log_level => 50,
      p_trace_level => 30,
      p_trace_timing => pit_util.C_TRUE,
      p_log_modules => 'PIT_CONSOLE:PIT_APEX',
      p_context_has_changed => l_context_has_changed);
    l_context := pit_context.get_context;
    ut.expect( l_context.context_name ).to_equal(C_CONTEXT_ACTIVE);
    ut.expect( l_context.log_level ).to_equal(50);
    ut.expect( l_context.log_modules.count ).to_equal(2);
    ut.expect( l_context_has_changed ).to_be_true();
  end set_explicit_context;
  
  --
  -- test set_context   --
  procedure set_explicit_string_context is
    l_context pit_context_type;
    l_context_has_changed boolean;
  begin
    -- populate actual
    pit_context.set_context(
      p_settings => '50|30|' || pit_util.C_TRUE || '|PIT_CONSOLE:PIT_APEX',
      p_context_has_changed => l_context_has_changed);
    l_context := pit_context.get_context;
    ut.expect( l_context.context_name ).to_equal(C_CONTEXT_ACTIVE);
    ut.expect( l_context.log_level ).to_equal(50);
    ut.expect( l_context.log_modules.count ).to_equal(2);
    ut.expect( l_context_has_changed ).to_be_true();
  end set_explicit_string_context;
  
  --
  -- test set_context   --
  procedure set_invalid_log_level_context is
    l_context pit_context_type;
    l_context_has_changed boolean;
  begin
    -- populate actual
    pit_context.set_context(
      p_settings => '75|30|' || pit_util.C_TRUE || '|PIT_CONSOLE:PIT_APEX',
      p_context_has_changed => l_context_has_changed);
  end set_invalid_log_level_context;
  
  --
  -- test set_context   --
  procedure set_invalid_trace_level_context is
    l_context pit_context_type;
    l_context_has_changed boolean;
  begin
    -- populate actual
    pit_context.set_context(
      p_settings => '50|35|' || pit_util.C_TRUE || '|PIT_CONSOLE:PIT_APEX',
      p_context_has_changed => l_context_has_changed);
  end set_invalid_trace_level_context;
  
  --
  -- test set_context   --
  procedure set_invalid_trace_flag_context is
    l_context pit_context_type;
    l_context_has_changed boolean;
  begin
    -- populate actual
    pit_context.set_context(
      p_settings => '50|30|X|PIT_CONSOLE:PIT_APEX',
      p_context_has_changed => l_context_has_changed);
  end set_invalid_trace_flag_context;
  
  --
  -- test set_context   --
  procedure set_invalid_log_module_context is
    l_context pit_context_type;
    l_context_has_changed boolean;
  begin
    -- populate actual
    pit_context.set_context(
      p_settings => '50|30|' || pit_util.C_TRUE || '|PIT_FOO',
      p_context_has_changed => l_context_has_changed);
  end set_invalid_log_module_context;
  
  --
  -- test set_value   --
  procedure set_value is
  begin
    pit_context.set_value('FOO', 'WILLI');
    -- assert
    ut.expect(pit_context.get_value('FOO')).to_equal('WILLI');
  end set_value;
  
  --
  -- test set_value   --
  procedure set_value_globally is
    l_cursor sys_refcursor;
  begin
    -- assert
    $IF pit_admin.C_HAS_GLOBAL_CONTEXT $THEN
    pit_context.set_value('FOO', 'WILLI');
    open l_cursor for 
      select * 
        from global_context
       where namespace = C_GLOBAL_CONTEXT
         and attribute = 'FOO';
    ut.expect( l_cursor ).not_to_be_empty();
    $ELSE
    skip_test;
    $END
  end set_value_globally;
  
  --
  -- test set_value   --
  procedure set_value_null is
  begin
    pit_context.set_value('FOO', 'WILLI');
    pit_context.set_value('FOO', NULL);
    -- assert
    ut.expect(pit_context.get_value('FOO')).to_be_null;
  end set_value_null;
  
  --
  -- test set_value   --
  procedure set_value_null_globally is
    l_cursor sys_refcursor;
  begin
    -- assert
    $IF pit_admin.C_HAS_GLOBAL_CONTEXT $THEN
    pit_context.set_value('FOO', 'WILLI');
    pit_context.set_value('FOO', NULL);
    open l_cursor for 
      select * 
        from global_context
       where namespace = C_GLOBAL_CONTEXT
         and attribute = 'FOO';
    ut.expect( l_cursor ).to_be_empty();
    $ELSE
    skip_test;
    $END
  end set_value_null_globally;
  
  --
  -- test set_value   --
  procedure get_value_globally is
  begin
    -- assert
    $IF pit_admin.C_HAS_GLOBAL_CONTEXT $THEN
    utl_context.set_value(C_GLOBAL_CONTEXT, 'FOO', 'WILLI');
    ut.expect(pit_context.get_value('FOO')).to_equal('WILLI');
    $ELSE
    skip_test;
    $END
  end get_value_globally;
  
  --
  -- test set_value   --
  procedure get_changed_value_globally is
  begin
    -- assert
    $IF pit_admin.C_HAS_GLOBAL_CONTEXT $THEN
    pit_context.set_value('FOO', 'WILLI');
    utl_context.set_value(C_GLOBAL_CONTEXT, 'FOO', 'PETER');
    ut.expect(pit_context.get_value('FOO')).to_equal('PETER');
    $ELSE
    skip_test;
    $END
  end get_changed_value_globally;
  
  --
  -- test set_value   --
  procedure get_deleted_value_globally is
  begin
    -- assert
    $IF pit_admin.C_HAS_GLOBAL_CONTEXT $THEN
    pit_context.set_value('FOO', 'WILLI');
    utl_context.clear_value(C_GLOBAL_CONTEXT, 'FOO');
    ut.expect(pit_context.get_value('FOO')).to_be_null();
    $ELSE
    skip_test;
    $END
  end get_deleted_value_globally;
  
  --
  -- test log_me   --
  procedure log_me is
    l_context_has_changed boolean;
  begin
    pit_context.set_context(
      p_settings => '50|20|' || pit_util.C_TRUE || '|PIT_CONSOLE:PIT_APEX',
      p_context_has_changed => l_context_has_changed);
    -- assert
    ut.expect(pit_context.log_me(40)).to_be_true();
  end log_me;
  
  --
  -- test log_me   --
  procedure do_not_log_me is
    l_context_has_changed boolean;
  begin
    pit_context.set_context(
      p_settings => '50|20|' || pit_util.C_TRUE || '|PIT_CONSOLE:PIT_APEX',
      p_context_has_changed => l_context_has_changed);
    -- assert
    ut.expect(pit_context.trace_me(60)).to_be_false();
  end do_not_log_me;
  
  --
  -- test log_me   --
  procedure trace_me is
    l_context_has_changed boolean;
  begin
    pit_context.set_context(
      p_settings => '50|20|' || pit_util.C_TRUE || '|PIT_CONSOLE:PIT_APEX',
      p_context_has_changed => l_context_has_changed);
    -- assert
    ut.expect(pit_context.trace_me(10)).to_be_true();
  end trace_me;
  
  --
  -- test log_me   --
  procedure do_not_trace_me is
    l_context_has_changed boolean;
  begin
    pit_context.set_context(
      p_settings => '50|20|' || pit_util.C_TRUE || '|PIT_CONSOLE:PIT_APEX',
      p_context_has_changed => l_context_has_changed);
    -- assert
    ut.expect(pit_context.trace_me(30)).to_be_false();
  end do_not_trace_me;
  
  --
  -- test trace_timing   --
  procedure trace_timing is
    l_context_has_changed boolean;
  begin
    pit_context.set_context(
      p_settings => '50|20|' || pit_util.C_TRUE || '|PIT_CONSOLE:PIT_APEX',
      p_context_has_changed => l_context_has_changed);
    -- assert
    ut.expect(pit_context.trace_timing).to_be_true();
  end trace_timing;
  
  --
  -- test trace_timing   --
  procedure do_not_trace_timing is
    l_context_has_changed boolean;
  begin
    pit_context.set_context(
      p_settings => '50|20|' || pit_util.C_FALSE || '|PIT_CONSOLE:PIT_APEX',
      p_context_has_changed => l_context_has_changed);
    -- assert
    ut.expect(pit_context.trace_timing).to_be_false();
  end do_not_trace_timing;
  
  --
  -- test get_log_level   --
  procedure get_log_level is
    l_context_has_changed boolean;
  begin
    pit_context.set_context(
      p_settings => '50|20|' || pit_util.C_FALSE || '|PIT_CONSOLE:PIT_APEX',
      p_context_has_changed => l_context_has_changed);
    -- assert
    ut.expect(pit_context.get_log_level).to_equal(50);
  end get_log_level;
  
  --
  -- test get_trace_level   --
  procedure get_trace_level is
    l_context_has_changed boolean;
  begin
    pit_context.set_context(
      p_settings => '50|20|' || pit_util.C_FALSE || '|PIT_CONSOLE:PIT_APEX',
      p_context_has_changed => l_context_has_changed);
    -- assert
    ut.expect(pit_context.get_trace_level).to_equal(20);
  end get_trace_level;

end ut_pit_context;
/
