<#
    .SYNOPSIS
    Tell the scripts to store the Python virtual environment outside the project folder.

    .DESCRIPTION
    Write a signal file inside the project root folder to tell the scripts to store
    the Python virtual environment outside the project folder.

    .EXAMPLE
    PS> .\scripts\Set-VenvOutsideProjectFolder.ps1
#>

Param (
    # Where to put the Python virtual environment.
    [string]$VenvRootFolder = "C:\venvs"
)

#Requires -Version 7.4
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Import-Module -Name "$PSScriptRoot\Utils.psm1"

$SignalFilePath = Get-VenvSignalFilePath

@"
# This file signals to the scripts that the Python virtual environment should be stored
# outside the project folder, under the folder specified by the VenvRootFolder property below.
# You probably want to keep this file out of version control.

@{
    VenvRootFolder = "$VenvRootFolder"
}
"@ | Out-File -FilePath $SignalFilePath -Encoding UTF8 -Force

@"
Wrote signal file: $SignalFilePath
You probably want to have the following line in your .gitignore file:
/$(Split-Path -Leaf $SignalFilePath)
"@ | Write-Host
