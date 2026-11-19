# Install PIT

PIT can live in its own owner schema and serve several client schemas. You can also use it directly in the owner schema. The APEX administration application is optional; scripts and the administration APIs are sufficient to maintain your installation.

## Prepare the owner

Use SQL*Plus and a Unicode-capable client configuration. The checked privileges are `CREATE TABLE`, `CREATE VIEW`, `CREATE TYPE`, `CREATE SEQUENCE`, `ALTER SESSION` and a directly granted `CREATE PROCEDURE`. The owner also needs suitable tablespace quota and access to the database facilities used by the chosen modules. Review the prerequisite scripts for your environment rather than granting a DBA role just to install PIT.

The installer chooses `core_23` and `parameters_23` on database releases 23 and later; these use native Boolean columns. Earlier releases use the regular directories. The runtime uses `UTL_CALL_STACK`; this handbook does not describe an Oracle 11g compatibility path.

Choose the default language before installation. The supplied [message](glossary/message.md) sets include `AMERICAN` and `GERMAN`. Every message and [translatable item](glossary/translatable-item.md) needs a default-language definition; other languages are translations of it.

Local settings in `PIT/init/settings.sql` control flag representation for the regular installation and the [exception](glossary/exception.md) prefix and postfix. For databases without native SQL Boolean support, choose the Boolean representation with `FLAG_TYPE`, `C_TRUE` and `C_FALSE`, for example `CHAR(1)` with `Y`/`N` or `NUMBER(1,0)` with `1`/`0`. On Oracle Database 23 and later, which support native SQL Boolean values, the installer fixes these settings to `BOOLEAN`, `TRUE` and `FALSE` and uses them automatically. Any manually selected flag representation is overridden on those versions. Review the initialization files before changing schema-wide conventions.

The regular installation exposes the selected representation through subtype `pit_util.flag_type` and the values `pit_util.C_TRUE` and `pit_util.C_FALSE`. Use these in application declarations and comparisons instead of repeating a concrete datatype or hardcoding flag values. This keeps the representation in one place and makes migration to a database with native SQL Boolean support easier.

In the current `core_23` interface, `pit_util.C_TRUE` and `pit_util.C_FALSE` return native `BOOLEAN` values, while declarations use `BOOLEAN` directly; that variant does not declare the `flag_type` subtype. When migrating application code to it, replace references to `pit_util.flag_type` with `BOOLEAN`. Comparisons using the PIT true and false values can retain those names.

## Install the owner

From the repository root:

```sh
cd PIT
./pit.sh install --owner PIT_OWNER --service MY_SERVICE --default-language AMERICAN
```

The wrapper prompts for missing values and passwords. Options override environment variables, which override prompts. Passwords are accepted through prompts or `PIT_OWNER_PW` and `PIT_CLIENT_PW`, rather than command-line options. A service can be a configured connect identifier or an Easy Connect string. Proxy logins such as `LOGIN_USER[PIT_OWNER]` are supported by the shell workflow.

The install sequence is [parameters](glossary/parameter.md), optional [context](glossary/context.md) support, core, then [output modules](glossary/output-module.md): console, table, APEX if available, and file. Mail is installed separately. Core installation includes schema migration, recompilation of invalid objects and final verification. Keep the installation logs and resolve reported errors before running application code.

## Product version and source provenance

`VERSION` at the repository root contains `1.3` (Major.Minor). Both core variants
expose `pit.get_version()` as `Major.Minor.CommitCount` and
`pit.get_git_commit()` as the full Git commit hash:

```sql
select pit.get_version(), pit.get_git_commit() from dual;
```

These functions replace the old numeric `PIT.version` constant (previously `1.2`,
available only in the regular core). Callers must migrate from `PIT.version` to
`PIT.get_version()` and handle a string containing three components.
No version package or table is created.

The owner installation starters (`PIT/pit.sh install` on Unix and
`PIT\pit.bat install` on Windows, including their direct `install.sh`/`install.bat`
wrappers) prepare the values automatically before opening a database connection.
Windows uses the existing Windows PowerShell dependency; Unix uses Bash and Git.
There is no additional build step. Other installation commands do not replace
`PIT` and therefore do not change its recorded version.

For a Git checkout, preparation requires a clean index and working tree,
including no untracked, non-ignored files, and complete history. Commit any
intentional settings changes before installation. Default logs under `PIT/logs`
are ignored. Shallow and partial clones, replacement refs, grafts and missing
Git objects are rejected. The helper resolves the full commit hash once, counts
**all commits reachable from that hash**, including merged branches, using
`git rev-list --count <hash>`, and uses that same hash for diff checks and export.
Changing Major or Minor never resets the count. Prepared export metadata cannot
override an existing Git checkout.

Installation logs show the version and commit. SQL*Plus enables `&` substitution
before loading the body, replacing `&PIT_VERSION.` and `&PIT_GIT_COMMIT.` directly
in the two return statements. The stored database source contains fixed strings.
At the end, the installer recompiles invalid schema objects, requires a valid
`PIT` specification and body, and compares both functions through a SQL query
against the supplied values. SQL errors return a failing process exit status.

### Prepare an installation package without Git

Create a new destination **outside** a clean, complete source checkout. From the
repository root on Unix:

```sh
bash PIT/install_scripts/version.sh --export "/tmp/PIT release"
```

On Windows:

```powershell
powershell.exe -NoProfile -File PIT/install_scripts/version.ps1 -Mode Export -Destination "C:\releases\PIT release"
```

Both commands export the selected commit and add `.pit-version` at the export
root, containing exactly two lines: product version and full commit hash. Package
that whole directory, including this metadata file and `VERSION`. Use the normal
installation starters from the exported directory. Bare `git archive` or a source
download without prepared metadata is insufficient and installation fails.

Metadata is trusted release data, not a cryptographic signature of the exported
files; distribute the export through a trusted channel and preserve its contents.
A Git checkout always validates Git and never falls back to metadata when dirty
or incomplete. The export helpers do not modify tracked source files.

### Reinstall an individual body from source

Generate definitions from the same trusted checkout/export before connecting.
From the repository root on Unix:

```sh
bash PIT/install_scripts/version.sh > /tmp/pit-version.sql
```

On Windows:

```powershell
$definitions = powershell.exe -NoProfile -File PIT/install_scripts/version.ps1 -Mode Sql
if ($LASTEXITCODE -ne 0) { throw "Version preparation failed" }
$definitions | Set-Content -Encoding ASCII "$env:TEMP\pit-version.sql"
```

Require a successful helper exit before continuing. In SQL*Plus or SQLcl, from
the `PIT` directory, load that definitions file, validate the values, then load
the body matching the installed core variant:

```sql
whenever oserror exit failure rollback
whenever sqlerror exit failure rollback
@/tmp/pit-version.sql
@init/init_version.sql &PIT_VERSION. &PIT_GIT_COMMIT.
@core/packages/pit.pkb
-- For the native Boolean installation use @core_23/packages/pit.pkb instead.
@tools/verify_version.sql
```

On Windows substitute the actual temporary file path and quote it when it contains
spaces. Definitions must come from the helper; positional SQL arguments are not
an untrusted-input interface. The same requirement applies when invoking the main
SQL installer directly: `@install_scripts/install.sql AMERICAN <version> <hash>`.
Use the starters to perform automatic provenance checks. Recompiling stored
source with `alter package pit compile body` does not need these variables.

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
