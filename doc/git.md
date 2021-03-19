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
* single
    ```
    $ git push --delete origin tagname
    $ git tag --delete tagname
    ```
* all
    ```
    $ git tag | while read -r line; do git tag --delete "$line"; done
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

## undo the last commit
* leave changes unstaged:
    ```
    $ git reset --soft HEAD~1
    ```
* discard changes:
    ```
    $ git reset --hard HEAD~1
    ```

## remotes
* add remote
    ```
    $ git remote add [name] [repo-url]
    ```

* set upstream remote branch of different name than local branch
    ```
    $ git push -u [remote-name] [local-branch]:[remote-branch]
    ```

* non-destructively test pushes
    ```
    $ git push ... --dry-run
    ```


## print all tag 'headlines'
* simple
    ```
    $ git tag -n1
    ```

* sorted, unique
    ```
    $ git tag -n1 | awk '{$1=""; print $0;}' | sort | uniq
    ```


## merging

* "normal" merge
    ```
    $ git merge their_branch
    ```

* merge which accepts incoming (their) changes on conflicts
    ```
    $ git merge -s recursive -X theirs their_branch
    ```

* merge which favors current (our) changes on conflicts
    ```
    $ git merge -s recursive -X ours their_branch
    ```

* don't make new merge commit automatically
    ```
    $ git merge --no-commit their_branch
    ```

* continue current merge
    ```
    $ git merge --continue
    ```

* aborting current merge
    ```
    $ git merge --abort
    ```
