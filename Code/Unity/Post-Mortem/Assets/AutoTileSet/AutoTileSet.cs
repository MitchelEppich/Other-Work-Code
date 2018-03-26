using UnityEngine;
using System.Collections;
using System.Collections.Generic;
#if UNITY_EDITOR
using UnityEditor;
#endif

[SelectionBase]
[ExecuteInEditMode]
public class AutoTileSet : MonoBehaviour {
	public int currentTileMaterial;
	public List<TileMaterial> tileMaterials;
	public float tileSize=1;
	
	public Vector3 gridOffset {get {return new Vector3(0.5f,0.5f)*tileSize;}}
	
	public TilePosition lastModifiedTileCoords;
	
	bool loaded=false;
	
	void Init() {
		tileMaterials=new List<TileMaterial>();
	}
	
	void Update() {
		if (!loaded) {
			Resources.UnloadUnusedAssets();
			UpdateAllTiles();
			loaded=true;
		}
	}
	
	void OnLevelWasLoaded() {
		UpdateAllTiles();
	}
	
	public void AddTile(TilePosition tileMapPosition) {
		CreateTile(tileMapPosition, true);
		UpdateTile(tileMapPosition);
		lastModifiedTileCoords=tileMapPosition;
		UpdateNeighbours(tileMapPosition);
	}
	
	public void RemoveTile(TilePosition tileMapPosition) {
		Transform tileTransform=GetTileTransformFromPosition(tileMapPosition);
		if (tileTransform!=null) {
			DestroyImmediate(tileTransform.gameObject);
			lastModifiedTileCoords=tileMapPosition;
			UpdateNeighbours(tileMapPosition);
		}
	}
	
	public void AddBackground(TilePosition tileMapPosition) {
		CreateTile(tileMapPosition, false);
		UpdateTile(tileMapPosition);
		lastModifiedTileCoords=tileMapPosition;
		UpdateNeighbours(tileMapPosition);
	}
	
	public void PushTile(TilePosition tileMapPosition) {
		Transform tileTransform=GetTileTransformFromPosition(tileMapPosition);
		if (tileTransform!=null) {
			tileTransform.name=BuildTileName(tileMapPosition, false, currentTileMaterial);
			UpdateTile(tileMapPosition);
			lastModifiedTileCoords=tileMapPosition;
			
			Transform backgroundChild=tileTransform.FindChild("Background");
			if (backgroundChild!=null) {
				#if UNITY_EDITOR
				Undo.DestroyObjectImmediate(backgroundChild.gameObject);
				#else
				Destroy(backgroundChild.gameObject);
				#endif
			}
			UpdateNeighbours(tileMapPosition);
		}
	}
	
	public void PullTile(TilePosition tileMapPosition) {
		Transform tileTransform=GetTileTransformFromPosition(tileMapPosition);
		if (tileTransform!=null) {
			tileTransform.name=BuildTileName(tileMapPosition, true, currentTileMaterial);
			UpdateTile(tileMapPosition);
			lastModifiedTileCoords=tileMapPosition;
			
			Transform backgroundChild=tileTransform.FindChild("Background");
			if (backgroundChild==null) {
				//TODO
			}
			UpdateNeighbours(tileMapPosition);
		}
	}
	
	public void UpdateAllTiles(int materialIndex=-1) {
		foreach (Transform tileTransform in transform) {
			if (materialIndex<0) {
				UpdateTile(tileTransform);
			} else {
				int tileIndex=-1;
				int.TryParse(tileTransform.name.Split(';')[2], out tileIndex);
				if (tileIndex==materialIndex) {
					UpdateTile(tileTransform);
				}
			}
		}
	}
	
	Transform CreateTile(TilePosition tileMapPosition, bool isSolid=true) {
		if (currentTileMaterial>=0) {
			string newTileName=BuildTileName(tileMapPosition, isSolid, currentTileMaterial);
			GameObject tileObject=new GameObject(newTileName, typeof(SpriteRenderer));
			#if UNITY_EDITOR
			Undo.RegisterCreatedObjectUndo(tileObject, "Edit Tiles");
			lastModifiedTileCoords=tileMapPosition;
			#endif
			tileObject.transform.parent=transform;
			return tileObject.transform;
		}
		return null;
	}
	
	void UpdateTile(TilePosition tileMapPosition) {
		UpdateTile(GetTileTransformFromPosition(tileMapPosition));
	}
	
	void UpdateTile(Transform tileTransform) {
		if (tileTransform!=null) {
			string[] parsedInfo=tileTransform.name.Split(';');
			string[] parsedCoords=parsedInfo[0].Replace("(","").Replace(")","").Split(',');
			int x=int.Parse(parsedCoords[0]);
			int y=int.Parse(parsedCoords[1]);
			TilePosition tileMapPosition=new TilePosition(x,y);
			bool solid=(parsedInfo[1]!="B");
			int materialIndex=int.Parse(parsedInfo[2]);
			TileMaterial tileMaterial;
			try {
				tileMaterial=tileMaterials[materialIndex];
			} catch {
				try {
				tileMaterial=tileMaterials[FindAnyTileMaterialIndex()];
				} catch {
					return;
				}
			}
			
			GameObject tileObject=tileTransform.gameObject;
			tileObject.transform.localScale=Vector3.one*tileSize;
			UpdateCollider(tileObject, solid, tileMapPosition, tileMaterial);
			SpriteRenderer spriteRenderer=tileObject.GetComponent<SpriteRenderer>();
			
			if (solid) {
				#if UNITY_EDITOR
				PolygonCollider2D collider=tileObject.GetComponent<PolygonCollider2D>();
				Undo.RecordObject(spriteRenderer, "Edit Tiles");
				if (collider!=null) {
					Undo.RecordObject(collider, "Edit Tiles");
				}
				#endif
				
				Transform backgroundTransform=tileTransform.FindChild("Background");
				if (tileMaterials[currentTileMaterial].transparentTileset && solid) {
					if (backgroundTransform==null) {
						backgroundTransform=new GameObject("Background", typeof(SpriteRenderer)).transform;
					}
					SpriteRenderer backgroundSpriteRenderer=backgroundTransform.GetComponent<SpriteRenderer>();
					backgroundTransform.parent=tileTransform;
					if (tileMaterial!=null) {
						backgroundSpriteRenderer.sprite=tileMaterial.GetSprite(20);
						backgroundSpriteRenderer.sharedMaterial=tileMaterial.renderMaterial;
					}
					backgroundTransform.rotation=transform.rotation;
					backgroundTransform.localPosition=Vector3.zero+transform.forward*tileMaterial.backLayerDepth;
				} else {
					if (backgroundTransform!=null) {
						#if UNITY_EDITOR
						Undo.DestroyObjectImmediate(backgroundTransform.gameObject);
						#else
						Destroy(backgroundTransform.gameObject);
						#endif
					}
				}
			}
			
			if (tileMaterial!=null) {
				spriteRenderer.sharedMaterial=tileMaterial.renderMaterial;
				spriteRenderer.sprite=tileMaterial.GetSprite(solid?GetTileImageIndex(tileMapPosition):20);
				tileObject.transform.position=transform.TransformPoint(tileMapPosition.ToVector3()*tileSize+gridOffset+Vector3.forward*(solid?tileMaterial.frontLayerDepth:tileMaterial.backLayerDepth));
			}
			if (solid) {tileObject.transform.SetAsFirstSibling();}
			spriteRenderer.sprite.hideFlags=HideFlags.DontSaveInBuild | HideFlags.DontSaveInEditor;
			tileObject.layer=gameObject.layer;
			tileObject.transform.rotation=transform.rotation;
			tileObject.transform.hideFlags=HideFlags.HideInHierarchy;
		}
	}
	
