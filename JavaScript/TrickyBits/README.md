# JavaScript: The Tricky Bits
https://www.linkedin.com/learning/javascript-the-tricky-bits

## Loops
### Sequental `for`
```js
for (var i = 0; i < array.length; i++) {
    // do something
}

```
- Basic `for` loops have a bunch of little decision points
    - What to name counter variable
    - What's the scope of counter variable
    - Do I directly access a member or do I rename it to something first
- Gets even more complicated for nested `for` loops

```js
for (member of array) {
    // do something
}

array.forEach(member => {
    // do something
});

array.forEach((member, index) => {
    // do something
});

band.every(member => {
    // do something
    return true;
})
```
- Enhanced `for`, `forEach`, and `every` are 3 better alternatives
- `forEach` has an optional `index` variable
    - Can help keep track where we are in the loop
    - Operates on every item
- `every` only continues to the next element if the previous callback returned
  true
    - Allows us to stop the loop in the middle
- Note that these are all for arrays specifically
