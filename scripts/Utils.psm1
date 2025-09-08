function Get-ProjectRootFolder {
    (Get-Item $PSScriptRoot).Parent.FullName
    | Write-Output
}

function Get-ProjectName {
    Get-ProjectRootFolder
    | Split-Path -Leaf
    | Write-Output
}

function Get-EnvFilePath {
    $EnvFilePath = Get-ProjectRootFolder | Join-Path -ChildPath ".env"
    $Result = (Test-Path $EnvFilePath -PathType Leaf) ? $EnvFilePath : ""
    $Result | Write-Output
}