	void UpdateCollider(GameObject tileObject, bool solid, TilePosition tileMapPosition, TileMaterial tileMaterial) {
		PolygonCollider2D existingCollider=tileObject.GetComponent<PolygonCollider2D>();
		#if UNITY_EDITOR
		if (existingCollider!=null) {
			Undo.RecordObject(existingCollider, "Edit Tiles");
		}
		#endif
		if (tileMaterial!=null) {
			if (tileMaterial.hasColliders) {
				if (existingCollider==null) {
					if (solid) {
						existingCollider=BuildCollider(tileObject.AddComponent<PolygonCollider2D>(), tileMapPosition, tileMaterial);
					}
				} else {
					if (solid) {
						BuildCollider(existingCollider, tileMapPosition, tileMaterial);
					} else {
						#if UNITY_EDITOR
						Undo.DestroyObjectImmediate(existingCollider);
						#else
						DestroyImmediate(existingCollider);
						#endif
					}
				}
				if (existingCollider!=null) {
					existingCollider.sharedMaterial=tileMaterial.physicMaterial;
				}
			} else {
				PolygonCollider2D collider=tileObject.GetComponent<PolygonCollider2D>();
				if (collider!=null) {
					#if UNITY_EDITOR
					Undo.DestroyObjectImmediate(collider);
					#else
					DestroyImmediate(collider);
					#endif
				}
			}
		}
	}
	
	PolygonCollider2D BuildCollider(PolygonCollider2D polCollider, TilePosition tileMapPosition, TileMaterial tileMaterial) {
		string sideNeighbours=GetSideNeighbours(tileMapPosition);
		string cornerNeighbours=GetCornerNeighbours(tileMapPosition);
		float marginFraction=tileMaterial.colliderMargin;
		float topMargin   =(sideNeighbours[0]=='1')?0:1;
		float rightMargin =(sideNeighbours[1]=='1')?0:1;
		float bottomMargin=(sideNeighbours[2]=='1')?0:1;
		float leftMargin  =(sideNeighbours[3]=='1')?0:1;
		
		if (sideNeighbours+cornerNeighbours=="11111111") {
			#if UNITY_EDITOR
			Undo.DestroyObjectImmediate(polCollider);
			#else
			DestroyImmediate(polCollider);
			#endif
			return null;
		}
		
		float alpha=((1-tileMaterial.bevelAmount)*0.5f+0.5f);
		int innerCornerCount=0;
		int cornerCount=0;
		bool cornerTypeUL=false, cornerTypeUR=false, cornerTypeBR=false, cornerTypeBL=false;
		bool cornerUL=false, cornerUR=false, cornerBR=false, cornerBL=false;
		if (cornerNeighbours[0]=='0' && sideNeighbours[0]=='1' && sideNeighbours[3]=='1') {cornerUL=true; cornerCount++; innerCornerCount++; cornerTypeUL=true;}
		if (cornerNeighbours[1]=='0' && sideNeighbours[1]=='1' && sideNeighbours[0]=='1') {cornerUR=true; cornerCount++; innerCornerCount++; cornerTypeUR=true;}
		if (cornerNeighbours[2]=='0' && sideNeighbours[2]=='1' && sideNeighbours[1]=='1') {cornerBR=true; cornerCount++; innerCornerCount++; cornerTypeBR=true;}
		if (cornerNeighbours[3]=='0' && sideNeighbours[3]=='1' && sideNeighbours[2]=='1') {cornerBL=true; cornerCount++; innerCornerCount++; cornerTypeBL=true;}
		if (sideNeighbours[0]=='0' && sideNeighbours[3]=='0') {cornerUL=true; cornerCount++; cornerTypeUL=false;}
		if (sideNeighbours[1]=='0' && sideNeighbours[0]=='0') {cornerUR=true; cornerCount++; cornerTypeUR=false;}
		if (sideNeighbours[2]=='0' && sideNeighbours[1]=='0') {cornerBR=true; cornerCount++; cornerTypeBR=false;}
		if (sideNeighbours[3]=='0' && sideNeighbours[2]=='0') {cornerBL=true; cornerCount++; cornerTypeBL=false;}
		
		Vector2 margin=Vector2.one*marginFraction;
		Vector2 offset=new Vector2(leftMargin-rightMargin, bottomMargin-topMargin)*marginFraction*0.5f;
		Vector2 size=(Vector2.one-new Vector2(rightMargin+leftMargin, topMargin+bottomMargin)*marginFraction)*0.5f;
		
		List<Vector2> points=new List<Vector2>();
		
		if (tileMaterial.colliderSlopeCorners && !cornerTypeUL && cornerUL && !cornerUR && !cornerBL) {
			points.Add(offset+new Vector2(size.x,  size.y));
		} else if (cornerUL) {
			points.Add(offset+new Vector2(-size.x, Mathf.Clamp(size.y-margin.y, 0, size.y)));
			if (alpha!=0.5f) {
				points.Add(offset+new Vector2(Mathf.Clamp(-size.x+margin.x*(cornerTypeUL?alpha:1-alpha), -size.x, 0),  Mathf.Clamp(size.y-margin.y*(cornerTypeUL?alpha:1-alpha), 0, size.y)));
			}
			points.Add(offset+new Vector2(Mathf.Clamp(-size.x+margin.x, -size.x, 0),  size.y));
		} else {
			points.Add(offset+new Vector2(-size.x,  size.y));
		}
		
		if (tileMaterial.colliderSlopeCorners && !cornerTypeUR && cornerUR && !cornerUL && !cornerBR) {
			points.Add(offset+new Vector2(size.x, -size.y));
		} else if (cornerUR) {
			points.Add(offset+new Vector2(Mathf.Clamp(size.x-margin.x, 0, size.x),  size.y));
			if (alpha!=0.5f) {
				points.Add(offset+new Vector2(Mathf.Clamp(size.x-margin.x*(cornerTypeUR?alpha:1-alpha),0, size.x), Mathf.Clamp(size.y-margin.y*(cornerTypeUR?alpha:1-alpha), 0, size.y)));
			}
			points.Add(offset+new Vector2( size.x, Mathf.Clamp(size.y-margin.y, 0, size.y)));
		} else {
			points.Add(offset+new Vector2( size.x, size.y));
		}
		
		if (tileMaterial.colliderSlopeCorners && !cornerTypeBR && cornerBR && !cornerBL && !cornerUR) {
			points.Add(offset+new Vector2(-size.x, -size.y));
		} else if (cornerBR) {
			points.Add(offset+new Vector2( size.x,Mathf.Clamp(-size.y+margin.y, -size.y, 0)));
			if (alpha!=0.5f) {
				points.Add(offset+new Vector2(Mathf.Clamp(size.x-margin.x*(cornerTypeBR?alpha:1-alpha), 0, size.x), Mathf.Clamp(-size.y+margin.y*(cornerTypeBR?alpha:1-alpha), -size.y, 0)));
			}
			points.Add(offset+new Vector2( Mathf.Clamp(size.x-margin.x, 0, size.x), -size.y));
		} else {
			points.Add(offset+new Vector2( size.x, -size.y));
		}
		
		if (tileMaterial.colliderSlopeCorners && !cornerTypeBL && cornerBL && !cornerBR && !cornerUL) {
			points.Add(offset+new Vector2(-size.x, size.y));
		} else if (cornerBL) {
			points.Add(offset+new Vector2(Mathf.Clamp(-size.x+margin.x, -size.x, 0), -size.y));
			if (alpha!=0.5f) {
				points.Add(offset+new Vector2(Mathf.Clamp(-size.x+margin.x*(cornerTypeBL?alpha:1-alpha), -size.x, 0), Mathf.Clamp(-size.y+margin.y*(cornerTypeBL?alpha:1-alpha),-size.y, 0)));
			}
			points.Add(offset+new Vector2(-size.x, Mathf.Clamp(-size.y+margin.y, -size.y, 0)));
		} else {
			points.Add(offset+new Vector2(-size.x, -size.y));
		}
		
		Vector2[] pointsArray=new Vector2[points.Count];
		for (int i = 0; i < points.Count; i++) {
			pointsArray[i]=points[i];
		}
		
		polCollider.points=pointsArray;
		
		return polCollider;
	}
	
