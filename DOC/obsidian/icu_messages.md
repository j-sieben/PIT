# Use ICU message formatting

Simple numbered arguments are often enough. When the wording depends on a quantity or a selection, an [ICU message](glossary/icu.md) can keep those language rules in the [message](glossary/message.md) text instead of scattering them through your PL/SQL code.

## Declare the format when calling PIT

The first argument must be `pit.format_icu`. The second can be a JSON document containing named values. For example, store this text in a message called `DEMO_ITEM_COUNT`:

```text
{count, plural, =0 {No items are ready.} one {One item is ready.} other {# items are ready.}}
```

Then retrieve or deliver it using the normal PIT methods:

```sql
select pit.get_message_text(
         msg.DEMO_ITEM_COUNT,
         msg_args(pit.format_icu, '{"count":2}')) as message_text
  from dual;
```

Create the message and regenerate `MSG` before running this example. Argument names are case-sensitive. Give translators the names and meanings in the message description.

## Pass safe JSON

The two-argument form preserves JSON types and escaping. Generate JSON with a suitable JSON serializer when values come from application data. A numeric count should be a JSON number, and quotes and control characters in strings must be escaped.

PIT also accepts alternating name/value arguments after the format marker. That path constructs JSON by concatenating quoted strings, so it is unsuitable for arbitrary unescaped text and does not preserve native JSON types. The 20-element `MSG_ARGS` limit includes the marker and the names. Prefer a JSON document for anything beyond simple controlled values.

## Numbers, dates and language

The Java formatter receives a locale derived from the session's language and territory. The integration supports conversion of numeric and date-like [parameter](glossary/parameter.md) values; use a dot for numeric decimal notation and ISO-style date strings such as `2026-11-12` or `2026-11-12T15:30:00` where the formatter expects text. Test the exact pattern and argument types with the deployed Java dependencies.

ICU formatting and message translation solve related problems: the translated pattern determines the grammar, while the arguments supply the data. [Translatable items](glossary/translatable-item.md) can provide translated names used inside the formatted message.

## Install the formatter dependencies

`MESSAGE_TYPE.FORMAT_ICU` is a Java call specification. ICU formatting therefore needs an Oracle JVM setup with the required ICU4J and JSON classes and the repository's `icu.ICU` class loaded into the PIT owner. The repository contains `PIT/core/java/ICU.jar` and its `core_23` counterpart; inspect the archive and resolve its dependencies when preparing your environment.

Use your database's Java deployment tooling and check resolution errors before enabling ICU messages. Ordinary PIT messages do not invoke this formatter. The existence of the call specification alone does not establish that all Java classes are installed and usable.

Implementation: [Java call specification](../../PIT/core/types/message_type.tps), [argument preparation and error handling](../../PIT/core/types/message_type.tpb), [formatter archive](../../PIT/core/java/ICU.jar).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](using_translatable_items.md) · [Next chapter](handling_contexts.md)
