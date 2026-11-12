# Install PIT

PIT can live in its own owner schema and serve several client schemas. You can also use it directly in the owner schema. The APEX administration application is optional; scripts and the administration APIs are sufficient to maintain your installation.

## Prepare the owner

Use SQL*Plus and a Unicode-capable client configuration. The checked privileges are `CREATE TABLE`, `CREATE VIEW`, `CREATE TYPE`, `CREATE SEQUENCE`, `ALTER SESSION` and a directly granted `CREATE PROCEDURE`. The owner also needs suitable tablespace quota and access to the database facilities used by the chosen modules. Review the prerequisite scripts for your environment rather than granting a DBA role just to install PIT.

The installer chooses `core_23` and `parameters_23` on database releases 23 and later; these use native Boolean columns. Earlier releases use the regular directories. The runtime uses `UTL_CALL_STACK`; this handbook does not describe an Oracle 11g compatibility path.

Choose the default language before installation. The supplied [message](glossary/message.md) sets include `AMERICAN` and `GERMAN`. Every message and [translatable item](glossary/translatable-item.md) needs a default-language definition; other languages are translations of it.

Local settings in `PIT/init/settings.sql` control flag representation for the regular installation and the [exception](glossary/exception.md) prefix and postfix. Release 23 and later use native Boolean values instead of the flag substitution. Review the initialization files before changing schema-wide conventions.

## Install the owner

From the repository root:

```sh
cd PIT
./pit.sh install --owner PIT_OWNER --service MY_SERVICE --default-language AMERICAN
```

The wrapper prompts for missing values and passwords. Options override environment variables, which override prompts. Passwords are accepted through prompts or `PIT_OWNER_PW` and `PIT_CLIENT_PW`, rather than command-line options. A service can be a configured connect identifier or an Easy Connect string. Proxy logins such as `LOGIN_USER[PIT_OWNER]` are supported by the shell workflow.

The install sequence is [parameters](glossary/parameter.md), optional [context](glossary/context.md) support, core, then [output modules](glossary/output-module.md): console, table, APEX if available, and file. Mail is installed separately. Core installation includes schema migration, recompilation of invalid objects and final verification. Keep the installation logs and resolve reported errors before running application code.

## Optional global context

The context prerequisite check looks for access to `DBA_CONTEXT` and either an existing `PIT_CTX_<owner>` context or permission to create it. If the prerequisites are available, the context framework is installed. Otherwise PIT uses local context state.

Local state is sufficient for many uses, but does not by itself carry a user's debug settings between pooled database sessions. A [session adapter](glossary/session-adapter.md) can request a context based on the calling environment; APEX uses this mechanism. If you later change the global-context prerequisites, reinstall so the compiled configuration agrees with them.

## Give another schema access

```sh
./pit.sh install-client --owner PIT_OWNER --client APP_OWNER --service MY_SERVICE
```

The wrapper connects as the owner to grant access, then as the client to create synonyms and register it. No client installation is necessary merely to use PIT inside its owner schema.

## Install optional modules

```sh
./pit.sh install-module --owner PIT_OWNER --service MY_SERVICE --module pit_mail
./pit.sh install-module-client --owner PIT_OWNER --client APP_OWNER \
  --service MY_SERVICE --module pit_mail
```

Check the module's own prerequisites first. Mail uses `UTL_TEXT` and mail configuration; file output needs a usable Oracle directory and filesystem permissions. Installing a module and selecting it in a runtime context are separate steps. See [output modules](output_modules.md).

## Install the APEX administration application

Install the required `UTL_TEXT` and `UTL_APEX` dependencies and make them accessible in the intended workspace schema. The checked APEX minimum is 20.2; the repository contains version-specific application exports. The installer selects an export according to the detected APEX version, so inspect the available directories and installation log for your target.

```sh
./pit.sh install-apex --owner PIT_OWNER --client APP_OWNER --service MY_SERVICE \
  --apex-workspace MY_WORKSPACE --apex-app-id 900
```

This is distinct from the PIT_APEX output module. The module delivers runtime messages; the administration application maintains PIT definitions and settings.

## Remove an installation

The dispatcher supports `uninstall-client`, `uninstall-module-client`, `uninstall-module` and `uninstall`, using the corresponding owner, client, service and module options. Review dependencies and preserve required definitions and logs before removing objects. The dispatcher has no `uninstall-apex` command; manage removal of the administration application through the APEX deployment process and the relevant schema objects.

Implementation: [dispatcher](../../PIT/pit.sh), [main SQL installer](../../PIT/install_scripts/install.sql), [prerequisites](../../PIT/install_scripts/check_prerequisites.sql), [context prerequisites](../../PIT/install_scripts/check_context_prerequisites.sql), [version settings](../../PIT/init/settings.sql).

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Next chapter](using_pit.md)
