# Assert conditions and validate user input

One of PIT's useful features is that validation logic can stay in the business layer. The caller decides whether a failed check is an [exception](glossary/exception.md) that stops processing or a finding to show next to an input field. You do not need to teach the business package about APEX page items.

An [assertion](glossary/assertion.md) expresses what you expect to be true. If the expectation fails, PIT creates a finding. Outside [collection mode](glossary/collection-mode.md) this raises an exception; within collection mode it normally records the finding so further checks can run.

## Available checks

| Method | Expectation |
| --- | --- |
| `pit.assert` | The Boolean expression is `TRUE`; `FALSE` and `NULL` fail |
| `pit.assert_is_null` | The value is null |
| `pit.assert_not_null` | The value is present |
| `pit.assert_exists` | The query or cursor returns a row |
| `pit.assert_not_exists` | The query or cursor returns no rows |
| `pit.assert_datatype` | Text can be converted to the selected datatype |

Use the overload appropriate to your datatype. Existence checks support SQL text and an open `SYS_REFCURSOR`; inspect the signatures before choosing one. Datatype checks accept `pit.type_integer`, `type_number`, `type_date`, `type_timestamp` and `type_xml`, with a format mask where applicable. Their `p_accept_null` defaults to true, so use a mandatory-value check or set it to false when absence is invalid.

## Supply a helpful message

Built-in assertions have default [messages](glossary/message.md). Supply your own message and arguments when the default wording is too technical for the caller.

```sql
pit.assert_not_null(
  p_condition => p_customer_id,
  p_message_name => msg.CUSTOMER_REQUIRED,
  p_error_code => 'CUSTOMER_ID');

pit.assert(
  p_condition => p_date_from <= p_date_until,
  p_message_name => msg.INVALID_DATE_RANGE,
  p_error_code => 'DATE_RANGE');
```

The message definitions must exist first. In a reusable business API, use stable [error codes](glossary/error-code.md) to identify the findings. Map those codes to UI fields in the caller. `p_affected_id` and `p_affected_ids` are also available when direct object references suit the interface.

## Deliver validation findings

If PIT has already constructed the active validation message, `pit.handle_validation` sends it to the module's `log_validation` channel and performs trace cleanup. This lets a UI display a finding without persisting it as an ordinary error. The table module does not override this channel.

For several findings, use [collection mode](collect_messages.md) and retrieve the collection before calling a general exception handler. Do not send every unexpected database failure through validation handling: that path expects an active PIT message and serves a different purpose from technical error logging.

Implementation: [assertion overloads](../../PIT/core/packages/pit.pks), [assertion implementation](../../PIT/core/packages/pit.pkb), [validation routing](../../PIT/core/packages/pit_internal.pkb).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](using_dbms_application_info.md) · [Next chapter](collect_messages.md)
