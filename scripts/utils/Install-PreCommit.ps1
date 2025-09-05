<#
    .SYNOPSIS
    Install pre-commit.
#>

#Requires -Version 7.4
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true

.\.venv\Scripts\activate.ps1
pre-commit install --install-hooks --overwrite
deactivate
