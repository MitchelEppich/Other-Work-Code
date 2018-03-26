using UnityEngine;
using System.Collections;

public class scr_flameThrower : MonoBehaviour {

    public GameObject flame;
    public float delay = 5;

    scr_utility utility;

    private bool CR_running = false;

    void Start()
    {
        utility = GetComponent<scr_utility>();
    }

    void Update()
    {
        if (utility.GetActive())
        {
            if (!CR_running) StartCoroutine(Fire());
        }
    }

    IEnumerator Fire()
    {
        CR_running = true;
        yield return new WaitForSeconds(delay);
        GameObject f = Instantiate(flame, new Vector2(transform.position.x, transform.position.y), Quaternion.identity) as GameObject;
        f.GetComponent<Animator>().enabled = false;
        CR_running = false;
    }
}
