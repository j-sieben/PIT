# Installation

## Main Entry Points

Unix dispatcher:

- `PIT/pit.sh`

Shared shell helper:

- `PIT/install_scripts/common.sh`

Main SQL scripts:

- `PIT/install_scripts/install.sql`
- `PIT/install_scripts/install_client.sql`
- `PIT/install_scripts/install_module.sql`
- `PIT/install_scripts/install_module_client.sql`
- corresponding uninstall scripts

## Full Install Flow

`./pit.sh install` dispatches to `PIT/install_scripts/install.sh`, which calls:

```text
PIT/install_scripts/install.sql
```

That SQL script:

1. runs `init/init.sql <DEFAULT_LANGUAGE>`
2. checks prerequisites
3. sets compiler flags
4. installs `parameters` or `parameters_23`
5. checks context prerequisites
6. installs `core` or `core_23`
7. installs output modules:
   - `pit_console`
   - `pit_table`
   - `pit_apex` only if APEX is available
   - `pit_file`
   - `pit_mail` is prepared but commented out in the main installer

## Core Schema Convergence

The CORE installers separate creation, migration, cleanup, and verification:

1. ensure the base tables;
2. normalize legacy CORE_23 `PMST_*` names where applicable;
3. capture legacy `PIT_MESSAGE` text rows in `PIT_MESSAGE_TEXT_MIG`;
4. run `remove_obsolete_objects.sql`;
5. ensure the current `PIT_MESSAGE` keys and `PIT_MESSAGE_TEXT` table;
6. merge and validate captured message text rows;
7. install the remaining views, types, and packages;
8. recompile invalid objects in the installation schema;
9. run `verify_schema.sql`.

`tools/compile_invalid_objects.sql` calls `DBMS_UTILITY.COMPILE_SCHEMA` with
`COMPILE_ALL => FALSE`, so valid objects are not recompiled. This also repairs
application objects that were temporarily invalidated by replacement of PIT
types or package specifications. Verification runs only after this dependency
recompilation.

`clean_up_install.sql` remains the full uninstall path. Optional modules own
their upgrade cleanup; in particular, `pit_mail` repairs its queue foreign key
in `modules/pit_mail/remove_obsolete_objects.sql`.

## Client Install Flow

`./pit.sh install-client` dispatches to `install_scripts/install_client.sh`.

It performs two SQL*Plus runs:

1. connect as PIT owner and run `grant_client_access.sql`
2. connect as client schema and run `create_client_synonyms.sql`

The first script grants access to:

- parameter installation
- PIT core
- installed output modules

The second script registers the client and creates synonyms/parameter records.

## Shared SQL*Plus Runner

All Unix shell commands route through `pit_run_sqlplus` in
`PIT/install_scripts/common.sh`.

Current connection style:

```bash
sqlplus -s -L "${connect_user}/${connect_password}@${service}" <<EOF
whenever oserror exit failure rollback
whenever sqlerror exit failure rollback
@${script_path} $*
exit
EOF
```

This is intentional. An earlier implementation used `/nolog` plus an internal
`connect` command:

```sql
connect ${connect_user}/"${connect_password}"@${service}
```

That failed for proxy-style users such as `juergens[b3m_utils]` with
`ORA-12162`, even though direct SQL*Plus login worked.

## Proxy User Pattern

A working PIT-owner input may look like:

```text
juergens[b3m_utils]
```

Meaning:

- login user: `juergens`
- proxy target / PIT owner schema: `b3m_utils`

`init/init_client.sql` extracts the schema inside brackets and uses it as
`PIT_USER`.

## Service Name

The service prompt accepts the SQL*Plus connect identifier. Examples:

- TNS alias: `b3m_pdb`
- Easy Connect: `//localhost:1521/b3m_pdb`

If a TNS alias works in direct SQL*Plus, it should work through `pit.sh` after
the shared runner fix.

## ORA message group imports

`core/messages/{AMERICAN,GERMAN}/MessageGroup_ORA.sql` and the corresponding
`core_23` scripts merge the group and messages without deleting `ORA` first.
Existing translations and messages added by clients or other components remain
when core messages are reimported.

