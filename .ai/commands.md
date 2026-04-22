# Commands

All commands are dispatched by `PIT/pit.sh`.

## Supported Commands

| Command | Wrapper | SQL entry point |
| --- | --- | --- |
| `install` | `install_scripts/install.sh` | `install_scripts/install.sql` |
| `install-client` | `install_scripts/install_client.sh` | `grant_client_access.sql`, `create_client_synonyms.sql` |
| `install-apex` | `install_scripts/install_apex.sh` | `grant_apex_access.sql`, `install_apex.sql` |
| `install-module` | `install_scripts/install_module.sh` | `install_module.sql` |
| `install-module-client` | `install_scripts/install_module_client.sh` | `grant_module_access.sql`, `register_module_client.sql` |
| `uninstall` | `install_scripts/uninstall.sh` | `uninstall.sql` |
| `uninstall-client` | `install_scripts/uninstall_client.sh` | `revoke_client.sql`, `unregister_client.sql` |
| `uninstall-module` | `install_scripts/uninstall_module.sh` | `uninstall_module.sql` |
| `uninstall-module-client` | `install_scripts/uninstall_module_client.sh` | `revoke_module_client.sql`, `unregister_module_client.sql` |

## Input Priority

`pit.sh` supports CLI options, environment variables, and prompts.

Priority:

1. CLI options
2. environment variables
3. interactive prompts

Common environment variables:

- `PIT_OWNER`
- `PIT_OWNER_PW`
- `PIT_CLIENT`
- `PIT_CLIENT_PW`
- `PIT_SERVICE`
- `PIT_DEFAULT_LANGUAGE`
- `PIT_MODULE`
- `PIT_APEX_WORKSPACE`
- `PIT_APEX_APP_ID`
- `PIT_LOG_DIR`

Passwords are intentionally not accepted as CLI options.

## Example

```bash
cd PIT

export PIT_OWNER='juergens[b3m_utils]'
export PIT_OWNER_PW='...'
export PIT_SERVICE='b3m_pdb'
export PIT_CLIENT='dac'
export PIT_CLIENT_PW='...'

./pit.sh install-client
```

## Verification Commands

Syntax-check shell wrappers:

```bash
bash -n PIT/pit.sh
find PIT/install_scripts -maxdepth 1 -name '*.sh' -exec bash -n {} \;
```

Find SQL*Plus usage:

```bash
rg -n "pit_run_sqlplus|sqlplus|/nolog|connect " PIT/install_scripts PIT/pit.sh -g '*.sh'
```
