using UnityEngine;
using System.Collections;

public class scr_player : MonoBehaviour {

    
    public int sourceFound = 0;
    public int drainFound = 0;
    public scr_waterHandler water;
    
    public int enableCollection = 0;
    public float collectionDelay = 5;

    public int enableDispersion = 0;
    public float dispersionDelay = 5;

	// Use this for initialization
	void Start () {
        water = GetComponent<scr_waterHandler>();
    }
	
	// Update is called once per frame
	void Update () {

        enableCollection = enableDispersion = Input.GetKey(KeyCode.LeftShift) ? 1 : 0;

        if (enableCollection == 1)
        {
            water.StartCollection();
        }

        if (enableDispersion == 1)
        {
            water.StartDispersion();
        }
    }
}
