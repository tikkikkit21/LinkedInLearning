# Learning Regular Expressions
https://www.linkedin.com/learning/learning-regular-expressions-15586553/

## Getting Started
### Intro
- Regular expressions are symbols that represent a text pattern
- Used for matching, searching, and replacing text
- Uses
    - Check if email has proper format
    - Search for all instances of either "color" or "colour"
    - Replace "Bob", "Bobby", and "B" with "Robert"
- Text and a regex pattern *match* if the pattern correctly describes the text
- By default, regex only finds the first match
- Regex moves from left to right
    - Goes through every letter of the text to compare with test string
    - Suppose we have "caramel" and we're looking for `/cat/`
    - After "ca", "r" no longer matches
    - Instead of continuing, it'll backtrack to "a"

### Engines
- Regex are evaluated by an engine
    - Different engines usually support the same core features
    - However, they might have a few subtle differences between them
- A good free online regex engine is https://regexr.com/

### Notation
- Regex are usually written inside 2 forward slashes
    - Ex: `/abc/`
    - This is the common syntax for indicating a string is regex
- Not all engines will require the forward slashes
    - Some lets you type the actual expression without slashes
- We can add flags to an expressions that changes the mode of the regex
    - Appended to the end of the expression
    - Ex: `/abc/g`
    - `g` is a flag that's added
- Flag options
    - `g`lobal - find every match, not just the first
    - case `i`nsensitive - don't care about letter cases
    - `m`ultiline - match text that stretches over multiple lines
    - `u`nicode - support unicode search
    - stick`y`

## Characters
### Literal Characters
- Normal letters in regex will match literal character sequences in text
- `/car/` matches "car"
    - Doesn't have to be the whole word
    - Pattern will match the first 3 letters in "carnival"
- Similar to ctrl+f in a word document
- Case-sensitive by default
    - Won't match "Carnival"
    - We can use `/car/i` to match both

### Metacharacters
- A metacharacter is something that has special meaning
    - If it's not a literal, it's a meta
    - Transforms literals into more powerful expressions
    - Can have multiple meanings
- Some examples:
    - `{}`
    - `()`
    - `?`
    - `!`

### Wildcard Metacharacters
- `.` is the wildcard metacharacter
    - Matches any character except for newline
    - Only matches one single character
- Ex: `/h.t/`
    - Matches "hat", "hot", "hit"
    - Doesn't match "heat"
- Broadest metacharacter
    - Use with caution
    - If a more specific metacharacter does the job, use that instead

### Escaping Metacharacters
- `/` is the escape character
- One problem with metacharacters is if we're trying to actually find them in the text
    - Ex: we want to find strings with periods in them
    - However, the period is the wildcard
- We can use the escape character to treat the metacharacter as a literal
    - `/9.00/` finds "9.00", "9-00", "9000"
    - `/9\.00` finds only "9.00"
- You can escape escape characters with a double backslash `\\`
- Escaping is only for metacharacters
    - Don't escape literals
