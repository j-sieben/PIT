"""Exercise provenance and installer handoff without an Oracle connection.

Run: python3 -m unittest discover -s tests -p 'test_version.py'
PowerShell parity checks run when pwsh is available.
"""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

SOURCE = Path(__file__).resolve().parents[1]


class VersionTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='pit version tests ')
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name).resolve() / 'source with spaces'
        self.root.mkdir()
        for name in ('VERSION', '.gitignore', 'PIT/install_scripts/version.sh',
                     'PIT/install_scripts/version.ps1', 'PIT/install_scripts/install.sh',
                     'PIT/install_scripts/common.sh'):
            target = self.root / name
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(SOURCE / name, target)
        self.git('init', '-b', 'main')
        self.git('config', 'user.name', 'Version Test')
        self.git('config', 'user.email', 'version@example.invalid')
        self.commit('initial')
        self.git('checkout', '-b', 'feature')
        (self.root / 'feature').write_text('feature\n')
        self.commit('feature')
        self.git('checkout', 'main')
        (self.root / 'main').write_text('main\n')
        self.commit('main')
        self.git('merge', '--no-ff', 'feature', '-m', 'merge')

    def git(self, *args):
        return subprocess.check_output(['git', '-C', str(self.root), *args],
                                       stderr=subprocess.PIPE, text=True).strip()

    def commit(self, message):
        self.git('add', '.')
        self.git('commit', '-m', message)

    def runners(self, root=None):
        root = root or self.root
        yield ['bash', str(root / 'PIT/install_scripts/version.sh')]
        if shutil.which('pwsh'):
            yield ['pwsh', '-NoProfile', '-File', str(root / 'PIT/install_scripts/version.ps1')]

    def check_metadata(self, root=None, expected=None, error=None):
        for command in self.runners(root):
            with self.subTest(command=command):
                result = subprocess.run(command, capture_output=True, text=True, cwd=self.temp.name)
                if error:
                    self.assertNotEqual(result.returncode, 0)
                    self.assertIn(error, result.stderr)
                else:
                    self.assertEqual(result.returncode, 0, result.stderr)
                    version, commit = expected or ('1.3.4', self.git('rev-parse', 'HEAD'))
                    self.assertEqual(result.stdout.splitlines(),
                                     [f'define PIT_VERSION={version}', f'define PIT_GIT_COMMIT={commit}'])

    def test_merge_count_and_minor_change(self):
        self.check_metadata()
        (self.root / 'VERSION').write_text('2.0\n')
        self.commit('minor')
        self.check_metadata(expected=('2.0.5', self.git('rev-parse', 'HEAD')))

    def test_dirty_tracked_staged_and_untracked(self):
        target = self.root / 'main'
        target.write_text('changed\n')
        self.check_metadata(error='Local changes')
        self.git('add', 'main')
        self.check_metadata(error='Local changes')
        self.git('reset', '--hard', 'HEAD')
        (self.root / 'untracked').write_text('new\n')
        self.check_metadata(error='Local changes')

    def test_shallow_and_partial(self):
        clone = Path(self.temp.name).resolve() / 'shallow clone'
        subprocess.run(['git', 'clone', '--depth=1', self.root.as_uri(), str(clone)],
                       check=True, capture_output=True)
        self.check_metadata(root=clone, error='shallow clone')
        self.git('config', 'remote.origin.promisor', 'true')
        self.check_metadata(error='Partial clones')

    def test_stale_metadata_never_overrides_git(self):
        (self.root / '.pit-version').write_text('0.0.0\n' + 'a' * 40 + '\n')
        self.commit('stale prepared data')
        self.check_metadata(expected=('1.3.5', self.git('rev-parse', 'HEAD')))

    def test_exports_and_invalid_metadata(self):
        for index, command in enumerate(self.runners()):
            target = Path(self.temp.name).resolve() / f'export with spaces {index}'
            args = ['--export', str(target)] if command[0] == 'bash' else ['-Mode', 'Export', '-Destination', str(target)]
            result = subprocess.run(command + args, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertFalse((target / '.git').exists())
            self.check_metadata(root=target)
            (target / '.pit-version').write_text("1.3.4\n'bad hash\n")
            self.check_metadata(root=target, error='Invalid full Git commit hash')
            (target / '.pit-version').write_text('1.2.4\n' + 'a' * 40 + '\n')
            self.check_metadata(root=target, error='does not match VERSION')
            (target / '.pit-version').unlink()
            self.check_metadata(root=target, error='No Git checkout')

    def test_linked_worktree(self):
        target = Path(self.temp.name).resolve() / 'linked worktree'
        self.git('worktree', 'add', '--detach', str(target), 'HEAD')
        self.check_metadata(root=target)

    def test_replacement_refs_and_grafts(self):
        self.git('replace', 'HEAD', 'HEAD~1')
        self.check_metadata(error='replace refs')
        self.git('replace', '-d', 'HEAD')
        (self.root / '.git/info/grafts').write_text(self.git('rev-parse', 'HEAD') + '\n')
        self.check_metadata(error='grafts')

    def test_invalid_base_and_missing_objects(self):
        (self.root / 'VERSION').write_text("1.3'bad\n")
        self.check_metadata(error='VERSION must contain')
        self.git('reset', '--hard', 'HEAD')
        missing = self.git('rev-parse', 'HEAD~1^{tree}')
        (self.root / '.git/objects' / missing[:2] / missing[2:]).unlink()
        self.check_metadata(error='Git')

    def test_installer_handoff_and_failure_before_connection(self):
        binaries = Path(self.temp.name).resolve() / 'mock bin'
        binaries.mkdir()
        marker = Path(self.temp.name).resolve() / 'sql input'
        sqlplus = binaries / 'sqlplus'
        sqlplus.write_text('#!/bin/bash\ncat > "$SQL_CAPTURE"\nexit "${SQL_STATUS:-0}"\n')
        sqlplus.chmod(0o755)
        env = dict(os.environ, PATH=str(binaries) + os.pathsep + os.environ['PATH'],
                   PIT_OWNER='owner', PIT_OWNER_PW='test', PIT_SERVICE='service',
                   PIT_DEFAULT_LANGUAGE='AMERICAN', SQL_CAPTURE=str(marker))
        command = ['bash', str(self.root / 'PIT/install_scripts/install.sh')]
        result = subprocess.run(command, env=env, capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        expected = f'@./install_scripts/install.sql AMERICAN 1.3.4 {self.git("rev-parse", "HEAD")}'
        self.assertIn(expected, marker.read_text())
        self.assertEqual(self.git('status', '--porcelain'), '')
        env['SQL_STATUS'] = '7'
        self.assertEqual(subprocess.run(command, env=env, capture_output=True).returncode, 7)
        marker.unlink()
        (self.root / 'main').write_text('dirty\n')
        result = subprocess.run(command, env=env, capture_output=True, text=True)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('Local changes', result.stderr)
        self.assertFalse(marker.exists())


if __name__ == '__main__':
    unittest.main()
