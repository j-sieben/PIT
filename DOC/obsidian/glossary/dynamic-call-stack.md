# Dynamic call stack

A snapshot of currently active PL/SQL calls, read through `UTL_CALL_STACK` by `pit_util.get_call_stack`.

By the time an [exception](exception.md) handler runs, some calls may have unwound. This snapshot therefore does not replace the [exception backtrace](exception-backtrace.md) and does not contain Oracle error [messages](message.md).

Compiler inlining removes the separate method from the compiled call structure. Supply its name through `p_action` on the PIT entry call when that method should retain its own trace label.

Continue with [exceptions](../exceptions.md).

[Glossary index](README.md) · [Handbook](../README.md)
