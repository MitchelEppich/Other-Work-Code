using UnityEngine;
using System.Collections;

public class Follow : MonoBehaviour {

    [Range(0.1f, 1)]
    public float speed;
    [Range(0, 5)]
    public float distanceThreshold;

    public GameObject playerInstance;

    private float distanceToPlayer;

	void Awake () {
	    
	}

	void Update () {
        distanceToPlayer = playerInstance.transform.position.x - transform.position.x;
        if (Mathf.Abs(distanceToPlayer) > distanceThreshold)
            transform.position = new Vector3(
                transform.position.x + (distanceToPlayer * (speed/100)), 
                transform.position.y,
                transform.position.z);
	}
}
