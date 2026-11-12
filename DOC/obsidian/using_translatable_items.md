# Translate application data

[Messages](glossary/message.md) are not the only text an application needs in several languages. Status names, labels and descriptions often belong to application data. A [translatable item](glossary/translatable-item.md) lets PIT maintain those translations without turning every label into an [exception](glossary/exception.md) message.

## Define an item

An item is identified by its ID and [message group](glossary/message-group.md). It has a name, display name and description in each language. Always create the default-language row first.

```sql
begin
  pit_admin.merge_translatable_item(
    p_pti_id => 'READY',
    p_pti_pml_name => pit.get_default_language,
    p_pti_pmg_name => 'DEMO',
    p_pti_name => 'Ready',
    p_pti_display_name => 'Ready for processing');
  pit_admin.harmonize_translatable_items;
end;
/
commit;
```

Create group `DEMO` first, for example with the [getting-started script](using_pit.md). Add another language with the same merge method and item identity. `harmonize_translatable_items` refreshes the materialized view used for runtime lookup; a merge alone changes the maintained table.

## Read from SQL

```sql
select pti_id, pti_name, pti_display_name, pti_description
  from pit_translatable_item_v
 where pti_pmg_name = 'DEMO';
```

`PIT_TRANSLATABLE_ITEM_V` selects the effective session language from published data in `PIT_TRANSLATABLE_ITEM_MV`. The materialized view supplies a default-language fallback when a translated row is absent. A present translation supplies the whole row; individual null translated fields are not filled independently from the default row.

Join this view to your application's data when reading several rows. It avoids repeated PL/SQL calls from SQL and makes the relationship visible to the query. The maintained table also has virtual default-language keys `PTI_UID` and `PTI_UPMG` for application foreign-key references without a language column.

## Read from PL/SQL

Use `pit.get_trans_item_name`, `get_trans_item_display_name`, `get_trans_item_description` or `get_trans_item` for the complete record. Inspect their signatures for group and argument [parameters](glossary/parameter.md). The name and display name can use replacement arguments; the description is additional explanatory text.

The runtime path uses published materialized data. Include [publication](glossary/publication.md) in deployment and test a language without a translation as well as one with a complete translation.

For group translation and deployment, continue with [translation](translating_messages.md) and [administration](administrer_pit.md).

Implementation: [table and reference keys](../../PIT/core/tables/pit_translatable_item.tbl), [published items](../../PIT/core/views/pit_translatable_item_mv.vw), [session view](../../PIT/core/views/pit_translatable_item_v.vw), [getters](../../PIT/core/packages/pit.pks).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](translating_messages.md) · [Next chapter](icu_messages.md)
