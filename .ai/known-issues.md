# Known Issues

## ORA-12162 During `pit.sh install-client`

Observed command:

```bash
./pit.sh install-client
```

Inputs:

```text
Enter owner schema for PIT: juergens[b3m_utils]
Enter service name for the database or PDB: b3m_pdb
Enter client schema name: dac
```

Observed error:

```text
ORA-12162: TNS: Net Service Name falsch angegeben
```

Direct SQL*Plus login worked:

```bash
sqlplus -L 'juergens[b3m_utils]/<password>@b3m_pdb'
```

### Cause

The shell helper previously connected using SQL*Plus `/nolog` and then issued a
SQL*Plus `connect` command inside a heredoc:

```sql
connect ${connect_user}/"${connect_password}"@${service}
```

This did not behave the same as passing the full logon string directly to
SQL*Plus, especially for proxy-style user names containing brackets.

### Fix

`PIT/install_scripts/common.sh` now connects directly:

```bash
sqlplus -s -L "${connect_user}/${connect_password}@${service}" <<EOF
```

All Unix commands exposed by `PIT/pit.sh` use `pit_run_sqlplus`, so this fix
applies to:

- `install`
- `install-client`
- `install-apex`
- `install-module`
- `install-module-client`
- `uninstall`
- `uninstall-client`
- `uninstall-module`
- `uninstall-module-client`

### Caveat

The direct logon-string style is compatible with the confirmed working manual
SQL*Plus call, but the password is briefly visible as a process argument. This is
usually acceptable for local development. A more secure future variant would need
to preserve proxy-user compatibility while avoiding password exposure.

## Windows `.bat` Scripts

The `.bat` scripts under `PIT/install_scripts` have independent SQL*Plus calls.
They are not used by `PIT/pit.sh`. They already use direct SQL*Plus logon strings,
not the broken `/nolog` heredoc pattern.
