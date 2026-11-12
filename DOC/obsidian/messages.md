# Messages and logging

A [message](glossary/message.md) is more than a piece of text. It has a stable name, a [severity](glossary/severity.md) and a [message group](glossary/message-group.md), and may have translations and a configured [exception](glossary/exception.md). This lets you improve the wording without touching all the places that use it.

## Choose a severity

Smaller numbers mean more severe messages. The active [log level](glossary/log-level.md) admits messages at or below its numeric value; the runtime always admits error, severe and fatal logging regardless of that [context](glossary/context.md) threshold. Delivery still needs an active, available [output module](glossary/output-module.md), and module thresholds can restrict it further.

| Function | Value | Intended use |
| --- | --- | --- |
| `pit.level_fatal` | 10 | Fatal errors |
| `pit.level_severe` | 20 | Severe errors |
| `pit.level_error` | 30 | Errors |
| `pit.level_warn` | 40 | Warnings |
| `pit.level_info` | 50 | Informational messages |
| `pit.level_debug` | 60 | Debug details |
| `pit.level_all` | 70 | Verbose output and the most inclusive log threshold |

Use `pit.raise_warn`, `pit.raise_info`, `pit.raise_debug` and `pit.raise_verbose` for ordinary logging. These methods do not raise PL/SQL exceptions. `pit.raise_error`, `pit.raise_severe` and `pit.raise_fatal` do; see [exceptions](exceptions.md).

## Pass arguments

`MSG_ARGS` is a `VARRAY(20) OF CLOB`. Argument 1 replaces `#1#`, argument 2 replaces `#2#`, and so on. Convert numbers and dates explicitly when their textual format matters.

```sql
-- Message text: 'Order #1# has status #2#.'
pit.raise_info(msg.ORDER_STATUS, msg_args(to_char(l_order_id), 'ready'));
```

This and later application-specific names are examples: create the corresponding definitions before compiling the code. CLOB arguments allow large content, although each destination has its own limits. In particular, a large message does not imply that the Oracle exception text can carry the entire CLOB.

An anchor may also contain a prefix, postfix and null replacement: `#1|before | after|not supplied#`. Prefix and postfix are used for a non-null argument; the fourth part is used for a null argument. If the argument is not supplied at all, the anchor remains in the text. Keep these templates readable for translators.

## Attach references and error codes

`p_affected_id` identifies one affected object or input field. `p_affected_ids` carries named references in `MSG_PARAMS`. These references are separate from `p_msg_args`, which changes the text, and from trace/state [parameters](glossary/parameter.md), which document execution.

`p_error_code` provides an application-specific identifier. It is useful when several validations share one message but the caller needs to distinguish their results. In [collection mode](glossary/collection-mode.md), omitted [error codes](glossary/error-code.md) default to the message name.

## Select delivery deliberately

`pit.log` delivers the requested message using its own severity, with temporary threshold and module overrides through `p_log_threshold` and `p_log_modules`. It does not raise an exception merely because the delivered message has error severity.

`pit.print` uses the `print` channel for presentation content. `pit.notify` uses the separate notification channel; its effect depends on the module implementation. `pit.tweet` accepts temporary, untranslated developer text without requiring a message definition. It is broadcast to available modules, so do not treat it as normal context-filtered logging.

To obtain text without delivering it, use `pit.get_message_text`. `pit.get_message` returns the complete message object. `pit.get_active_message` and `pit.get_active_message_text` expose the current message during error processing; handlers may clear it, so read it before consuming the error.

Implementation: [public methods](../../PIT/core/packages/pit.pks), [argument replacement](../../PIT/core/types/message_type.tpb), [logging and routing](../../PIT/core/packages/pit_internal.pkb).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](concepts.md) · [Next chapter](tracing.md)
