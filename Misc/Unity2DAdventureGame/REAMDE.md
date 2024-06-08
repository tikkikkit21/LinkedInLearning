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
