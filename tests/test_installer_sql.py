"""Installer SQL regressions; no Oracle connection or schema changes.

SQLPLUS may point to a SQL*Plus binary for the /nolog DEFINE smoke test.
SQLite checks the generated SQL literals, not Oracle PL/SQL execution.
"""
from contextlib import closing
import os
from pathlib import Path
import re
import shutil
import sqlite3
import subprocess
import unittest

ROOT = Path(__file__).resolve().parents[1]
MIGRATIONS = (
    'PIT/core/tables/prepare_pit_message_migration.sql',
    'PIT/core/tables/change_pit_message.sql',
    'PIT/core_23/tables/change_pit_message.sql',
)
QUOTE_EXPR = "dbms_assert.enquote_literal( replace(l_default_language, '''', ''''''))"


def statements(source):
    return re.findall(r"execute immediate (.*?);", source, re.S | re.I)


class MigrationTests(unittest.TestCase):
    def test_ctas_literal_and_delete_bind(self):
        for name in MIGRATIONS:
            with self.subTest(file=name):
                source = (ROOT / name).read_text()
                ctas = [s for s in statements(source)
                        if 'create table pit_message_text_mig as' in s]
                self.assertEqual(len(ctas), 2)
                for sql in ctas:
                    self.assertNotIn(':default_language', sql)
                    self.assertNotRegex(sql, r'\busing\b')
                inferred = next(s for s in ctas if "'SOURCE'" in s)
                self.assertIn(QUOTE_EXPR, ' '.join(inferred.split()))
                deletes = [s for s in statements(source) if 'delete from pit_message' in s]
                self.assertEqual(len(deletes), 1)
                self.assertIn(':default_language', deletes[0])
                self.assertRegex(deletes[0], r"\]' using l_default_language$")

    def test_generated_ctas_preserves_text_and_status(self):
        # Render the actual CTAS fragments with SQL-standard apostrophe escaping.
        # The expression contract above separately checks the Oracle helper call.
        for name in MIGRATIONS:
            expression = next(s for s in statements((ROOT / name).read_text())
                              if 'create table pit_message_text_mig as' in s
                              and "'SOURCE'" in s)
            fragments = re.findall(r"q'\[(.*?)\]'", expression, re.S)
            self.assertEqual(len(fragments), 2)
            for language in ('AMERICAN', "O'NEIL", "'QUOTED'", "X' then 'BAD' --"):
                with self.subTest(file=name, language=language), closing(sqlite3.connect(':memory:')) as db:
                    db.execute('create table pit_message (pms_name, pms_pml_name, pms_text, pms_description)')
                    rows = [('MSG', language, "Source's text", 'Source description'),
                            ('MSG', 'GERMAN', 'Übersetzung', 'Beschreibung')]
                    db.executemany('insert into pit_message values (?, ?, ?, ?)', rows)
                    literal = "'" + language.replace("'", "''") + "'"
                    db.execute(fragments[0] + literal + fragments[1])
                    actual = db.execute('select * from pit_message_text_mig order by pmt_pmst_name').fetchall()
                    self.assertEqual(actual, [rows[0] + ('SOURCE',), rows[1] + ('TRANSLATED',)])

    def test_fresh_and_repeated_install_skip_legacy_capture(self):
        # Current/fresh tables lack PMS_PML_NAME, so legacy capture is guarded.
        for name in MIGRATIONS:
            with self.subTest(file=name):
                source = (ROOT / name).read_text()
                self.assertRegex(source, r"column_name = 'PMS_PML_NAME';\s+if l_has_old_(?:layout|columns) > 0 then")
                self.assertLess(source.index('if l_has_old_'),
                                source.index('create table pit_message_text_mig as'))

    def test_core23_shared_stages_delegate(self):
        for stage in ('prepare', 'finish'):
            name = f'{stage}_pit_message_migration.sql'
            self.assertEqual((ROOT / 'PIT/core_23/tables' / name).read_text().strip(),
                             '@core/tables/' + name)


