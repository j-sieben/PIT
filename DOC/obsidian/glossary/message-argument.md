# Message argument

A value supplied in `MSG_ARGS` to replace part of a [message](message.md) template. Ordinary templates use numbered anchors such as `#1#`.

`MSG_ARGS` is a `VARRAY(20) OF CLOB`. Arguments have an order and are different from named trace [parameters](parameter.md) or [affected references](affected-reference.md). [ICU](icu.md) messages use the format marker and named values instead.

Continue with [messages](../messages.md).

[Glossary index](README.md) · [Handbook](../README.md)
