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

### Other Special Characters
- Spaces are just a normal space character
- Tabs are `\t`
- Line returns are `\r`, `\n`, or `\r\n`
    - `\r` is line return
    - `\n` is new line
    - Pretty much the same, just depends on OS

## Character Sets
### Define a Character Set
- A character set is like a more limited wildcard
- Denoted with square brackets `[]`
- Any letter in the set can be matched
    - But only 1 letter
- Order of characters don't matter
- Case sensitive
- Examples
    - `/[aeiou]/` matches any vowel
    - `/gr[ea]y/` matches "gray" or "grey"
    - `/gr[ea]t/` doesn't match "great"
- Not restricted to only letters
    - Can also use numbers or punctuation

### Character Ranges
- Character ranges are shorthand for character sets for:
    - Numbers
    - Lowercase letters
    - Uppercase letters
- Uses the hyphen `-` to include all ranges between the 2 characters
- Note that its special only within a character set
    - Outside of a set, it's treated as a literal hyphen
- Examples:
    - `/[0-9]/` matches any number
    - `/[A-Za-z]/` matches any letter, regardless of case
- Remember that it's a *character* range
    - Ex: `/[50-99]/` won't find numbers from 50 to 99

### Negative Character Sets
- The carat `^` negates an entire character set
    - Everything within the brackets
    - Even if there's multiple ranges like `/[^A-Za-z]/`
- Not any one of the several characters
- Ex: `/[^aeiou]/` matches constants only
- Remember that it's still looking for a character
    - `/see[^mn]/` won't find "see"

### Metacharacters Inside Character Sets
- By default, most metacharacters are automatically escaped in character sets
    - Ex: `/h[a.]t/` matches "hat" and "h.t", but not "hot"
- Some exceptions that need to be explicitly escaped
    - `]` because it ends the set
    - `-` because it's used for ranges
    - `^` because it's used for negation
    - `\` because it's the escape character

### Shorthand Character Sets
| Shorthand | Meaning            | Equivalent      |
| --------- | ------------------ | --------------- |
| `\d`      | digit              | `[0-9]`         |
| `\w`      | word character     | `[a-zA-Z0-9_]`  |
| `\s`      | whitespace         | `[\t\r\n]`      |
| `\D`      | not digit          | `^[0-9]`        |
| `\W`      | not word character | `^[a-zA-Z0-9_]` |
| `\S`      | not whitespace     | `^[\t\r\n]`     |

- These shorthand symbols are useful for common character sets/ranges
- Not all engines will support these
    - Most should though
    - Only older engines shouldn't support
- Note that `\w` includes the underscore `_`
    - "Word character" is more in the programming sense
    - Underscores are common when it comes to code and filenames
    - Hyphen is not included, even though it's a common character we see in
      normal text (like a book)
    - We can use `/[\w\-]/` to include hyphen
- `/[^\d\s/]` is not the same as `[\D\S]`
    - First is not digit or space character
    - Second is either not digit or not space

## Repetition
### Repetition Metacharacters
- There are 3 special metacharacters for repeated patterns
    - `*` 0 or more times
    - `+` 1 or more times
    - `?` 0 or 1 time
- Examples
    - `/Good .+/` matches "Good morning...", "Good evening...", "Good day..."
    - `/[a-z]+ed/` matches any word ending in "ed"
- Comparison chart:

| RegEx       | "apple" | "apples" | "applesssss" |
| ----------- | ------- | -------- | ------------ |
| `/apples*/` | ✅       | ✅        | ✅            |
| `/apples+/` | ❌       | ✅        | ✅            |
| `/apples?/` | ✅       | ✅        | ❌            |

- Sometimes `*` and `+` can be used interchangeable
    - `/\d\d\d+/`
    - `/\d\d\d\d*/`
    - These 2 patterns are the same: 3 numbers or more

### Quantified Repetition
- Sometimes, we want to repeat a specific amount
- We can use `{min,max}` with numbers to indicate number of repetitions
    - Specifies the min and max amount of reptitions allowed
- Use cases
    - `/\d{4,8}/` 4-8 digits
    - `/\d{4}/` exactly 4 digits
    - `/\d{4,}/` at least 4 digits
- Equivalent cases
    - `/\d{0,}/` is the same as `/\d*/` 
    - `/\d{1,}/` is the same as `/\d+/` 

### Greedy Expressions
- Suppose we have a string `"123abc456def789"`
- Now we have a regex `/\d+\w+\d+/`
    - Looks for some numbers, some word characters, then some more numbers
- What will be returned?
    - "123abc456"
    - "123abc456def789"
    - Both strings fit the regex pattern
- Standard repetition quantifiers are greedy
    - Looks for the longest possible string
- However, it doesn't always return the longest possible string
- Each sub-expression tries to match as much as possible before handing it off
  to the next sub-expression
- Ex: `/.*[0-9]+/` with "Page 266"
    - `.*` will match "Page 26"
    - `[0-9]+` only matches the "6" at the end

### Lazy Expressions
- When `?` is applied to a quantifier, it changes it to being lazy
    - `*?`, `+?`, `{min,max}?`, `??`
- Makes it the opposite of greedy
    - Tries to match as little as possible before moving on
- Ex: `/.*?[0-9]+/` with "Page 266"
    - `.*?` matches "Page "
    - `[0-9]+` matches "266"
- Useful for matching shorter possible strings
