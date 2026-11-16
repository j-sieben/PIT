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

## Prepare the example messages

The following examples build a small booking validation API. They use one shared required-value message and more specific messages for quantity and date checks. Run this setup in the PIT owner before compiling the example procedures. The default exception suffix `_ERR` is used below.

```sql
declare
  procedure add_message(p_name in varchar2, p_text in varchar2) is
  begin
    pit_admin.merge_message(
      p_pms_name => p_name,
      p_pms_pmg_name => 'DEMO_VALIDATION',
      p_pms_pse_id => pit.level_error,
      p_pms_text => p_text,
      p_error_number => -20000);
  end;
begin
  pit_admin.merge_message_group(
    p_pmg_name => 'DEMO_VALIDATION',
    p_pmg_description => 'Booking validation examples');
  add_message('DEMO_V_REQUIRED', '#1# is required.');
  add_message('DEMO_V_QUANTITY_POSITIVE', 'Quantity must be greater than zero.');
  add_message('DEMO_V_QUANTITY_LIMIT', 'Quantity must not exceed #1#.');
  add_message('DEMO_V_DATE_RANGE', 'End date must be on or after start date.');
  pit_admin.create_message_package;
end;
/
```

`p_error_number => -20000` requests an allocated exception number. The generated `MSG` package supplies the constants used below. In a client schema, install client access first; the definitions remain maintained in the owner.

## Group several checks for one value

Let's start with a quantity. It must be present, positive and at most 1000. These are three tests, but they all describe one input value. Give them the same error code, `QUANTITY`, while choosing the message that explains the particular failure.

```sql
create or replace procedure demo_validate_quantity(p_quantity in number) as
begin
  pit.assert_not_null(
    p_condition => p_quantity,
    p_message_name => msg.DEMO_V_REQUIRED,
    p_msg_args => msg_args('Quantity'),
    p_error_code => 'QUANTITY');

  if p_quantity is not null then
    pit.assert(
      p_condition => p_quantity > 0,
      p_message_name => msg.DEMO_V_QUANTITY_POSITIVE,
      p_error_code => 'QUANTITY');
  end if;

  if p_quantity > 0 then
    pit.assert(
      p_condition => p_quantity <= 1000,
      p_message_name => msg.DEMO_V_QUANTITY_LIMIT,
      p_msg_args => msg_args('1000'),
      p_error_code => 'QUANTITY');
  end if;
end;
/
```

Outside collection mode, a failed assertion raises immediately, so execution never reaches the later tests. In collection mode, the first error is recorded under `QUANTITY`. The explicit input guards skip checks whose prerequisites are not met, leaving the caller with the most useful finding for this value. PIT also uses the shared code to suppress further assertion findings of the same or a milder [severity](glossary/severity.md) within that group. Checks for other error codes can still run.

Order the checks from prerequisites to more specific rules. There is little value in telling the user that a missing quantity is also not positive. A shared error code also makes UI mapping simple: any of these findings belongs to the quantity field, regardless of which message explains it.

These guards are especially useful when later tests perform conversions, divide by a value or query using an earlier input. PL/SQL evaluates an assertion's arguments before PIT receives them. Put a potentially unsafe expression inside the guarded block, rather than expecting PIT to prevent its evaluation.

## Combine independent fields and dependent checks

A booking needs a customer, a valid quantity and two dates. Reuse the quantity validator and give each other input its own code. The same required-value message can now appear several times, with a different argument and error code for each field.

```sql
create or replace procedure demo_validate_booking(
  p_customer_id in number,
  p_quantity in number,
  p_date_from in date,
  p_date_until in date)
as
begin
  pit.assert_not_null(
    p_condition => p_customer_id,
    p_message_name => msg.DEMO_V_REQUIRED,
    p_msg_args => msg_args('Customer'),
    p_error_code => 'CUSTOMER_ID');

  demo_validate_quantity(p_quantity);

  pit.assert_not_null(
    p_condition => p_date_from,
    p_message_name => msg.DEMO_V_REQUIRED,
    p_msg_args => msg_args('Start date'),
    p_error_code => 'DATE_FROM');

  pit.assert_not_null(
    p_condition => p_date_until,
    p_message_name => msg.DEMO_V_REQUIRED,
    p_msg_args => msg_args('End date'),
    p_error_code => 'DATE_UNTIL');

  if p_date_from is not null and p_date_until is not null then
    pit.assert(
      p_condition => p_date_from <= p_date_until,
      p_message_name => msg.DEMO_V_DATE_RANGE,
      p_error_code => 'DATE_RANGE');
  end if;
end;
/
```

The date-range test depends on both date fields, so it runs only when both dates are present. An invalid quantity does not prevent checking the dates. These input guards work equally for a direct call and a collection run.

