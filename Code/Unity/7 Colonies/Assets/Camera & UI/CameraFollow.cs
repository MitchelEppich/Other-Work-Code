using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow : MonoBehaviour {

    GameObject player;

	// Use this for initialization
	void Start () {
        player = GameObject.FindGameObjectWithTag("Player");
        print(player.ToString());
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    private void LateUpdate()
    {
        gameObject.transform.position = player.transform.position;
    }

}
