# Work with parameters and realms

The [parameter](glossary/parameter.md) framework is useful beyond PIT itself. It stores default values centrally, lets client schemas override them locally and supports different values for deployment environments through [realms](glossary/realm.md). You can use it for an application's service URLs or other settings as well as for logging.

## Definitions and effective values

A parameter name is unique within its parameter group. `PARAM_ADMIN` maintains groups, definitions, validation rules, realms and realm values. `PARAM` reads effective values and writes local overrides.

The getter API provides string, CLOB, XML, integer, float, date, timestamp and Boolean access. Use the matching datatype rather than relying on implicit conversion. The public getter/setter API has no dedicated RAW pair, even though the storage views expose a RAW column.

```sql
declare
  l_threshold number;
begin
  l_threshold := param.get_integer('LOG_STATE_THRESHOLD', 'PIT');
end;
/
```

Use `param.set_<datatype>` for a local value and `param.reset_parameter` to remove an override according to its signature. Whether a parameter may be changed depends on its definition and group settings.

## Where values come from

`PARAMETER_TAB` stores definitions and defaults. `PARAMETER_LOCAL` stores overrides. In the owner, `PARAMETER_CORE_V` resolves local and active-realm values over defaults. The client-facing `PARAMETER_V` overlays the client's local values. `PARAMETER_VW` is provided as a compatibility synonym.

Precedence is resolved per typed value with `COALESCE`. A null override therefore falls back to the next source; it does not mean “explicitly erase the default”. Query the views when you need to inspect which values your environment sees.

## Use realms for environments

A realm names a deployment environment, such as development, test or production. Define it with `PARAM_ADMIN`, associate parameter values with it and select the active realm using parameter `REALM` in group `PIT`. This keeps environment-specific values separate from deployable defaults.

Local client overrides and realms solve different problems: the former customize one consuming schema, while the latter select environment-specific owner values. Export both deliberately when moving configuration.

## Export configuration

`param_admin.export_parameter_group` exports a definition group. `param_admin.export_local_parameters` and `param.get_parameters` expose local configuration scripts. Check which schema executes the export: local values belong to that schema, not to every PIT client.

Runtime packages may cache values. Reinitialize PIT after changing initialization-time settings, and verify the effective values in the application session. See [administration](administrer_pit.md) and [troubleshooting](troubleshooting.md).

Implementation: [PARAM](../../PIT/parameters/packages/param.pks), [PARAM_ADMIN](../../PIT/parameters/packages/param_admin.pks), [owner resolution](../../PIT/parameters/views/parameter_core_v.vw), [client resolution](../../PIT/parameters/views/parameter_v.vw).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](handling_contexts.md) · [Next chapter](output_modules.md)
