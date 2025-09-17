<#
    .SYNOPSIS
    Update the scripts.

    .DESCRIPTION
    Upgrade (or downgrade) the scripts to the specified version.
    Requires robocopy <https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy>

    .EXAMPLE
    PS> .\scripts\Update-Scripts.ps1 -DestinationFolder .\scripts\
#>

Param (
    # The folder containing the scripts. Deafults to the current working directory.
    [string]$DestinationFolder = ".",
    # The version to update to, in the form <major>.<minor>.<patch>. Defaults to the latest version.
    [string]$Version = "latest",
    # Add also "new" scripts, not already present in the destination folder.
    [switch]$AddNew = $false,
    # Remove "old" scripts from the destination folder, not present in the downloaded version.
    [switch]$RemoveOld = $false
)

#Requires -Version 7.4
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
$ProgressPreference = "SilentlyContinue"

$OldScriptsFolder = $DestinationFolder
New-Item -ItemType Directory -Force $OldScriptsFolder | Out-Null

$DownloadFolderName = ".update-scripts-cache"
$DownloadFolder = Join-Path $OldScriptsFolder $DownloadFolderName

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

# Robocopy.
$NewScriptsFolder = Join-Path $DownloadFolder "scripts"
$AddNewOption = ($AddNew) ? $null : "/xl"
$RemoveOldOption = ($RemoveOld) ? "/purge" : $null
# robocopy has weird exit codes: exitCode <= 7 means success.
$PSNativeCommandUseErrorActionPreference = $false
robocopy $NewScriptsFolder $OldScriptsFolder $AddNewOption $RemoveOldOption /r:2 /w:1 /e /np /tee /ts /log:"$DownloadFolder\robocopy.log"
if ($LASTEXITCODE -ge 8) {
    throw "robocopy failed with error code $LASTEXITCODE"
}
$PSNativeCommandUseErrorActionPreference = $true

# Clean up.
Remove-Item $DownloadFolder -Recurse -Force
