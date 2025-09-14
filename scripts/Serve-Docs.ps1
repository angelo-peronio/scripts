<#
.SYNOPSIS
    Start the documentation development server.
#>

#Requires -Version 7.4
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Import-Module -Name "$PSScriptRoot\Utils.psm1"

uv run $(Get-UvRunOptions) mkdocs serve --config-file=docs/mkdocs.yaml --strict
