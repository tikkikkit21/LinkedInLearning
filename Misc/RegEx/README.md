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
    - `g`lobal - find every match
    - case `i`nsensitive - don't care about letter cases
    - `m`ultiline - match text that stretches over multiple lines
    - `u`nicode - support unicode search
    - stick`y`
