"""Check identifier coverage and upgrade ordering without an Oracle connection."""
from pathlib import Path
import re
import unittest

ROOT = Path(__file__).resolve().parents[1] / 'PIT'


class IdentifierLengthTests(unittest.TestCase):
    def test_creation_and_upgrade_cover_same_stored_identifiers(self):
        for component in ('core', 'parameters', 'modules/pit_table', 'modules/pit_mail'):
            folder = ROOT / component
            migration = (folder / 'tables/ensure_identifier_lengths.sql').read_text()
            expected = set()
            for table in (folder / 'tables').glob('*.tbl'):
                for line in table.read_text().splitlines():
                    column = re.match(r'\s*(\w+)\s+&ORA_NAME_TYPE\.', line)
                    if column and ' virtual' not in line.lower():
                        expected.add((table.stem, column[1]))
            actual = set(re.findall(
                r'@&tools.ensure_identifier_length.sql (\w+) (\w+)', migration))
            with self.subTest(component=component):
                self.assertTrue(expected)
                self.assertEqual(actual, expected)
                install = (folder / 'install.sql').read_text()
                stage = install.index('@&table_dir.ensure_identifier_lengths.sql')
                self.assertGreater(stage, install.rindex('@&tools.check_has_table'))
                self.assertLess(stage, install.index('@&tools.install_'))
        for component in ('core', 'parameters'):
            folder = ROOT / (component + '_23')
            self.assertEqual((folder / 'tables/ensure_identifier_lengths.sql').read_text().strip(),
                             '@' + component + '/tables/ensure_identifier_lengths.sql')
            self.assertIn('@&table_dir.ensure_identifier_lengths.sql',
                          (folder / 'install.sql').read_text())

    def test_identifier_references_have_no_legacy_width(self):
        for component in ('core', 'core_23'):
            for path in (ROOT / component / 'tables').glob('*.tbl'):
                for column, datatype in re.findall(
                        r'^\s*(\w+)\s+(varchar2\(50 (?:byte|char)\))',
                        path.read_text(), re.M | re.I):
                    self.assertEqual(column, 'pml_display_name', f'{path}: {column} {datatype}')

    def test_explicit_byte_limit_and_validation(self):
        for name in ('init.sql', 'init_apex.sql', 'init_client.sql', 'init_module.sql'):
            source = (ROOT / 'init' / name).read_text()
            self.assertIn('define ORA_NAME_TYPE="varchar2(128 byte)"', source)
            self.assertIn('define ORA_MAX_LENGTH=128', source)
        for variant in ('core', 'core_23'):
            source = (ROOT / variant / 'packages/pit_admin.pkb').read_text()
            validate = source[source.index('  procedure validate_message('):]
            self.assertIn('lengthb(p_row.pms_name)', validate)
            self.assertIn('l_max_length := pit_util.c_max_length;', validate)
            self.assertLess(validate.index('if l_message_length > l_max_length'),
                            validate.index('check_error(p_row)'))
            util = (ROOT / variant / 'packages/pit_util.pkb').read_text()
            self.assertIn('lengthb(pmg_error_prefix)', util)
            self.assertIn('lengthb(pmg_error_postfix)', util)
        helper = (ROOT / 'tools/ensure_identifier_length.sql').read_text()
        self.assertIn("if l_data_length != 128 or l_char_used != 'B' then", helper)
        self.assertIn('varchar2(128 byte)', helper)
        self.assertNotIn('when others', helper.lower())


if __name__ == '__main__':
    unittest.main()
