# Your first steps with PIT

After installing PIT, you can use it straight away. I suggest starting with a [message](glossary/message.md) and a small procedure rather than instrumenting the whole application at once. Once you have seen the output and chosen a [context](glossary/context.md), the remaining calls follow the same pattern.

## Create a message

Run this in the PIT owner schema. Omitting the language uses the installation's default language.

```sql
begin
  pit_admin.merge_message_group(
    p_pmg_name => 'DEMO',
    p_pmg_description => 'Examples for the PIT handbook');
  pit_admin.merge_message(
    p_pms_name => 'DEMO_GREETING',
    p_pms_pmg_name => 'DEMO',
    p_pms_pse_id => pit.level_info,
    p_pms_text => 'Hello #1#, welcome to PIT!');
  pit_admin.create_message_package;
end;
/
commit;
```

`MSG.DEMO_GREETING` is now a compiler-checked constant. The text stays in the message repository; changing its wording does not require rebuilding `MSG`.

## Make the output visible

```sql
set serveroutput on
begin
  pit.set_context(
    p_log_level => pit.level_all,
    p_trace_level => pit.trace_all,
    p_trace_timing => true,
    p_log_modules => 'PIT_CONSOLE');
  pit.enter_mandatory;
  pit.raise_info(msg.DEMO_GREETING, msg_args('everybody'));
  pit.leave_mandatory;
  pit.reset_context;
end;
/
```

The console module must be installed and available. The settings above enable logging, tracing and timing for the active context scope. Reset the context when you have finished experimenting.

## Add an exception message

```sql
begin
  pit_admin.merge_message(
    p_pms_name => 'DEMO_NAME_REQUIRED',
    p_pms_pmg_name => 'DEMO',
    p_pms_pse_id => pit.level_error,
    p_pms_text => 'Please provide a name.',
    p_error_number => -20000);
  pit_admin.create_message_package;
end;
/
commit;
```

Passing `-20000` requests allocation of a custom error number. Passing `NULL` does not request a named [exception](glossary/exception.md). With the default naming convention, `MSG` now contains `DEMO_NAME_REQUIRED_ERR` as well as the message constant.

```sql
create or replace procedure greet(p_name in varchar2) as
begin
  pit.enter_mandatory;
  pit.assert_not_null(p_name, msg.DEMO_NAME_REQUIRED);
  pit.raise_info(msg.DEMO_GREETING, msg_args(p_name));
  pit.leave_mandatory;
exception
  when msg.DEMO_NAME_REQUIRED_ERR then
    pit.handle_exception;
end;
/
```

The handler logs the existing message and performs the corresponding stack cleanup. It consumes the exception, so the caller continues. If the caller must receive the original exception, put `raise;` after `pit.handle_exception`.

For more detail, continue with [messages](messages.md), [tracing](tracing.md) and [exception handling](exceptions.md). Client schemas need the client installation before they can use the shared PIT objects.

Implementation: [message administration](../../PIT/core/packages/pit_admin.pks), [public API](../../PIT/core/packages/pit.pks).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](installing_pit.md) · [Next chapter](concepts.md)
