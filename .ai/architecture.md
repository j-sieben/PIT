# Architecture

## Core Runtime

Primary public API:

- `PIT/core/packages/pit.pks`
- `PIT/core/packages/pit.pkb`

Important API areas:

- Severity constants: `level_fatal`, `level_error`, `level_warn`,
  `level_info`, `level_debug`, `level_all`
- Trace constants: `trace_off`, `trace_mandatory`, `trace_optional`,
  `trace_detailed`, `trace_all`
- Logging: `raise_*`, `log`, `log_state`, `tweet`, `notify`, `print`
- Exceptions: `handle_exception`, `stop`, `reraise_exception`, `handle_panic`
- Tracing: `enter_*`, `leave_*`, `long_op`
- Assertions: `assert*`
- Message collection: `start_message_collection`, `stop_message_collection`,
  `get_message_collection`
- Context API: `set_context`, `reset_context`, `get_active_context`

## Administration

Primary admin API:

- `PIT/core/packages/pit_admin.pks`
- `PIT/core/packages/pit_admin.pkb`

Responsibilities:

- create/regenerate package `MSG`
- merge/delete/translate messages
- manage translatable items
- create named contexts and context toggles
- create/apply translation XML
- create export/installation scripts

## Internal Runtime

Important internals:

- `PIT/core/packages/pit_internal.*` - message construction, routing, errors,
  collection mode, assertions
- `PIT/core/packages/pit_context.*` - active context, module loading, module
  availability, log/trace decisions
- `PIT/core/packages/pit_call_stack.*` - call-stack tracking and tracing
- `PIT/core/packages/pit_util.*` - shared utility types/constants/helpers

## Object Types

Key types:

- `PIT/core/types/message_type.*` - message object
- `PIT/core/types/pit_module.tps` - abstract output module interface
- `PIT/core/types/pit_context_type.*` - log/trace/module context
- `PIT/core/types/pit_call_stack_type.*` - trace/call-stack state
- `PIT/core/types/msg_args*` / `msg_params*` - message argument containers
- `PIT/core/types/pit_default_adapter.*` - default session adapter

## Output Modules

Module layout convention:

- `PIT/modules/<module>/install.sql`
- `PIT/modules/<module>/types/*.tps|*.tpb`
- `PIT/modules/<module>/packages/*.pks|*.pkb`
- `PIT/modules/<module>/scripts/*.sql`
- optional `tables/`, `sequences/`, `messages/`

Known modules:

- `pit_console` - console output
- `pit_table` - persisted table logging
- `pit_file` - file output, needs Oracle directory `PIT_FILE_DIR`
- `pit_mail` - mail queue and SMTP support, installed separately
- `pit_apex` - APEX integration and APEX-specific adapter

All modules implement or inherit channels from `PIT_MODULE`:

- `tweet`
- `notify`
- `log_state`
- `log_validation`
- `log_exception`
- `panic`
- `print`
- `enter`
- `leave`
- `purge_log`
- `context_changed`

## Parameter Framework

Primary APIs:

- `PIT/parameters/packages/param.pks`
- `PIT/parameters/packages/param_admin.pks`

Features:

- typed parameter get/set methods for string, CLOB, XML, float, integer, date,
  timestamp, Boolean
- parameter groups
- realms
- validation
- export of parameter groups/local parameters

PIT uses parameter group `PIT`; the parameter framework itself can also be reused
outside PIT.
