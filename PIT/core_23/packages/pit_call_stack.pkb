create or replace package body pit_call_stack
as
  /**
    Package: PIT_CALL_STACK Body
      Implementation of call stack functionality for PIT.

    Author::
      Juergen Sieben, ConDeS GmbH

      Published under MIT licence
   */

  /**
    Group: Private global Variables
   */
  /**
    Variables: Call Stack related variables
      g_call_stack - Instance of <PIT_CALL_STACK_TAB>, actual call stack.
   */
  g_call_stack pit_call_stack_tab;


  /**
    Group: Private call stack maintenance methods
   */
  /**
    Procedure: maintain_application_info
      Helper to maintain Application Info. Called from <PUSH_STACK>/<POP_STACK> methods.

    Parameters:
      p_module - Module that was called
      p_action - Method of the module that was called
      p_client_info - Client info passed in as optional parameter
   */
  procedure maintain_application_info(
    p_module in varchar2,
    p_action in varchar2,
    p_client_info in varchar2)
  as
  begin
    -- Administer application info
    dbms_application_info.set_module(substr(p_module, 1, 48), substr(p_action, 1, 32));
    dbms_application_info.set_client_info(substr(p_client_info, 1, 64));
  end maintain_application_info;


  /**
    Procedure: pop
      Pops an entry from the call stack and maintains timing information
   */
  function pop(
    p_params in msg_params)
  return pit_call_stack_type
  as
    l_last_entry binary_integer;
    l_actual_entry pit_call_stack_type;
    l_predecessor pit_call_stack_type;
  begin
    l_last_entry := g_call_stack.last;

    if l_last_entry > 0 then
      l_actual_entry := g_call_stack(l_last_entry);

      if pit_context.trace_me(l_actual_entry.trace_level) then
        -- preparing an entry is only done if tracing is required
        -- persist last call stack entry in out parameter
        l_actual_entry.params := p_params;
        -- replace existing ID with new ID to allow for persistance
        l_actual_entry.id := pit_log_seq.nextval;

        -- maintain timing for call stack entries
        l_actual_entry.leave;

        if l_last_entry > 1 then
          l_predecessor := g_call_stack(l_last_entry - 1);
          -- Resume time measurement
          l_predecessor.resume();

          -- set application info to the predecessor
          maintain_application_info(l_predecessor.app_module, l_predecessor.app_action, l_predecessor.client_info);
        else
          -- Last entry is going to be popped, reset application info
          maintain_application_info(null, null, null);
        end if;
      else
        -- actual entry must not be traced, reset
        l_actual_entry := null;
      end if;

      -- in any case: pop entry from stack
      g_call_stack.delete(l_last_entry);
    end if;

    return l_actual_entry;
  end pop;

  /**
    Procedure: initialize
      Initialization method of the package
   */
  procedure initialize_call_stack
  as
  begin
    g_call_stack.delete;
  end initialize_call_stack;


  /**
    Procedure: push_stack
      See <pit_call_stack.push_stack>
   */
  function push_stack(
    p_user_name in varchar2,
    p_session_id in varchar2,
    p_module in varchar2,
    p_action in varchar2,
    p_client_info in varchar2,
    p_params in msg_params,
    p_trace_level in binary_integer,
    p_trace_context in pit_context_type)
    return pit_call_stack_type
  as
    l_last_entry binary_integer;
    l_next_entry binary_integer;
    l_call_stack_entry pit_call_stack_type;
  begin
    -- Initialize
    l_last_entry := g_call_stack.count;
    l_next_entry := l_last_entry + 1;

    if pit_context.trace_timing and l_last_entry > 0 then
      l_call_stack_entry := g_call_stack(l_last_entry);
      l_call_stack_entry.pause();
    end if;

    maintain_application_info(p_module, p_action, p_client_info);

    l_call_stack_entry :=
      pit_call_stack_type(
        p_session_id => p_session_id,
        p_user_name => p_user_name,
        p_module_name => p_module,
        p_method_name => p_action,
        p_app_module => p_module,
        p_app_action => p_action,
        p_client_info => p_client_info,
        p_params => p_params,
        p_call_level => l_next_entry,
        p_trace_level => p_trace_level,
        p_trace_timing => pit_context.trace_timing,
        p_trace_context => p_trace_context);
    g_call_stack(l_next_entry) := l_call_stack_entry;

    return l_call_stack_entry;
  end push_stack;


  /**
    Function: pop_stack
      See <pit_call_stack.pop_stack>
   */
  function pop_stack(
    p_params in msg_params,
    p_severity in binary_integer)
    return pit_call_stack_tab
  as
    l_call_stack_entry pit_call_stack_type;
    l_call_stack pit_call_stack_tab;
    l_params msg_params;
    l_module pit_util.ora_name_type;
    l_action pit_util.ora_name_type;
    l_entry_found binary_integer;
  begin
    case p_severity
    when pit_internal.C_LEVEL_FATAL then
      -- if a fatal error occurred, completely empty the call stack
      l_entry_found := 1;
    when pit_internal.C_LEVEL_ERROR then
      -- it is not secured that the exception handler is at the same method as the method raising the exception.
      -- Therefore try to find the method handling the error by name and remove any entry up to this entry
      pit_util.get_module_and_action(
        p_module => l_module,
        p_action => l_action);

      l_entry_found := g_call_stack.last + 1; -- Set found to a value higher max to avoid deleting entries if nothing is found
      if g_call_stack.count > 0 then
        for i in reverse 1 .. g_call_stack.last loop
          if coalesce(lower(l_action), 'FOO') = coalesce(lower(g_call_stack(i).method_name), 'FOO')
          and coalesce(lower(l_module), 'FOO') = coalesce(lower(g_call_stack(i).module_name), 'FOO') then
            l_entry_found := i;
            exit;
          end if;
        end loop;
      end if;
    else
      -- Normal tracing is assumed, including that a complete list of ENTER-LEAVE pairs is provided
      -- Not advisable to look for named methods, as their name might be wrong based on code inlining
      l_entry_found := g_call_stack.last;
    end case;

    -- collect all found entries from the call stack and pass params to first popped entry
    -- List is examined by the calling code to throw the respective log events
    if g_call_stack.count > 0 then
      for i in reverse l_entry_found .. g_call_stack.last loop
        if i = g_call_stack.last then
          l_params := p_params;
        else
          l_params := null;
        end if;
        l_call_stack_entry := pop(p_params);
        if l_call_stack_entry is not null then
          l_call_stack(l_call_stack.count + 1) := l_call_stack_entry;
        end if;
      end loop;
    end if;

    return l_call_stack;
  end pop_stack;


  /**
    Procedure: long_op
      See <pit_call_stack.long_op>
   */
  procedure long_op(
    p_sofar in number,
    p_total in number,
    p_target in varchar2,
    p_units in varchar2,
    p_op_name in varchar2)
  as
    l_idx binary_integer;
    l_op_name pit_util.ora_name_type;
    l_sno binary_integer;
    l_actual_entry pit_call_stack_type;
  begin
    l_op_name := p_op_name;

    if g_call_stack.count > 0 then
      -- Tracing active, take details from there
      l_actual_entry := g_call_stack(g_call_stack.last);
      l_op_name := substr(
                     coalesce(p_op_name,
                              l_actual_entry.app_module || '.' || l_actual_entry.app_action
                     ), 1, 64);
      l_sno := l_actual_entry.long_op_sno;
      l_idx := coalesce(l_actual_entry.long_op_idx, dbms_application_info.set_session_longops_nohint);

      dbms_application_info.set_session_longops(
        rindex => l_idx,
        slno => l_sno,
        op_name => l_op_name,
        target_desc => substr(p_target, 1, 32),
        sofar => p_sofar,
        totalwork => p_total,
        units => substr(coalesce(p_units, 'iterations'), 1, 32));

      -- write maintenance values back to the call stack
      l_actual_entry.long_op_sno := l_sno;
      l_actual_entry.long_op_idx := l_idx;
      g_call_stack(g_call_stack.last) := l_actual_entry;
    else
      -- if tracing is not active, call session_longops just like normal
      dbms_application_info.set_session_longops(
        rindex => l_idx,
        slno => l_sno,
        op_name => l_op_name,
        target_desc => substr(p_target, 1, 32),
        sofar => p_sofar,
        totalwork => p_total,
        units => substr(coalesce(p_units, 'iterations'), 1, 32));
    end if;
  end long_op;
  
end pit_call_stack;
/