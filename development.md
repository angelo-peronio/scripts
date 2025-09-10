# Development notes for `scripts`

## As a git submodule

Instead of copying, you can include the `scripts` repository as a submodule of your project. On Windows:

* Enable developer mode to be able to create symbolic links without administrative rights.
* Enable symbolic links in git:

    ```pwsh
    git config core.symlinks true
    ```

* Add `scripts` as a submodule:

    ```pwsh
    git submodule add https://github.com/angelo-peronio/scripts.git submodules/scripts
    New-Item -ItemType SymbolicLink -Path scripts -Target .\submodules\scripts\scripts\
    ```

* Remember to clone your project with `git clone --recurse`
* It still does not work, for this [reason](https://stackoverflow.com/questions/5917249/git-symbolic-links-in-windows/59761201#comment136888044_59761201).

## Later

* Release
* GitHub release with zip archive from CI
