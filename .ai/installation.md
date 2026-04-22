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
