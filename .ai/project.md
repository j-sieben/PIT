# Project

## Purpose

`PIT` is the PL/SQL Instrumentation Toolkit. It provides a single API for:

- exceptions and error handling
- debug/log output
- trace/call-stack instrumentation
- assertions
- user-facing and translatable messages

The repository is not an application in the usual sense. It is an Oracle PL/SQL
framework that is installed into an owner schema and then granted/registered into
client schemas.

## Important Locations

- `README.md` - conceptual overview and usage examples
- `PIT/pit.sh` - Unix command dispatcher for installs/uninstalls
- `PIT/install_scripts/*.sh` - shell wrappers around SQL*Plus
- `PIT/install_scripts/*.sql` - top-level SQL*Plus install/uninstall scripts
- `PIT/init/*.sql` - shared SQL*Plus initialization and folder variable setup
- `PIT/tools/*.sql` - reusable SQL*Plus helpers for creating/granting objects
- `PIT/parameters` - generic parameter framework
- `PIT/parameters_23` - Oracle 23c variant of parameter framework
- `PIT/context` - reusable global/local context framework
- `PIT/core` - PIT core implementation
- `PIT/core_23` - Oracle 23c variant of PIT core
- `PIT/modules/*` - optional PIT output modules
- `PIT/apex` - APEX administration app
- `PIT/tests` - test packages and `pit_ut` test module

## Main Concepts

- Messages are stored in PIT tables and referenced in code via generated package
  `MSG`.
- `PIT` is the public runtime API used by application code.
- `PIT_ADMIN` manages messages, translations, named contexts, toggles, and export
  scripts.
- Contexts control log level, trace level, timing, and active output modules.
- Output modules derive from abstract object type `PIT_MODULE` and implement
  channels such as `log_exception`, `enter`, `leave`, `print`, `notify`, and
  `panic`.
- Parameters are stored and read through `PARAM` / `PARAM_ADMIN`.

## Oracle Version Split

`PIT/init/settings.sql` detects Oracle 23c and sets `FOLDER_EXTENSION` to `_23`.
The main installer then uses:

- `parameters/install.sql` or `parameters_23/install.sql`
- `core/install.sql` or `core_23/install.sql`

The 23c variants account for native Boolean behavior.
