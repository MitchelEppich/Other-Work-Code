using UnityEngine;
using System.Collections;

public class scr_bucket : MonoBehaviour {

    public scr_waterHandler water;

    public GameObject source;

    public int collecting = 0;
    public float collectionDelay = 0;

    // Use this for initialization
    void Start () {
        water = GetComponent<scr_waterHandler>();
    }
	
	// Update is called once per frame
	void Update () {

    }

    void OnCollisionStay2D(Collision2D coll)
    {
        if (coll.gameObject.tag == "t_water")
        {
            water.StartCollection();
        }
    }

    void OnCollisionExit2D(Collision2D coll)
    {
        if (coll.gameObject.tag == "t_water")
        {
            source = null;
        }
    }
}
