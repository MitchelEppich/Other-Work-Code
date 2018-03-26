using UnityEngine;
using System.Collections;

public class scr_switch : MonoBehaviour {

    public int key_toggle = 0;
    public GameObject[] connections;

    Animator anim;

	// Use this for initialization
	void Start () {
        anim = GetComponent<Animator>();
    }
	
	// Update is called once per frame
	void Update () {

	}

    void OnMouseOver()
    {
        if (Input.GetMouseButtonDown(0))
        {
            foreach(GameObject c in connections)
            {
                scr_utility u = c.GetComponent<scr_utility>();
                u.SetActive(!u.GetActive());

                anim.SetFloat("Speed", u.GetActive() ? -1 : 1);
                anim.Play("SwitchOnOff", -1, u.GetActive() ? 1 : 0);
            }
        }
    }
}
