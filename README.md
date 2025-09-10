# PowerShell scripts to streamline common tasks in Python projects

[![license](https://img.shields.io/github/license/angelo-peronio/scripts)](https://github.com/angelo-peronio/scripts/blob/master/LICENSE)
[![ci](https://github.com/angelo-peronio/scripts/actions/workflows/ci.yaml/badge.svg)](https://github.com/angelo-peronio/scripts/actions/workflows/ci.yaml)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/angelo-peronio/scripts/master.svg)](https://results.pre-commit.ci/latest/github/angelo-peronio/scripts/master)

A collection of PowerShell scripts to streamline common tasks during the development of projects written in Python or using tools written in Python ([pre-commit](https://pre-commit.com/), [Bump My Version](https://callowayproject.github.io/bump-my-version/), [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/), …), inspired by [Scripts to Rule Them All](https://github.blog/engineering/scripts-to-rule-them-all/). Requires [`uv`](https://docs.astral.sh/uv).

## Usage

* Clone this project and copy the [`scripts`](scripts) subfolder into your project.
* Customize the scripts as you like, add your own, and delete what you do not need.
* Create or edit the [`pyproject.toml`](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/) of your project:
    * Use the [`requires-python`](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/#python-requires) entry to specify the Python version you want to use.
    * List the dependencies of the tools you use in the `dev` [dependency group](https://packaging.python.org/en/latest/specifications/dependency-groups/).
    * If your project does **not** include a Python package, do not define the [`[build-system]`](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/#declaring-the-build-backend) table.
* Profit.

## Scripts

* [`Bootstrap.ps1`](scripts/Bootstrap.ps1) Bootstrap a development environment.
* [`New-PythonVenv.ps1`](scripts/New-PythonVenv.ps1) Create or refresh a Python virtual environment.
* [`Install-PreCommitHooks.ps1`](scripts/Install-PreCommitHooks.ps1) Install [pre-commit](https://pre-commit.com/) hooks.
* [`Build-Package.ps1`](scripts/Build-Package.ps1) Build source distribution and wheel, then expand them for inspection.
* [`Release-Project.ps1`](scripts/Release-Project.ps1) Bump the project version, tag a release, and push to `origin`.
* [`Set-VenvOutsideProject.ps1`](scripts/Set-VenvOutsideProject.ps1) Tell [`uv`](https://docs.astral.sh/uv) to store the Python virtual environment outside the project folder. Useful to avoid [problems](https://github.com/astral-sh/uv/issues/7906) with Microsoft OneDrive.

## Documentation

Use `Get-Help` to show the documentation of each script:

```powershell
PS> Get-Help .\scripts\Release-Project.ps1 -Detailed
```

## Details

* The Python virtual environment is created with [`uv sync --upgrade`](https://docs.astral.sh/uv/reference/cli/#uv-sync--upgrade), always using the latest version of the dependencies. This prioritizes keeping the dependencies up to date over having a reproducible dependency set. Therefore, it makes sense to exclude the [lockfile](https://docs.astral.sh/uv/concepts/projects/layout/#the-lockfile) `uv.lock` from version control.
* Environment variables are automatically loaded from a `.env` file in the project root folder, if present. This mechanism is used to optionally store the virtual environment outside the project folder, until `uv` will [support](https://github.com/astral-sh/uv/issues/1495) this natively.

## Alternatives

Other common ways to reach the same goal:

* [just](https://just.systems/)
* [nox](https://nox.thea.codes/en/stable/cookbook.html)
* [make](https://www.gnu.org/software/make/)
* [invoke](https://www.pyinvoke.org/)
* [doit](https://pydoit.org/)
