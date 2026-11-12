# The PIT handbook

Hi everybody,
welcome to the PL/SQL Instrumentation Toolkit handbook. PIT helps you keep [exception](glossary/exception.md) handling, debugging, tracing and user [messages](glossary/message.md) together without filling your application with logging code. The idea is simple: describe what happened in your code and let PIT take care of delivering the message.

If you are new here, start with installation and the first working example. After that, choose the chapters that match the work in front of you. The examples use the default exception suffix `_ERR`; adjust it if your installation uses another convention.

## Get started

1. [Install PIT](installing_pit.md): owner, client schemas, optional modules and APEX.
2. [Use PIT](using_pit.md): create a message and instrument your first procedure.
3. [Understand the concepts](concepts.md): how messages, [contexts](glossary/context.md) and [output modules](glossary/output-module.md) fit together.

## Instrument your application

- [Messages and logging](messages.md): [severity](glossary/severity.md), arguments, affected objects and explicit delivery.
- [Tracing and timing](tracing.md): balanced entry/exit calls and variable state.
- [Exceptions](exceptions.md): raise, handle, propagate or deliberately ignore an exception.
- [Application information and long operations](using_dbms_application_info.md).

## Validate and translate

- [Assertions and validation](validations.md).
- [Collection mode](collect_messages.md): report several findings in one validation run.
- [Translate messages](translating_messages.md): individual translations and [XLIFF](glossary/xliff.md).
- [Translatable items](using_translatable_items.md): translated application data.
- [ICU messages](icu_messages.md): named arguments and language-sensitive formatting.

## Configure and operate

- [Contexts and toggles](handling_contexts.md).
- [Parameters and realms](parameters.md).
- [Output modules](output_modules.md), including writing your own.
- [Administration and deployment](administrer_pit.md).
- [The APEX administration application](administration_app.md).
- [Performance](performance.md).
- [Troubleshooting](troubleshooting.md).

## Reference

- [Glossary](glossary/README.md): one page per term.
- [API documentation](../api/index.html): Natural Docs output generated from the source comments.
- [Current API conventions](interface_changes.md).
- [Documentation maintenance](maintaining_documentation.md): build the API reference and check links.

The handbook describes the implementation in this repository. The package specifications are the reference for complete signatures and overloads. The generated API reference also includes internal packages; application code should normally use `PIT`, `PIT_ADMIN`, `PARAM` and `PARAM_ADMIN`.
