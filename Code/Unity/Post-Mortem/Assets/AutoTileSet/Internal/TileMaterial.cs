using UnityEngine;
using System.Collections;
#if UNITY_EDITOR
using UnityEditor;
#endif

[System.Serializable]
public class TileMaterial : ScriptableObject {
	public Material renderMaterial;
	public PhysicsMaterial2D physicMaterial;
	
	public bool  transparentTileset=false;
	public bool  hasBleeding;
	public float frontLayerDepth=0;
	public float backLayerDepth=0.1f;
	
	public bool  hasColliders=true;
	public float colliderMargin=0.1f;
	public float bevelAmount=1f;
	public bool  colliderSlopeCorners;
	
	Sprite[] sprites;
	
	public void Init(Material material, bool slopedCorners, float bevelAmount, float colliderMargin) {
		this.renderMaterial=material;
		this.colliderSlopeCorners=slopedCorners;
		this.bevelAmount=bevelAmount;
		
		if (material==null) {
			Material newMaterial=new Material(Shader.Find("Unlit/Texture"));
			material=newMaterial;
			Texture2D newTexture=new Texture2D(8,6);
			newTexture.SetPixel(4,3, (Color.blue+Color.white)*0.5f); newTexture.Apply();
			material.mainTexture=newTexture;
		}
		
		CheckBleeding(material.mainTexture);
	}
	
	public Sprite GetSprite(int index) {
		if (sprites==null || sprites.Length<48) {
			sprites=new Sprite[48];
		}
		if (sprites[index]==null) {
			sprites[index]=CreateSpriteFromIndex(index);
		}
		
		return sprites[index];
	}
	
	Sprite CreateSpriteFromIndex(int index) {
		return CreateSpriteFromSlicePosition(TilesetPositionFromIndex(index));
	}
	
	Sprite CreateSpriteFromSlicePosition(Vector2 slicePosition) {
		float bleeding=(hasBleeding?2:0);
		Texture2D texture=(Texture2D)renderMaterial.mainTexture;
		float spriteWidth=((float)texture.width)/8f;
		Sprite newSprite=Sprite.Create(
			texture,
			new Rect(slicePosition.x*spriteWidth+bleeding,
			slicePosition.y*spriteWidth+bleeding,
			spriteWidth-bleeding*2,
		    spriteWidth-bleeding*2),
			Vector2.one*0.5f,
			spriteWidth-bleeding*2,
			0,
			SpriteMeshType.FullRect);
		newSprite.hideFlags=HideFlags.DontSave;
		
		return newSprite;
	}
	
	public static Vector2 TilesetPositionFromIndex(int index) {
		int x=(index%8);
		int y=5-Mathf.FloorToInt((float)index/8f);
		return new Vector2(x,y);
	}
	
	bool CheckBleeding(Texture texture) {
		int tileWidth=Mathf.RoundToInt(texture.width/8f);
		return !Mathf.IsPowerOfTwo(tileWidth);
	}
}
