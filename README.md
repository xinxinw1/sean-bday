# Common Lisp Sean System

## Dependencies

The command line interface and shell scripts currently only works with the Common Lisp distribution SBCL (Steel Bank Common Lisp).

## Download

Install [Steel Bank Common Lisp](http://www.sbcl.org/).

`git clone https://github.com/xinxinw1/sean-bday.git`  
`cd sean-bday`

## Compile

`./compile` This will make a file `sean` in the current directory.

### Encode

`./sean -e $'<message>'`

`$'<message>'` is the Bash string escape syntax so you can include special characters like `!`, `'`, or `"`, for example `$'What\'s that "thing"!!??'`.

### Decode

`./sean -d "<puzzle message>"`

### ASCII Encode only

`./sean --encode $'<message>'`

### ASCII Decode only

`./sean --decode <ascii message>`

## Run tests

`./run-tests`

## Open Lisp REPL (Read-eval-print loop) with everything loaded

`./repl`