	public void UpdateNeighbours(TilePosition tileMapPosition) {
		UpdateTile(new TilePosition(tileMapPosition.x+0, tileMapPosition.y+1));
		UpdateTile(new TilePosition(tileMapPosition.x+1, tileMapPosition.y+0));
		UpdateTile(new TilePosition(tileMapPosition.x+0, tileMapPosition.y-1));
		UpdateTile(new TilePosition(tileMapPosition.x-1, tileMapPosition.y+0));
		UpdateTile(new TilePosition(tileMapPosition.x-1, tileMapPosition.y+1));
		UpdateTile(new TilePosition(tileMapPosition.x+1, tileMapPosition.y+1));
		UpdateTile(new TilePosition(tileMapPosition.x+1, tileMapPosition.y-1));
		UpdateTile(new TilePosition(tileMapPosition.x-1, tileMapPosition.y-1));
	}
	
	///Template: (X,Y);TYPE;MATERIAL
	string BuildTileName(TilePosition tileMapPosition, bool isSolid, int materialIndex) {
		return GetTileCoords(tileMapPosition)+";"+(isSolid?"":"B")+";"+materialIndex;
	}
	
	///Template: (X,Y)
	string GetTileCoords(TilePosition tileMapPosition) {
		return "("+tileMapPosition.x+","+tileMapPosition.y+")";
	}
	
	public TilePosition ScreenToTilePosition(Vector3 screenPosition) {
		Plane p = new Plane(transform.TransformDirection(Vector3.forward), new Vector3());
		
		Ray ray = Camera.main.ScreenPointToRay(screenPosition);
		
		Vector3 hit = new Vector3();
		float dist;
		if (p.Raycast(ray, out dist)) {
			hit = ray.origin + ray.direction.normalized*dist;
		}
		Vector3 mouseHitPos = transform.position+transform.InverseTransformPoint(hit);
		var relativePos = new Vector2(mouseHitPos.x - transform.position.x, mouseHitPos.y - transform.position.y);
		return new TilePosition(Mathf.RoundToInt((relativePos.x-gridOffset.x)/tileSize), Mathf.RoundToInt((relativePos.y-gridOffset.y)/tileSize));
	}
	
	public TileType GetTileTypeFromPosition(TilePosition tileMapPosition) {
		Transform tileTransform=GetTileTransformFromPosition(tileMapPosition, true);
		if (tileTransform==null) {
			return TileType.None;
		} else {
			if (tileTransform.name.Contains(";B;")) {
				return TileType.Back;
			} else {
				return TileType.Front;
			}
		}
	}
	
	public Transform GetTileTransformFromPosition(TilePosition tileMapPosition, bool includeBack=true) {
		foreach (Transform child in transform) {
			if (child.name.Contains(GetTileCoords(tileMapPosition))) {
				if (includeBack) {
					return child;
				} else {
					if (!child.name.Contains(";B;")) {
						return child;
					}
				}
			}
		}
		return null;
	}
	
