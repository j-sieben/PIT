# Trace method calls and variable state

Tracing answers a different question from logging: how did the code get here, and where did it spend its time? Add an entry call at the beginning of a method and the matching exit call on every normal way out. PIT maintains the [instrumented call stack](glossary/instrumented-call-stack.md) for you.

## Choose the level

| Level | Value | Entry / exit methods |
| --- | --- | --- |
| Off | 10 | No trace entry calls at this level |
| Mandatory | 20 | `enter_mandatory` / `leave_mandatory` |
| Optional | 30 | `enter_optional` / `leave_optional` |
| Detailed | 40 | `enter_detailed` / `leave_detailed` |
| All | 50 | `enter` / `leave` |

I normally use mandatory tracing for public entry points, optional tracing for important private methods and detailed tracing for helpers. This gives you useful control when choosing a [context](glossary/context.md) later. Match the entry and exit variants; a mismatched pair can leave the stack out of balance at some trace settings.

## Supply the method name

PIT normally discovers the package and action through `UTL_CALL_STACK`. Each `enter` variant has an optional `p_action` argument for the method name. Set it explicitly for methods that the compiler inlines into their callers: the compiled code no longer contains a separate call from which PIT could determine the original method name.

```sql
pit.enter_optional(p_action => 'calculate_total');
```

The explicit name preserves the trace label. It does not restore the original method or its line numbers in Oracle's error diagnostics.

## Pass parameters and results

```sql
procedure process_order(p_order_id in number) as
begin
  pit.enter_mandatory(
    p_params => msg_params(msg_param('order_id', p_order_id)));
  -- Process the order here.
  pit.leave_mandatory;
exception
  when others then
    pit.handle_exception;
    raise;
end;
```

`MSG_PARAMS` is a collection of named `MSG_PARAM` values. The overloaded `MSG_PARAM` constructors convert the supplied values to text for tracing, so you can pass supported datatypes directly. The [output module](glossary/output-module.md) then decides how to display that text.

| Value type | Stored text / output form |
| --- | --- |
| `VARCHAR2` | First 2000 bytes, followed by `...` if truncated |
| `CLOB` | First 2000 characters, followed by `...` if truncated |
| `NUMBER` | Numeric text without padding; fractional values use the session's decimal separator |
| `DATE` | `YYYY-MM-DD`, with ` HH24:MI:SS` when a time component is present |
| `TIMESTAMP` | `YYYY-MM-DD`, with ` HH24:MI:SSXFF` when a time component is present |
| `TIMESTAMP WITH TIME ZONE` | As above, with ` TZR` when a time component is present |
| `BOOLEAN` | Boolean text: the regular constructor uses `true` / `false`; the SQL-Boolean constructor uses `TO_CHAR` |
| `XMLTYPE` | First 2000 characters of the serialized XML, followed by `...` if truncated |
| `RAW` | First 200 bytes as uppercase hex, followed by the original byte length, for example `A1B2 (2 byte)`; a UUID fits completely |
| `BLOB` | Length only, for example `[BLOB], 1024 byte`; contents are not read |
| `MSG_ARGS` | Comma-separated list; each argument is limited to 200 characters with `...` if truncated. A long list ends with ` [...]`. Available in the regular specification |

Each `MSG_PARAM` stores a [parameter](glossary/parameter.md) name and its formatted value. Console state output displays them as `name: value`; entry/exit output uses `name="value"` and abbreviates the value further. For example, `msg_param('arguments', msg_args('first', 'second'))` produces the state entry `arguments: first, second`. `MSG_ARGS` supplies ordered values, so the name belongs to the enclosing `MSG_PARAM`; each list element is shortened to 200 characters before the list is assembled. The SQL-Boolean specification does not currently provide the `MSG_ARGS` overload. For null Boolean values, the regular constructor stores `false`, while the SQL-Boolean constructor leaves the value null.

### Log return values and output parameters on exit

`pit.leave`, `pit.leave_mandatory`, `pit.leave_optional` and `pit.leave_detailed` all accept `p_params => msg_params(...)`, just like the entry calls. Use entry parameters for incoming values and exit parameters for the results: a function can record its calculated return value, and a procedure can record its `OUT` or `IN OUT` parameters after assigning them.

```sql
function calculate_total(p_quantity in number, p_unit_price in number)
  return number
as
  l_total number;
begin
  pit.enter_optional(
    p_action => 'calculate_total',
    p_params => msg_params(
      msg_param('quantity', p_quantity),
      msg_param('unit_price', p_unit_price)));
  l_total := p_quantity * p_unit_price;
  pit.leave_optional(
    p_params => msg_params(msg_param('return_value', l_total)));
  return l_total;
end;
```

For a procedure, pass the output parameters to the matching exit call once their final values are available:

```sql
pit.leave_mandatory(
  p_params => msg_params(
    msg_param('p_total', p_total),
    msg_param('p_status', p_status)));
```

Place the exit call before `return` so that the calculated value is logged before the function leaves. PIT does not capture return values or output parameters automatically; you choose which values to include. The selected [trace level](glossary/trace-level.md) and output module control whether and how they are recorded.

You can also pass `p_params` to [exception](glossary/exception.md) handlers to record values available when processing fails.

