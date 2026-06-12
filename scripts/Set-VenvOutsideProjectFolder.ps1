<#
    .SYNOPSIS
    Tell the scripts to store the Python virtual environment outside the project folder.

    .DESCRIPTION
    Write a `.venv-outside-project-folder` file inside the project root folder.

    .EXAMPLE
    PS> .\scripts\Set-VenvOutsideProjectFolder.ps1
#>

#Requires -Version 7.4
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Import-Module -Name "$PSScriptRoot\Utils.psm1"

$SignalFilePath = Get-VenvSignalFilePath

@"
This file signals to the scripts that the Python virtual environment should be stored outside the project folder.

You probably want to add the following line to your .gitignore file:

/.venv-outside-project-folder
"@
| Out-File -FilePath $SignalFilePath -Encoding UTF8 -Force

"Wrote signal file: $SignalFilePath" | Write-Host
