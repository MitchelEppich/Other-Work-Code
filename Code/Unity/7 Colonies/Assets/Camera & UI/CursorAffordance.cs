using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(CameraRaycaster))]
public class CursorAffordance : MonoBehaviour {

    [SerializeField] Texture2D[] cursors = { };

    [SerializeField] Vector2 cursorHotspot = new Vector2(0, 0);

    CameraRaycaster cameraRaycaster;

	// Use this for initialization
	void Start () {
        cameraRaycaster = GetComponent<CameraRaycaster>();
	}
	
	// Update is called once per frame
	void Update () {
        foreach (Texture2D cursor in cursors)
        {
            if (cursor.name == cameraRaycaster.currentLayerHit.ToString())
            {
                Cursor.SetCursor(cursor, cursorHotspot, CursorMode.Auto);
                break;
            }
        }
    }
}
