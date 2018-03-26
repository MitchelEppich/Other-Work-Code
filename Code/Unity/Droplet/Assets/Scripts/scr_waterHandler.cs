using UnityEngine;
using System.Collections;

public class scr_waterHandler : MonoBehaviour {

    public float water = 0;
    public bool destructable = true;
    public bool resizable = true;
    public bool bottomless = false;
    public bool isSource = false;
    public bool isDrain = false;

    public GameObject source = null;
    public GameObject drain = null;

    public int collecting = 0;
    public int dispersing = 0;

    public int sourceFound = 0;
    public int drainFound = 0;

    public float dispersionDelay = 0;
    public float collectionDelay = 0;

    // Use this for initialization
    void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
        if (water < 1 && destructable)
            Destroy(gameObject);
        if (resizable)
            AdjustSize();
    }



    public void TransferWater(ref float from, ref float to, float amt)
    {
        amt = amt == -1 ? from : amt;
            
        if (from >= amt)
        {
            amt = bottomless ? amt : Mathf.Min(amt, 100 - to);
            to += amt;
            from -= amt;
        }
    }

    void AdjustSize()
    {
        float x = 1f + (float)water / 5f;
        float y = 1f + (float)water / 5f;

        transform.localScale = Vector2.Lerp(transform.localScale, new Vector2(x, y), 0.1f);
    }

    public void StartCollection()
    {
        if (collecting == 0 && (sourceFound == 1 || isSource))
        {
            StartCoroutine(Collect());
        }
    }

    public void StartDispersion()
    {
        if (dispersing == 0 && (drainFound == 1 || isDrain))
        {
            StartCoroutine(Disperse());
        }
    }

    IEnumerator Collect()
    {
        collecting = 1;
        yield return new WaitForSeconds(collectionDelay);
        if (source) TransferWater(ref source.GetComponent<scr_waterHandler>().water, ref water, 1);
        collecting = 0;
    }

    IEnumerator Disperse()
    {
        dispersing = 1;
        yield return new WaitForSeconds(dispersionDelay);
        if (drain) TransferWater(ref water, ref drain.GetComponent<scr_waterHandler>().water, 1);
        dispersing = 0;
    }

    void OnCollisionStay2D(Collision2D coll)
    {
        if (coll.gameObject.tag == "t_source" || coll.gameObject.tag == "t_water")
        {
            sourceFound = 1;
            source = coll.gameObject;
        }

        if (coll.gameObject.tag == "t_drain")
        {
            drainFound = 1;
            drain = coll.gameObject;
        }
    }

    void OnCollisionExit2D(Collision2D coll)
    {
        if (coll.gameObject.tag == "t_source" || coll.gameObject.tag == "t_water")
        {
            sourceFound = 0;
            source = null;
        }

        if (coll.gameObject.tag == "t_drain")
        {
            drainFound = 0;
            drain = null;
        }
    }
}
