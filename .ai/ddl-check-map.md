# DDL and Check Map

This map is the navigation entry point for table creation and migration work.
It records stable relationships only; inspect the referenced source before making
a change.

## Locations

- `PIT/tools/check_*.sql` - reusable SQL*Plus feature/object checks
- `PIT/tools/run_script.sql` - conditionally dispatches a script
- `PIT/tools/null.sql` - no-op target used by conditional dispatch
- `PIT/core/tables/*.tbl` - core table definitions
- `PIT/core/tables/change_*.sql` - migrations for existing core tables
- `PIT/core_23/tables/*.tbl` - Oracle 23c table definitions
- `PIT/core_23/tables/change_*.sql` - Oracle 23c migrations
- `PIT/parameters*/tables/` - parameter-framework tables and migrations
- `PIT/modules/*/tables/` - tables owned by optional output modules

## Reusable Checks

| Script | Question answered |
| --- | --- |
| `check_has_apex.sql` | Is APEX available? |
| `check_has_client.sql` | Does the requested client/schema exist? |
| `check_has_column.sql` | Does a table contain a named column? |
| `check_has_constraint.sql` | Does a named constraint exist? |
| `check_has_sequence.sql` | Does a named sequence exist? |
| `check_has_sql_boolean.sql` | Is native SQL Boolean supported? |
| `check_has_table.sql` | Does a named table exist? |
| `check_type_is_used.sql` | Is an object type currently referenced? |
| `check_installation.sql` | Are installation prerequisites satisfied? |

`install_type_spec.sql` also checks `USER_TAB_COLUMNS` before replacing a type.
If a table column uses the type, the existing specification is retained and the
installer emits a status message instead of provoking ORA-22866. Type source
files must not locally switch `WHENEVER SQLERROR` to `CONTINUE`; unexpected type
creation errors must still stop the installation.

The current checks combine two responsibilities: they inspect the dictionary and
they derive a target script from a naming convention. This works for initial
creation, but limits their use for migrations:

- `check_has_table <table>` can only select `<table_dir>/<table>.tbl`.
- `check_has_column <table> <column>` can only select
  `<table_dir>/change_<table>.sql` when the column is absent.
- Most existing checks have no explicit `on exists`/`on missing` target.
- There are no reusable checks for indexes or views.
- `check_has_constraint.sql` accepts explicit scripts for the present and missing
  cases and is used for additive constraint repair.

## Current Core Migration Flow

Both `core/install.sql` variants currently mix three migration styles:

1. Initial objects are created through `check_has_table` and
   `check_has_sequence`.
2. Simple missing columns use `check_has_column`, for example
   `PIT_MESSAGE_SEVERITY.PSE_REQUIRES_EXCEPTION` and
   `PIT_MESSAGE_LANGUAGE.PML_EFFECTIVE_NAME`.
3. Complex changes run unconditionally in `change_pit_message.sql` and
   `change_pit_message_runtime.sql`; those scripts inspect dictionary state in
   PL/SQL and execute DDL dynamically.

`change_pit_message.sql` performs a data migration, key change, column removal,
temporary-table lifecycle, text-table creation, and (in `core_23`) legacy-name
normalization. `change_pit_message_runtime.sql` removes obsolete columns,
constraints, indexes, views, and tables and also tries to alter
`PIT_MAIL_QUEUE`.

## Recommended Check Contract

Decouple checking from script naming. A reusable conditional dispatcher should
accept explicit targets, conceptually:

```text
check_has_column <table> <column> <when-present.sql> <when-missing.sql>
check_has_constraint <table> <constraint> <when-present.sql> <when-missing.sql>
check_has_index <index> <when-present.sql> <when-missing.sql>
check_has_view <view> <when-present.sql> <when-missing.sql>
```

`tools/null.sql` remains the no-op target. Compatibility wrappers may preserve
the current two-argument behavior, but new migration calls should always name
their target explicitly. Each check must assign both the script and message
substitution variables on every path so a value from a preceding SQL*Plus call
cannot leak into the next call.

Use small operation scripts for one independently testable schema transition,
for example `drop_pmt_pmst_name.sql` or `add_pml_effective_name_fk.sql`. Guard
each operation with the dictionary fact that determines whether that exact DDL
is needed. Do not infer one operation from an only loosely related fact.

## What Can Use Tool Checks

These operations can be dispatched directly once the generic contracts exist:

- add a missing column;
- add a missing named constraint or index;
- drop an existing column, constraint, index, view, or table;
- rename a legacy column, constraint, or index when old and new names are
  distinguishable;
- create a missing table or sequence;
- run data cleanup only while its source column/table still exists.

The current `change_pit_message_runtime.sql` is therefore a good candidate for
decomposition into guarded operation scripts. The CORE_23 `PMST_*` to `PMT_*`
normalization can also be expressed as a sequence of old-name checks, provided
each rename additionally protects against the new name already existing.

## What Needs More Than Existing Checks

The following cannot safely be reduced to the present checks:

- Copying multilingual rows into `PIT_MESSAGE_TEXT` before source columns are
  removed. This requires ordered data migration and validation.
- Deduplicating `PIT_MESSAGE` before changing its primary key.
- Creating and consuming `PIT_MESSAGE_TEXT_MIG` across partial installations.
- Choosing a default translation status based on both column availability and
  data values.
