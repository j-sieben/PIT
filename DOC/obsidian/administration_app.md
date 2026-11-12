# Use the APEX administration application

If you prefer a GUI for maintaining PIT, the optional APEX application puts the administration APIs behind forms and reports. It is particularly useful during development, where you create [messages](glossary/message.md), tune [contexts](glossary/context.md) and prepare deployment exports.

Install it using the [APEX installation workflow](installing_pit.md#install-the-apex-administration-application). It depends on `UTL_TEXT`, `UTL_APEX` and access to the PIT installation. The runtime PIT_APEX [output module](glossary/output-module.md) and this application have different jobs.

## Configure PIT

The PIT administration area shows output modules, their availability and active status. Use the [parameter](glossary/parameter.md) dialogs to adjust module settings such as [fire thresholds](glossary/fire-threshold.md). Named contexts and toggles control which parts of the application produce diagnostics and where those diagnostics go.

After configuration changes, verify effective settings in the session you are investigating. The administration application's own session is not necessarily the application's runtime session.

## Maintain messages

Filter messages by group and language, then edit text, description, [severity](glossary/severity.md) and supported [exception](glossary/exception.md) settings. Message identity is a technical key; changing a label is different from renaming a message referenced in code.

Create groups to organize definitions and exports. Publish message changes and regenerate `MSG` when required by the [administration workflow](administrer_pit.md). Do not assume that editing a definition means every existing session has already refreshed its runtime data.

## Maintain parameters

Choose a parameter group, then maintain definitions, values and validation rules. Group and parameter settings determine whether a value may be modified. A validation expression checks entered values according to the parameter framework's conventions.

Use [realms](glossary/realm.md) for environment-specific values. Selecting the active realm changes the source of effective parameter values; it is different from changing the default definition or a client's local override. Read [parameters](parameters.md) before using realms to manage production configuration.

## Export and translate

The master-data area exports selected message, parameter and translatable-item groups as SQL scripts, bundled for download. Message and item translation uses [XLIFF](glossary/xliff.md) export/import. Keep exported scripts in version control and deploy through the same [publication](glossary/publication.md) steps used by scripted administration.

## Application structure

The controller package is `PITA_UI`; `PIT_APP_API` supplies application-facing validation and persistence wrappers around the administration APIs. This keeps UI handling separate from the reusable administration logic. The delivered application can serve as an example of that separation in your own applications.

The repository includes screenshots under `images/`, but they are not a promise that every version-specific export has the same layout or labels. This guide follows the available functions rather than relying on an older screen sequence.

Implementation: [APEX installation](../../PIT/apex/install.sql), [UI controller](../../PIT/apex/packages/pita_ui.pks), [application API](../../PIT/core/packages/pit_app_api.pks).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](administrer_pit.md) · [Next chapter](performance.md)
