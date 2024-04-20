# Unity 5: 2D Essential Training
https://www.linkedin.com/learning/unity-5-2d-essential-training

## Sprites
### Cutting Sprite Sheets
- A <u>sprite</u> is a piece of artwork/image that's displayed on screen
- Usually stored in the `Artwork/sprites` folder
- <u>Sprite sheets</u> contain multiple sprites, usually of the same object
    - Saves memory and is more organized
    - Usually a sprite sheet corresponds to a single asset in the game
- The <u>scene</u> is like the main screen for the game
    - Kind of like the background or foundation
- Each square in the scene grid is called a <u>unit</u>
    - Good idea to make sprite units 1 pixel-per-unit
    - Easier to visualize and manipulate
- To cut up a sprite sheet, we can use Unity's *Sprite Editor*
    - Found in the *Inspector* tab when you select a sheet
    - Use the `Slice` option
- When slicing, it's important to add some padding between sprites
    - Prevents "bleed"
    - When a sprite's edge pixels show up in another
    - Results in random lines or glitchy display

### Optimizing Loose Sprites
- Sometimes games can have loose sprites
- Having each sprite take up an asset can be resource consuming
- A good optimization way is to use a sprite packer

*note: LiL course suggested an outdated solution so I researched my own*

- Newer versions of Unity uses the *Sprite Atlas*
    - Create one with `Assets > Create > 2D > Sprite Atlas`
    - Select the sprites you want to include or the whole folder
- The concept is that it combines all the different sprites into one texture
    - All the loose sprites become one asset
    - Displaying a different "object" just displays the different sprite
- This can result in exponential savings the more assets and sprites we have

### Pixel Perfect Camera
- See `PixelPerfectCamera.cs`
- Recall that we want to set 1 grid square = 1 pixel
- This can result in different zoom levels based on device screen size and
  resolution
- We can create a script that can automatically resizes the camera zoom level
- Some notes
    - The `Start()` function is called at beginning of game
    - The `Update()` function is called once every frame
    - Any public class members will show up as a parameter when using the script
- We can drag this script into the `Main Camera` in the hierarchy
    - Note that this script only runs at the start of a game
    - Changing resolution in the middle won't auto resize

## Repeating Textures
### Textures
- <u>Textures</u> can be repeated for a pixel background
- Create one with `GameObject > 3D Object > Quad`
- Although a *Quad* is a 3D object, they're useful for 2D background textures
    - Easy to apply and scale textures
- A *Quad* has a `z` property that can be useful
    - Technically don't need it since we're working with 2D
    - However, it can be useful for layering with other objects
- We need a <u>material</u> to apply texture to the quad
    - Stored in `Assets/Textures`
- We create one as a new *Material* file
    - In the Inspector, we can select the texture we want
    - Then drag the material/texture file onto the quad and texture will be applied

### Resizing Textures
- See `TiledBackground.cs`
- We can resize our quad to fill up the screen
- However, this just makes a single texture really big
- We can go into our texture file and changing the `tiling` properties
    - This determines how many times the tiles repeat in order to reach the
      desired size
- Instead of manually doing this for each resolution, we can make another 
  script

### Animate Scrolling Background
- See `AnimatedTexture.cs`
- We can use the offset to make it look like the background is scrolling by
    - Player is technically standing still
    - Scrolling background makes it look like it's moving

### Emulate Parallax Scrolling
- Can remove the *Mesh Collider* from the background *quad*
    - Used in 3D, not needed
- <u>Parallax scrolling</u> is a concept to add depth perception
    - The foreground scrolls by faster than the background
- We can do this by changing the speed parameter to the `AnimatedTexture.cs`
  script
    - Set the foreground speed to be a little faster than background

## Obstacles
### Reusable Obstacle Game Object
- A <u>spawner</u> creates assets on the screen
    - Uses the (0,0) coord of a sprite to position it
- The corresponding sprite property is `pivot`
    - Determines where the sprite's (0,0) is located
    - In a runner game, we want to set it to bottom so we can ensure each 
      different sprite spawns flush to the floor
- To apply physics to our obstacle, we add a component called *Rigidbody 2D*
    - Allows it to be an unmovable force
    - Freeze rotation
    - When our player hits it, it'll be pushed off screen
- Remember that the `z` value for position determines layering
    - The smaller it is, the nearer it is (includes negative numbers)
    - Set floor `z=1` so obstacles can be in front of floor
- A <u>prefab</u> is a re-usable game object
    - Configured in scene or folder
    - Used by spawners
    - Files in a `Prefab` folder

### Moving Obstacles
- See `InstantVelocity.cs`
- We add a *Boxcollider 2D* component to our obstacles
    - Handles collision logic
    - Interacts with other colliders in the game, like one on the player
- We can use a script to move object across screen
- The `FixedUpdate()` function is called a certain number of times
    - More efficient than `Update()`
- We can set the collider's `interpolate` property to "interpolate"
    - Smooths the refresh rate on the object
    - Makes it less "jittery"

### Spawn New Obstacles
- A <u>spawner</u> uses a timer to create new objects in time intervals
- Also requires a script
- Spawners use handy dandy coroutines

### Random Spawner Delay Times
- We can nest objects inside others
    - Or use empty game objects purely as "folders"
    - Helps organize the hierarchy view
- Adding randomness helps make the game more interesting and unpredictable

### Destroy Objects Offscreen
- See `DestroyOffscreen.cs`
- It's a good idea to destroy objects once they go offscreen
- Saves memory and resources
- However, it's more efficient to reuse game objects
    - This is the concept of object pooling

## Object Pooling
- See `GameObjectUtil.cs`
- Creating and destroying objects is wasteful
- We want to recycle objects through reconfiguration
- We can use a util script to do this
    - We create the helper methods as static
    - That way we can call `Class.Method()` without needing to create an actual
      instance of the class
- We then use our util functions instead of the default `GameObject` ones

### Recycling
- See `RecycleGameObject.cs`
- This script is used to indicate whether to recycle an object or not
- Before we destroy and object, check if it has a recycle script
    - If so, we shutdown instead of destroy

### Build Object Pool
- See `ObjectPool.cs`
- An <u>object pool</u> manages the objects it creates
    - Also manage whether objects are active or inactive
- If we request an object to be created, the pool will first find an inactive
  object to use
    - If there aren't any, it'll create a new one
- This is a dynamic pool
    - Not all pools dynamically scale
    - Sometimes you want a pool with fixed number of objects

### Wire Up Object Pool
- We use a dictionary to manage our prefabs
    - We create this as a private static in `GameObjectUtil`
- We modify the `GameObjectUtil.cs` script to utilize the pool

### Make Obstacles Recyclable
- In our `ObjectPool.cs`, we need to implement recycling
- We use the `activeSelf` property, which indicates if it's been deactivated
- When an object is requested, see if there's an inactive object available first
    - Otherwise, we create a new one