- Recovering safely from one of several intermediate legacy layouts.

Keep these steps in a dedicated migration script, but give that migration one
clear entry guard and explicit postcondition checks. For future changes, a small
schema-version/history table is preferable to reconstructing every historical
state from unrelated columns. Oracle DDL commits implicitly, so restartability
must be designed per step; exception handlers must ignore only the exact
"already absent/already exists" error expected by that step.

## Ownership and Ordering Finding

`change_pit_message_runtime.sql` currently tries to add
`FK_PMQ_PMS_ID` to `PIT_MAIL_QUEUE`. This cannot be made reliable in the CORE
installer:

- `pit_mail` is not part of the normal enabled module list in
  `install_scripts/install.sql`.
- When installed, modules run after CORE.
- If an old `PIT_MAIL_QUEUE` exists, `pit_mail/install.sql` only checks whether
  the table exists and therefore does not repair its constraint.
- The CORE migration suppresses the missing-table error, so the required change
  can be silently skipped forever.

Move this migration into `modules/pit_mail/install.sql` (or a module-local
`change_pit_mail_queue.sql`) and guard it with a constraint check there. CORE
must not migrate an optional module's table.

## Cleanup versus Upgrade Cleanup

`core/clean_up_install.sql` and `core_23/clean_up_install.sql` are destructive
uninstall scripts. They are called by `install_scripts/uninstall.sql` and remove
the current PIT tables as well as packages, types, views, and sequences. Do not
give these files an additional upgrade meaning.

Use a separate installation stage, for example
`core/remove_obsolete_objects.sql`, with this contract:

- it only removes explicitly listed legacy objects and legacy table elements;
- it never removes an object that belongs to the current target model;
- it runs after required legacy data has been copied and validated;
- it runs before dependent views and packages are recreated;
- optional modules clean up their own legacy objects in their own installers;
- every operation is restartable and unexpected errors stop installation.

A useful installation lifecycle is:

```text
ensure base objects
-> migrate and validate legacy data
-> remove obsolete columns/constraints/indexes/views/tables
-> ensure current additive schema elements
-> recreate views, types, and packages
-> verify installation
```

The name `remove_obsolete_objects.sql` distinguishes this convergent upgrade step
from the full uninstall performed by `clean_up_install.sql`.

Implemented CORE stages:

- `tables/prepare_pit_message_migration.sql` captures legacy text rows and
  deduplicates `PIT_MESSAGE` before its key changes.
- `remove_obsolete_objects.sql` removes explicitly listed legacy schema parts.
- `tables/ensure_pit_message_keys.sql` restores the current primary key and
  conditional unique index.
- `tables/finish_pit_message_migration.sql` merges captured rows, validates the
  row count, and only then removes the migration table.
- `verify_schema.sql` checks required/obsolete columns, key constraints,
  temporary objects, and invalid CORE program units.
- `core_23/tables/normalize_pit_message_names.sql` converges historic `PMST_*`
  identifiers to `PMT_*` before migration.
- `modules/pit_mail/remove_obsolete_objects.sql` owns repair of
  `FK_PMQ_PMS_ID`.

## Oracle 23c Strategy

The `core_23` table definitions already use `CREATE TABLE IF NOT EXISTS`, and
some indexes use `CREATE INDEX IF NOT EXISTS`. Oracle 23c also supports
`IF EXISTS` on supported `ALTER` and `DROP` DDL statements. Prefer these native
forms in the 23c upgrade-cleanup script instead of dictionary queries whose only
purpose is suppressing a missing-object error.

This syntax checks existence, not structural equality. In particular,
`CREATE TABLE IF NOT EXISTS` leaves an existing table unchanged even if columns,
types, constraints, or indexes differ from the `.tbl` target definition. The 23c
flow therefore still needs explicit migration/data-validation steps and additive
schema repair. Native existence clauses replace simple guards; they do not form a
general schema-diff engine.

## Error Handling Rule

Avoid `when others then null` around arbitrary DDL. It hides invalid identifiers,
wrong referenced columns, privilege errors, and genuine data/constraint
violations. Conditional dispatch should prevent expected absence errors. Where
dynamic DDL is still required, whitelist only the Oracle error code expected for
that individual statement and re-raise everything else.

## How to Trace a DDL Path

1. Start at the component's `install.sql` and follow `@` and `@@` includes in
   execution order.
2. Record each `.tbl` creation and `change_*.sql` migration it invokes.
3. For every conditional block, identify the `check_*.sql` contract: input
   defines, output define/substitution variable, and selected target script.
4. Check both `core` and `core_23` (or `parameters` and `parameters_23`) because
   corresponding scripts may intentionally differ.
5. Search dependent views, packages, constraints, and grants by object/column
   name before changing a table.

Useful searches:

```bash
rg -n "^\s*@@?|check_has_|run_script" PIT -g '*.sql'
rg -n "<TABLE_OR_COLUMN_NAME>" PIT -g '*.sql' -g '*.tbl' -g '*.vw' -g '*.pk?'
```

## Maintenance

Update this file when a reusable check is added or removed, when the conditional
execution contract changes, or when table migrations move to another location.
Detailed one-off findings belong in a task report unless they establish a stable
project convention.
