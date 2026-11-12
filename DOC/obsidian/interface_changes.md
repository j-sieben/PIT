# Current API conventions

This page is a quick orientation when reading application code. The handbook describes the current interface; the generated API reference supplies complete signatures and overloads.

## Public methods

Use `pit.raise_error`, `raise_severe` and `raise_fatal` to raise [exceptions](glossary/exception.md). Use `raise_warn`, `raise_info`, `raise_debug` and `raise_verbose` for ordinary logging at the corresponding levels. `pit.log` is explicit delivery with optional threshold and destination overrides.

Use `pit.handle_exception` to consume and log an exception, `handle_exception; raise;` to preserve its propagation, or `pit.stop` / `pit.reraise_exception` for PIT's fatal raise path. `pit.handle_validation`, `pit.ignore_exception` and `pit.handle_panic` serve distinct handling purposes. See [exceptions](exceptions.md).

[Severity](glossary/severity.md) functions are `level_fatal` (10), `level_severe` (20), `level_error` (30), `level_warn` (40), `level_info` (50), `level_debug` (60) and `level_all` (70). [Trace levels](glossary/trace-level.md) form a separate scale from `trace_off` (10) to `trace_all` (50).

## Output-module contract

Implement the actual `PIT_MODULE` methods: `log_exception`, `log_state`, `log_validation`, `panic`, `print`, `notify`, `tweet`, `enter`, `leave`, `purge_log` and `context_changed`. Their payload types differ. Copy signatures from the current base type when implementing a custom destination.

## Collection queries

`pit.assert_is_ok` and `pit.assert_is_not_ok` query recorded findings by [error code](glossary/error-code.md), list and threshold. They return Booleans; they do not raise a new [assertion](glossary/assertion.md) finding. `get_message_collection` consumes the [message](glossary/message.md) list. See [collection mode](collect_messages.md) for termination behavior.

Implementation: [PIT specification](../../PIT/core/packages/pit.pks), [module contract](../../PIT/core/types/pit_module.tps).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](troubleshooting.md) · [Next chapter](maintaining_documentation.md)
