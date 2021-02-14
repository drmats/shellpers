# bash cheatsheet


## conditionals
* `if`
    ```bash
    if test-expression
    then
        statements
    fi
    ```
* `if`-`else`
    ```bash
    if test-expression
    then
        statements
    elif test-command
    then
        statements
    else
        statements
    fi
    ```
* `case`
    ```bash
    case expression in
        pattern_1)
            statements
            ;;
        pattern_2)
            statements
            ;;
        pattern_n)
            statements
            ;;
        *)
            statements
            ;;
    esac
    ```


## tests
* `test EXPRESSION`
* `[ EXPRESSION ]`
* `[[ EXPRESSION ]]`


## test operators
* `string1 = string2` within `[ ... ]`
* `string1 == string2` within `[[ ... ]]`
* `string1 != string2`
* `string1 =~ regex`
* `string1 > string2`
* `string1 < string2`
* `-z string` - string length is zero
* `-n string` - string length is non-zero
* `integer1 -eq integer2` - equal
* `integer1 -gt integer2` - greater than
* `integer1 -lt integer2` - less than
* `integer1 -ge integer2` - greater or equal
* `integer1 -le integer2` - less or equal
* `-h file` - exists and is a symbolic link
* `-r file` - exists and is readable
* `-w file` - exists and is writable
* `-x file` - exists and is executable
* `-d file` - exists and is a directory
* `-e file` - exists
* `-f file` - exists and is a regular file (not a directory or device)


## functions
* first format
    ```bash
    function_name () {
        statements
    }
    ```
* second format
    ```bash
    function function_name {
        statements
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
* `$!` - PID of the last background job

<br />


# bash recipes


## execute command for every output line
```bash
$ command-outputting-some-lines | while read -r line; do some-command "$line"; done
```