## Timing

Enable `p_trace_timing` in the context to collect timing for traced methods. There are two separate questions: *when* did the call take place, and *how much time* did it consume? For durations, distinguish time including nested helper calls from time spent in the method itself, and elapsed real time from CPU time.

### WallClock: when the event happened

`wall_clock` is a local timestamp, not a duration. At entry it records the start of measurement. At exit PIT calculates the total duration from that start, then replaces `wall_clock` with the exit timestamp. The console label is `wc`; its appearance follows the session's timestamp format.

For example, an entry at `10:00:00` and an exit at `10:00:10` identify the position of the call on the clock. The time between them is the call's total runtime. WallClock itself has no CPU counterpart; CPU consumption is recorded in the duration fields.

### Total time and time in the method itself

| Scope | Runtime, including waits | CPU time |
| --- | --- | --- |
| Complete call, including nested helpers | `total` (`t`): interval from entry to exit | `total_cpu` (`t_cpu`): CPU consumed over that same call |
| Method itself, excluding nested traced helpers | `elapsed` (`e`): accumulated runtime while the method's own timer is active | `elapsed_cpu` (`e_cpu`): accumulated CPU time during those active periods |

Total time answers “How long did this call take for its caller?” It includes the method's own work and all synchronous helper calls made within it. Runtime also includes waits, for example while waiting for I/O or a lock. CPU time counts processor consumption, so a long runtime with little CPU time points to a different kind of delay from a call that spends most of its time on the CPU.

The method's own time answers “How much of that work belongs to this method rather than its traced helpers?” PIT's timing model pauses the parent's own timer when a nested traced method is entered and resumes it when the helper returns. Total time continues across the helper call. A helper without its own active trace entry cannot be separated this way: its time remains attributed to the enclosing method. Choose the trace level accordingly when comparing results.

### Units and console labels

| Field | Console label | Representation |
| --- | --- | --- |
| `wall_clock` | `wc` | Local `TIMESTAMP` at entry or exit |
| `total` | `t` | `INTERVAL DAY TO SECOND`, for example `+00 00:00:10.000000` |
| `elapsed` | `e` | Hundredths of a second; `100` means one second |
| `total_cpu` | `t_cpu` | Hundredths of a second of CPU time |
| `elapsed_cpu` | `e_cpu` | Hundredths of a second of CPU time |

PIT uses `LOCALTIMESTAMP` for the timestamps and total interval, `DBMS_UTILITY.GET_TIME` for the own-runtime counter and `DBMS_UTILITY.GET_CPU_TIME` for CPU counters. The console prints these values without converting the numeric counters to seconds. Small operations can therefore show zero in a counter, and measurements from the different clocks need not agree exactly.

PIT_TABLE stores the duration fields in `CLS_TOTAL_TIME`, `CLS_ELAPSED`, `CLS_TOTAL_TIME_CPU` and `CLS_ELAPSED_CPU`, with the same interval/counter distinction. Its `CLS_LOG_DATE` uses the event's WallClock timestamp when available.

### Read a nested-call example

Suppose method A takes 10 seconds from entry to exit. During that call it spends 6 seconds inside traced helper B and 4 seconds in its own work. A consumes 2 seconds of CPU in its own work, and B consumes another second. The timing model distinguishes these values:

| Measurement | Method A | Helper B |
| --- | --- | --- |
| Total runtime, including helpers | 10 seconds (`t`) | 6 seconds (`t`) |
| Own runtime, excluding traced helpers | 4 seconds (`e = 400`) | 6 seconds (`e = 600`) |
| Total CPU time, including helpers | 3 seconds (`t_cpu = 300`) | 1 second (`t_cpu = 100`) |
| Own CPU time, excluding traced helpers | 2 seconds (`e_cpu = 200`) | 1 second (`e_cpu = 100`) |

This example assumes B has no further traced helpers and ignores measurement overhead and clock granularity. Do not add A's total time to B's total time to obtain the overall duration: B is already included in A. Own times attribute work across the call hierarchy.

## Log state between entry and exit

```sql
pit.log_state(msg_params(
  msg_param('order_id', l_order_id),
  msg_param('status', l_status)));
```

This records variable state without creating a separate [message](glossary/message.md) definition for each variable. An optional `p_severity` controls admission; otherwise `LOG_STATE_THRESHOLD` supplies the level. The module receives a `PIT_LOG_STATE_TYPE`, through the `log_state` channel.

Balance calls before early `return` paths. Exception handlers such as `pit.handle_exception` and `pit.ignore_exception` already perform stack cleanup; do not add another exit call for the same entry. See [exceptions](exceptions.md) for propagation choices and [application information](using_dbms_application_info.md) for live progress reporting.

Implementation: [public trace API](../../PIT/core/packages/pit.pks), [stack maintenance](../../PIT/core/packages/pit_call_stack.pkb), [timing object](../../PIT/core/types/pit_call_stack_type.tpb), [parameter constructors](../../PIT/core/types/msg_param.tpb), [SQL-Boolean parameter constructors](../../PIT/core/types/msg_param_23.tpb).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](messages.md) · [Next chapter](exceptions.md)