	int GetTileImageIndex(TilePosition tileMapPosition) {
		int result=0;
		
		string neighbourInfo1=GetSideNeighbours(tileMapPosition);
		string neighbourInfo2=GetCornerNeighbours(tileMapPosition);
		
		switch (CountOnes(neighbourInfo1)) {
		case 1:
			switch (neighbourInfo1) {
			case "0010": if (TestCornerTemplate("XXXX", neighbourInfo2)) {result= 3;} break;
			case "0001": if (TestCornerTemplate("XXXX", neighbourInfo2)) {result=26;} break;
			case "1000": if (TestCornerTemplate("XXXX", neighbourInfo2)) {result=19;} break;
			case "0100": if (TestCornerTemplate("XXXX", neighbourInfo2)) {result=24;} break;
			}
			break;
			
		case 2:
			switch (neighbourInfo1) {
			case "1010": if (TestCornerTemplate("XXXX", neighbourInfo2)) {result=11;} break;
			case "0101": if (TestCornerTemplate("XXXX", neighbourInfo2)) {result=25;} break;
			case "0110": if (TestCornerTemplate("XX0X", neighbourInfo2)) {result= 5;} 
				if (TestCornerTemplate("XX1X", neighbourInfo2)) {result= 0;} break;
			case "0011": if (TestCornerTemplate("XXX0", neighbourInfo2)) {result= 7;} 
				if (TestCornerTemplate("XXX1", neighbourInfo2)) {result= 2;} break;
			case "1001": if (TestCornerTemplate("0XXX", neighbourInfo2)) {result=23;} 
				if (TestCornerTemplate("1XXX", neighbourInfo2)) {result=18;} break;
			case "1100": if (TestCornerTemplate("X0XX", neighbourInfo2)) {result=21;} 
				if (TestCornerTemplate("X1XX", neighbourInfo2)) {result=16;} break;
			}
			break;
			
		case 3:
			switch (neighbourInfo1) {
			case "0111": if (TestCornerTemplate("XX11", neighbourInfo2)) {result= 1;}
				if (TestCornerTemplate("XX01", neighbourInfo2)) {result=34;}
				if (TestCornerTemplate("XX10", neighbourInfo2)) {result=37;}
				if (TestCornerTemplate("XX00", neighbourInfo2)) {result= 6;} break;
				
			case "1011": if (TestCornerTemplate("1XX1", neighbourInfo2)) {result=10;}
				if (TestCornerTemplate("1XX0", neighbourInfo2)) {result=35;}
				if (TestCornerTemplate("0XX1", neighbourInfo2)) {result=45;}
				if (TestCornerTemplate("0XX0", neighbourInfo2)) {result=15;} break;
				
			case "1101": if (TestCornerTemplate("11XX", neighbourInfo2)) {result=17;}
				if (TestCornerTemplate("01XX", neighbourInfo2)) {result=43;}
				if (TestCornerTemplate("10XX", neighbourInfo2)) {result=44;}
				if (TestCornerTemplate("00XX", neighbourInfo2)) {result=22;} break;
				
			case "1110": if (TestCornerTemplate("X11X", neighbourInfo2)) {result= 8;}
				if (TestCornerTemplate("X01X", neighbourInfo2)) {result=42;}
				if (TestCornerTemplate("X10X", neighbourInfo2)) {result=36;}
				if (TestCornerTemplate("X00X", neighbourInfo2)) {result=13;} break;
			}
			break;
			
		case 4:
			if (TestCornerTemplate("1111", neighbourInfo2)) {result= 9; break;}
			if (TestCornerTemplate("0000", neighbourInfo2)) {result=14; break;}
			if (TestCornerTemplate("1010", neighbourInfo2)) {result= 4; break;}
			if (TestCornerTemplate("0101", neighbourInfo2)) {result=12; break;}
			
			if (TestCornerTemplate("1000", neighbourInfo2)) {result=38; break;}
			if (TestCornerTemplate("0100", neighbourInfo2)) {result=39; break;}
			if (TestCornerTemplate("0010", neighbourInfo2)) {result=47; break;}
			if (TestCornerTemplate("0001", neighbourInfo2)) {result=46; break;}
			
			if (TestCornerTemplate("1101", neighbourInfo2)) {result=32; break;}
			if (TestCornerTemplate("1110", neighbourInfo2)) {result=33; break;}
			if (TestCornerTemplate("0111", neighbourInfo2)) {result=41; break;}
			if (TestCornerTemplate("1011", neighbourInfo2)) {result=40; break;}
			
			if (TestCornerTemplate("0XX0", neighbourInfo2)) {result=28; break;}
			if (TestCornerTemplate("00XX", neighbourInfo2)) {result=29; break;}
			if (TestCornerTemplate("X00X", neighbourInfo2)) {result=30; break;}
			if (TestCornerTemplate("XX00", neighbourInfo2)) {result=31; break;}
			break;
			
		default: result=(27); break;
		}
		
		return result;
	}
	
	string CheckIfSolidTile(int x, int y) {
		return CheckIfSolidTile(new TilePosition(x,y));
	}
	
	string CheckIfSolidTile(TilePosition tileMapPosition) {
		Transform existingTile=GetTileTransformFromPosition(tileMapPosition, false);
		return (existingTile!=null)?"1":"0";
	}
	
	bool TestCornerTemplate(string template, string str) {
		for (int i = 0; i < template.Length; i++) {
			if (template[i]!='X' && template[i]!=str[i]) {
				return false;
			}
		}
		return true;
	}
	
	int CountOnes(string str) {
		int result=0;
		for (int i = 0; i < str.Length; i++) {
			if (str[i]=='1') {
				result++;
			}
		}
		return result;
	}
	
	string GetSideNeighbours(TilePosition tilePosition) {
		return CheckIfSolidTile(tilePosition.x,tilePosition.y+1)+CheckIfSolidTile(tilePosition.x+1,tilePosition.y)+CheckIfSolidTile(tilePosition.x,tilePosition.y-1)+CheckIfSolidTile(tilePosition.x-1,tilePosition.y);
	}
	
	string GetCornerNeighbours(TilePosition tilePosition) {
		return CheckIfSolidTile(tilePosition.x-1,tilePosition.y+1)+CheckIfSolidTile(tilePosition.x+1,tilePosition.y+1)+CheckIfSolidTile(tilePosition.x+1,tilePosition.y-1)+CheckIfSolidTile(tilePosition.x-1,tilePosition.y-1);
	}
	
	Vector2 GetSlicePosition(TilePosition tileMapPosition) {
		return TileMaterial.TilesetPositionFromIndex(GetTileImageIndex(tileMapPosition));
	}
	
	public int FindAnyTileMaterialIndex() {
		if (tileMaterials!=null) {
			for (int i = 0; i < tileMaterials.Capacity; i++) {
				if (tileMaterials[i]!=null) {
					return i;
				}
			}
		}
		return -1;
	}
	
	
	#if UNITY_EDITOR
	[SerializeField]bool displayGrid=false;
	[SerializeField]bool isEditing=false;
	
	public void CreateMaterialList() {
		tileMaterials=new List<TileMaterial>();
	}
	
	void OnDrawGizmosSelected() {
		foreach (Transform child in transform) {
			child.SendMessage("OnDrawGizmosSelected", SendMessageOptions.DontRequireReceiver);
		}
		DrawMapGrid();
	}
	
	void DrawMapGrid() {
		if (displayGrid) {
			Gizmos.color=isEditing?Color.yellow*0.8f:Color.gray;
			float gridSize=512;
			for (float i = -gridSize*tileSize; i < gridSize*tileSize; i+=tileSize) {
				Gizmos.DrawLine(transform.TransformPoint(new Vector3(i, -gridSize)), transform.TransformPoint(new Vector3(i, gridSize)));
			}
			for (float j = -gridSize*tileSize; j < gridSize*tileSize; j+=tileSize) {
				Gizmos.DrawLine(transform.TransformPoint(new Vector3(-gridSize, j)), transform.TransformPoint(new Vector3(gridSize, j)));
			}
		}
	}
	#endif
	
}

public class TilePosition {
	public int x;
	public int y;
	
	public int taxicabDistance {
		get {
			return Mathf.Abs(x)+Mathf.Abs(y);
		}
	}
	
	public TilePosition(int x, int y) {
		this.x=x;
		this.y=y;
	}
	
	public Vector2 ToVector2() {
		return new Vector2(x,y);
	}
	
