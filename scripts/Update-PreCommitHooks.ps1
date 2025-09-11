<#
    .SYNOPSIS
    Update pre-commit hooks.
#>

#Requires -Version 7.4
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Import-Module -Name "$PSScriptRoot\Utils.psm1"

uv run $(Get-UvRunOptions) pre-commit autoupdate --jobs=4
