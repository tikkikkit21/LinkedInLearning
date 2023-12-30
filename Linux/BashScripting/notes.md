# Learning Linux Shell Scripting
## Basics
### Hello World
```Bash
# hello.sh
echo Hello, World
```
- To run this file, we do `bash hello.sh`

### Permissions
- By default, new Bash scripts can't be run directly
- We have to give it executable permissions in order to directly run it
    - `chmod u+x myScript.sh`
    - Now we can run it like `./myScript.sh`

### Shebang
```Bash
#!/usr/bin/env bash
```
- The <u>shebang</u> must be the first line in the file
- Specifies which shell to use when running it
- Default shell in most Linux systems is Bash, so forgetting it isn't a big deal
    - Should still get in the habit of including it

### Variables
```Bash
NAME='Bob Roberts'
FAV_COLOR=blue

echo Hi $NAME, your favorite color is $FAV_COLOR
```
- Variable properties:
    - Must begin with letter or underscore
    - Number allowed except for first character
    - Case sensitive
    - Convention is all upper case
- No spaces between the `=`
- If a variable value has spaces, enclose in single or double quotes

### Parameters
```Bash
echo Hello $1
```
- Running it gives us:
    ```
    $ ./hello.sh Joe
    Hello Joe
    ```
- `$0` is name of file (path included), so we start with `$1`
- We usually only use parameters `$1-9`
    - That's because multi-digit parameters are only available in newer versions
      of Bash
    - We would do `${100}`

```Bash
USER=$1
echo Hello $USER
echo $(date)
echo $(pwd)

exit 0
```
- It's good practice to name the parameters before using them
    - Makes code a lot more readable
- When we want to run a command within `echo`, we wrap it with `$()`
- To check the return value of the program, we can run `echo $?` on the command
  line
    - Gives us the most recent exit code of any program
    - 0 means it's success, otherwise it's error
    - It'll return 0 by default if success, but it's a good idea to manually
      return it

## Branching and Loops
### Conditionals
```Bash
COLOR=$1
if [ $COLOR = "blue" ]
then
    echo "The color is blue"
else
    echo "The color isn't blue"
fi

USER_GUESS=$2
COMPUTER=50

if [ $USER_GUESS -lt $COMPUTER ]
then
    echo "You're too low"
elif [ $USER_GUESS -gt $COMPUTER ]
    echo "You're too high"
else
    echo "You've guessed it"
fi
```
- `fi` is used to end the whole `if` block
- Some comparison operators
    - `-eq` if equal
    - `-ne` if not equal
    - `-lt` if less than
    - `-gt` if greater than
    - `-le` if less than or equal
    - `-ge` if greater than or equal

### Loops
#### While
```Bash
COUNT=0

while [ $COUNT -lt 10 ]
do
    echo "Count = $COUNT"
    ((COUNT++))
done

echo "while loop finished"
exit 0
```

#### For
```Bash
NAMES=$@

for NAME in $NAMES
do
    echo "Hello $NAME"
done

echo "for loop finished"
exit 0
```
- The `$@` stores all passed arguments in an array
- We can use `break` and `continue` like usual

## Environment Variables
```Bash
echo "The PATH is: $PATH"
echo "The terminal is: $TERM"
echo "The editor is: $EDITOR"

# note that $EDITOR isn't always set and may return empty string
# '-z' is used to detect empty string
if [ -z $EDITOR ]
then
    echo "The EDITOR variable is not set"
fi

# we can also directly modify env variables
PATH="/bob"
```
- Note that changing env variables in script isn't permanent
    - It'll only affect the variables for the script
    - Once the script is done, the env variables are restored to original
- Common env variables
    - `$HOME` user's home directory
    - `$PATH` directories which are searched for commands
    - `$HOSTNAME` hostname of machine
    - `$SHELL` shell that is being used
    - `$USER` user of the session
    - `$TERM` type of command-line terminal that is being used

## Functions
### Basics
```Bash
function Hello() {
    echo "Hello"
}

Goodbye() {
    echo "Goodbye"
}

echo "Calling the Hello function"
Hello

echo "Calling the Goodbye function"
Goodbye
```
- 'function' keyword is optional
- Note that calling functions don't use parentheses
- Functions must be defined *before* they are called

### Function Parameters
```Bash
function Hello() {
    local LNAME=$1
    echo "Hello $LNAME"
}

Goodbye() {
    echo "Goodbye $1"
}

echo "Calling the Hello function"
Hello Tikki

echo "Calling the Goodbye function"
Goodbye Mike
```
- We can use function parameters the same way as file parameters
- Variables are defined on the global scope by default, so `local` keyword
  prevents that

### Piping
```Bash
# list, reverse, and then get first 3
FILES=`ls -1 | sort -r | head -3`
COUNT=1

for FILE in $FILES
do
    echo "File $COUNT = $FILE"
    ((COUNT++))
done
```
- Note that we're using backtick \`, not single quote '

## File Operations
### File I/O
```Bash
COUNT=1

while IFS='' read -r LINE
do
    echo "Line $COUNT: $LINE"
    ((COUNT++))
done < "$1"
```
- IFS is "internal field separator"
    - We set to empty string since we don't do anything with it
- `-r` does not allow escape characters
- The `< $1` pipes the argument as a file name as an input
- To write to files, you can just redirect the output to the file
    - `>` overwrites
    - `>>` appends

### Checksums
- `cksum [filename]` is a command to check the checksum of a file
    - Outputs a checksum, the size of file, and file name
    - Ex:
        ```
        $ cksum names.txt
        123456789 28 names.txt
        ```
- If a file has been changed, the checksum will be different 
- Restoring file to original state reverts back to the same checksum

## Sleep and Process
### Sleeping
```Bash
DELAY=$1

if [ -z $DELAY ]
then
    echo "You must supply a delay"
    exit 1
fi

echo "Going to sleep for $DELAY seconds"
sleep $DELAY
echo "We are awake now"
exit 0
```

### Watching a Process
```Bash
STATUS=0

if [ -z $1 ]
then
    echo "Please supply a PID"
    exit 1
fi

echo "Watching PID = $1"

while [ $STATUS -eq 0 ]
do
    ps $1 > /dev/null
    STATUS=$?
done

echo "Process $1 has terminated"
exit 0
```
- We try to send the PID to null
    - If it's still running, it'll fail
    - The latest return `#?` would be nonzero
- Once it's done, then it'll be successful
    - We then know the process is terminated

## Interactive Scripts
### Getting Input
```Bash
# using read won't give us an automatic newline like echo
read -p "What is your first name: " NAME
echo "Your name is $NAME"
```

### Handling Bad Data
```Bash
VALID=0

while [ $VALID -eq 0 ]
do
    read -p "Please enter name and age: " NAME AGE

    # make sure we got data
    if [[ ( -z $NAME) || ( -z $AGE) ]]
    then
        echo "Not enough parameters"
        continue
    # regex check 
    elif [[ ! $NAME =~ ^[A-Za-z]+$ ]]
    then
        echo "Non alpha characters detected [$NAME]"
        continue
    elif [[ ! $AGE =~ ^[0-9]+$ ]]
    then
        echo "Non digit characters detected [$AGE]"
        continue
    fi
    VALID=1
done

echo "Name = $NAME and Age = $AGE"
exit 0
```
