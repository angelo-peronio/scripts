<#
.SYNOPSIS
    Start the documentation development server.
#>

#Requires -Version 7.4
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Import-Module -Name "$PSScriptRoot\Utils.psm1"

# Explicit --livereload to work around https://github.com/mkdocs/mkdocs/issues/4032
uv run $(Get-UvRunOptions) mkdocs serve --config-file=docs/mkdocs.yaml --livereload
