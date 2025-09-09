function Get-ProjectRootFolder {
    <#
        .SYNOPSIS
        Get the path of the root folder of the project

        .OUTPUTS
        A string with the path of the root folder of the project.
    #>

    (Get-Item $PSScriptRoot).Parent.FullName
    | Write-Output
}


function Get-ProjectName {
    <#
        .SYNOPSIS
        Get the name of the project.

        .DESCRIPTION
        Get the name of the folder containing the project.

        .OUTPUTS
        A string with the name of the project.
    #>

    Get-ProjectRootFolder
    | Split-Path -Leaf
    | Write-Output
}


function Get-EnvFilePath {
    <#
        .SYNOPSIS
        Get the path to the `.env` file inside the project root folder.

        .OUTPUTS
        A string.
    #>

    Get-ProjectRootFolder
    | Join-Path -ChildPath ".env"
    | Write-Output
}


function Get-UvEnvFileOption {
    <#
        .SYNOPSIS
        Get the --env-file command line option for `uv run`.

        .OUTPUTS
        If an `.env` file is found inside the project root folder returns
        "--env-file=<path to the .env file>", otherwise returns nothing.
    #>

    $EnvFilePath = Get-EnvFilePath
    if (Test-Path $EnvFilePath -PathType Leaf) {
        "--env-file=$EnvFilePath" | Write-Output
    }
}


function Get-UvRunOptions {
    <#
        .SYNOPSIS
        Get the command line options we use to invoke `uv run`.

        .OUTPUTS
        An array of option strings.

        .EXAMPLE
        PS> uv run $(Get-UvRunOptions) ruff check
    #>

    @(
        "--directory=$(Get-ProjectRootFolder)",
        $(Get-UvEnvFileOption),
        "--"
    ) | Write-Output
}
