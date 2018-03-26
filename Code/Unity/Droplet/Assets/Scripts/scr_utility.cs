using UnityEngine;
using System.Collections;

public class scr_utility : MonoBehaviour {

    public bool active = true;

	// Use this for initialization
	void Start () {

	}
	
	// Update is called once per frame
	void Update () {

	}

    public void SetActive(bool active)
    {
        this.active = active;
    }

    public bool GetActive()
    {
        return this.active;
    }
}
