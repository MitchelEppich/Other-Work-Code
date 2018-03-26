using UnityEngine;
using System.Collections;

public class Move : MonoBehaviour {

    private Rigidbody body;

	void Awake () {
        body = GetComponent<Rigidbody>();
	}

	void Update () {
        if (Input.GetKey(KeyCode.RightArrow))
            body.AddTorque(Vector3.back * 20f, ForceMode.Force);
        else if (Input.GetKey(KeyCode.LeftArrow))
            body.AddTorque(Vector3.forward * 20f, ForceMode.Force);
    }
}
