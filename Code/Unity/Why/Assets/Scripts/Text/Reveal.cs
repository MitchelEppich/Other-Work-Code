using UnityEngine;
using System.Collections;

public class Reveal : MonoBehaviour {

    [Range(0, 10)]
    public float distanceThreshold;
    public float startZ;

    public GameObject playerInstance;

    private float distanceToPlayer;
    private float ratio;
    private float zOffset = 1f;

    void Awake () {
        playerInstance = GameObject.Find("Player");
    }

	void Update () {
        distanceToPlayer = playerInstance.transform.position.x - transform.position.x;
        ratio = 1 - (Mathf.Abs(distanceToPlayer) / distanceThreshold);
        if (ratio >= 0 && ratio < 1 && distanceToPlayer < 0)
            transform.position = new Vector3(
                transform.position.x,
                transform.position.y,
                startZ - (zOffset * ratio));
        else if (distanceToPlayer >= 0 && transform.position.z != startZ - zOffset)
            transform.position = new Vector3(
                transform.position.x,
                transform.position.y,
                startZ - zOffset);
    }
}
