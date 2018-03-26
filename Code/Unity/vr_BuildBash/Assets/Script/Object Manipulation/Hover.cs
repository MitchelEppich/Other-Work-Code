using UnityEngine;
using System.Collections;

public class Hover : MonoBehaviour {

    GameObject hover_object;

	// Use this for initialization
	void Start () {

	}
	
	// Update is called once per frame
	void Update () {
        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);

        RaycastHit hit;

        if (Physics.Raycast(ray, out hit))
        {
            if (hover_object != hit.collider.gameObject)
            {
                if (hover_object != null)
                {
                    hit.collider.GetComponent<Renderer>().material.color = Color.white;
                    hover_object = hit.collider.gameObject;
                }

                hit.collider.GetComponent<Renderer>().material.color = Color.red;
            }
        }
    }
}
