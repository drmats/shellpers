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

<br />


## `while` loop

* basic form
    ```bash
    while condition
    do
        statements
    done
    ```

* basic example
    ```bash
    i=0
    while [ $i -lt 10 ]; do
        echo iteration: $i
        ((i++))
    done
    ```

* infinite loop example
    ```bash
    while :
    do
        echo "press <ctrl+c> to exit."
        sleep 1
    done
    ```

* read file line-by-line example (`IFS=` prevents line trimming,
    `-r` for `read` prevents interpreting `\` as escape character)
    ```bash
    file=~/.bash_history
    while IFS= read -r line; do
        echo $line
    done < "$file"
    ```

* `break` and `continue` works as expected
    ```bash
    i=0
    while :; do
        echo "iteration: $i"
        if [[ "$i" == "4" ]]; then
            break
        fi
        ((i++))
    done
    echo "Done."
    ```

<br />


## `for` loop

* basic form
    ```bash
    for item in list
    do
        statements
    done
    ```

* basic example
    ```bash
    for planet in Mercury Venus Earth Mars
    do
        echo "Planet: $planet"
    done
    ```

* c-style form
    ```bash
    for ((initialization; test-expression; step))
    do
        statements
    done
    ```

* c-style example
    ```bash
    for ((i = 0; i <= 100; i++)); do
        echo "Counter: $i"
    done
    ```

* number range loop
    ```bash
    for i in {0..5}; do
        echo "$i"
    done
    ```

* number range loop with custom increment
    ```bash
    for i in {0..10..2}; do
        echo "$i"
    done
    ```

* loop over array
    ```bash
    declare -a my_array=( "Wing" "Harness" "Reserve" "Helmet" "Vario" )
    for i in "${my_array[@]}"; do
        echo "$i"
    done
    ```

<br />


## `until` loop

* basic form
    ```bash
    until condition
    do
        statements
    done
    ```

<br />


## tests

* `test EXPRESSION`
* `[ EXPRESSION ]`
* `[[ EXPRESSION ]]`

<br />


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

<br />


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
        local variable="x"
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

<br />


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
$ command-outputting-some-lines | while IFS= read -r line; do some-command "$line"; done
```


## iterate over files in current directory
```bash
$ for file in *; do some-command "$file"; done
```
