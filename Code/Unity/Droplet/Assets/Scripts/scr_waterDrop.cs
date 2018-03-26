using UnityEngine;
using System.Collections;

public class scr_waterDrop : MonoBehaviour {

    public int overtaken = 0;
    public float life = 60;

    public scr_waterHandler water;

	// Use this for initialization
	void Start () {
        water = GetComponent<scr_waterHandler>();
        water.water = 1;
	}
	
	// Update is called once per frame
	void Update () {
        InvokeRepeating("LifeSpan", 1, 0);
	}

    void OnCollisionStay2D(Collision2D coll)
    {
        if (coll.gameObject.tag == "t_water" || coll.gameObject.tag == "t_player")
        {
            scr_waterHandler wd = coll.gameObject.GetComponent<scr_waterHandler>();
            if (wd.water < 100 && life < 0 && (wd.water > water.water - 1 || coll.gameObject.tag == "t_player"))
            {
                water.TransferWater(ref water.water, ref wd.water, -1);
            }
        }
    }

    void LifeSpan()
    {
        life--;
    }
}
