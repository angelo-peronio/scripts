<#
    .SYNOPSIS
    Install pre-commit.
#>

#Requires -Version 7.4
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true

Import-Module -Name "$PSScriptRoot\Utils.psm1"

$ProjectRootFolder = Get-ProjectRootFolder
$UvEnvFileOption = Get-UvEnvFileOption

uv run --env-file=$UvEnvFileOption --directory=$ProjectRootFolder -- pre-commit install --install-hooks --overwrite
