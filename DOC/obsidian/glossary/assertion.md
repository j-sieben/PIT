# Assertion

A check that expresses an expected condition and creates a PIT finding when it fails.

Outside [collection mode](collection-mode.md) the finding normally raises an [exception](exception.md). In collection mode it can be recorded while further checks continue. `assert_is_ok` and `assert_is_not_ok` are queries over recorded findings, rather than checks that create new findings.

Continue with [validations](../validations.md).

[Glossary index](README.md) · [Handbook](../README.md)
