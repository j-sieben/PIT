# Collection mode

A validation mode that collects PIT findings so a caller can process several results from one run.

It does not make ordinary Oracle [exceptions](exception.md) resumable. The collection is not nested, and retrieving it consumes the stored [message](message.md) list. The current stop logic has an explicit limitation for severe findings; read the chapter before using it.

Continue with [collect messages](../collect_messages.md).

[Glossary index](README.md) · [Handbook](../README.md)
