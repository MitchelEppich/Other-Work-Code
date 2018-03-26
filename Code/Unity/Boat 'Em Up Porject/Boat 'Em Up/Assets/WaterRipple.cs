using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WaterRipple : MonoBehaviour {

	// Use this for initialization
	void Start () {
        StartCoroutine(Example()); //this will run your timer
    }
	
	// Update is called once per frame
	void Update () {
        
    }

    IEnumerator Example()
    {
        yield return new WaitForSeconds(this.GetComponent<Animator>().GetCurrentAnimatorStateInfo(0).length); //this will wait 5 seconds
        Destroy(gameObject);
    }
}
