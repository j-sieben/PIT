param(
    [ValidateSet('Sql', 'Values', 'Export')][string]$Mode = 'Sql',
    [string]$Destination
)
$ErrorActionPreference = 'Stop'
try {
    $root = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
    function Invoke-Git([string[]]$Arguments) {
        $result = & git -C $root @Arguments
        if ($LASTEXITCODE -ne 0) { throw "Git failed: $($Arguments -join ' ')" }
        return $result
    }
    $base = [IO.File]::ReadAllText((Join-Path $root 'VERSION')).TrimEnd("`r", "`n")
    if ($base -cnotmatch '^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$') { throw 'VERSION must contain Major.Minor.' }
    if (Test-Path (Join-Path $root '.git')) {
        $top = Invoke-Git -Arguments @('rev-parse', '--show-toplevel')
        if ([IO.Path]::GetFullPath($top) -ne $root) { throw 'Invalid Git checkout root.' }
        $commit = Invoke-Git -Arguments @('rev-parse', '--verify', 'HEAD^{commit}')
        if ((Invoke-Git -Arguments @('rev-parse', '--is-shallow-repository')) -ne 'false') {
            throw 'Incomplete Git history (shallow clone); fetch the complete history first.'
        }
        $partial = & git -C $root config --get-regexp '^(extensions\.partialclone|remote\..*\.promisor)$'
        if ($LASTEXITCODE -gt 1) { throw 'Cannot inspect Git partial clone configuration.' }
        if ($partial) { throw 'Partial clones are unsupported; use a complete checkout.' }
        if (Invoke-Git -Arguments @('for-each-ref', '--format=%(refname)', 'refs/replace')) { throw 'Git replace refs are unsupported.' }
        $grafts = Invoke-Git -Arguments @('rev-parse', '--git-path', 'info/grafts')
        if (![IO.Path]::IsPathRooted($grafts)) { $grafts = Join-Path $root $grafts }
        if ((Test-Path $grafts) -and (Get-Item $grafts).Length -gt 0) { throw 'Git grafts are unsupported.' }
        if (Invoke-Git -Arguments @('status', '--porcelain', '--untracked-files=all')) {
            throw 'Local changes found; commit or remove them before installation/export.'
        }
        Invoke-Git -Arguments @('diff', '--quiet', $commit, '--')
        Invoke-Git -Arguments @('diff', '--cached', '--quiet', $commit, '--')
        $null = Invoke-Git -Arguments @('--no-replace-objects', 'fsck', '--connectivity-only', '--no-reflogs', $commit)
        $count = Invoke-Git -Arguments @('--no-replace-objects', 'rev-list', '--count', $commit)
        $version = "$base.$count"
    } else {
        $metadata = Join-Path $root '.pit-version'
        if (!(Test-Path $metadata)) { throw 'No Git checkout or prepared .pit-version metadata; use a prepared release export.' }
        $lines = [IO.File]::ReadAllLines($metadata)
        if ($lines.Count -ne 2) { throw 'Invalid .pit-version metadata.' }
        $version, $commit = $lines
        if ($version -notlike "$base.*" -or $version.Substring(0, $version.LastIndexOf('.')) -ne $base) {
            throw 'Prepared version does not match VERSION.'
        }
    }
    if ($version -cnotmatch '^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$') { throw 'Invalid product version.' }
    if ($commit -cnotmatch '^([0-9a-f]{40}|[0-9a-f]{64})$') { throw 'Invalid full Git commit hash.' }
    switch ($Mode) {
        Sql { "define PIT_VERSION=$version"; "define PIT_GIT_COMMIT=$commit" }
        Values { "PIT_VERSION=$version"; "PIT_GIT_COMMIT=$commit" }
        Export {
            if (!(Test-Path (Join-Path $root '.git'))) { throw 'Exports must originate from Git.' }
            if (!$Destination) { throw 'Export requires -Destination NEW_DIRECTORY.' }
            $target = [IO.Path]::GetFullPath($Destination)
            if ($target -eq $root -or $target.StartsWith($root + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) {
                throw 'Export outside the source checkout.'
            }
            if (Test-Path $target) { throw 'Export destination already exists.' }
            $archive = [IO.Path]::GetTempFileName()
            try {
                Invoke-Git -Arguments @('archive', '--format=zip', "--output=$archive", $commit)
                Add-Type -AssemblyName System.IO.Compression.FileSystem
                [IO.Compression.ZipFile]::ExtractToDirectory($archive, $target)
                [IO.File]::WriteAllText((Join-Path $target '.pit-version'), "$version`n$commit`n", [Text.UTF8Encoding]::new($false))
            } finally { Remove-Item -LiteralPath $archive -ErrorAction SilentlyContinue }
            "Exported PIT $version ($commit) to $target"
        }
    }
} catch {
    [Console]::Error.WriteLine("PIT version: " + $_.Exception.Message)
    exit 1
}
