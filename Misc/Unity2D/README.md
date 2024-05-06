# Unity 5: 2D Essential Training
https://www.linkedin.com/learning/unity-5-2d-essential-training

## Working With Sprites
### Cut Up Sprites
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
- Things to change for sprites
    - Set pixels per unit to 1
    - Change filter mode to `Point`

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
    - Efficient and easy to use
- A *Quad* has a `z` property that can be useful
    - Technically don't need it since we're working with 2D
    - However, it can be useful for layering with other objects
- We need a <u>material</u> to apply texture to the quad
    - Stored in a `Materials` folder
- We create one as a new *Material* file
    - In the Inspector, we can select the texture we want
    - Use `Mobile/Particles/Alpha Blended` as the shader
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
    - Scrolling background makes it look like our player is moving

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
    - Set body type to *Kinematic*
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
- We can set the collider's `interpolate` property to *interpolate*
    - Smooths the refresh rate on the object
    - Makes it less "jittery"

### Spawn New Obstacles
- See `Spawner.cs`
- A <u>spawner</u> uses a timer to create new objects in time intervals
- Also requires a script
- Spawners use handy dandy coroutines

### Random Spawner Delay Times
- We can nest objects inside others
    - Or use empty game objects purely as "folders"
    - Helps organize the hierarchy view
- Adding randomness helps make the game more interesting and unpredictable
    ```c#
    public Vector2 delayRange = new Vector2(1, 2);

    // ...

    void ResetDelay()
    {
        delay = UnityEngine.Random.Range(delayRange.x, delayRange.y);
    }
    ```
    - We use `delayRange` to specify min and max values of time ranges
    - The `ResetDelay()` function generates a new random delay time

### Destroy Objects Offscreen
- See `DestroyOffscreen.cs`
- It's a good idea to destroy objects once they go offscreen
- Saves memory and resources
- However, it's more efficient to reuse game objects
    - This will be the concept of object pooling

## Object Pooling
- See `GameObjectUtil.cs`
    - Doesn't extend `MonoBehavior`
    - This is just a plain C# class
- Creating and destroying objects is wasteful
- We want to recycle objects through reconfiguration
- We can use a util script to do this
    - We create the helper methods as static
    - That way we can call `Class.Method()` without needing to create an actual
      instance of the class
- We then use the util functions in our scripts instead of the default
  `GameObject` ones
    - Ex: use `GameObjectUtil.Instantiate()` instead of plain `Instantiate()`

### Recycle Game Objects
- See `RecycleGameObject.cs`
- This script is used to indicate whether to recycle an object or not
- Before we destroy and object, check if it has a recycle script
    - If so, we shutdown instead of destroy
- Unity prefers composition over inheritance
    - Everything is broken down into tiny modular scripts

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
    ```c#
    private static Dictionary<RecycleGameObject, ObjectPool> pools = new Dictionary<RecycleGameObject, ObjectPool>();
    ```
    - We create a dictionary to manage the objects in our pool
    - It's static since we only need 1
- We then create a helper function to find objects to use
    ```c#
    private static ObjectPool GetObjectPool(RecycleGameObject reference)
    {
        ObjectPool pool;
        if (pools.ContainsKey(reference))
        {
            pool = pools[reference];
        }
        else
        {
            var poolContainer = new GameObject(reference.gameObject.name + "ObjectPool");
            pool = poolContainer.AddComponent<ObjectPool>();
            pool.prefab = reference;
            pools.Add(reference, pool);
        }

        return pool;
    }
    ```
- Also modify `Instantiate()` to utilize our pool
    ```c#
    public static GameObject Instantiate(GameObject prefab, Vector3 pos)
    {
        GameObject instance;
        var recycledScript = prefab.GetComponent<RecycleGameObject>();
        if (recycledScript != null)
        {
            var pool = GetObjectPool(recycledScript);
            instance = pool.NextObject(pos).gameObject;
        }
        else
        {
            instance = GameObject.Instantiate(prefab);
            instance.transform.position = pos;
        }

        return instance;
    }
    ```

### Make Obstacles Recyclable
- In our `ObjectPool.cs`, we need to implement recycling
- Update the `NextObject()` function to use the pool
    ```c#
    foreach (var go in poolInstances)
    {
        if (go.gameObject.activeSelf == false)
        {
            instance = go;
            instance.transform.position = pos;
        }
    }
    ```
    - We use the `activeSelf` property, which indicates if it's been deactivated
    - When an object is requested, see if there's an inactive object available
      first
    - Otherwise, we create a new one

