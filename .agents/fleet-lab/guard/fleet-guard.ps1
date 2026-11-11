<#
fleet-guard: check a fetched agent branch BEFORE it is checked out on the host (Windows twin of fleet-guard.sh).
It only reads git objects. It never checks out, merges or runs anything from the branch.
Run it from this kit, never from a copy inside the target repository.

Usage:  pwsh -File fleet-guard.ps1 <ref> [-Base main] [-Scope 'docs/*','*.md'] [-MaxFiles 50]
Exit: 0 PASS, 1 FAIL (violations listed), 2 usage or git error.
Scope globs use PowerShell -like: * also matches /.
#>
param(
    [Parameter(Mandatory = $true, Position = 0)][string]$Ref,
    [string]$Base = 'main',
    [string[]]$Scope = @(),
    [int]$MaxFiles = 50
)
$ErrorActionPreference = 'Stop'

foreach ($r in $Ref, $Base) {
    git rev-parse --verify -q "$r^{commit}" *> $null
    if ($LASTEXITCODE -ne 0) { Write-Host "unknown ref: $r"; exit 2 }
}

# Paths that can run code or steer an agent on my machine once checked out, opened or built.
$protectedPatterns = @(
    '.claude/*', '*/.claude/*', 'CLAUDE.md', '*/CLAUDE.md', 'AGENTS.md', '*/AGENTS.md', '.mcp.json', '*/.mcp.json',
    '.agents/*', '*/.agents/*',
    '.github/*', '.gitlab-ci.yml', 'azure-pipelines.yml', '.circleci/*',
    '.vscode/*', '*/.vscode/*', '.idea/*', '.devcontainer/*', '*/.devcontainer/*',
    '.git*', '*/.git*', '.husky/*', '.pre-commit-config.yaml', '.envrc', '*/.envrc',
    '*.sh', '*.bash', '*.zsh', '*.ps1', '*.psm1', '*.cmd', '*.bat', 'Makefile', '*/Makefile',
    'package.json', '*/package.json', '.npmrc', '*/.npmrc',
    'Directory.Build.props', 'Directory.Build.targets', '*/Directory.Build.props', '*/Directory.Build.targets', '*.csproj', '*.targets'
)
function Test-Protected([string]$p) { foreach ($g in $protectedPatterns) { if ($p -like $g) { return $true } }; return $false }
function Test-InScope([string]$p) { if ($Scope.Count -eq 0) { return $true }; foreach ($g in $Scope) { if ($p -like $g) { return $true } }; return $false }

Write-Host "fleet-guard: $Base...$Ref"
# --raw -z: ":oldmode newmode oldsha newsha status" NUL path NUL (renames and copies: two paths).
$raw = (git diff --raw -z --no-abbrev -M "$Base...$Ref" | Out-String)
$parts = $raw -split "`0" | Where-Object { $_ -ne '' -and $_ -ne "`n" }
$fail = $false; $n = 0; $i = 0
while ($i -lt $parts.Count) {
    $meta = $parts[$i].Trim(); $i++
    $fields = $meta -split ' '
    $newMode = $fields[1]; $status = $fields[-1]
    $path = $parts[$i]; $i++
    if ($status -match '^[RC]') { $path = $parts[$i]; $i++ }
    $n++
    if (Test-Protected $path) { Write-Host "FAIL protected path: $path"; $fail = $true }
    if (-not (Test-InScope $path)) { Write-Host "FAIL outside scope: $path"; $fail = $true }
    switch ($newMode) {
        '120000' { Write-Host "FAIL symbolic link: $path"; $fail = $true }
        '160000' { Write-Host "FAIL submodule: $path"; $fail = $true }
        '100755' { Write-Host "FAIL executable file: $path"; $fail = $true }
    }
}
if ($n -gt $MaxFiles) { Write-Host "FAIL $n files changed, limit $MaxFiles"; $fail = $true }
$commits = (git rev-list --count "$Base..$Ref").Trim()
Write-Host "files: $n  commits: $commits"
if ($fail) { Write-Host "Do not check out this branch. Read the diff with: git diff $Base...$Ref"; exit 1 }
Write-Host 'PASS'
exit 0
