
$VenvsRootFolder = "C:\venvs"
$ProjectRootFolder = (Get-Item $PSScriptRoot).Parent.FullName
$ProjectName = Split-Path $ProjectRootFolder -Leaf
$VenvFolder = Join-Path $VenvsRootFolder $ProjectName
$EnvFilePath = Join-Path $ProjectRootFolder ".env"

Push-Location $ProjectRootFolder
# uv accepts only forward slashes as path separator.
"UV_PROJECT_ENVIRONMENT=$VenvFolder" -replace "\\", "/" | Out-File $EnvFilePath
