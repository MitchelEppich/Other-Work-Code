using UnityEngine;
using System.Collections;

public class RuntimeTileEditor : MonoBehaviour {

	AutoTileSet autoTileSet;
	
	void Start() {
		autoTileSet=GetComponent<AutoTileSet>();
	}
	
	void OnGUI() {
		GUILayout.Label("Use left mouse button to toggle tiles/background\nUse right mouse button to delete tiles");
	}
	
	void Update () {
		TilePosition currentTilePosition=autoTileSet.ScreenToTilePosition(Input.mousePosition);
		
		if (Input.GetMouseButton(0)) {
			if ((currentTilePosition-autoTileSet.lastModifiedTileCoords).taxicabDistance>0) {
				TileType existingTileType=autoTileSet.GetTileTypeFromPosition(currentTilePosition);
				
				switch (existingTileType) {
					case TileType.None:
						autoTileSet.AddTile(currentTilePosition);
					break;
					case TileType.Front:
						autoTileSet.PushTile(currentTilePosition);
					break;
					case TileType.Back:
						autoTileSet.PullTile(currentTilePosition);
					break;
				}
			}
		}
		
		if (Input.GetMouseButton(1)) {
			Transform existingTileType=autoTileSet.GetTileTransformFromPosition(currentTilePosition);
			if (existingTileType!=null) {
				autoTileSet.RemoveTile(currentTilePosition);
			}
		}
		
		if (Input.GetMouseButtonUp(0) || Input.GetMouseButtonUp(1)) {
			autoTileSet.lastModifiedTileCoords=null;
		}
	}
	
	
}
