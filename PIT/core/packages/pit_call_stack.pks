create or replace package pit_call_stack
  authid definer
  accessible by (package pit_internal, package pit, package ut_pit_call_stack)
as
  /**
    Package: pit_call_stack
      Helper package to implement the Call Stack functionality for PIT.

      Th call stack maintains the hierarchy of method calls along with the actually valid
      log settings and timing information on both the wall clock and the time spent within
      the actual method.

      Log settings may differ between different methods because of the toggle functionality
      that allows specific methods to dynamically change the settings. If such a method
      is left, the original log settings are restored.

    Author::
      Juergen Sieben, ConDeS GmbH

      Published under MIT licence
   */

  /**
    Type: pit_call_stack_tab
      Type to store a list of <pit_call_stack_type> instances. Indexed by binary_integer.
   */
  type pit_call_stack_tab is table of pit_call_stack_type index by binary_integer;


  /**
    Procedure: initialize_call_stack
      Method to initialize the package. Is called during <PIT_INTERNAL> package initialization
   */
   procedure initialize_call_stack;


  /**
    Function: push_stack
      Method to push an entry to the call stack. Called from the <ENTER> method.

    Parameters:
      p_user_name - Name of the actually connected application user
      p_session_id - Identifier for the session
      p_action - Method of the module that was called
      p_client_info - Optional client info passed in as a pararameter to <ENTER>
      p_params - Parameter list of parameters passed to the method
      p_trace_level - Trace level of the entry
      p_trace_settings - In case of toggles trace settings may change. The new settings are passed in here

    Returns:
      Instance of <PIT_CALL_STACK_TYPE>, as this method may only return the entry pushed onto the stack
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
  return pit_call_stack_type;


  /**
    Function: pop_stack
      Method to pop one or more entries from the call stack. Called from <LEAVE>-method.

    Parameter:
      p_params - Parameter list of parameters passed to the method
      p_severity - Severity of the call. If level FATAL, it will completely empty the stack,
                   if level ERROR, it will try to find the entry with the actual name and delete the stack
                   up to this entry, in every other case it will simply remove the last entry.

    Returns:
      List of instances of <pit_call_stack_type>, as this method may pop more than one entry from the stack.
   */
  function pop_stack(
    p_params in msg_params,
    p_severity in binary_integer)
    return pit_call_stack_tab;


  /**
    Procedure: long_op
      Sets dbms_application_info.

      Use this procedure to pass information about long operations to the database. If this task is completed,
      call this procedure with

      --- SQL
      p_sofar = p_total (or p_sofar = 100)
      ---

      to allow for proper state cleansing.

      If you call <pit.HANDLE_EXCEPTION> or <pit.STOP>, the state will be cleaned as well.
      This method will work only if tracing is enabled, as it takes the method name from the call stack and
      persist the actual index with the call stack.

    Parameters:
      p_sofar - Percentage of the task completed (0 .. 100 or individual scale)
      p_total - Amount of work to be done
      p_target - Description of the operation
      p_units - Unit of work, eg. "rows processed" or similar
      p_op_name - Actual action. Either passed in manually or taken from the method name
   */
  procedure long_op(
    p_sofar in number,
    p_total in number,
    p_target in varchar2,
    p_units in varchar2,
    p_op_name in varchar2);

end pit_call_stack;
/