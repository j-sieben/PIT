# Administer and deploy PIT

Once PIT is installed, most routine work is maintaining definitions and choosing suitable runtime settings. Keep these changes in deployment scripts so another environment can reproduce them.

## Maintain and publish messages

Use `PIT_ADMIN` to merge groups, [messages](glossary/message.md), translations and [translatable items](glossary/translatable-item.md). Message names are unique across groups; groups organize ownership and exports rather than creating separate message namespaces.

Messages have maintained metadata and language text, while runtime lookup uses published materialized data. `pit_admin.create_message_package` assigns active error numbers, creates `MSG`, refreshes `PIT_MESSAGE_MV` and resets package state. With `p_directory`, it writes package DDL to a file instead; that branch does not perform the normal runtime [publication](glossary/publication.md).

Adding, deleting or changing [exception](glossary/exception.md) mappings requires regenerating and deploying `MSG`. Wording changes do not alter its constants, but still require refreshing the published message data. Use the standard publication step when deploying definitions. Rebuilding `MSG` can invalidate dependent application units and reset session state, so do it at a controlled point.

After maintaining translatable items, call `pit_admin.harmonize_translatable_items` to refresh `PIT_TRANSLATABLE_ITEM_MV`. Changes written directly to base tables bypass API checks and publication; use the administration methods instead.

## Export a group

```sql
select pit_admin.get_installation_script(
         p_pmg_name => 'DEMO',
         p_target => pit_admin.C_TARGET_PMS) as installation_script
  from dual;
```

The returned CLOB contains API calls suitable for deployment. The procedure `create_installation_script` also returns a filename. Target constants select messages (`C_TARGET_PMS`), translatable items (`C_TARGET_PTI`) or [parameters](glossary/parameter.md) (`C_TARGET_PAR`). The APEX UI can bundle several groups into a ZIP download.

Store definitions and translations with the application that owns them. Review local parameter values separately so a default deployment does not accidentally replace environment-specific settings. Custom error numbers are allocated during package generation; refer to named exceptions in PL/SQL instead of hardcoding generated numbers in external contracts.

## Retain useful logs

Choose a retention policy for persistent [output modules](glossary/output-module.md). `pit.purge_log` accepts a cutoff date or a number of days and an optional [severity](glossary/severity.md) argument. The table implementation deletes message rows at or before the cutoff whose numeric severity is greater than or equal to the supplied value; despite the public parameter's name, the comparison preserves more severe, smaller-numbered messages when a threshold is supplied.

```sql
begin
  pit.purge_log(p_days_before => 30);
end;
/
```

Purge dispatch goes to the active modules, and each implements its own behavior. PIT_TABLE removes [affected references](glossary/affected-reference.md) with their parent messages and clears old trace/state records. Trace rows use the date cutoff without a severity restriction. Schedule purging in an environment whose [context](glossary/context.md) selects the destinations you intend to clean.

## Reload configuration

Use `pit.initialize` to reload PIT configuration and instantiate output modules in a session. Inspect the resulting module state rather than assuming every installed module is usable. Global context changes and local package caches have different scopes; verify changes from the actual application session, particularly with connection pools.

Implementation: [administration API](../../PIT/core/packages/pit_admin.pks), [publication implementation](../../PIT/core/packages/pit_admin.pkb), [purge API](../../PIT/core/packages/pit.pks), [table purge behavior](../../PIT/modules/pit_table/packages/pit_table_pkg.pkb).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](output_modules.md) · [Next chapter](administration_app.md)
