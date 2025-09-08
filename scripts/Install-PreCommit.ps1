<#
    .SYNOPSIS
    Install pre-commit.
#>

#Requires -Version 7.4
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true

uv run --env-file=.env pre-commit install --install-hooks --overwrite
