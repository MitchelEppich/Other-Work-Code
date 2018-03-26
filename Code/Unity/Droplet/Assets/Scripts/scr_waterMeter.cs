using UnityEngine;
using System.Collections;

public class scr_waterMeter : MonoBehaviour {

    public GameObject holder;
    public GameObject filler;
    public GameObject target;

    public float waterLevel = 0;
    public float max = 100;

    public float duration = 0.01f;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
        waterLevel = target.GetComponent<scr_waterHandler>().water;

        //filler.transform.localScale = holder.GetComponent(typeof(scr_bucket)).waterLevel / max;
        duration = waterLevel >= 1 ? 0.01f : 0;
        filler.transform.localScale = new Vector2(filler.transform.localScale.x, Mathf.Lerp(waterLevel/100, max/100, duration));

        if (waterLevel >= 100)
            Application.LoadLevel(Application.loadedLevelName);
	}
}
