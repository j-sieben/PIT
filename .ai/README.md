# PIT Project Map

This directory contains a compact orientation map for future AI/code-agent work on
this repository. It is not runtime documentation; it summarizes how the project is
structured, where important entry points live, and what local pitfalls are known.

Start here:

- [project.md](project.md) - project purpose, main concepts, directory map
- [architecture.md](architecture.md) - core packages, objects, modules, data flow
- [installation.md](installation.md) - install command flow and SQL*Plus wrappers
- [commands.md](commands.md) - `pit.sh` command mapping
- [ddl-check-map.md](ddl-check-map.md) - DDL migration scripts and reusable checks
- [known-issues.md](known-issues.md) - observed issues and local fixes

Maintenance rule:

- Do not use Graphify for this PL/SQL repository.
- Check these maps against the source when starting an investigation.
- Update the relevant map whenever code changes alter structure, dependencies,
  install order, or reusable tooling.

Repository root notes:

- The actual deployable project lives in `PIT/`.
- Top-level `README.md` is the functional product overview.
- `Doc/` and `PIT/Doc/` contain generated and authored documentation.
- The project is primarily Oracle PL/SQL plus SQL*Plus install automation.
