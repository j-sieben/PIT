# Publication

The step that makes maintained [message](message.md) or translatable-item definitions available through PIT runtime materialized views.

The standard message path is `pit_admin.create_message_package`, which also rebuilds `MSG`. For items, use `pit_admin.harmonize_translatable_items`. Reloading session configuration with `pit.initialize` is a different operation.

Continue with [administrer pit](../administrer_pit.md).

[Glossary index](README.md) · [Handbook](../README.md)
