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
- To create an animation, select multiple sprite frames at once and drag them onto the scene
    - Prompts us to create an animation file, put it in an *Animations* folder
- Use `Window > Animation > Animation` and `Window > Animation > Animator` for 2 panels that deal with animations
- In the *Animator*, we can see the animation
    - Clicking on it reveals some properties
- A second file will be created for us
    - This is the animation controller
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
- To trigger animation changes, we use parameters
- In the *Animator*, there is a *Parameters* tab
    - We can create new parameters with the "+" button
    - With multiple animations, an int is a good type choice
- Click on an arrow to open up its *Inspector*
    - Uncheck *Fixed Duration*
    - Set *Transition Duration (%)* to 0
    - Uncheck *Can Transition to Self*
    - Down in *Conditions*, click "+" and assign to a number with *Equals*
