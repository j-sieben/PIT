# Troubleshoot PIT

When PIT appears quiet, start with the effective settings and the destination. A [message](glossary/message.md) may be admitted by the runtime yet have no usable module to receive it.

## No output

Inspect `pit.get_active_context` and query `table(pit.get_modules)`, `table(pit.get_available_modules)` and `table(pit.get_active_modules)`. Check module status, selection in the [context](glossary/context.md) and the module's [fire threshold](glossary/fire-threshold.md). For console output, enable `SERVEROUTPUT` in the client.

Make sure the destination implements the channel you used. For example, PIT_TABLE does not override `log_validation` or `print`. If conditional compilation disabled a wrapper, increasing the runtime trace or [log level](glossary/log-level.md) cannot restore its body.

## Changed text is not visible

Check the session language, the default-language definition and the effective-language mapping. Runtime messages come from `PIT_MESSAGE_MV` through `PIT_MESSAGE_V`; runtime [translatable items](glossary/translatable-item.md) come from `PIT_TRANSLATABLE_ITEM_MV` through its session view.

Publish messages through `pit_admin.create_message_package` and items through `pit_admin.harmonize_translatable_items`. These operations have deployment and transaction effects; use them at an appropriate maintenance point. `pit.initialize` reloads session configuration and modules but does not replace the definition-[publication](glossary/publication.md) workflow.

## Changes to packages or types

Rebuilding `MSG` or replacing shared types can invalidate dependent units and disrupt session package state. Review compilation errors and the installer verification output first. Run `pit.initialize` in the affected session after the objects are valid to reload configuration and module instances.

A long-running call may hold a package while deployment tries to replace it. Coordinate the deployment with application activity. For pooled environments, distinguish an old database session's cached state from a new request using a different connection.

## Unexpected stack contents

`get_call_stack` returns the [dynamic stack](glossary/dynamic-call-stack.md); `get_error_stack` returns Oracle error messages followed by the [exception backtrace](glossary/exception-backtrace.md). Console logging prints both attributes in sequence. PIT_TABLE stores them in separate columns. Read [exceptions](exceptions.md#preserve-useful-diagnostic-details) before changing filters.

The table's two diagnostic columns each allow 2000 characters. A complete [error stack](glossary/error-stack.md) can be longer, so inspect destination capacity if a message cannot be persisted. A missing trace entry is a different issue: check matching entry/exit calls and trace admission.

## Collection mode surprises

A normal Oracle [exception](glossary/exception.md) still interrupts execution. [Collection mode](glossary/collection-mode.md) only controls PIT's own raise/[assertion](glossary/assertion.md) paths. Retrieve findings before a general error handler clears collection state, and clean up if validation exits unexpectedly. Read the [collection-mode limitations](collect_messages.md#know-when-processing-stops), especially for severe findings and immediate fatal termination.

## Connection failures during installation

The Unix wrappers use a shared SQL*Plus runner with a direct connection string. If a proxy login or service fails, try the equivalent direct SQL*Plus connection with the same connect identifier, then inspect the wrapper log. The client workflow requires successful owner and client connections; success in one does not prove the other works.

Implementation: [module state](../../PIT/core/packages/pit_context.pkb), [shared connection helper](../../PIT/install_scripts/common.sh), [table definition](../../PIT/modules/pit_table/tables/pit_table_log.tbl).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](performance.md) · [Next chapter](interface_changes.md)
