# Unity 5: 2D Building an Adventure Game
https://www.linkedin.com/learning/unity-5-2d-building-an-adventure-game/

## Working With Sprites
### Set Up Project
- To import a custom package, go to `Assets > Import Package > Custom Package...`

### Optimize Sprites
- In the project view, we can filter files by type
    - Ex: select "Texture" to see all sprites
- Standard sprite adjustments
    - Sprite mode = single
    - Pixels to unit = 1
    - Filter mode to *Point*
    - Format is RGBA 32 bit (based on personal trial/error)

### Optimize Draw Calls
- By default, game will make a draw call for each sprite on screen
- We can optimize this with a sprite atlas
    - `Assets > Create > 2D > Sprite Atlas`

### Cut Up Spritesheets
- We can indicate a texture is a spritesheet by changing the *Sprite Mode* to
  `multiple`
- Then we use the *Sprite Editor* to cut it up for use
- It's good practice to surround each sprite in the sheet with some transparency
    - Helps prevent bleeding between textures
    - Unity is a 3D engine under the hood so sometimes it oversamples textures 

## Working With Animations
### Build Animations
- To create an <u>animation</u>, select multiple sprite frames at once and drag them onto the scene
    - Prompts us to create an animation file, put it in an *Animations* folder
- Use `Window > Animation > Animation` and `Window > Animation > Animator` for 2 panels that deal with animations
- In the *Animator*, we can see the animation
    - Clicking on it reveals some properties
- A second file will be created for us
    - This is the <u>animation controller</u>
    - Used for controlling animations
    - Game objects use this component side-by-side with sprite renderers
- In the *Animation* tab, you can press play to run the animation without running the game
    - Note: sometimes it disables the *Animator* component for no reason

### Animation Timeline
- To create an animation with a single sprite frame, it has to be done by hand
- In *Animation* tab, click the dropdown for the animations
    - Select *Create New Clip...*
    - Adjust frame rate with the *Samples* property
    - Drag the single sprite into the animation timeline
- Double click the animation
    - This will bring up the *Inspector*
    - Uncheck *Loop Time* since we only have a single frame
- In *Animator*, the orange animation is the default
    - To change which one is default, right-click an animation and select *Set as Layer Default State*
- Make sure that the game object's sprite renderer also uses the default sprite frame
    - Ensures startup matches the idle animation

### Create Player Animations
- Repeat the above section as many times as you like for different animations
- An animation can also have different "sub-animations" within in
- Drag different frames onto the *Animation* timeline
    - You can move animations around to different times
    - Ex: a still image that has some particles every 2 seconds

### Change Animations on the Player
- In the *Animator*, you can see the different game states and animations
- The *Any State* is really useful
    - Facilitates transitions without needing to connect every animation to each other
- Right click on the *Any State* and click *Make Transition*
    - Link each arrow to every animation
- To trigger animation changes, we use <u>parameters</u>
- In the *Animator*, there is a *Parameters* tab
    - We can create new parameters with the "+" button
    - With multiple animations, an int is a good type choice
- Click on an arrow to open up its *Inspector*
    - Uncheck *Fixed Duration*
    - Set *Transition Duration (%)* to 0
    - Uncheck *Can Transition to Self*
    - Down in *Conditions*, click "+" and assign to a number with *Equals*

## Creating a Player
### Create a Player Prefab
- A <u>prefab</u> is like a template for a game object
- Create a new folder called *Prefabs*
    - Drag game objects from the hierarchy to this folder
    - Automatically creates a prefab
- Some important properties:
    - Changing source prefab (the one in the *Prefab* folder) will change all
    - Changing a prefab game object in the scene will only affect that game object
    - If we wanted to apply the changes to all, click *Apply* in the *Inspector*

### Add Collision to Player
- To add some physics to the player, we can add a *Rigidbody 2D*
    - This will add things like gravity
- Sometimes we want to change settings
    - We can tweak settings in the game object inspector
    - But this only affects that specific game object
