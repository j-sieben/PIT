# How PIT fits together

PIT is centered around [messages](glossary/message.md). You give a message a name, write its text once and use that name throughout your code. This keeps the code readable and gives translators a place to work without changing application logic.

## From a message to its destination

A message definition has a unique name, a [message group](glossary/message-group.md), a [severity](glossary/severity.md) and text in the default language. Translations add language-specific text and descriptions. `PIT_ADMIN` maintains these definitions; the generated `MSG` package gives your code constants and, where configured, named [exceptions](glossary/exception.md).

At runtime, PIT constructs a `MESSAGE_TYPE` instance. It resolves the language, replaces arguments and attaches details such as session information, an [error code](glossary/error-code.md) and [affected object references](glossary/affected-reference.md). The active [context](glossary/context.md) selects the [output modules](glossary/output-module.md) that receive it. Each output module decides how to handle the particular communication channel.

This separation is what makes PIT useful in different applications. Your validation code can be the same whether its caller is APEX, a batch job or another PL/SQL package.

## Three different stacks

Please keep these apart when reading a log:

- The [instrumented call stack](glossary/instrumented-call-stack.md) is maintained by matching `pit.enter_*` and `pit.leave_*` calls. It supplies trace hierarchy, [parameters](glossary/parameter.md) and timing.
- The [dynamic call stack](glossary/dynamic-call-stack.md) is a snapshot of currently executing PL/SQL calls, returned by `pit_util.get_call_stack`.
- The [error stack](glossary/error-stack.md) contains Oracle error messages. `pit_util.get_error_stack` returns these followed by the [exception backtrace](glossary/exception-backtrace.md), which records where the exception originated.

An exception may already have unwound several calls by the time its handler runs. The dynamic stack at that point and the exception backtrace therefore answer different questions.

## Keep the responsibilities clear

Use `PIT` from application code and `PIT_ADMIN` to maintain definitions and settings. Use `PARAM` for effective parameter values and local overrides, and `PARAM_ADMIN` for parameter definitions. Output modules implement delivery; [session adapters](glossary/session-adapter.md) identify the calling environment and can request a context.

The installation selects `core` or `core_23` for the database version. Both provide the public PIT interface, but their implementations are not identical in every detail. In particular, read the collection-mode notes before relying on severe findings to terminate a validation run.

Implementation: [PIT specification](../../PIT/core/packages/pit.pks), [message construction](../../PIT/core/types/message_type.tpb), [event routing](../../PIT/core/packages/pit_internal.pkb).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](using_pit.md) · [Next chapter](messages.md)
