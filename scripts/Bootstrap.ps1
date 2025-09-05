<#
    .SYNOPSIS
    Bootstrap a development environment.
#>

#Requires -Version 7.4
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true

&"$PSScriptRoot\utils\New-PythonVenv.ps1"
&"$PSScriptRoot\utils\Install-PreCommit.ps1"
