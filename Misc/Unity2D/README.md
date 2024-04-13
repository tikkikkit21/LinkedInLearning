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
- Recall that we want to set 1 grid square = 1 pixel
- This can result in different zoom levels based on device screen size and
  resolution
- We can create a script that can automatically resizes the camera zoom level
- See `Assets/Scripts/PixelPerfectCamera.cs`
- We can drag this script into the `Main Camera` in the hierarchy
    - Note that this script only runs at the start of a game
    - Changing resolution in the middle won't auto resize

