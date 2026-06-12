<#
    .SYNOPSIS
    Install pre-commit hooks.
#>

#Requires -Version 7.4
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Import-Module -Name "$PSScriptRoot\Utils.psm1"

Set-UvEnvironmentVariables
uv run prek install --install-hooks --overwrite
