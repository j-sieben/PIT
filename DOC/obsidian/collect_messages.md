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

Severe and fatal raise methods may also log immediately while collecting. Collection and delivery are separate aspects of error processing.

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

## Map findings to APEX items with UTL_APEX

The companion library [UTL_APEX](https://github.com/j-sieben/UTL_APEX) provides `utl_apex.handle_bulk_errors` for this UI-side work. It retrieves PIT's message collection and maps the error codes to APEX page items. UTL_APEX must be installed and accessible to the APEX parsing schema; this helper is not part of the PIT package.

The `p_mapping` argument is a `CHAR_TABLE` containing alternating error codes and item names:

```sql
char_table(
  'CUSTOMER_ID', 'P10_CUSTOMER_ID',
  'QUANTITY',    'P10_QUANTITY',
  'DATE_FROM',   'P10_DATE_FROM',
  'DATE_UNTIL',  'P10_DATE_UNTIL',
  'DATE_RANGE',  'P10_DATE_UNTIL')
```

Always supply complete pairs. This is a mapping collection, not a list of [message arguments](glossary/message-argument.md). Several codes may map to the same item: both a missing end date and an invalid date range belong to `P10_DATE_UNTIL` in this example. Conversely, all quantity checks from the [booking validation example](validations.md#group-several-checks-for-one-value) share `QUANTITY` and therefore need only one mapping entry.

### Call it from the page process

Use the `demo_validate_booking` procedure and message definitions from [validations](validations.md#prepare-the-example-messages). On page 10, create the corresponding customer, quantity and date items. The example assumes numeric conversion checks have already passed and the date items use the format `YYYY-MM-DD`; adjust the conversions to your page's actual formats.

```sql
declare
  l_discarded_findings pit_message_table;
begin
  pit.start_message_collection;
  demo_validate_booking(
    p_customer_id => to_number(:P10_CUSTOMER_ID),
    p_quantity => to_number(:P10_QUANTITY),
    p_date_from => to_date(:P10_DATE_FROM, 'YYYY-MM-DD'),
    p_date_until => to_date(:P10_DATE_UNTIL, 'YYYY-MM-DD'));
  pit.stop_message_collection;
exception
  when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
    utl_apex.handle_bulk_errors(
      p_mapping => char_table(
        'CUSTOMER_ID', 'P10_CUSTOMER_ID',
        'QUANTITY',    'P10_QUANTITY',
        'DATE_FROM',   'P10_DATE_FROM',
        'DATE_UNTIL',  'P10_DATE_UNTIL',
        'DATE_RANGE',  'P10_DATE_UNTIL'));
  when others then
    l_discarded_findings := pit.get_message_collection;
    raise;
end;
```

The bulk handler belongs in the UI boundary, where the page-item names are known. Do not call `pit.get_message_collection` before invoking it: that would consume the findings the helper needs. The separate unexpected-exception path clears collection state and propagates the original failure instead of turning it into an ordinary field finding.

### What the user sees

For the invalid booking from the validation chapter, the mapping produces these associations:

| Error code | Finding | APEX item |
| --- | --- | --- |
| `CUSTOMER_ID` | Customer is required | `P10_CUSTOMER_ID` |
| `QUANTITY` | Quantity must be greater than zero | `P10_QUANTITY` |
| `DATE_RANGE` | End date must be on or after start date | `P10_DATE_UNTIL` |

The helper passes collected error and fatal findings to `APEX_ERROR.ADD_ERROR`. Resolved page items use the configured field-error display location; an unmapped code is displayed in the notification area without an item association and also produces a warning about the missing mapping. If the message text contains `#LABEL#`, the helper replaces it with the resolved item's label where available. Error-code matching is normalized to uppercase.

This keeps the dependency in one direction: the business validator knows `QUANTITY`, while the page process knows that it belongs to `P10_QUANTITY`. Another page or application can reuse the same validator with a different mapping.

The collection is consumed by the helper. It handles error delivery; it does not save the booking or decide your page's transaction flow. Configure validation and subsequent processing so that displayed findings prevent invalid data from being persisted.

Source: [UTL_APEX helper declaration](https://github.com/j-sieben/UTL_APEX/blob/master/core/packages/utl_apex.pks), [mapping and APEX error delivery](https://github.com/j-sieben/UTL_APEX/blob/master/core/packages/utl_apex.pkb).

Implementation: [public collection methods](../../PIT/core/packages/pit.pkb), [collection state and severity checks](../../PIT/core/packages/pit_internal.pkb), [23c implementation](../../PIT/core_23/packages/pit_internal.pkb).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](validations.md) · [Next chapter](translating_messages.md)