- We can make global changes with `Edit > Project Settings > Physics 2D`
- To add collision logic, we use a *Box Collider 2D*
    - Need to add to both player and the ground
- There are other colliders we can use
    - For example, the *Polygon 2D*
    - This allows us to add colliders to non-rectangular shapes
    - There's an "Edit Collider" button that allows us to edit the boundaries
    - Adds more realistic collisions

### Clean Up the Player
- Box colliders are great but they can be clunky sometimes
    - Easily gets caught on other tiles
    - Doesn't easily account for transparency in sprite art
- Another option is the *Circle Collider 2D*
    - Draws a circle instead of box around the game object
    - Good idea to freeze Z so it doesn't roll on slopes
- We can add some more physics by creating a physics <u>material</u>
    - Create a "Materials" folder
    - Go to `Create > 2D > Physics Material 2D`
    - You can modify the friction and bounciness settings
- Drag the new material into the *Circle Collider 2D*
- Sometimes the game object will have a stuttering effect when it's resting on an object
    - To remedy this, go back to the global settings
    - Change *Velocity Threshold* to 2

## Moving the Player
### Move Player Left & Right
- See `Player.cs`
- Useful methods
    - `SpriteRenderer.flipX` can be true/false to mirror the sprit
        - Useful for facing opposite directions when moving
    - `Rigidbody2D.AddForce()` adds a physics force to the game object

### Enable Flying
- We modify `Player.cs` to add some flying logic
- Added variables for air movement
- Ensured we can still move left/right while in the air
- Slowed player down while in the air
- Set *Linear Drag* to 0.3 in the player's *Rigidbody 2D*

### Controller Class
- See `PlayerController.cs`
- We use a controller class to help clean up the logic for player movement
    - Encapsulates the logic for mapping controller input to game actions
    - The controller class focuses on mapping input to actions
    - The player class focuses on responding to those actions
- We then modify `Player.cs` to use the new controller class
- Previous fly logic:
    ```c#
    if (Input.GetKey(KeyCode.RightArrow))
    {
        if (absVelX < maxVelocity.x)
        {
            forceX = standing
            ? speed
            : speed * airSpeedMultiplier;
        }

        renderer2d.flipX = false;
    }
    else if (Input.GetKey(KeyCode.LeftArrow))
    {
        if (absVelX < maxVelocity.x)
        {
            forceX = standing
            ? -speed
            : -speed * airSpeedMultiplier;
        }

        renderer2d.flipX = true;
    }
    ```

- New fly logic:
    ```c#
    if (controller.moving.x != 0)
    {
        if (absVelX < maxVelocity.x)
        {
            var newSpeed = speed * controller.moving.x;
            forceX = standing
            ? newSpeed
            : newSpeed * airSpeedMultiplier;
            renderer2d.flipX = forceX < 0;
        }
    }
    ```
- This makes it easier to add support for new controllers such as a joystick
    - Only need to update the controller class

### Connect Animations
- We use the `Animator` class in `Player.cs`

## Building a Level
### Camera
- We create `CameraFollow.cs` for a script to follow the player

### Create a Simple Map
- Create a tile map with `GameObject > Tile Map`
- We can select some sprites for tiling in the *Inspector*
    - Brings up a grid where we can paint tiles
    - Adjust the `Tile Padding` to match the sprites
- `Window > Tile Picker` brings up a pane to select the different tiles
    - Can zoom in to make tiles bigger
- Holding down shift when painting will allows us to paint with mouse movement
- Create a background and foreground tilemap
- In the foreground, select all the tiles
    - Set `Order in Layer` to 1
    - Add box collider 2D's
- Set the player's layer order to 3

## Interactive Objects
### Create Collectible Objects
- We add a box collider 2d to detect when a player has collided with it
    - Turn on the `Is Trigger` setting so there's no actual collision
- We create a `Collectible.cs` script to help
    - Detects when something has collided with it
    - Destroys on collision
- We set the `Tag` of our player prefab to `"Player"`
    - Tags are useful for grouping objects together

