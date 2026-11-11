<#
Install the fleet-lab skills into a target repository, for Pi and Claude Code at once (Windows).
Usage:  pwsh -ExecutionPolicy Bypass -File install.ps1 "C:\path\to\target-repo"
  .agents\skills\<name>          real files (Pi reads this, Agent Skills spec)
  .claude\skills\<name>          symbolic link to the above, or a copy if links are not allowed
  .claude\agents\fleet-worker.md Claude Code worker launcher (Claude only)
Symbolic links need Windows Developer Mode (or an elevated prompt). Without them the skills are copied.
#>
param([Parameter(Mandatory = $true)][string]$Target)
$ErrorActionPreference = 'Stop'

$kit = $PSScriptRoot
$root = (git -C $Target rev-parse --show-toplevel).Trim()
if ($LASTEXITCODE -ne 0) { throw "Not a git repository: $Target" }
$root = [System.IO.Path]::GetFullPath($root)

foreach ($d in '.agents\skills', '.claude\skills', '.claude\agents') {
    New-Item -ItemType Directory -Force -Path (Join-Path $root $d) | Out-Null
}

$copied = $false
foreach ($s in 'fleet-plan', 'fleet-run', 'fleet-worker') {
    $real = Join-Path $root ".agents\skills\$s"
    $link = Join-Path $root ".claude\skills\$s"
    if (Test-Path $real) { Remove-Item -Recurse -Force $real }
    Copy-Item -Recurse (Join-Path $kit "skills\$s") $real
    if (Test-Path $link) { Remove-Item -Recurse -Force $link }
    try {
        # Relative target, so the link survives a move of the repository.
        New-Item -ItemType SymbolicLink -Path $link -Target "..\..\.agents\skills\$s" | Out-Null
    } catch {
        Copy-Item -Recurse $real $link
        $copied = $true
    }
    Write-Host "skill $s"
}
Copy-Item -Force (Join-Path $kit 'claude\agents\fleet-worker.md') (Join-Path $root '.claude\agents\fleet-worker.md')
Write-Host 'agent fleet-worker (Claude Code)'

# Keep .fleet\ out of git.
$exclude = Join-Path $root (git -C $root rev-parse --git-path info/exclude).Trim()
New-Item -ItemType File -Force -Path $exclude -ErrorAction SilentlyContinue | Out-Null
if (-not (Select-String -Path $exclude -Pattern '^\.fleet/$' -Quiet)) { Add-Content -Path $exclude -Value '.fleet/' }

# Shell scripts run inside Linux sandboxes: keep LF line endings.
$attr = Join-Path $root '.gitattributes'
if (-not ((Test-Path $attr) -and (Select-String -Path $attr -Pattern '^\*\.sh\s+text\s+eol=lf' -Quiet))) {
    Add-Content -Path $attr -Value '*.sh text eol=lf'
    Write-Host '.gitattributes: *.sh text eol=lf'
}

if ($copied) {
    Write-Warning '.claude\skills holds COPIES (symbolic links are not allowed here). Edit skills in .agents\skills and run this installer again. To get links: turn on Developer Mode and run: git config core.symlinks true'
}
Write-Host "done. Commit .agents, .claude and .gitattributes on a branch before 'sbx run --clone': the clone sees only committed files."
