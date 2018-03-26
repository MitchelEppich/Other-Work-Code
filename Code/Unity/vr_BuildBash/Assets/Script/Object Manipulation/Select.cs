using UnityEngine;
using System.Collections;

public class Select : MonoBehaviour {

    public ArrayList selected_object;

	// Use this for initialization
	void Start () {
        selected_object = new ArrayList();
	}
	
	// Update is called once per frame
	void Update () {

        if (Input.GetMouseButtonDown(0))
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);

            RaycastHit hit;

            if (Physics.Raycast(ray, out hit))
            {
                if (selected_object.Contains(hit.collider.gameObject))
                {
                    hit.collider.GetComponent<Renderer>().material.color = Color.white;
                    selected_object.Remove(hit.collider.gameObject);
                }
                else
                {
                    hit.collider.GetComponent<Renderer>().material.color = Color.cyan;
                    selected_object.Add(hit.collider.gameObject);
                }
            }
        }
    }

    public ArrayList GetSelectedObject()
    {
        return selected_object;
    }

    public void EmptySelectedObject()
    {
        selected_object = new ArrayList();
    }
}
