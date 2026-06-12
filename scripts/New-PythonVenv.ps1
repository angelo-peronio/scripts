<#
    .SYNOPSIS
    Create or refresh a Python virtual environment.

    .DESCRIPTION
    This script requires a `pyproject.toml` configuration file, and
        * if present, installs the corresponding package in editable mode
        * if present, installs the "dev" dependency group,
    The virtual enviroment is replaced if it already exists.
    The pinned versions specified e.g. in `uv.lock` or `pylock.toml` are ignored.
    Requires uv <https://docs.astral.sh/uv/>.

    .EXAMPLE
    PS> .\scripts\New-PythonVenv.ps1
#>

#Requires -Version 7.4
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Import-Module -Name "$PSScriptRoot\Utils.psm1"

"Project root folder: $(Get-ProjectRootFolder)" | Write-Host

Set-UvEnvironmentVariables
uv sync --upgrade
$PythonVersion = uv run python --version
$PythonPath = uv run python -c "import sys; print(sys.executable)"
"$PythonVersion at $PythonPath" | Write-Host
