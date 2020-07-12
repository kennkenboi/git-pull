<div align="center">

# SSH GIT PULL Deploy

[![ForTheBadge built-with-love](http://ForTheBadge.com/images/badges/built-with-love.svg)](https://twitter.com/kenboi_)

</div>


## Config example:

```
name: Build and Deploy
on:
    push:
        branches:
            -   master

jobs:
    build:
        name: Build and Deploy
        runs-on: ubuntu-latest
        steps:
            -   name: Pull Code
                uses: kennkenboi/git-pull@v1
                env:
                    DEPLOY_KEY: ${{ secrets.DEPLOY_KEY }}
                    DEPLOY_USER: ${{ secrets.DEPLOY_USER }}
                    DEPLOY_HOST: ${{ secrets.DEPLOY_HOST }}
                    DEPLOY_PATH: ${{ secrets.DEPLOY_PATH }}
```
