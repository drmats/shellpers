# [git](https://git-scm.com/) stuff

## rewrite history (change author info)
```bash
#!/bin/sh

# https://help.github.com/articles/changing-author-info/

git filter-branch --env-filter '
OLD_EMAIL="your-old-email@example.com"
CORRECT_NAME="Your Correct Name"
CORRECT_EMAIL="your-correct-email@example.com"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
```

```
$ git clone --bare git@github.com:user/repo.git
$ cd repo.git

-- paste script --

$ git push --force --tags origin 'refs/heads/*'
```

## GPG sign all commits and tags in the history
```
$ git filter-branch -f --commit-filter 'git commit-tree -S "$@";' -- --all
```

## GPG sign all commits and tags in the history on all branches
```
$ git filter-branch -f --commit-filter 'git commit-tree -S "$@";' --tag-name-filter cat -- --branches --tags
```

## delete branches
```
$ git branch -d branch_name
$ git push -d origin branch_name
$ git remote prune origin
```

## delete tags
```
git push --delete origin tagname
git tag --delete tagname
```

## replace `master` with `other_branch`
```
$ git branch -f master other_branch
```

## rename signed tag
```
$ git tag -s newtag oldtag^{}
$ git tag -d oldtag
$ git push origin :refs/tags/oldtag
$ git push --tags
$ git pull --prune --tags
```
