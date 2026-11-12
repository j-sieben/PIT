# Raise and handle exceptions

PIT lets you attach a meaningful [message](glossary/message.md) where an error occurs and decide how to handle it at the appropriate boundary. The distinction matters: raising an [exception](glossary/exception.md) and logging an exception are separate actions.

## Define a named exception

Create a message using `pit_admin.merge_message`, then rebuild `MSG` with `pit_admin.create_message_package`. Use `p_error_number => -20000` to request a custom error number, or provide a supported Oracle error number to associate the message with that error. For optional-exception [severities](glossary/severity.md), a null error number does not request an exception constant. A new fatal message receives an allocated exception even when the number is omitted.

With the default naming convention, message `ORDER_NOT_FOUND` produces message constant `msg.ORDER_NOT_FOUND` and, when configured, exception `msg.ORDER_NOT_FOUND_ERR`. Use the constant when calling PIT and the exception in `raise` statements and handlers. Configure the prefix and postfix before installation if your project uses another convention.

## Raise at the point of failure

```sql
pit.raise_error(msg.ORDER_NOT_FOUND, msg_args(to_char(l_order_id)));
```

`pit.raise_error`, `pit.raise_severe` and `pit.raise_fatal` set the respective [severity](glossary/severity.md) and raise an application error outside [collection mode](glossary/collection-mode.md). The message and arguments are retained for the handler. Severe and fatal errors are also dispatched for logging immediately. If a message has no configured error number, raising uses the fallback number `-20000`; do not expect a message-specific named exception in that case.

You can still use ordinary PL/SQL `raise msg.ORDER_NOT_FOUND_ERR;`. In that case, supply text arguments when handling it, because that statement does not construct a parameterized PIT message.

## Choose what the handler does

| Call | Effect |
| --- | --- |
| `pit.handle_exception` | Logs the error, clears the active message and closes the relevant trace entry; does not propagate it |
| `pit.handle_exception; raise;` | Logs and cleans up, then propagates the original exception |
| `pit.stop` or `pit.reraise_exception` | Handles the error at fatal severity and raises through PIT |
| `pit.handle_validation` | Uses the validation channel and performs stack cleanup |
| `pit.ignore_exception(p_reason)` | Clears the active message and calls trace cleanup without logging the exception |
| `pit.handle_panic` | Uses panic handling, resets the [instrumented stack](glossary/instrumented-call-stack.md) and raises the PIT panic error |

When PIT already constructed the message, call the handler without a message name to reuse it:

```sql
begin
  pit.enter_mandatory;
  pit.raise_error(msg.ORDER_NOT_FOUND, msg_args(to_char(l_order_id)));
  pit.leave_mandatory;
exception
  when msg.ORDER_NOT_FOUND_ERR then
    pit.handle_exception;
    raise;
end;
```

For a native Oracle exception, you can supply an application-specific message:

```sql
exception
  when no_data_found then
    pit.handle_exception(msg.ORDER_NOT_FOUND, msg_args(to_char(l_order_id)));
```

Without an explicit message or an existing PIT message, error handling uses the SQL error fallback. Use `handle_exception; raise;` when preserving the original exception origin is important. `stop` is a PIT raise path and is not equivalent to a bare `raise;`.

## Ignore deliberately

```sql
exception
  when no_data_found then
    pit.ignore_exception('No preference exists; the caller uses its default.');
```

The required reason documents your decision in the source. PIT does not store, validate or log it. Internally, `pit_internal.ignore_error` sets the active message to null and calls `leave(C_TRACE_MANDATORY, null)`. Use it where consuming the exception and closing the current trace entry are intended. It does not undo database changes or reset collection mode.

## Preserve useful diagnostic details

`pit_util.get_call_stack` returns the current [dynamic call stack](glossary/dynamic-call-stack.md). `pit_util.get_error_stack` returns all Oracle error messages followed by the [exception backtrace](glossary/exception-backtrace.md). The latter defaults to a complete backtrace. Pass `p_filter_backtrace => true` to apply the configured package filter to backtrace units; error messages remain unfiltered.

`OMIT_PIT_IN_STACK` and `OMIT_PKG_IN_STACK` control dynamic-stack filtering. They do not remove Oracle error messages. The console prints both message attributes in succession. PIT_TABLE stores them separately in `LOG_MESSAGE_STACK` and `LOG_MESSAGE_BACKTRACE`.

Compiler inlining also affects the location reported in error diagnostics. When a method is inlined into its caller, it no longer exists as a separate method in the compiled code. Oracle's [error stack](glossary/error-stack.md) and backtrace can therefore no longer identify the exact source line within that original method where the error occurred. This is a limitation of Oracle's compiled diagnostic information. Passing `p_action` to a PIT entry call preserves the method label in tracing, but cannot recover those original line numbers.

Use `p_params` on exception handlers for variable state, `p_affected_id` or `p_affected_ids` for affected objects and `p_error_code` for caller-facing distinctions. Read the active message before calling a handler that clears it.

Implementation: [PIT API](../../PIT/core/packages/pit.pks), [raising and handling](../../PIT/core/packages/pit_internal.pkb), [diagnostic stacks](../../PIT/core/packages/pit_util.pkb).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](tracing.md) · [Next chapter](using_dbms_application_info.md)
