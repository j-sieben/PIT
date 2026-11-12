# Session adapter

An object that supplies PIT with the current user identity, session identity and an optional requested [context](context.md).

The default adapter uses database session information. The APEX adapter recognizes the APEX environment and debug settings. This matters when one application session uses several pooled database connections.

Continue with [handling contexts](../handling_contexts.md).

[Glossary index](README.md) · [Handbook](../README.md)
