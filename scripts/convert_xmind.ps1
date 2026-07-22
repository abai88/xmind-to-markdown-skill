[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string]$SourcePath,
    [Parameter(Mandatory)] [string]$OutputPath,
    [string]$ToolPath = '',
    [switch]$AllowOverwrite
)

$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($ToolPath)) {
    $ToolPath = Join-Path $PSScriptRoot 'xmind2md.py'
}

if (-not (Test-Path -LiteralPath $ToolPath -PathType Leaf)) {
    throw "Converter not found: $ToolPath"
}
if (-not (Test-Path -LiteralPath $SourcePath)) {
    throw "Input path not found: $SourcePath"
}

$sourceItem = Get-Item -LiteralPath $SourcePath
if ($sourceItem.PSIsContainer) {
    if ([IO.Path]::GetExtension($OutputPath) -ieq '.md') {
        throw 'For a folder conversion, OutputPath must be a directory.'
    }
    $sourceRoot = $sourceItem.FullName.TrimEnd([char]92)
    $items = Get-ChildItem -LiteralPath $sourceRoot -Filter '*.xmind' -File -Recurse
    $targets = foreach ($item in $items) {
        $relative = $item.FullName.Substring($sourceRoot.Length).TrimStart([char]92)
        [pscustomobject]@{
            Source = $item.FullName
            Destination = Join-Path $OutputPath ([IO.Path]::ChangeExtension($relative, '.md'))
        }
    }
} else {
    if ($sourceItem.Extension -ine '.xmind') {
        throw 'The input file must have the .xmind extension.'
    }
    if ([IO.Path]::GetExtension($OutputPath) -ine '.md') {
        throw 'For a file conversion, OutputPath must end in .md.'
    }
    $targets = @([pscustomobject]@{ Source = $sourceItem.FullName; Destination = $OutputPath })
}

$success = 0
$skipped = 0
$failed = @()
foreach ($target in $targets) {
    if ((Test-Path -LiteralPath $target.Destination) -and -not $AllowOverwrite) {
        Write-Warning "Skipped existing file: $($target.Destination)"
        $skipped++
        continue
    }
    New-Item -ItemType Directory -Path (Split-Path -Parent $target.Destination) -Force | Out-Null
    & python $ToolPath $target.Source -o $target.Destination
    if ($LASTEXITCODE -eq 0 -and (Test-Path -LiteralPath $target.Destination -PathType Leaf)) {
        $success++
    } else {
        $failed += $target.Source
    }
}

[pscustomobject]@{
    Found = @($targets).Count
    Converted = $success
    Skipped = $skipped
    Failed = $failed.Count
    FailedFiles = $failed
}

if ($failed.Count -gt 0) { exit 1 }