### Random Sprite
- We create `RandomSprite.cs` script to help generate a random skin for this crystal
- To update a prefab, go to `Overrides` and then `Apply All`

### Deadly Obstacles
- Tags are useful for indicating if an obstacle is harmful
    - Ex: `"Deadly"`
- We can give tags to a GameObject, and then detect collisions with the player
- See `Explode.cs`

### Create Debris
- See `Debris.cs`
- We're creating a script so debris will slowly disappear from the scene
- Cool effect

### Spawn Debris
- We attach a `RandomSprite.cs` script so there's some variety
- Update `Explode.cs` so it'll spawn the debris on death

## Alien & AI
### Aliens That Walk
- See `MoveForward.cs`
- This script lets the alien to walk forward at a set speed until it hits
  something solid

### Turnaround At Walls
- See `LookForward.cs`
- This script helps us to look forward and turn back once we hit a wall
- We add a subobject to the Alien prefab with `AlienA` > `Create Empty`
    - This subobject is what detects the actual collision
- We also need to add a new layer to the tiles
    - Go to 1 tile in the foreground and add a new layer
    - Select the rest of tiles and change the layer as well
- The layer's name needs to match the name given in
    ```C#
    1 << LayerMask.NameToLayer("Solid")
    ```

### Keep Aliens On Platform
- We modify `LookForward.cs`
- We add a `needsCollision` variable to the script
    - If enabled, it will only turn when there's a collision
    - Otherwise, it'll turn when the sight end is no longer with the variable

### Clean Up Alien AI
- We set the alien's label as "Deadly"
- Add the following code to `Explode.cs`
    ```c#
    void OnCollisionEnter2D(Collision2D target)
        {
            // explode only when we hit a game object with "Deadly" tag
            if (target.gameObject.tag == "Deadly")
            {
                OnExplode();
            }
        }
    ```
- We'll also need to handle logic for when aliens bump into each other
    - Change layer of aliens to solid
    - Add another child object called `StartSight`
    - Move it to just in front of the circle collider
    - Update scripts fo the sightEnd to reference that child object

## Managing Scenes
### Create a Splash Screen
- Create a new scene with `File > New Scene`
    - We'll want the one that creates a camera for us (*Basic 2D - Built In*)
- We can change the background color like so
    - Set *Clear Flags* to *Solid Color*
    - Change *Background* to color as you like
- We can set a background image by right clicking the scene and going to `GameObject > UI > Image`
    - This creates a `Canvas` object as well for the image to sit in
- In `Canvas` object, we want to set the *Render Mode* to *Screen Space - Camera* and enable *Pixel Perfect*
- We also want to set the *Render Camera* to the main camera that the scene created for us
- Change the pixels per unit to 1 in order to make it consistent
- Set *UI Scale Mode* to *Scale With Screen Size* to make it consistent across screens
    - Gives it a reference point based on the intended resolution
    - We'll want to change the slider so it's completely to *Height*
- When working with the `Image` object, we can:
    - Set an image that we created as the source
    - Click *Set Native Size* to automatically resize
    - Adjust the position as needed
- Repeat for as many screen elements as needed

### Animate the Splash Screen
- We can first create an animation by dragging multiple frames onto the screen
    - This creates a temp animation object which we can borrow components from
- We can then move desired components to our Canvas images
    - Right click the *Sprite Renderer* and copy
    - Go to `Image` object and disable the image stuff
    - Right click and *Paste Component as New*
- We can do the same thing with the *Animator* component
- Also change the *Order in Layer* to 1 so it's on top
- We can adjust the ordering of `Image`s by adding a `Canvas` component
    - Set the order there
- The `FloatEffect.cs` script creates subtle floating effect of the player
    - Drag it to the player's `Image` object

### Switch Between Scenes
- Go to `File > Build Settings`
    - Add the 2 scenes to the *Scenes in Build*
    - Make splash scene 0 and main scene 1
- Add a `StartGame.cs` script to start up the game
    - Doesn't matter where you put it since it listens to mouse input
    - Set the scene's name in the script parameter to the main scene
