using UnityEngine;
using System.Collections;

public class scr_clock : MonoBehaviour {

    public GameObject hourArm;
    public GameObject minuteArm;
    public GameObject secondArm;

    public float speed = 30f;

	// Use this for initialization
	void Start () {
	    
	}
	
	// Update is called once per frame
	void Update () {
        secondArm.transform.Rotate(Vector3.back * Time.deltaTime * speed);
        minuteArm.transform.Rotate(Vector3.back * Time.deltaTime * speed/10);
        hourArm.transform.Rotate(Vector3.back * Time.deltaTime * speed/100);
    }
}
