# bash recipes


## execute command for every output line
```bash
$ command-outputting-some-lines | while read -r line; do some-command "$line"; done
```


## functions
* first format
    ```bash
    function_name () {
        commands
    }
    ```
* second format
    ```bash
    function function_name {
        commands
    }
    ```
* local variables - use keyword `local`
    ```bash
    some_function () {
        local variable='X'
    }
    ```
* returning values - through `exit status`, `global variable` or `stdout`
    ```bash
    my_function () {
        local result="local twelve"
        echo "$result"
        my_function_return="twelve"
        return 12
    }

    fun_result="$(my_function)"
    echo $?
    echo $my_function_result
    echo $fun_result
    ```


## script/function variables
* `$0` - script/function name
* `$1`, `$2`, ... - script/function positional parameters
* `$#` - number of positional parameters passed to a script/function
* `$*`, `$@` - all positional parameters passed to a script/function
    - `"$*"` - expands to `"$1 $2 ... $n"`
    - `"$@"` - expands to `"$1" "$2" ... "$n"`
* `$?` - exit status of previous command
