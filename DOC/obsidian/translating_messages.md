# Translate messages and application text

Keep the default-language text complete first, then add translations. This gives PIT a reliable fallback and gives translators the [context](glossary/context.md) they need. Use the description to explain arguments and the situation in which the text appears.

## Translate one message

```sql
begin
  pit_admin.translate_message(
    p_pms_name => 'DEMO_GREETING',
    p_pms_pml_name => 'GERMAN',
    p_pms_text => 'Hallo #1#, willkommen bei PIT!',
    p_pms_description => 'Greeting used in the handbook example.');
end;
/
commit;
```

Use the same [message](glossary/message.md) name and preserve the meaning of the argument anchors. The translation does not change [severity](glossary/severity.md), [exception](glossary/exception.md) mapping or group membership.

The runtime reads published message data through `PIT_MESSAGE_V` and `PIT_MESSAGE_MV`, using the effective language configured in `PIT_MESSAGE_LANGUAGE`. The standard [publication](glossary/publication.md) path is `pit_admin.create_message_package`, which refreshes the message materialized view as well as rebuilding `MSG`. Wording changes do not require new constants, but changed repository text still needs publication before the runtime sees it. Schedule publication as a deployment step rather than assuming each merge changes runtime output immediately.

## Translate a group using XLIFF

Export a [message group](glossary/message-group.md) using `pit_admin.create_translation_xml` or its CLOB-returning counterpart `get_translation_xml`. Pass the Oracle target-language name and select `pit_admin.C_TARGET_PMS` for messages or `C_TARGET_PTI` for [translatable items](glossary/translatable-item.md). The procedure returns the filename and an `XMLTYPE` document.

Translate the [XLIFF](glossary/xliff.md) content while keeping identifiers and placeholders intact. Import it through `pit_admin.apply_translation`, with the matching target kind. The APEX administration application wraps export and import in a UI and can bundle groups into ZIP downloads.

Keep the resulting translations in your deployment scripts. `pit_admin.create_installation_script` exports a group with its translations, so the target environment does not depend on a manual editing session.

## Translate translatable items

Use `pit_admin.merge_translatable_item` with the same item ID and group and another language. There is no separate `translate_translatable_item` method. After maintaining items, call `pit_admin.harmonize_translatable_items` to refresh their published runtime data. See [translatable items](using_translatable_items.md).

## Verify the result

Use a separate call after publication, select the intended session language and retrieve the text with `pit.get_message_text` or the translatable-item view. Check both a translated item and an item that must fall back to the default language. If an [ICU message](glossary/icu.md) is involved, also test representative argument values.

Implementation: [translation and export API](../../PIT/core/packages/pit_admin.pks), [publication](../../PIT/core/packages/pit_admin.pkb), [runtime language selection](../../PIT/core/views/pit_message_v.vw).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](collect_messages.md) · [Next chapter](using_translatable_items.md)