	public Vector3 ToVector3() {
		return new Vector3(x,y);
	}
	
	public static TilePosition operator+(TilePosition a, TilePosition b) {
		return new TilePosition(a.x+b.x, a.y+b.y);
	}
	
	public static TilePosition operator-(TilePosition a, TilePosition b) {
		a=(a!=null)?a:new TilePosition(0,0);
		b=(b!=null)?b:new TilePosition(0,0);
		return new TilePosition(a.x-b.x, a.y-b.y);
	}
}

public enum TileType {None, Front, Back}


#if UNITY_EDITOR
[CustomEditor(typeof(AutoTileSet))]
public class AutoTileSetEditor : Editor {
	
	public AutoTileSet mapManager {get{return serializedObject.targetObject as AutoTileSet;}}
	
	Vector3 mouseHitPos;
	
	SerializedObject tileMaterialSerializedObject;
	
	override public void OnInspectorGUI() {
		FindProperties();
		DrawTop();
		DrawContent();
		DrawFooter();
		
		if (Event.current.type==EventType.KeyDown && Event.current.keyCode==KeyCode.E) {
			isEditing.boolValue=!isEditing.boolValue;
			Event.current.Use();
		}
		
		serializedObject.ApplyModifiedProperties();
		if (tileMaterialSerializedObject!=null) {
			tileMaterialSerializedObject.ApplyModifiedProperties();
		}
	}
		
	GUIStyle boldFont;
	Texture autotilesetLogo_;
	Texture autotilesetLogo {
		get {
			if (autotilesetLogo_==null) {
				string path=AssetDatabase.GUIDToAssetPath(AssetDatabase.FindAssets("AutoTileSet")[0]).Replace("AutoTileSet.cs","")+"/Internal/Images/autotileset_logo.png";
				autotilesetLogo_ = (Texture)AssetDatabase.LoadAssetAtPath(path, typeof(Texture));
			}
			return autotilesetLogo_;
		}
	}
	Texture autotilegenIcon_;
	Texture autotilegenIcon {
		get {
			if (autotilegenIcon_==null) {
				string path=AssetDatabase.GUIDToAssetPath(AssetDatabase.FindAssets("AutoTileSet")[0]).Replace("AutoTileSet.cs","")+"/Internal/Images/autotilegen_icon.png";
				autotilegenIcon_ = (Texture)AssetDatabase.LoadAssetAtPath(path, typeof(Texture));
			}
			return autotilegenIcon_;
		}
	}
	SerializedProperty isEditing, tileSize, transparentTileset, renderMaterial, hasBleeding, displayGrid, hasColliders, colliderMargin, bevelAmount, colliderSlopeCorners, currentTileMaterial, tileMaterials;
	public void FindProperties() {
		
		if (boldFont==null) {
			boldFont=new GUIStyle(GUI.skin.FindStyle("Label"));
			boldFont.fontStyle=FontStyle.Bold;
		}
		
		isEditing	=serializedObject.FindProperty("isEditing");
		tileSize	=serializedObject.FindProperty("tileSize");
		displayGrid	=serializedObject.FindProperty("displayGrid");
		
		if (mapManager.tileMaterials!=null && mapManager.tileMaterials.Count>0) {
			currentTileMaterial=serializedObject.FindProperty("currentTileMaterial");
			tileMaterials	   =serializedObject.FindProperty("tileMaterials");
			
			if (currentTileMaterial.intValue<0) {
				currentTileMaterial.intValue=mapManager.FindAnyTileMaterialIndex();
				serializedObject.ApplyModifiedProperties();
			}
			
			if (mapManager.tileMaterials[currentTileMaterial.intValue]!=null) {
			tileMaterialSerializedObject=new SerializedObject(serializedObject.FindProperty("tileMaterials").GetArrayElementAtIndex(currentTileMaterial.intValue).objectReferenceValue);
			
			if (tileMaterialSerializedObject.targetObject==null) {
					tileMaterialSerializedObject=new SerializedObject(serializedObject.FindProperty("tileMaterials").GetArrayElementAtIndex(mapManager.FindAnyTileMaterialIndex()).objectReferenceValue);
				}
				
			transparentTileset	=tileMaterialSerializedObject.FindProperty("transparentTileset");
			renderMaterial		=tileMaterialSerializedObject.FindProperty("renderMaterial");
			hasBleeding			=tileMaterialSerializedObject.FindProperty("hasBleeding");
			hasColliders		=tileMaterialSerializedObject.FindProperty("hasColliders");
			colliderSlopeCorners=tileMaterialSerializedObject.FindProperty("colliderSlopeCorners");
			colliderMargin		=tileMaterialSerializedObject.FindProperty("colliderMargin");
			bevelAmount			=tileMaterialSerializedObject.FindProperty("bevelAmount");
			}
		}
	}
	
	void DrawTop() {
		GUILayout.Space(8f);
		if (autotilesetLogo!=null) {
			var headerRect = GUILayoutUtility.GetRect(Screen.width, 5.0f );
			headerRect.x=headerRect.x-16f;
			headerRect.width = autotilesetLogo.width*0.5f;
			headerRect.height = autotilesetLogo.height*0.5f;
			GUILayout.Space( headerRect.height );
			GUI.DrawTexture( headerRect, autotilesetLogo);
			
			if (GUI.Button(new Rect(Screen.width-60, headerRect.y+4, headerRect.height*0.875f, headerRect.height*0.875f), new GUIContent(autotilegenIcon, "Get AutoTileGen!"))) {
				Application.OpenURL("http://www.pixelatto.com/autotilegen");
			}
		}
		
		EditorGUILayout.BeginHorizontal();
		GUILayout.Label(new GUIContent("Selected Tile Material: ", "Drop a material over the grid to assign"), boldFont);
		GUILayout.Label(new GUIContent("Loaded Tile Materials: ", "Click to select.\nDrag and drop to re-arrange"), boldFont);
		EditorGUILayout.EndHorizontal();
	}
	
