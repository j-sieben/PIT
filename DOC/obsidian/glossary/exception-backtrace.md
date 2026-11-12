# Exception backtrace

The recorded units and line numbers identifying the path from an [exception](exception.md) origin, available through `UTL_CALL_STACK`.

PIT appends it to the result of `get_error_stack`. The default preserves all backtrace units; optional filtering uses the configured package filters.

If the compiler inlines a method into its caller, Oracle can no longer identify the exact original source line within that method from the compiled diagnostic information. PIT cannot reconstruct the removed method or recover that line number by setting a trace label.

Continue with [exceptions](../exceptions.md).

[Glossary index](README.md) · [Handbook](../README.md)
