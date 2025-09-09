# PowerShell scripts to streamline common tasks in Python projects

[![license](https://img.shields.io/github/license/angelo-peronio/scripts)](https://github.com/angelo-peronio/scripts/blob/master/LICENSE)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/angelo-peronio/scripts/master.svg)](https://results.pre-commit.ci/latest/github/angelo-peronio/scripts/master)

A collection of PowerShell scripts to streamline common tasks during the development of projects written in Python or using tools written in Python ([pre-commit](https://pre-commit.com/), [Bump My Version](https://callowayproject.github.io/bump-my-version/), [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/), …). Requires [`uv`](https://docs.astral.sh/uv).

## Usage

* Copy the `scripts` folder into your project.
* Customize as needed.
* Create a [`pyproject.toml`](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/)
    * Use the [`requires-python`](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/#python-requires) entry to specify the Python version you want to use.
    * If your project does **not** include a Python package, do not define the [`[build-system]`](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/#declaring-the-build-backend) table.
    * List the dependencies of the tools you use in the `dev` [dependency group](https://packaging.python.org/en/latest/specifications/dependency-groups/).
* Profit.

## Scripts

* [`Bootstrap.ps1`](scripts/Bootstrap.ps1) Bootstrap a development environment.
* [`New-PythonVenv.ps1`](scripts/New-PythonVenv.ps1) Create or refresh a Python virtual environment.
* [`Install-PreCommitHooks.ps1`](scripts/Install-PreCommitHooks.ps1) Install [pre-commit](https://pre-commit.com/) hooks.
* [`Build-Package.ps1`](scripts/Build-Package.ps1) Build source distribution and wheel, then expand them for inspection.
* [Release-Package.ps1](scripts/Release-Package.ps1) Bump the project version, tag a release and push to `origin`.
* [`Set-VenvOutsideProject.ps1`](scripts/Set-VenvOutsideProject.ps1) Tell [`uv`](https://docs.astral.sh/uv) to store the Python virtual environment outside the project folder. Useful to avoid [problems](https://github.com/astral-sh/uv/issues/7906) with Microsoft OneDrive.

## Documentation

Use `Get-Help` to show the documentation of each script:

```powershell
PS> Get-Help .\scripts\Release-Package.ps1 -Detailed
```

## Alternatives

Other common ways to reach the same goal:

* [just](https://just.systems/)
* [nox](https://nox.thea.codes/en/stable/cookbook.html)
* [make](https://www.gnu.org/software/make/)
* [invoke](https://www.pyinvoke.org/)
* [doit](https://pydoit.org/)
