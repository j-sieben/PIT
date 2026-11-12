# Control logging with contexts and toggles

A [context](glossary/context.md) brings together the [log level](glossary/log-level.md), [trace level](glossary/trace-level.md), timing flag and list of [output modules](glossary/output-module.md). This lets you instrument your code once and decide how much information to collect when you need it.

## Define and select settings

Create a named context with the administration API:

```sql
begin
  pit_admin.create_named_context(
    p_context_name => 'APP_DEBUG',
    p_log_level => pit.level_all,
    p_trace_level => pit.trace_all,
    p_trace_timing => true,
    p_module_list => 'PIT_CONSOLE:PIT_TABLE');
end;
/
commit;
```

Named contexts are [parameters](glossary/parameter.md) named `CONTEXT_<name>` in group `PIT`. Their compact value is `log level|trace level|timing flag|module list`, for example `70|50|Y|PIT_CONSOLE:PIT_TABLE`. Module names use colons. Use the API to validate the settings instead of constructing parameter rows yourself.

```sql
begin
  pit.set_context('APP_DEBUG');
  -- Run the work to inspect.
  pit.reset_context;
end;
/
```

You can also call the overloaded `pit.set_context` with `p_log_level`, `p_trace_level`, `p_trace_timing` and `p_log_modules` for temporary settings without defining a named context. `CONTEXT_DEFAULT` supplies the baseline; `CONTEXT_ACTIVE` is reserved for runtime state.

The lowest log threshold does not suppress error, severe or fatal logging. Removing all destinations can still leave you without a record. Use an appropriate persistent output module in production.

## Understand the scope

With global-context support, `UTL_CONTEXT` controls visibility across database sessions, users and client identifiers. `PIT_CTX_TYPE` chooses the mode. Without that support, context state is local to the database session. In a pool, one browser request may use a different database session from the next.

The context modes include global visibility, forced user/client-identifier matching, preferred client-identifier matching with fallback, and session scope. Use the constants in `UTL_CONTEXT` when configuring them. Think carefully about the identity your application actually sets: a database username and an application user are often different things.

A [session adapter](glossary/session-adapter.md) provides session details and can request a context. The default adapter uses database information; the APEX adapter detects the APEX environment and debug settings. This is why enabling APEX debugging can change PIT's effective settings without a manual call in your application.

## Toggle by package or method

A [context toggle](glossary/context-toggle.md) temporarily changes settings when an instrumented package or method is entered. Enable `ALLOW_TOGGLE` and create the target named context before creating its toggle.

```sql
begin
  pit_admin.create_context_toggle(
    p_toggle_name => 'ORDER_DEBUG',
    p_module_list => 'ORDER_API:ORDER_RULES.CHECK_ORDER',
    p_context_name => 'APP_DEBUG',
    p_comment => 'Trace order processing while investigating an issue');
end;
/
commit;
```

The implementation uses colon-separated target lists. On entry, a matching toggle selects its context; stack exit restores the preceding settings. Toggles need minimal stack tracking even when detailed tracing is off. Turn `ALLOW_TOGGLE` off when you do not need that facility.

## Read settings and store application values

Use `pit.get_active_context`, `get_log_level` and `get_trace_level` to inspect runtime settings. `check_log_level_greater_equal` and `check_trace_level_greater_equal` let your code avoid expensive preparation when the intended level is inactive.

`pit.set_context_value` and `pit.get_context_value` provide named application values in PIT's context storage. A null value removes the attribute. Their visibility follows the installed context mechanism and configuration; do not assume cross-session sharing in a local installation.

Parameter changes and context changes are related but different. PIT and output modules cache configuration. After changing configuration that is read at initialization, call `pit.initialize` in the affected session to reload it. Do not assume that changing a table row refreshes all existing sessions.

Implementation: [context API](../../PIT/core/packages/pit.pks), [context implementation](../../PIT/core/packages/pit_context.pkb), [toggle creation](../../PIT/core/packages/pit_admin.pkb), [context framework](../../PIT/context/packages/utl_context.pks).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](icu_messages.md) · [Next chapter](parameters.md)
