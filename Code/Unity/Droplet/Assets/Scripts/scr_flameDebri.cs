using UnityEngine;
using System.Collections;

public class scr_flameDebri : MonoBehaviour {

    public float witherDelay = 0.5f;
    public float reduction = 0.1f;

	// Use this for initialization
	void Start () {
        InvokeRepeating("Wither", witherDelay, witherDelay);
	}
	
	void Wither()
    {
        if (transform.localScale.x <= 0 || transform.localScale.y <= 0)
        {
            Destroy(gameObject);
        }

        transform.localScale = new Vector2(transform.localScale.x - reduction, transform.localScale.y - reduction);
    }
}
