# Collect validation findings

A transaction API may only need the first invalid value to reject an operation. A form, on the other hand, should show the user all useful findings at once. [Collection mode](glossary/collection-mode.md) lets you reuse the same [assertion](glossary/assertion.md)-based validation for both cases.

## Run the validation

Start collection immediately before validation and stop it afterwards. PIT collects its own findings; it cannot make an ordinary Oracle [exception](glossary/exception.md) or a PL/SQL `raise` statement continue executing.

```sql
declare
  l_findings pit_message_table;
begin
  pit.start_message_collection;
  -- Call your validation routine here.
  pit.stop_message_collection;
  l_findings := pit.get_message_collection;
  -- Process non-error findings here as well.
exception
  when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
    l_findings := pit.get_message_collection;
    -- Map and display the findings in the caller.
end;
/
```

The default suffix is shown here. Each element is a `MESSAGE_TYPE` with text, [severity](glossary/severity.md), [error code](glossary/error-code.md) and [affected references](glossary/affected-reference.md). Retrieve the collection once and keep the result: `get_message_collection` returns a copy, clears the internal [message](glossary/message.md) list and turns collection off. It does not perform the severity check of `stop_message_collection`.

Starting a new collection clears earlier findings and remembered severities. Calling `start_message_collection` while already collecting does not create a nested collection. Arrange for cleanup if validation exits through an unrelated exception; do not leave collection enabled for the next request.

## Know when processing stops

The current stop logic raises `PIT_BULK_ERROR` when the most severe recorded finding is `LEVEL_ERROR`, and `PIT_BULK_FATAL` when it is `LEVEL_FATAL`. Warnings do not trigger those bulk exceptions. The setting `PIT_STOP_BULK_ON_FATAL` can make fatal errors stop immediately rather than waiting for the end.

There is an important implementation limitation: the stop logic has no `LEVEL_SEVERE` branch. Do not rely on a severe finding alone to raise a bulk exception. Retrieve and inspect the findings, or use error-level assertions for the normal validation flow. Severe and fatal raise methods may also log immediately, so collection is not a guarantee of silent delivery.

## Distinguish and order checks

An error code separates repeated uses of one message. For example, two required-value checks can share the same message while reporting `DATE_FROM` and `DATE_UNTIL`. Omitted codes default to the message name during collection.

PIT remembers the most severe finding per code. Assertion admission can skip later checks for the same code when they would not be more severe. Place general checks before checks that require valid input. This does not delay evaluation of the PL/SQL expressions you pass as arguments: guard expressions that would themselves fail.

Use `pit.assert_is_ok` to ask whether recorded findings are less severe than the threshold, which defaults to `pit.level_error`. `pit.assert_is_not_ok` is its inverse. Both are Boolean queries, despite their names.

```sql
if pit.assert_is_ok(
     p_error_code_list => char_table('DATE_FROM', 'DATE_UNTIL')) then
  pit.assert(
    p_condition => p_date_from <= p_date_until,
    p_message_name => msg.INVALID_DATE_RANGE,
    p_error_code => 'DATE_RANGE');
end if;
```

## Keep UI mapping in the UI

The business layer publishes its error codes. The UI maps those codes to field names and displays any unmapped finding at page level. This keeps the validation reusable in a batch job or another frontend. The mapping routine belongs to your application; collection mode does not automatically infer the relationship between an error code and an APEX item.

Implementation: [public collection methods](../../PIT/core/packages/pit.pkb), [collection state and severity checks](../../PIT/core/packages/pit_internal.pkb), [23c implementation](../../PIT/core_23/packages/pit_internal.pkb).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](validations.md) · [Next chapter](translating_messages.md)
