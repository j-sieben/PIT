# Report application information and long operations

Trace output is useful after the event. Sometimes you want to see what a session is doing while it is still running. PIT integrates stack maintenance with `DBMS_APPLICATION_INFO` for this purpose.

## Module, action and client information

When an instrumented call is actually pushed onto PIT's stack, stack maintenance sets module, action and client information through `DBMS_APPLICATION_INFO`. On exit it restores the predecessor's values, or clears them when no entry remains.

This depends on trace admission or toggle tracking. Do not expect `pit.enter_mandatory` to update application information when its body has been compiled out or when neither tracing nor toggles admits the entry. Enable at least mandatory tracing for a predictable setup.

PIT normally discovers module and action itself. Supply `p_action` and `p_client_info` on public entry calls when you need explicit labels. Set `p_action` for methods the compiler inlines into their callers, because their original method names can no longer be inferred from the compiled call structure. The public entry methods infer the package. Database application-information fields have their own length limits; the stack helper truncates module to 48, action to 32 and client information to 64 characters.

You can inspect the information through session monitoring facilities such as `V$SESSION`, subject to your database privileges. The current session's client information is also accessible through `sys_context('USERENV', 'CLIENT_INFO')`.

## Progress of long operations

Call `pit.long_op` while an instrumented method is active. Give it a target description and the amount of work completed. The default total is 100; pass a real total when counting rows or files is more natural.

```sql
pit.enter_mandatory;
for i in 1 .. 100 loop
  -- Perform one unit of work.
  pit.long_op(p_target => 'Preparing report', p_sofar => i, p_total => 100);
end loop;
pit.leave_mandatory;
```

`p_units` describes the unit of work; `p_op_name` can override the operation label. PIT keeps the long-operation state with the active call-stack entry and updates `DBMS_APPLICATION_INFO.SET_SESSION_LONGOPS`. Monitor progress through `V$SESSION_LONGOPS` where your account has access.

Implementation: [public signature](../../PIT/core/packages/pit.pks), [stack and long-operation handling](../../PIT/core/packages/pit_call_stack.pkb).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](exceptions.md) · [Next chapter](validations.md)