The procedures deliberately leave the collection boundary and delivery to the caller. A helper must not start a new collection or consume the findings of the routine that called it. They also leave persistence to the transaction API: validation reports findings and does not save partially valid data.

| Code | Checks grouped under it | Possible UI destination |
| --- | --- | --- |
| `CUSTOMER_ID` | Customer must be present | Customer selector |
| `QUANTITY` | Required, positive, maximum 1000 | Quantity input |
| `DATE_FROM` | Start date must be present | Start-date input |
| `DATE_UNTIL` | End date must be present | End-date input |
| `DATE_RANGE` | Both dates are present and in order | Date-range area or end-date input |

The code identifies the validation group; the message identifies the failed rule and supplies its wording. Keep the codes stable as part of the validation API. They are not Oracle exception numbers, and several messages can share one code.

## Use grouped results during collection

Within a collection run, `pit.assert_is_ok` lets you decide whether dependent work can proceed. Pass one code for one input group or `p_error_code_list` for several prerequisites. It returns true when none of those groups has a finding at or above the selected severity; the default threshold is `pit.level_error`.

Place these checks after validation and before `pit.stop_message_collection`:

```sql
-- Inside a collection started by pit.start_message_collection:
-- demo_validate_booking(...) has already run.
if pit.assert_is_ok(p_error_code => 'QUANTITY') then
  -- All quantity checks passed; calculate quantity-dependent values here.
  null;
end if;

if pit.assert_is_ok(
     p_error_code_list => char_table('DATE_FROM', 'DATE_UNTIL', 'DATE_RANGE')) then
  -- Both dates and their relationship passed; check availability here.
  null;
end if;
```

The comments stand for application-specific processing. The date check includes `DATE_RANGE` as well as the individual field codes: two present dates do not necessarily form a valid range. Restrict the query to the prerequisites of the next operation, so an unrelated customer or quantity finding does not suppress independent checks. `pit.assert_is_not_ok` gives the inverse result when you need to handle an invalid group explicitly.

## Use the same validator in two ways

### Stop at the first finding

A transaction API can call the validation method directly before writing data. This call fails at the positive-quantity test and raises `msg.DEMO_V_QUANTITY_POSITIVE_ERR`:

```sql
begin
  demo_validate_booking(
    p_customer_id => 42,
    p_quantity => 0,
    p_date_from => date '2026-12-20',
    p_date_until => date '2026-12-22');
  -- Save the booking here only after validation succeeds.
end;
/
```

Handle the named exception at the boundary that owns the decision to recover, display a validation finding or propagate it. The validator itself does not hide the failure.

### Collect findings for a form

A UI caller can wrap the same method in collection mode. This example has three independent problems: no customer, a zero quantity and reversed dates.

```sql
set serveroutput on
declare
  l_findings pit_message_table;
begin
  pit.start_message_collection;
  begin
    demo_validate_booking(
      p_customer_id => null,
      p_quantity => 0,
      p_date_from => date '2026-12-22',
      p_date_until => date '2026-12-20');
    pit.stop_message_collection;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      null; -- Retrieve the completed collection below.
    when others then
      l_findings := pit.get_message_collection;
      raise;
  end;

  l_findings := pit.get_message_collection;
  for i in 1 .. l_findings.count loop
    dbms_output.put_line(
      l_findings(i).error_code || ': ' || l_findings(i).message_text);
  end loop;
end;
/
```

With the example definitions, the findings are:

```text
CUSTOMER_ID: Customer is required.
QUANTITY: Quantity must be greater than zero.
DATE_RANGE: End date must be on or after start date.
```

If both dates were null, the result would instead contain separate required-value findings for `DATE_FROM` and `DATE_UNTIL`, and no `DATE_RANGE` finding. If you added another independent field, its tests could still run after a quantity error.

In an application, replace the output loop with mapping from error codes to input fields and display unmapped findings at page level. The unexpected-exception handler consumes the collection before propagating the failure, so collection mode does not leak into later work. Retrieval consumes the findings; keep the returned collection if more than one part of the UI needs it. Do not save data from this demonstration block merely because it caught a bulk exception.

## Deliver validation findings

If PIT has already constructed the active validation message, `pit.handle_validation` sends it to the module's `log_validation` channel and performs trace cleanup. This lets a UI display a finding without persisting it as an ordinary error. The table module does not override this channel.

For several findings, use [collection mode](collect_messages.md) and retrieve the collection before calling a general exception handler. Do not send every unexpected database failure through validation handling: that path expects an active PIT message and serves a different purpose from technical error logging.

Implementation: [assertion overloads](../../PIT/core/packages/pit.pks), [assertion implementation](../../PIT/core/packages/pit.pkb), [validation routing](../../PIT/core/packages/pit_internal.pkb).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](using_dbms_application_info.md) · [Next chapter](collect_messages.md)
