<#
.SYNOPSIS
    Build the documentation.
#>

param (
    # Build for offline usage.
    [switch]$Offline = $false
)

#Requires -Version 7.4
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Import-Module -Name "$PSScriptRoot\Utils.psm1"

# Define the environemnt variables used in docs/mkdocs.yaml
# The site_dir path is relative to the MkDocs config file docs/mkdocs.yaml
$Env:mkdocs_site_dir = $Offline ? "../build/offline-docs" : "../build/docs"
$Env:mkdocs_offline = $Offline ? "true" : ""

uv run $(Get-UvRunOptions) mkdocs build --config-file=docs/mkdocs.yaml --strict --verbose