	void DrawContent() {
		EditorGUILayout.BeginHorizontal();
		Rect leftRect = GUILayoutMakeRectWithSpace();
		CheckTilesetDragAndDrop(leftRect);
		if (mapManager.tileMaterials!=null) {
			for (int j = 0; j < 5; j++) {
				Rect rightRect = new Rect(leftRect.x+leftRect.width+8f, leftRect.y+(leftRect.height*0.2f+2f)*j, leftRect.width*0.2f, leftRect.height*0.2f);
				for (int i = 0; i < 5; i++) {
					int currentButtonIndex=i+j*5;
					if (mapManager.tileMaterials.Capacity>currentButtonIndex) {
						if (rightRect.Contains(Event.current.mousePosition)) {
							if (Event.current.type==EventType.DragUpdated) {
								DragAndDrop.visualMode=DragAndDropVisualMode.Move;
							}
							if (Event.current.type==EventType.MouseDrag) {
								DragAndDrop.PrepareStartDrag();
								DragAndDrop.SetGenericData("index", currentButtonIndex);
								Object[] objects=new Object[1];
								objects[0]=mapManager.tileMaterials[currentButtonIndex];
								DragAndDrop.objectReferences=objects;
								DragAndDrop.StartDrag("Dragging TileMaterial");
								Event.current.Use();
							}
							if (Event.current.type==EventType.DragPerform) {
								DragAndDrop.AcceptDrag();
								Object draggedObject=DragAndDrop.objectReferences[0];
								if (draggedObject is TileMaterial) {
									TileMaterial dropMaterial=(TileMaterial)tileMaterials.GetArrayElementAtIndex(currentButtonIndex).objectReferenceValue;
									int dragIndex;
									try {
										dragIndex=(int)DragAndDrop.GetGenericData("index");
									} catch {
										dragIndex=-1;
									}
									if (dropMaterial!=null && dragIndex!=-1) {
										SwapMaterials(dragIndex, currentButtonIndex);
									} else {
										if (dragIndex!=-1) {
											tileMaterials.DeleteArrayElementAtIndex(dragIndex);
										}
										tileMaterials.GetArrayElementAtIndex(currentButtonIndex).objectReferenceValue=(TileMaterial)draggedObject;
										currentTileMaterial.intValue=currentButtonIndex;
									}
									serializedObject.ApplyModifiedProperties();
									RequestUpdate();
								}
							}
						}
						if (mapManager.tileMaterials[currentButtonIndex]!=null) {
							if (GUI.Toggle(rightRect, currentTileMaterial.intValue==currentButtonIndex, "", GUI.skin.FindStyle("Button"))) {
								currentTileMaterial.intValue=currentButtonIndex;
							}
							if (mapManager.tileMaterials[currentButtonIndex].renderMaterial!=null) {
								if (mapManager.tileMaterials[currentButtonIndex].renderMaterial.mainTexture!=null) {
									GUI.DrawTextureWithTexCoords(SquareRect(ShrinkRect(rightRect, 2f)), mapManager.tileMaterials[currentButtonIndex].renderMaterial.mainTexture, new Rect(0,5f/6f,1f/8f, 1f/6f));
								}
							}
						} else {
							GUI.Box(rightRect, "N/A");
						}
					} else if (mapManager.tileMaterials.Count==(currentButtonIndex)) {
						if (rightRect.Contains(Event.current.mousePosition)) {
							if (Event.current.type==EventType.DragUpdated) {
								DragAndDrop.visualMode=DragAndDropVisualMode.Move;
							}
							if (Event.current.type==EventType.DragPerform) {
								DragAndDrop.AcceptDrag();
								Object draggedObject=DragAndDrop.objectReferences[0];
								if (draggedObject is TileMaterial) {
									if (tileMaterials==null) {mapManager.CreateMaterialList(); tileMaterials=serializedObject.FindProperty("tileMaterials");}
									tileMaterials.InsertArrayElementAtIndex(currentButtonIndex);
									tileMaterials.GetArrayElementAtIndex(currentButtonIndex).objectReferenceValue=(TileMaterial)draggedObject;
									currentTileMaterial.intValue=currentButtonIndex;
								}
							}
						}
						if (GUI.Button(rightRect, "+")) {
							TileMaterial newTileMaterial=ScriptableObjectUtility.CreateAsset<TileMaterial>("TM_NewTileMaterial");
							if (newTileMaterial!=null) {
								newTileMaterial.Init(null, false, 0, 0.2f);
								if (tileMaterials==null) {mapManager.CreateMaterialList(); tileMaterials=serializedObject.FindProperty("tileMaterials");}
								tileMaterials.InsertArrayElementAtIndex(currentButtonIndex);
								tileMaterials.GetArrayElementAtIndex(currentButtonIndex).objectReferenceValue=newTileMaterial;
							}
						}
					}
					rightRect=MoveRectRight(rightRect);
				}
			}
		}
		EditorGUILayout.EndHorizontal();
	}
	
	void SwapMaterials(int indexA, int indexB) {
		var temp=tileMaterials.GetArrayElementAtIndex(indexA).objectReferenceValue;
		tileMaterials.GetArrayElementAtIndex(indexA).objectReferenceValue=(TileMaterial)tileMaterials.GetArrayElementAtIndex(indexB).objectReferenceValue;
		tileMaterials.GetArrayElementAtIndex(indexB).objectReferenceValue=temp;
	}
	
	Rect GUILayoutMakeRectWithSpace() {
		Rect rect=EditorGUILayout.BeginVertical();
		float ratio=8f/6f;
		GUILayout.Space(Screen.width*0.5f/ratio);
		EditorGUILayout.EndVertical();
		float width=rect.width*0.5f-8f;
		Rect displayRect=new Rect(rect.x, rect.y, width, width/ratio);
		return displayRect;
	}
	
	Rect MoveRectDown(Rect rect, float margin=2f) {
		return new Rect(rect.x, rect.y+rect.height+margin, rect.width, rect.height);
	}
	
	Rect MoveRectRight(Rect rect, float margin=2f) {
		return new Rect(rect.x+rect.width+margin, rect.y, rect.width, rect.height);
	}
	
	Rect ShrinkRect(Rect rect, float margin=2f) {
		return new Rect(rect.x+margin, rect.y+margin, rect.width-2*margin, rect.height-2*margin);
	}
	
	Rect SquareRect(Rect rect) {
		float error=(rect.width-rect.height)*0.5f;
		return new Rect(rect.x+error, rect.y, rect.width-2*error, rect.height);
	}
	
