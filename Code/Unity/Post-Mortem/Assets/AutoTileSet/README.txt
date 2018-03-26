AutoTileSet 2.0 by Pixelatto
============================
An advanced AutoTile placement tool for AutoTileGen tilesets (www.pixelatto.com/autotilegen) or your own

DEMO SCENE CONTENTS:
ExampleSceneColliders - A scene containing an already prepared AutoTileSet Component with some tiles and lighting. Includes some rigidbodies 2D for collider testing.
ExampleSceneMulti - Scene using multiple tilematerials per AutoTileSet component
ExampleSceneTransparent - Example scene using a transparent TileMaterial
ExampleSceneRuntime - Includes a simple script "RuntimeTileEditor" that shows how to create/remove tiles on runtime

QUICK START GUIDE:
1. Import "AutoTileSet" package into your project
2. Drop "AutoTileSet" prefab into your scene
3. Select the AutoTileSet object and click on the "Enter Edit Mode" button (use the same button when finished editing)
4. Click and drag around on the scene to add/remove tiles
	-Left click to add/remove solid ground
	-Right click to add/remove background
5. Enjoy

TILEMATERIAL OPTIONS:
TileMaterials are AutoTileSet custom material assets. They allow you to define how the autotiles will behave after placement.
You can edit them in the "AutoTileSet" component or directly by selecting the prefab file for advanced options

-TileMaterial: Currently assigned material for this AutoTileSet slot
-Render Material: Currently assigned material for this AutoTile
-Transparent Tileset: Tells AutoTileSet if the tiles should include a background behind
-Has Bleeding: Removes the tileset bleeding/separation between tiles (2 pixels margin)
-Has colliders: Should the AutoTile generate colliders?
-Collider margin/bevel/slope: Collider shape parameters
-(Advanced)Front/Back layer depths: depth at which tiles are created
-(Advanced)Physic Material: Physic Material (2D) to add to these tile colliders

EDITING TILES BY SCRIPT:
The AutoTileSet component includes some methods for easy tile manipulation
AddTile():        Adds a front tile at the provided tilePosition
AddBackground():  Adds a background tile at the provided tilePosition
RemoveTile():     Removes a tile (if it exists) at the provided tilePosition
PushTile():       Moves the tile at the provided tilePosition from the front to the background
PullTile():       Moves the tile at the provided tilePosition from the background to the front

TIPS:
-You can create new TileMaterials by dragging a Material over the preview or by clicking the "+" button on the material list. Remember to assign them a shader
-You can drag & drop TileMaterial buttons in the AutoTileSet component to swap tile skins and/or sort them
-If you see any erratic behaviour you can click the "Update All" button to force an update on every autotiles
-You can adjust TileMaterial advanced settings in the inspector by selecting the corresponding TileMaterial asset in your project
-You can disable colliders in a TileMaterial to make secret rooms
-You can have up to 25 TileMaterials per AutoTileSet object
-If you want AutoTiles of the same type to ignore their neighbours somewhere, use different AutoTileSet objects

ADDITIONAL NOTES:
Check your normal maps settings when importing them:
	-Set texture type to "Normal Map"
	-Import Type to "Normal Map"
	-Disable "Create from grayscale"
	-(Optional)Set texture type to "Advanced" and disable "Non Power of 2"

Get AutoTileGen: www.pixelatto.com/autotilegen

Get more assets at: www.pixelatto.com

If you need any help: support@pixelatto.com
