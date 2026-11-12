# Deliver messages through output modules

[Output modules](glossary/output-module.md) connect PIT to the places where you need information: a console, log tables, a file, mail or an application UI. Your business code does not need to know which of them is active.

## Installation, availability and selection

These are three separate questions. A module can be installed but unavailable in the current environment, or available without being selected in the active [context](glossary/context.md). Its [fire threshold](glossary/fire-threshold.md) may further restrict the [messages](glossary/message.md) it processes.

Inspect the runtime state rather than guessing:

```sql
select * from table(pit.get_modules);
select * from table(pit.get_available_modules);
select * from table(pit.get_active_modules);
```

A fire threshold normally admits messages whose numeric [severity](glossary/severity.md) is less than or equal to it. Individual channel implementations decide whether to apply that threshold; trace and tweet behavior need not match [exception](glossary/exception.md) logging.

## Built-in destinations

| Module | Purpose | Important requirement |
| --- | --- | --- |
| `PIT_CONSOLE` | Formats messages, stacks, trace calls and state for `DBMS_OUTPUT` | Enable server output in the client |
| `PIT_TABLE` | Persists messages, traces, [parameters](glossary/parameter.md) and [affected references](glossary/affected-reference.md) | Keep an appropriate purge policy |
| `PIT_FILE` | Writes formatted diagnostics to a trace file | Usable Oracle directory and filesystem permissions |
| `PIT_MAIL` | Sends or queues error reports according to configured thresholds | Separate installation, `UTL_TEXT` and mail setup |
| `PIT_APEX` | Integrates validation, debugging and presentation with APEX | A usable APEX session for runtime availability |

The APEX module supplies a [session adapter](glossary/session-adapter.md) that recognizes APEX session identity and debug settings. Its notification implementation posts to the configured WebSocket service endpoint; installing PIT does not provide that external service. The administration application is a separate component.

Mail uses live and daily thresholds and `PIT_MAIL_QUEUE`; inspect its package and job scripts when configuring delivery. Do not assume that installing a mail type also completes your SMTP and scheduling setup.

## PIT_TABLE storage

`PIT_TABLE_LOG` holds message text and metadata. The diagnostic columns have distinct contents:

| Column | Source and meaning |
| --- | --- |
| `LOG_MESSAGE_STACK` | `message.stack`, the [dynamic call stack](glossary/dynamic-call-stack.md) from `get_call_stack` |
| `LOG_MESSAGE_BACKTRACE` | `message.backtrace`, the [error stack](glossary/error-stack.md) followed by the [exception backtrace](glossary/exception-backtrace.md) from `get_error_stack` |

The module inserts those attributes unchanged and does not concatenate them. Both columns are `VARCHAR2(2000 CHAR)`. The error-stack function can return more than that, so a long diagnostic value can exceed table capacity. Message text itself is a CLOB.

`PIT_TABLE_CALL_STACK` contains instrumented entry/exit records. `PIT_TABLE_PARAMS` stores trace and state parameters as well as affected references. Join message references using `ptp_id = log_id`.

A single `affected_id` is stored with parameter name `ID`. A non-null `affected_ids` collection takes precedence, including an empty collection. Null elements, unnamed entries and null values are omitted. For duplicate names, the first non-null value wins. References use the parent message's timestamp and severity and are purged with it.

The table module overrides `log_exception`, `panic`, `tweet`, `log_state`, `enter`, `leave` and `purge_log`. It inherits the base no-op behavior for validation, presentation and notification channels.

## Communication channels

The non-instantiable, non-final `PIT_MODULE` object type defines the contract:

| Method | Payload or purpose |
| --- | --- |
| `log_exception`, `log_validation`, `panic` | A `MESSAGE_TYPE` for the respective handling path |
| `print`, `notify`, `tweet` | A message for presentation, notification or developer output |
| `log_state` | A `PIT_LOG_STATE_TYPE` with named values |
| `enter`, `leave` | A `PIT_CALL_STACK_TYPE` with execution details |
| `purge_log` | A cutoff date and severity filter |
| `context_changed` | The new `PIT_CONTEXT_TYPE` |

Base implementations do nothing. Override only the channels your destination supports. Names in the table are the actual module methods, not the public PIT wrapper names.

## Write your own module

I normally keep the object body thin and delegate the work to a package. Packages give you private helpers and state without complicating the module interface. The delivered modules are useful examples.

1. Define an instantiable subtype under `PIT_MODULE` with a parameterless constructor.
2. Override the required methods using the exact types and signatures from the base object.
3. Initialize its threshold and status in the constructor. Catch setup failures and retain diagnostic information in the module's `stack` attribute.
4. Add configuration through `PARAM_ADMIN` and supply module installation and client registration scripts.
5. Reinitialize PIT, inspect availability and select the module in a context.

Modules must not allow delivery failures to escape into application code. PIT dispatches events in an autonomous transaction and manages its commit/rollback. Do not commit the business transaction from a module or introduce competing transaction control into that dispatch path.

Implementation: [module contract](../../PIT/core/types/pit_module.tps), [base methods](../../PIT/core/types/pit_module.tpb), [table storage](../../PIT/modules/pit_table/packages/pit_table_pkg.pkb), [table columns](../../PIT/modules/pit_table/tables/pit_table_log.tbl), [APEX notification](../../PIT/modules/pit_apex/packages/pit_apex_pkg.pkb).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](parameters.md) · [Next chapter](administrer_pit.md)