class LanguageImportTests(unittest.TestCase):
    def test_default_language_seed_before_bulk_merge(self):
        source = (ROOT / 'PIT/core/scripts/merge_languages.sql').read_text()
        self.assertEqual((ROOT / 'PIT/core_23/scripts/merge_languages.sql').read_text().strip(),
                         '@core/scripts/merge_languages.sql')
        self.assertLess(source.index('if l_has_default = 0 then'),
                        source.index('merge into pit_message_language'))
        self.assertRegex(source, r"where pml_name = l_language;\s+if l_has_default = 0 then")
        self.assertRegex(source, r"column_name = 'PML_EFFECTIVE_NAME';\s+if l_has_effective_name > 0 then")
        self.assertIn('using l_language, l_display_name, l_language;', source)
        self.assertNotIn('pml_effective_name', source.split('when matched then update set')[1])
        insert = re.search(r"execute immediate q'\[(.*?)\]'", source, re.S)[1]
        for language in ('AMERICAN', 'GERMAN'):
            with self.subTest(language=language), closing(sqlite3.connect(':memory:')) as db:
                db.execute('pragma foreign_keys=on')
                db.execute('create table pit_message_language ('
                           'pml_name text primary key, pml_display_name text, pml_default_order integer, '
                           f"pml_effective_name text not null default '{language}' "
                           'references pit_message_language(pml_name))')
                # The unseeded bulk insert fails; the actual seed INSERT supplies
                # the self-reference and allows subsequent defaulted inserts.
                with self.assertRaises(sqlite3.IntegrityError):
                    db.execute("insert into pit_message_language(pml_name) values ('FRENCH')")
                db.execute(insert, {'language': language, 'display_name': language,
                                    'effective_name': language})
                db.execute("insert into pit_message_language(pml_name) values ('FRENCH')")
                self.assertEqual(db.execute('select pml_effective_name from pit_message_language').fetchall(),
                                 [(language,), (language,)])
                # Simulate the dictionary/row guard on the second invocation.
                count = db.execute('select count(*) from pit_message_language where pml_name = ?',
                                   (language,)).fetchone()[0]
                self.assertEqual(count, 1)
                if count == 0:
                    db.execute(insert, {'language': language, 'display_name': language,
                                        'effective_name': language})
                self.assertEqual(db.execute('select count(*) from pit_message_language').fetchone()[0], 2)


