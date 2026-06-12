function Get-ProjectRootFolder {
    <#
        .SYNOPSIS
        Get the path of the root folder of the project

        .DESCRIPTION
        Looks for the first parent folder containing a `pyproject.toml` file.

        .OUTPUTS
        A string with the path of the root folder of the project.
    #>

    $Folder = $PSScriptRoot
    while ($Folder -ne "") {
        $Folder = Split-Path $Folder -Parent
        $PyprojectPath = Join-Path $Folder "pyproject.toml"
        if (Test-Path $PyprojectPath -PathType Leaf) {
            return $Folder
        }
    }
    throw "Cannot determine the project root folder. " `
        + "`pyproject.toml` not found in any parent folder of $PSScriptRoot"
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


function Get-VenvSignalFilePath {
    <#
        .SYNOPSIS
        Get the path to the `.venv-outside-project-folder` signal file inside the project root folder.

        .OUTPUTS
        A string.
    #>

    Get-ProjectRootFolder
    | Join-Path -ChildPath ".venv-outside-project-folder"
    | Write-Output
}

function Set-UvEnvironmentVariables {
    <#
        .SYNOPSIS
        Set the uv environment variables for the current session.

        .DESCRIPTION
        Sets UV_WORKING_DIRECTORY to the project root folder, so that the scripts
        can be run from anywhere.
        If a file named `.venv-outside-project-folder` is found in the project root
        folder, also sets UV_PROJECT_ENVIRONMENT to store the Python virtual environment
        under the $VenvRootFolder defined below.
        Placing the environment outside the project folder avoids synchronization issues
        with Microsoft OneDrive, e.g. <https://github.com/astral-sh/uv/issues/7906>.

        .EXAMPLE
        PS> Set-UvEnvironmentVariables
    #>

    $VenvRootFolder = "C:\venvs"

    $ProjectRootFolder = Get-ProjectRootFolder
    $Env:UV_WORKING_DIRECTORY = $ProjectRootFolder

    if (Test-Path $(Get-VenvSignalFilePath) -PathType Leaf) {
        $VenvFolder = Join-Path $VenvRootFolder $(Get-ProjectName)
        # uv accepts here only forward slashes as path separator.
        $Env:UV_PROJECT_ENVIRONMENT = $VenvFolder.Replace("\", "/")
    }
}