### Implement Recycle in Any Script
- We use an interface in `RecycleGameObject.cs` so other scripts can use restart/shutdown
    ```c#
    public interface IRecycle
    {
        void Restart();
        void Shutdown();
    }
    ```
- Other scripts can implement this interface
- When our recycle script needs to restart/shutdown, we can tell it what other
  scripts it needs to restart/shutdown as well

### Clean Up Obstacles
- See `Obstacle.cs`
- We will now recycle obstacle objects to display different sprites
- Our script implements the `IRecycle` interface
    - This means we *have to* implement `Restart()` and `Shutdown()`
- Note that we don't use lifecycle methods (`Awake`, `Start`, etc.)
    - We rely on `IRecycle`'s lifecycle methods
- A tip in unity is to use the lock icon in the *Inspector*
    - This allows us to lock in the particular view
    - We can navigate to other objects without the inspector changing

### Resize Box Colliders
- In our `Obstacle.cs` script, we can resize the collider to sprite size
    ```c#
    var collider = GetComponent<BoxCollider2D>();
    collider.size = renderer.bounds.size;
    ```
- We'll also need to adjust the offset
    ```c#
    public Vector2 colliderOffset = Vector2.zero;

    public void Restart()
    {
        // ...
        var collider = GetComponent<BoxCollider2D>();
        var size = renderer.bounds.size;
        size.y += colliderOffset.y;
        collider.size = size;
        collider.offset = new Vector2(-colliderOffset.x, collider.size.y / 2 - colliderOffset.y);
    }
    ```

## Creating the Player
### Build the Player
- If we select multiple sprites from the sprite sheets and drag onto the scene,
  the game will automatically create an animation for us
- Put these in an `Assets/Animations` folder
- Add a *BoxCollider2D* and *RigidBody2D* to the player component
    - Box collider will need to be resized to the main body
    - Set gravity of rigid body to 60
- We'll also need to add a *BoxCollider2D* to the floor
    - This creates the actual gravity effect
    - Prevents player from sinking to the ground

### Detect When Player is Standing
- See `InputState.cs`
- We use this script to detect when a player is standing on the floor
    - Helps with jump logic later

### Make Player Jump
- See `Jump.cs`
- Good practice to break down actions into their own individual little script
    - More reusable and easier to debug

### Add Idle Animation
- To create a new animation, we can use Unity's animation windows
    - `Window > Animation > Animation`
    - `Window > Animation > Animator`
- With the panel open, clicking on the player will reveal the animation states
    - *Entry*: beginning of the animation
    - *PlayerRunAnimation*: this is the animation we created
    - *Any State*: transitions between states regardless of where we came from
- In the *Animation* panel, we can click the animation dropdown to create a new
  clip
- We can change the FPS of the animation via `Samples` property
    - May need to click triple dot to show it
- After configuring the animation, we can add frames to it
    - Drag sprite skins onto the timeline
- We can manage state transitions in the *Animator* tab
    - Start by right clicking *Any State* to make a transition
    - This creates an arrow you can use to click on other animations
- We'll also need to add a parameter that indicates which animation to use
    - Go to the *Parameters* subtab in the animator
    - Create a new boolean parameter
- Then click on a transition, which will bring up the *Inspector* window
    - Scroll down to `Conditions` and add one
    - We can use the boolean parameter to indicate which animation to use
- A couple more things to change
    - Set transition duration to 0 for instant transition
    - Disable "can transition to self" 
- If we run the game, we can manually check/uncheck the parameter to switch
  between animations

### Player Animation Manager
- See `PlayerAnimationManager.cs`
- This script automatically toggles the animation
- We've been using an MVC model with our scripts
    - `InputState.cs` is the model
    - `Jump.cs` is the controller
    - `PlayerAnimationManager.cs` is the view

### Recycle the Player
- First change the player to a prefab
    - Drag player from hierarchy into `Prefab` folder
- Add `DestroyOffscreen` and `RecycleGameObject` scripts
- Note that working with a Prefab is different than an instance
    - Changes to a prefab affects all existing instances, both current and future
    - Changing an instance only changes that instance
    - Changes to instance overrides changes to prefab