	void DrawFooter() {
		GUILayoutOption[] smallButtonOptions={GUILayout.Width(Screen.width*0.25f-10), GUILayout.Height(20)};
		GUILayoutOption[] largeButtonOptions={GUILayout.Width(Screen.width*0.50f-18), GUILayout.Height(40)};
		
		EditorGUILayout.BeginHorizontal();
		
		EditorGUILayout.BeginVertical();
		EditorGUILayout.LabelField("Selected Tile Material options:", boldFont);
		
		if (tileMaterialSerializedObject!=null) {
			EditorGUI.BeginChangeCheck();
			tileMaterials.GetArrayElementAtIndex(mapManager.currentTileMaterial).objectReferenceValue=EditorGUILayout.ObjectField(new GUIContent("Tile Material"), tileMaterials.GetArrayElementAtIndex(mapManager.currentTileMaterial).objectReferenceValue, typeof(TileMaterial), false);
			EditorGUILayout.PropertyField(renderMaterial);
			EditorGUILayout.PropertyField(transparentTileset);
			EditorGUILayout.PropertyField(hasBleeding);
			hasColliders.boolValue=EditorGUILayout.Toggle("Has Colliders", hasColliders.boolValue, GUILayout.Width(Screen.width*0.5f-22));
			EditorGUI.indentLevel++;
			if (hasColliders.boolValue) {
				colliderMargin.floatValue=EditorGUILayout.Slider("Collider Margin", colliderMargin.floatValue, 0, 0.3f, GUILayout.Width(Screen.width*0.5f-22));
				bevelAmount.floatValue=EditorGUILayout.Slider("Corner Bevel", bevelAmount.floatValue, 0f, 1f, GUILayout.Width(Screen.width*0.5f-22));
				EditorGUILayout.PropertyField(colliderSlopeCorners);
			}
			EditorGUI.indentLevel--;
			if (EditorGUI.EndChangeCheck()) {RequestUpdate(mapManager.currentTileMaterial);}
		}
		EditorGUILayout.EndVertical();
		
		EditorGUILayout.BeginVertical();
		EditorGUILayout.LabelField("Tilemap options:", boldFont);
		EditorGUILayout.Space();
		tileSize.floatValue=EditorGUILayout.FloatField("Tile Size", tileSize.floatValue, GUILayout.Width(Screen.width*0.5f-22));
		EditorGUILayout.Space();
		EditorGUILayout.BeginHorizontal();
		
		bool toggleGridValue=GUILayout.Toggle(displayGrid.boolValue, !displayGrid.boolValue ? new GUIContent("Toggle Grid") : new GUIContent("Toggle Grid"), "Button", smallButtonOptions);
		if (displayGrid.boolValue!=toggleGridValue) {
			displayGrid.boolValue=toggleGridValue;
		}
		
		if (GUILayout.Button(new GUIContent("Clear Tilemap", "Clears all current map tiles"), smallButtonOptions)) {
			if (EditorUtility.DisplayDialog("Destroy All Map Tiles", "Are you sure?", "Destroy", "Cancel")) {
				ClearMap();
			}
		}
		
		EditorGUILayout.EndHorizontal();
		
		EditorGUILayout.BeginHorizontal();
		if (GUILayout.Button("Remove Material", smallButtonOptions)) {
			tileMaterials.DeleteArrayElementAtIndex(currentTileMaterial.intValue);
			currentTileMaterial.intValue=-1;
		}
		if (GUILayout.Button("Update all", smallButtonOptions)) {
			RequestUpdate();
		}
		EditorGUILayout.EndHorizontal();
		
		EditorGUILayout.Space();
		
		if (isEditing.boolValue) {GUI.color=new Color32(228, 56, 93,255);} else {GUI.color=new Color32(255,210, 23,255);}
		bool toggleEditValue=GUILayout.Toggle(isEditing.boolValue, !isEditing.boolValue ? new GUIContent("Enter Edit Mode") : new GUIContent("Exit Edit Mode"), "Button", largeButtonOptions);
		if (Event.current.type==EventType.KeyDown && Event.current.keyCode==KeyCode.E) {
			toggleEditValue=!isEditing.boolValue;
			Event.current.Use();
		}
		GUI.color=Color.white;
		
		if (isEditing.boolValue!=toggleEditValue) {
			isEditing.boolValue=toggleEditValue;
			if (toggleEditValue) {
				OnStartEdit();
			} else {
				OnEndEdit();
			}
		}
		EditorGUILayout.EndVertical();
		
		EditorGUILayout.EndHorizontal();
	}
	
	void RequestUpdate(int materialIndex=-1) {
		serializedObject.ApplyModifiedProperties();
		if (tileMaterialSerializedObject!=null) {
			tileMaterialSerializedObject.ApplyModifiedProperties();
		}
		mapManager.UpdateAllTiles(materialIndex);
	}
	
	void CheckTilesetDragAndDrop(Rect displayRect) {
		float cellSize=(displayRect.width/8f);
		
		if (mapManager.currentTileMaterial>=0) {
			try {
				EditorGUI.DrawPreviewTexture(displayRect, mapManager.tileMaterials[currentTileMaterial.intValue].renderMaterial.mainTexture);
			} catch {}
		}
		if (Event.current.type==EventType.DragUpdated) {
			if (displayRect.Contains(Event.current.mousePosition)) {
				DragAndDrop.visualMode=DragAndDropVisualMode.Copy;
			} else {
				return;
			}
		}
		if (Event.current.type==EventType.DragPerform && displayRect.Contains(Event.current.mousePosition)) {
			DragAndDrop.AcceptDrag();
			if (DragAndDrop.objectReferences[0] is Material) {
				Material newMaterial=(Material)DragAndDrop.objectReferences[0];
				TileMaterial newTilesetMaterial=ScriptableObjectUtility.CreateAsset<TileMaterial>("TM_"+newMaterial.name);
				if (mapManager.tileMaterials==null) {mapManager.tileMaterials=new List<TileMaterial>();}
				mapManager.tileMaterials.Add(newTilesetMaterial);
				mapManager.currentTileMaterial=mapManager.tileMaterials.Capacity;
				newTilesetMaterial.Init(newMaterial, false, 0.5f, 0.2f);
			} else {
				Debug.LogWarning("Incorrect asset type: Material required");
			}
			RequestUpdate();
		}
		
		for (int i = 0; i <= 8; i++) {
			EditorGUI.DrawRect(new Rect(displayRect.x+cellSize*i-1,displayRect.y,1,displayRect.height), Color.black);
		}
		for (int j = 0; j <= 6; j++) {
			EditorGUI.DrawRect(new Rect(displayRect.x,displayRect.y+cellSize*j-1,displayRect.width,1), Color.black);
		}
		
		GUIStyle whiteStyle=new GUIStyle();
		whiteStyle.normal.textColor=Color.white;
		GUIStyle blackStyle=new GUIStyle();
		blackStyle.normal.textColor=Color.black;
		
		for (int i = 0; i < 8; i++) {
			for (int j = 0; j < 6; j++) {
				int cellNumber=GetCellNumberFromTop(i, j);
				EditorGUI.LabelField(new Rect(displayRect.x+cellSize*i+1, displayRect.y+cellSize*j+1, cellSize, cellSize), ""+cellNumber, blackStyle);
				EditorGUI.LabelField(new Rect(displayRect.x+cellSize*i, displayRect.y+cellSize*j, cellSize, cellSize), ""+cellNumber, whiteStyle);
			}
		}
	}
	
	int GetCellNumberFromTop(int x, int y) {
		return y*8+x;
	}
	
	Tool lastTool;
	void OnStartEdit() {
		lastTool=Tools.current;
		Tools.current = Tool.View;
	}
	
	void OnEndEdit() {
		Tools.current = (lastTool!=Tool.View)?lastTool:Tool.Move;
		if (isEditing!=null && isEditing.boolValue) {
			isEditing.boolValue=false;
		}
	}
	
	void OnDisable() {
		OnEndEdit();
	}
	
