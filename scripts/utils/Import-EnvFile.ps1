<#
    .SYNOPSIS
    Import environment variables from a .env file.

    .EXAMPLE
    .\Import-EnvFile.ps1

    .NOTES
    Adapted from https://stackoverflow.com/a/76723749
#>

$ErrorActionPreference = "Stop"


$ProjectRootFolder = (Get-Item $PSScriptRoot).Parent.Parent.FullName
$EnvFilePath = Join-Path $ProjectRootFolder ".env"

if (-not (Test-Path $EnvFilePath -PathType Leaf)) {
    "$EnvFilePath not found, not loading environment variables." | Write-Host
    return
}

$Variables = Get-Content -raw $EnvFilePath | ConvertFrom-StringData
$Variables.GetEnumerator() | Foreach-Object {
    $Name, $Value = $_.Name, $_.Value
    "Setting environment variable $Name=$Value" | Write-Host
    Set-Content -Path "Env:\$Name" -Value $Value
}
