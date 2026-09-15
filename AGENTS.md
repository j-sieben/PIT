# Repository Instructions

## PL/SQL code navigation

- Do not use Graphify for this repository. Its extraction and relationship model
  is not reliable enough for this PL/SQL and SQL*Plus project.
- Use the maintained text maps in `.ai/` as the first navigation aid.
- Verify every map entry against the source before relying on it for a change.
- Whenever a change adds, removes, renames, or materially rewires a component,
  update the affected `.ai/*.md` map in the same change.
- For focused investigations, build temporary maps from `rg`, SQL*Plus include
  directives (`@`/`@@`), object names, package references, and install order.
  Promote durable findings into `.ai/`.

## Map ownership

- `.ai/project.md` owns the repository and component directory map.
- `.ai/architecture.md` owns runtime packages, object types, modules, and their
  responsibilities.
- `.ai/installation.md` owns installation order and SQL*Plus script flow.
- `.ai/commands.md` owns shell entry points and their SQL entry points.
- `.ai/ddl-check-map.md` owns reusable checks and table migration/DDL patterns.
- `.ai/known-issues.md` owns confirmed limitations, traps, and workarounds.
