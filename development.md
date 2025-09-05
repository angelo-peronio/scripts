# Development notes for `scripts`

## Next steps

* Use `uv run`
* Use `.env` file to set `UV_PROJECT_ENVIRONMENT`
* README
    * Setup (copy, checkout one file, submodule)
    * Scripts list
* `-OutsideProjectFolder` for `Install-PreCommit`. How to centralize `VenvsRootFolder`?
* Test `Release-Package` and `Build-Package` for this project.
* Dry run option for `Release-Package`
* CI: run scripts
* Document `uv.lock` in `.gitignore`

## Notes

* An additional task runner would maybe help. Note that:
    * I do not want to have to install something else, apart `uv`.
    * We are already using `nox` for tests.
    * Maybe document standard tasks in `development.md`
