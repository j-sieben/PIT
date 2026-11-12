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

`MSG_PARAMS` is a collection of named `MSG_PARAM` values. Its constructors support several datatypes, so you do not need to convert every value to text yourself. A `RAW` value is represented as hexadecimal text using at most its first 200 bytes (400 hex characters), followed by the original length in bytes, for example `A1B2 (2 byte)`. This also makes UUID values readable while retaining the full length when a longer value is truncated. A `BLOB` value is represented only by its length in bytes, in the form `[BLOB], <length> byte`; its contents are not read. It is also possible to pass boolean values in, they are represented by the strings `true` and `false`.

You can also pass `p_params` to exit calls and [exception](glossary/exception.md) handlers to record results available at that point.

PIT normally discovers the package and action through `UTL_CALL_STACK`. Each `enter` variant has an optional `p_action` argument for the method name. Set it explicitly for methods that the compiler inlines into their callers: the compiled code no longer contains a separate call from which PIT could determine the original method name.

```sql
pit.enter_optional(p_action => 'calculate_total');
```

The explicit name preserves the trace label. It does not restore the original method or its line numbers in Oracle's error diagnostics.

## Timing

Enable `p_trace_timing` in the context to collect timing. The call-stack object distinguishes total duration from elapsed time excluding nested instrumented calls, and supplies CPU timing as well. [Output modules](glossary/output-module.md) decide how to display or persist those fields.

## Log state between entry and exit

```sql
pit.log_state(msg_params(
  msg_param('order_id', l_order_id),
  msg_param('status', l_status)));
```

This records variable state without creating a separate [message](glossary/message.md) definition for each variable. An optional `p_severity` controls admission; otherwise `LOG_STATE_THRESHOLD` supplies the level. The module receives a `PIT_LOG_STATE_TYPE`, through the `log_state` channel.

Balance calls before early `return` paths. Exception handlers such as `pit.handle_exception` and `pit.ignore_exception` already perform stack cleanup; do not add another exit call for the same entry. See [exceptions](exceptions.md) for propagation choices and [application information](using_dbms_application_info.md) for live progress reporting.

Implementation: [public trace API](../../PIT/core/packages/pit.pks), [stack maintenance](../../PIT/core/packages/pit_call_stack.pkb), [timing object](../../PIT/core/types/pit_call_stack_type.tpb).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](messages.md) · [Next chapter](exceptions.md)
