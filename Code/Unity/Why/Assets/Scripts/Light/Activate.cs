using UnityEngine;
using System.Collections;

public class Activate : MonoBehaviour {

    [Range(0, 10)]
    public float distanceThreshold;

    public GameObject playerInstance;
    public Light light;

    private float distanceToPlayer;

    void Awake()
    {
        playerInstance = GameObject.Find("Player");
        light = GetComponent<Light>();
    }

    void Update()
    {
        distanceToPlayer = playerInstance.transform.position.x - transform.position.x;

        if (distanceToPlayer > -distanceThreshold && distanceToPlayer < distanceThreshold * 10f)
        {
            light.enabled = true;
        }
        else
        {
            light.enabled = false;
        }
    }
}
