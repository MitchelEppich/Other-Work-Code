using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow : MonoBehaviour {

    public Transform target;
    public Vector3 distance;
    public void Update()
    {
        transform.position = new Vector3(target.transform.position.x - distance.x, target.transform.position.y - distance.y, target.transform.position.z - distance.z);

    }

}