class TableDefinitionTests(unittest.TestCase):
    def test_custom_error_unique_indexes(self):
        paths = [ROOT / 'PIT' / name for name in (
            'core/tables/pit_message.tbl',
            'core_23/tables/pit_message.tbl',
            'core/tables/ensure_pit_message_keys.sql',
            'core/tables/change_pit_message.sql',
            'core_23/tables/change_pit_message.sql',
        )]
        for path in paths:
            source = path.read_text()
            self.assertNotRegex(source, r'(?i)constraint\s+pms_custom_error_u\s+unique')
            indexes = re.findall(
                r'create unique index pms_custom_error_u on pit_message\(\s*(case\b.*?\bend)\s*\)',
                source, re.S | re.I)
            self.assertTrue(indexes, str(path))
            for expression in indexes:
                with self.subTest(file=str(path.relative_to(ROOT)), expression=expression):
                    with closing(sqlite3.connect(':memory:')) as db:
                        db.execute('create table pit_message (pms_custom_error number)')
                        db.execute('create unique index pms_custom_error_u '
                                   f'on pit_message({expression})')
                        db.executemany('insert into pit_message values (?)',
                                       [(None,), (None,), (-20000,), (-20000,),
                                        (-20001,), (-20002,), (0,)])
                        for value in (-20001, -20002, 0):
                            with self.assertRaises(sqlite3.IntegrityError):
                                db.execute('insert into pit_message values (?)', (value,))

    def test_message_creation_and_reinstall_guards(self):
        source = (ROOT / 'PIT/core/tables/pit_message.tbl').read_text()
        self.assertRegex(source, r'references pit_message_severity\(pse_id\)\s*\) organization index;')
        self.assertLess(source.index(') organization index;'),
                        source.index('create unique index pms_custom_error_u'))
        self.assertIn('constraint pit_message_pk primary key (pms_name)', source)
        self.assertIn('constraint pms_pmg_name_fk foreign key (pms_pmg_name)', source)
        self.assertIn('constraint pms_pse_id_fk foreign key (pms_pse_id)', source)
        ensure = (ROOT / 'PIT/core/tables/ensure_pit_message_keys.sql').read_text()
        self.assertRegex(ensure, r"from user_indexes\s+where index_name = 'PMS_CUSTOM_ERROR_U';\s+if l_count = 0 then\s+execute immediate")
        self.assertEqual((ROOT / 'PIT/core_23/tables/ensure_pit_message_keys.sql').read_text().strip(),
                         '@core/tables/ensure_pit_message_keys.sql')
        check = (ROOT / 'PIT/tools/check_has_table.sql').read_text()
        self.assertIn("case amt when 0 then '&table_dir.&1..tbl' else 'tools/null.sql'", check)
        for variant in ('core', 'core_23'):
            install = (ROOT / 'PIT' / variant / 'install.sql').read_text()
            self.assertIn('@&tools.check_has_table pit_message\n', install)
            self.assertIn('@&table_dir.ensure_pit_message_keys.sql', install)
            self.assertNotIn('change_pit_message.sql', install)

    def test_severity_group_column_and_check(self):
        definitions = sorted((ROOT / 'PIT').rglob('pit_message_severity.tbl'))
        self.assertEqual([p.relative_to(ROOT / 'PIT').as_posix() for p in definitions],
                         ['core/tables/pit_message_severity.tbl',
                          'core_23/tables/pit_message_severity.tbl'])
        for path in definitions:
            with self.subTest(file=str(path.relative_to(ROOT))):
                source = path.read_text()
                column = re.search(r'^\s*pse_pti_pmg_id\s+(.+),$', source, re.M)
                self.assertIsNotNone(column)
                definition = ' '.join(column[1].lower().split())
                if path.parent.parent.name == 'core':
                    self.assertEqual(definition,
                                     "varchar2(50 byte) default on null 'pit' "
                                     "constraint pse_pti_pmg_id_chk check (pse_pti_pmg_id = 'pit')")
                    expression = re.search(r'check\s*\((.*?)\)', column[1], re.I)[1]
                    # Execute the actual CHECK expression, without translating
                    # Oracle-specific DEFAULT ON NULL or the rest of the DDL.
                    with closing(sqlite3.connect(':memory:')) as db:
                        db.execute('create table severity (pse_pti_pmg_id text '
                                   f'check ({expression}))')
                        db.execute("insert into severity values ('PIT')")
                        with self.assertRaises(sqlite3.IntegrityError):
                            db.execute("insert into severity values ('OTHER')")
                else:
                    self.assertEqual(definition, "varchar2(50 char) default on null 'pit'")


class DefineTests(unittest.TestCase):
    def test_no_bare_ampersand_including_generated_scripts(self):
        for path in (ROOT / 'PIT').rglob('*'):
            if path.is_file() and path.suffix in ('.sql', '.pkb'):
                with self.subTest(file=str(path.relative_to(ROOT))):
                    self.assertNotRegex(path.read_text(), r'(?i)\bset\s+define\s+&')

    def test_sqlplus_define_commands_and_substitution(self):
        binary = os.environ.get('SQLPLUS') or shutil.which('sqlplus')
        if not binary:
            self.skipTest('SQL*Plus unavailable; set SQLPLUS to run /nolog checks')
        commands = []
        for path in (ROOT / 'PIT').rglob('*'):
            if path.is_file() and path.suffix in ('.sql', '.pkb'):
                source = path.read_text()
                commands.extend(re.findall(r'(?im)^\s*(set\s+define\s+on)\s*$', source))
                commands.extend(re.findall(r"'(set define on)'", source))
        self.assertGreaterEqual(len(commands), 8)
        script = 'set define ~\ndefine PIT_DEFINE_PROBE=works\n'
        for command in commands:
            script += command + '\nprompt PIT_DEFINE_PROBE=&PIT_DEFINE_PROBE.\nset define ~\n'
        script += 'exit\n'
        result = subprocess.run([binary, '-s', '/nolog'], input=script,
                                text=True, capture_output=True, timeout=30)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertNotRegex(result.stdout + result.stderr, r'SP2-\d+')
        self.assertEqual(result.stdout.count('PIT_DEFINE_PROBE=works'), len(commands))


if __name__ == '__main__':
    unittest.main()
