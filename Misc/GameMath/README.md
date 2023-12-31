# Game Development Foundations: Game-Related Math
https://www.linkedin.com/learning/game-development-foundations-game-related-math

## Layout
### Centering Objects
```js
// intuitive approach to horizontal centering
player.x = map.width / 2 - player.width - 2

// more optimal
player.x = map.x + (map.width - player.width) * 0.5

// vertical centering
player.y = map.y + (map.height - player.height) * 0.5
```
- This code assumes that `(x,y)` values correspond to top-left of entities
- Division is expensive in code, try to use add/subtract or multiplication
    - The first line works as well
    - However, this is not as optimal
- We should also account for map offsets
- This code will run the same no matter where the map is rendered

### Horizontal/Vertical Layout
```js
function drawBox(x, y, box) {
    // draws the box...
}
var box = redBox;
```
- This is a good technique when designing a UI that has repetition
    - Ex: row of buttons in menu

#### Horizontally-Aligned Boxes
```js
for (var i = 0; i < 5; i++) {
    var x = box.width * i;
    var y = 0;
    drawBox(x, y, box);
}
```

#### Add Padding
```js
var padding = 5;
for (var i = 0; i < 5; i++) {
    var x = (box.width + padding) * i;
    var y = 0;
    drawBox(x, y, box);
}
```

#### Add Offset
```js
var startX = 5;
var startY = 5;
for (var i = 0; i < 5; i++) {
    var x = startX + (box.width + padding) * i;
    var y = startY;
    drawBox(x, y, box);
}
```

#### Vertically-Aligned Boxes
```js
for (var i = 0; i < 5; i++) {
    var x = startX;
    var y = startY + (box.height + padding) * i;
    drawBox(x, y, box);
}
```
- Swap `x` and `y` code

### Grid Layout
```js
var columns = 10;
var rows = 10;
var total = columns * rows;
var padding = 5;
var column = 0;
var row = 0;

for (var i = 0; i < total; i++) {
    var x = (box.width + padding) * column;
    var y = (box.height + padding) * row;
    drawBox(x, y, box);
    column++;

    if (column >= columns) {
        row++;
        column = 0;
    }
}
```
- Good technique for tile maps or grid inventories
- Can apply offsets like we did in the previous 2 sections
- Padding is optional
    - Ideal for grid UIs
    - Not ideal for tile maps

## Collision
### Point Collisions
```js
function contains(target, x, y) {
    return (
        x >= target.x &&
        x <= target.x + target.width &&
        y >= target.y &&
        y <= target.y + target.height
    );
}
```
- Returns true if a point is inside the target or not
- This assumes that the object is rectangular

### Rectangle Collisions
```js
function contains(collisionBounds, target) {
    return (
        target.x + target.width >= collisionBounds.x &&
        target.x <= collisionBounds.x + collisionBounds.width &&
        target.y + target.height >= collisionBounds.y &&
        target.y <= collisionBounds.y + collisionBounds.height
    );
}
```

### Distance Between 2 Objects
```js
var xd = 0;
var yd = 0;
function distanceTo(targetA, targetB) {
    xd = targetA.x - targetB.x;
    yd = targetA.y - targetB.y;

    return Math.sqrt(xd * xd + yd * yd);
}
```
- This assumes that `(x,y)` corresponds to the center of objects
- Note that `sqrt` is an expensive operation
    - Good practice is to only calculate distance for objects within the screen
    - If it's outside of render distance, it's easier to detect it and not
      calculate the distance

## Formulas
### Healthbar and Percentages
```js
var maxHealth = 10;
var health = maxHealth;

var ratio = health / maxHealth;
var percent = ratio * 100;

var fillWidth = healthBar.width * ratio;
```

### EXP Calculator
```js
function calculateNextLevelExp(level, multiplier) {
    // linear
    var requirement = level * multiplier;
    
    // exponential
    var requirement = (level * level) * multiplier;
    
    // adjusted
    var requirement = (level * (level + 1)) * multiplier
    
    return requirement;
}
```
- There are many ways to scale exp
    - Linear is simple, but easy
    - We want exp requirements to get harder the higher they are
- Can tweak this to your preferences

### Linear Tween
```js
function linearTween(time, start, change, duration) {
    return change * time / duration + start;
}

function updatePosition() {
    var currentTime = 1000 / fps;
    var duration = 500;

    var startPos = box.x;
    var changeInPos = targetX - box.x;
    box.x = linearTween(currentTime, startPos, changeInPos, duration);

    startPos = box.y;
    changeInPos = targetY - box.y;
    box.y = linearTween(currentTime, startPos, changeInPos, duration);
}
```
- "Tween" is a way to move objects across the screen
- A smooth animation for objects to transition between places
- Moves really fast to the desired location and then slows down as it gets
  closer
    - A "slow down" effect
