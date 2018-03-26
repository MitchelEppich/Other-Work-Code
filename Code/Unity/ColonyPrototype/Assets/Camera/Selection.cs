using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Selection : MonoBehaviour {

    CameraRaycaster camRayCast;

    List<GameObject> charArr = new List<GameObject>();

	// Use this for initialization
	void Start () {
        camRayCast = Camera.main.GetComponent<CameraRaycaster>();
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    private void FixedUpdate()
    {
        if (camRayCast.currentLayerHit == Layer.Civilian)
        {
            var character = camRayCast.hit.transform.gameObject;
            if (!charArr.Contains(character))
            {
                charArr.Add(character);
            }
        }
    }
}