	void OnSceneGUI() {
		if (isEditing!=null && isEditing.boolValue) {
			GUIStyle labelStyle=new GUIStyle(GUI.skin.FindStyle("Label"));
			if (labelStyle!=null) {
				labelStyle.normal.textColor=Color.yellow;
				labelStyle.alignment=TextAnchor.LowerLeft; 
				labelStyle.fixedWidth=250;
				labelStyle.fixedHeight=60;
				
				if (Camera.current!=null) {
					Vector3 center=Camera.current.ScreenToWorldPoint(new Vector2(Screen.width*0.05f, Screen.height*0.1f))+Camera.current.transform.forward;
					Handles.Label(center, "TileMap Edit Mode ON\nL Mouse Button: Add/Remove ground\nR Mouse Button: Add/Remove background", labelStyle);
				}
			}
		}
	
		if (isEditing!=null && isEditing.boolValue) {
			Tools.current = Tool.View;
			EditorGUIUtility.AddCursorRect(new Rect(0,0,Screen.width, Screen.height), MouseCursor.Link);
		}
	
		if (Event.current.type==EventType.KeyDown && Event.current.keyCode==KeyCode.E) {
			isEditing.boolValue=!isEditing.boolValue;
			Event.current.Use();
		}
		
		if (isEditing!=null && isEditing.boolValue) {
			UpdateHitPosition();
			if (Tools.current == Tool.View) {
				
				Event e = Event.current;
				
				if (e.type==EventType.MouseUp) {
					mapManager.lastModifiedTileCoords=null;
				}
				
				if (!e.alt) {
					if ((e.type == EventType.MouseDrag || e.type == EventType.MouseDown) && (e.button == 0 || e.button == 1)) {
						
						var relativePos = new Vector2(mouseHitPos.x - mapManager.transform.position.x, mouseHitPos.y - mapManager.transform.position.y);
						DoPaint(relativePos);
						e.Use();
					}
				}
			}
		}
	}
	
	public void UpdateHitPosition() {
		Plane p = new Plane((this.target as MonoBehaviour).transform.TransformDirection(Vector3.forward), new Vector3());
		
		Ray ray = HandleUtility.GUIPointToWorldRay(Event.current.mousePosition);
		
		Vector3 hit = new Vector3();
		float dist;
		if (p.Raycast(ray, out dist)) {
			hit = ray.origin + ray.direction.normalized*dist;
		}
		mouseHitPos = mapManager.transform.position+(this.target as MonoBehaviour).transform.InverseTransformPoint(hit);
	}
	
	delegate void PaintTool(TilePosition tilePosition);
	PaintTool CurrentPaintTool;
	
	void DoPaint(Vector3 pos) {
		TilePosition tileMapPosition=new TilePosition(Mathf.RoundToInt((pos.x-mapManager.gridOffset.x)/mapManager.tileSize), Mathf.RoundToInt((pos.y-mapManager.gridOffset.y)/mapManager.tileSize));
		
		Transform existingTile=mapManager.GetTileTransformFromPosition(tileMapPosition);
		
		if (Event.current.type == EventType.MouseDown) {
			if (existingTile==null) {
				if (Event.current.button==0) {CurrentPaintTool=AnyToSolid;} else {CurrentPaintTool=NullToBack;}
			} else {
				if (existingTile.name.Contains(";B;")) {
					if (Event.current.button==0) {CurrentPaintTool=AnyToSolid;} else {CurrentPaintTool=BackToNull;}
				} else {
					if (Event.current.button==0) {CurrentPaintTool=SolidToBack;} else {CurrentPaintTool=AnyToNull;}
				}
			}
		}
		
		if ((tileMapPosition-mapManager.lastModifiedTileCoords).taxicabDistance>0) {
			CurrentPaintTool(tileMapPosition);
			mapManager.UpdateNeighbours(tileMapPosition);
			mapManager.lastModifiedTileCoords=tileMapPosition;
		}
	}
	
	void SolidToBack(TilePosition tileMapPosition) {
		Transform existingTile=mapManager.GetTileTransformFromPosition(tileMapPosition, true);
		if (existingTile==null) {
			mapManager.AddBackground(tileMapPosition);
		} else {
			mapManager.PushTile(tileMapPosition);
		}
	}
	
	void NullToBack(TilePosition tileMapPosition) {
		Transform existingTile=mapManager.GetTileTransformFromPosition(tileMapPosition, true);
		if (existingTile==null) {
			mapManager.AddBackground(tileMapPosition);
		}
	}
	
	void AnyToSolid(TilePosition tileMapPosition) {
		Transform existingTile=mapManager.GetTileTransformFromPosition(tileMapPosition, true);
		if (existingTile==null) {
			mapManager.AddTile(tileMapPosition);
		} else {
			mapManager.PullTile(tileMapPosition);
		}
	}
	
	void BackToNull(TilePosition tileMapPosition) {
		Transform existingTile=mapManager.GetTileTransformFromPosition(tileMapPosition, true);
		if (existingTile!=null && existingTile.name.Contains(";B;")) {
			AnyToNull(tileMapPosition);
		}
	}
	
	void AnyToNull(TilePosition tileMapPosition) {
		Transform existingTile=mapManager.GetTileTransformFromPosition(tileMapPosition, true);
		if (existingTile!=null) {
			Undo.DestroyObjectImmediate(existingTile.gameObject);
		}
	}
	
	
	Transform GetNeighbour(TilePosition tilePosition) {
		Transform existingTile=mapManager.GetTileTransformFromPosition(tilePosition, false);
		return existingTile;
	}
	
	void ClearMap() {
		for (int i = mapManager.transform.childCount-1; i >=0 ; i--) {
			Undo.DestroyObjectImmediate(mapManager.transform.GetChild(i).gameObject);
		}
		
	} 
	
}

public static class ScriptableObjectUtility {
	public static T CreateAsset<T> (string name="") where T : ScriptableObject {
		T asset = ScriptableObject.CreateInstance<T> ();
		
		string path = AssetDatabase.GetAssetPath (Selection.activeObject);
		if (path == "") {
			path = "Assets";
		} else if (System.IO.Path.GetExtension (path) != "") {
			path = path.Replace (System.IO.Path.GetFileName (AssetDatabase.GetAssetPath (Selection.activeObject)), "");
		}
		
		string selectedPath="";
		selectedPath=EditorUtility.SaveFilePanelInProject("Create new TileMaterial", name, "asset", "Enter a name for the new TileMaterial");
		
		if (selectedPath=="") {return null;}
		
		string assetPathAndName = AssetDatabase.GenerateUniqueAssetPath (path + "/" + name + ".asset");
		
		AssetDatabase.CreateAsset (asset, assetPathAndName);
		EditorUtility.SetDirty(asset);
		
		AssetDatabase.SaveAssets ();
		AssetDatabase.Refresh();
		
		EditorGUIUtility.PingObject(asset);
		
		return asset;
	}
}
#endif