## Version Preparation and Verification

Only the full owner installer replaces the selected versioned object, `PIT`.
Before connecting, `install.sh` calls `version.sh`; `install.bat` calls
`version.ps1`. The helpers reject dirty, shallow, partial or incomplete Git
checkouts (including replacement refs/grafts), resolve one full commit hash and
count all commits reachable from it. `VERSION` provides Major.Minor. Without
`.git`, validated `.pit-version` export metadata and matching `VERSION` are
required. A present Git checkout never falls back to prepared metadata.

`install.sql` receives language, version and hash. It saves the language before
`init/init_version.sql` captures the version and hash, because nested SQL*Plus
scripts overwrite positional arguments. Named definitions survive nested calls.
`init/init.sql` preserves failing SQL exit status. The PIT body enables `&`
substitution explicitly with `set define on`. Use this form when restoring the
default substitution character, including generated PARAM_ADMIN exports;
SQL*Plus 23.3 rejects the bare `set define &` form with SP2-0317. After all
modules, the top-level installer recompiles
invalid objects and runs `tools/verify_version.sql`, checking valid PIT spec/body
and both values through SQL. Version and commit appear in the installation log.

Direct body installs require helper-generated definitions and
`init/init_version.sql`, followed by `tools/verify_version.sql`. Recompilation of
stored source needs no definitions. See the handbook's installation chapter.

## Technical View Client Access

Both CORE installers create `PIT_TRANSLATABLE_ITEM_TV` after its materialized
source. `verify_schema.sql` requires the view to exist and be valid (CORE_23
delegates to the regular CORE verification script). Both client grant scripts
grant `READ WITH GRANT OPTION`, and registration creates a client synonym.
Client removal revokes `READ` and drops the synonym; full CORE uninstall drops
the view. Existing clients receive access by rerunning `install-client` after
the owner installation.

## Effective Language View Client Access

Both CORE installers create `PIT_EFFECTIVE_LANGUAGE_V` after the effective
language column is ensured. Shared schema verification requires a valid view.
Both client grant scripts grant `READ WITH GRANT OPTION`; registration creates
a synonym. Client removal revokes `READ` and drops the synonym, and the existing
full CORE cleanup drops the view. Existing clients receive access by rerunning
`install-client` after the owner installation.

## Legacy Message Migration SQL

`core/scripts/merge_languages.sql` inserts a missing default language before
the bulk MERGE, explicitly referencing itself through PML_EFFECTIVE_NAME. This
ensures the self-referencing foreign key has a parent before other rows use the
column default. Existing rows and effective-language mappings are preserved.
For legacy tables without PML_EFFECTIVE_NAME, the seed uses the old columns;
the existing subsequent column migration installs the effective-language field.
CORE_23 delegates its language import to this shared script.

`core/tables/prepare_pit_message_migration.sql` captures texts before cleanup;
CORE_23 delegates its prepare/finish stages to CORE. The older
`change_pit_message.sql` files still contain separate migration implementations
in both variants. All three CTAS implementations infer SOURCE/TRANSLATED for
legacy rows without PMS_PMT_NAME using a SQL literal: embedded apostrophes are
doubled with REPLACE before DBMS_ASSERT.ENQUOTE_LITERAL. CTAS cannot accept
binds; the subsequent DELETE still uses a language bind. The legacy-layout
dictionary guards skip capture on fresh/current schemas and repeated installs.

`tests/test_installer_sql.py` checks CTAS construction, DML binds, literal/text
round trips (SQLite, not Oracle), CORE_23 stage delegation, and DEFINE commands.
Set SQLPLUS to a SQL*Plus binary to enable its database-free /nolog smoke test.
Oracle installation/upgrade validation requires a separate disposable schema.

## 128-byte identifiers

The owner/client/APEX/module initialization scripts define ORA_NAME_TYPE as
`varchar2(128 byte)` and ORA_MAX_LENGTH as 128. CORE and PARAMETERS (including
23c), PIT_TABLE, and PIT_MAIL run `tables/ensure_identifier_lengths.sql` before
recreating their dependent program units. The shared helper and column-list
ownership are documented in `ddl-check-map.md`.
