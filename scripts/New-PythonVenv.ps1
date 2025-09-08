<#
    .SYNOPSIS
    Create or refresh a Python virtual enviroment.

    .DESCRIPTION
    Usage:
        * copy into your project,
        * set the default values of the parameters at your convenience,
        * execute.
    This script requires a `pyproject.toml` configuration file, and
        * if present, installs the corresponding package in editable mode
        * if present, installs the "dev" dependency group,
    The virtual enviroment is replaced if it already exists.
    The pinned versions specified e.g. in `uv.lock` or `pylock.toml` are ignored.
    Placing the environment outside the project folder avoids synchronization issues
    with Microsoft OneDrive, e.g. <https://github.com/astral-sh/uv/issues/7906>.
    Requires uv <https://docs.astral.sh/uv/>.

    .EXAMPLE
    PS> .\scripts\New-PythonVenv.ps1

    .EXAMPLE
    PS> .\New-PythonVenv.ps1 -OutsideProjectFolder
#>

param (
    # Location of the project root folder relative to the folder containing this script.
    # Common values are ".", "..", or "..\..".
    [string]$ProjectRootFolder = ".."
)

#Requires -Version 7.4
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true

$ProjectRootFolder = Join-Path $PSScriptRoot $ProjectRootFolder | Resolve-Path
"Project root folder: $ProjectRootFolder" | Write-Host

# As of uv 0.8.15, `uv sync` does not support an `--env-file` option like `uv run`,
# so we have to
&$PSScriptRoot\utils\Import-EnvFile.ps1
uv sync --upgrade --directory=$ProjectRootFolder
