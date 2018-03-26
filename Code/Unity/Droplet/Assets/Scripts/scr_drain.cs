using UnityEngine;
using System.Collections;

public class scr_drain : MonoBehaviour {

    public scr_waterHandler water;

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
            scr_waterHandler w = coll.gameObject.GetComponent<scr_waterHandler>();
            water.TransferWater(ref w.water, ref water.water, -1);
        }
    }
}
