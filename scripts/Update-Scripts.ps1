<#
    .SYNOPSIS
    Update scripts.

    .DESCRIPTION

    .EXAMPLE
#>

Param (
    # The folder containing the scripts. Deafults to the current working directory.
    [string]$ScriptsFolder = ".",
    # The versiopn to update to, in the form <major>.<minor>.<patch>. Defaults to the latest version.
    [string]$Version = "latest",
    # Download all scripts, not only those already present.
    [switch]$All = $false
)

#Requires -Version 7.4
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
# Import-Module -Name "$PSScriptRoot\Utils.psm1"

$DownloadFolderName = "__update_scripts_cache"
$ScriptsFolder_ = Join-Path $(Get-Location) $ScriptsFolder | Resolve-Path
$DownloadFolder = Join-Path $ScriptsFolder_ $DownloadFolderName

# Create cache folder.
if (Test-Path $DownloadFolder) {
    Remove-Item $DownloadFolder -Recurse -Force
}
New-Item -ItemType Directory $DownloadFolder | Out-Null
# https://bford.info/cachedir/
$CacheDirTagPath = Join-Path $DownloadFolder "CACHEDIR.TAG"
"Signature: 8a477f597d28d172789f06886806bc55" | Out-File $CacheDirTagPath
$GitIgnorePath = Join-Path $DownloadFolder ".gitignore"
"*" | Out-File $GitIgnorePath

# Compute download URL.
$Repo = "angelo-peronio/scripts"
if ($Version -eq "latest") {
    $LatestReleaseUrl = "https://api.github.com/repos/$Repo/releases/latest"
    $Response = Invoke-RestMethod -Uri $LatestReleaseUrl -Headers @{ "User-Agent" = "PowerShell" }
    $VersionTag = $Response.tag_name
}
else {
    $VersionTag = "v$Version"
}
$ReleaseFileName = "scripts-$VersionTag.zip"
$ReleaseUrl = "https://github.com/$Repo/releases/download/$VersionTag/$ReleaseFileName"

# Download and expand.
$DownloadPath = Join-Path $DownloadFolder $ReleaseFileName
"Downloading $ReleaseUrl" | Write-Host
Invoke-WebRequest -Uri $ReleaseUrl -OutFile $DownloadPath
Expand-Archive $DownloadPath -DestinationPath $DownloadFolder

$NewScriptsFolder = Join-Path $DownloadFolder "scripts"
$NewScripts = Get-ChildItem $NewScriptsFolder
foreach ($NewScript in $NewScripts) {
    $OldScript = Join-Path $ScriptsFolder_ $NewScript.Name
    if ($All -or (Test-Path $OldScript -PathType Leaf)) {
        Copy-Item $NewScript $OldScript
        "Updated $($NewScript.Name)" | Write-Host
    }
}

# Clean up.
Remove-Item $DownloadFolder -Recurse -Force
