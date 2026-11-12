# Keep instrumentation useful and economical

My recommendation is to start with [context](glossary/context.md) settings. Instrument the code clearly, choose sensible [trace levels](glossary/trace-level.md) and enable only the destinations you need. Measure the application with its real [output modules](glossary/output-module.md) before removing useful diagnostics.

## Avoid unnecessary work

Use `pit.check_log_level_greater_equal` and `pit.check_trace_level_greater_equal` before preparing expensive diagnostic content. PL/SQL evaluates arguments before passing them to PIT, so a disabled destination does not save the cost of building a large argument in the caller.

Timing, toggles and persistent destinations each add work. `ALLOW_TOGGLE` requires minimal stack tracking even when normal trace output is disabled. Balance entry and exit calls, and choose mandatory, optional and detailed levels so you can reduce volume without changing the application.

For SQL over [parameters](glossary/parameter.md) or [translatable items](glossary/translatable-item.md), join the supplied views rather than calling a PL/SQL getter for every row. The runtime [message](glossary/message.md) and item views read published materialized data; [publication](glossary/publication.md) belongs to maintenance and deployment rather than the hot path.

## Conditional compilation

`PIT_ADMIN` declares Boolean compile-time switches `C_LEVEL_LE_WARN`, `C_LEVEL_LE_INFO`, `C_LEVEL_LE_DEBUG`, `C_LEVEL_LE_ALL` and `C_TRACE_LE_OFF`, `C_TRACE_LE_MANDATORY`, `C_TRACE_LE_OPTIONAL`, `C_TRACE_LE_DETAILED`, `C_TRACE_LE_ALL`.

The PIT body uses these switches to replace selected public wrapper bodies with no-op implementations. After changing the constants, recompile the affected `PIT_ADMIN` specification/body and the PIT body. Inspect the corresponding version directory before doing so. Disabled code cannot be enabled by changing a context; it requires recompilation with different switches.

Use specialized trace methods consistently. Generic `enter` and `leave` correspond to trace-all handling. Explicit logging through `pit.log` has a separate delivery purpose and should not replace ordinary level-specific calls just to tune performance.

Reserve this technique for a measured need. It changes the compiled behavior of the shared installation and may invalidate dependent objects, so plan the change as a deployment operation.

## Compiler and destination choices

The installer configures PL/SQL compilation through its compiler-flag helper. Native compilation and optimization can affect runtime cost and visible call structure; measure the actual environment rather than relying on a historical percentage or promised speedup. For methods that are inlined into their callers, pass the method name explicitly through the optional `p_action` argument of `enter` calls. The separate method no longer exists in the compiled code, so its name cannot be inferred from the [dynamic call stack](glossary/dynamic-call-stack.md). The same Oracle optimization prevents error diagnostics from identifying the exact original source line within that method; an explicit trace label cannot restore that information.

A slow mail, file or custom module may dominate the cost of a message. Choose its threshold and delivery strategy accordingly. Keep logging independent of the business transaction and avoid modules that lock application rows while PIT dispatches autonomously.

Implementation: [compile-time switches](../../PIT/core/packages/pit_admin.pks), [public wrapper bodies](../../PIT/core/packages/pit.pkb), [compiler configuration](../../PIT/tools/set_compiler_flags.sql), [runtime event dispatch](../../PIT/core/packages/pit_internal.pkb).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](administration_app.md) · [Next chapter](troubleshooting.md)
