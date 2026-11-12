# PIT — PL/SQL Instrumentation Toolkit

Hi everybody,
this is the home of PIT, the PL/SQL Instrumentation Toolkit. It helps you manage [exceptions](DOC/obsidian/glossary/exception.md), debug information, tracing, [assertions](DOC/obsidian/glossary/assertion.md) and user [messages](DOC/obsidian/glossary/message.md) through one PL/SQL API, with as little instrumentation code as possible.

Define your messages once, translate them when needed and let [output modules](DOC/obsidian/glossary/output-module.md) deliver them to the console, tables, files, mail or APEX. [Contexts](DOC/obsidian/glossary/context.md) control the amount of logging and tracing without changing your application code. [Collection mode](DOC/obsidian/glossary/collection-mode.md) lets the same validation logic report several findings to a UI.

The code is free to use under the MIT licence. I hope you enjoy using it. If you find a problem, please describe it in an issue so it can be investigated.

## Start here

- [Read the handbook](DOC/obsidian/README.md).
- [Install PIT](DOC/obsidian/installing_pit.md).
- [Create a message and instrument your first procedure](DOC/obsidian/using_pit.md).
- [Look up a term in the glossary](DOC/obsidian/glossary/README.md).
- [Browse the API reference](DOC/api/index.html).

## A small example

After creating the message definitions and generating `MSG`, an instrumented procedure can look like this:

```sql
procedure process_order(p_order_id in number) as
begin
  pit.enter_mandatory(
    p_params => msg_params(msg_param('order_id', p_order_id)));
  -- Process the order here.
  pit.raise_info(msg.ORDER_PROCESSED, msg_args(to_char(p_order_id)));
  pit.leave_mandatory;
exception
  when others then
    pit.handle_exception;
    raise;
end;
```

The handler logs the error and cleans up tracing; `raise;` passes the original exception to the caller. The handbook explains the alternatives, including validation handling and deliberate exception ignoring.

## Documentation and source

The English Markdown handbook lives in `DOC/obsidian`; the generated Natural Docs API reference lives in `DOC/api`. See [documentation maintenance](DOC/obsidian/maintaining_documentation.md) for generation and validation commands.

Application code normally uses `PIT`. `PIT_ADMIN` maintains messages and settings; `PARAM` and `PARAM_ADMIN` provide the reusable [parameter](DOC/obsidian/glossary/parameter.md) framework. The installer selects the regular or native-Boolean implementation for the database version. Optional output modules live under `PIT/modules`.
