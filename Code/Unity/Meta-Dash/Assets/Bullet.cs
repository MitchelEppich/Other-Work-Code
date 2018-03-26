using UnityEngine;
using System.Collections;

public class Bullet : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

    void OnCollisionStay(Collision collision)
    {
        collision.collider.GetComponent<Rigidbody>().isKinematic = false;
    }

}
