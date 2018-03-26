using UnityEngine;
using System.Collections;

public class scr_camera : MonoBehaviour {

    public int distanceFromTarget = 40;
    public float speed = 0.1f;
    public GameObject target;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
        transform.position = Vector3.Lerp(transform.position, new Vector3(target.transform.position.x, target.transform.position.y, -distanceFromTarget), speed);
	}
}
