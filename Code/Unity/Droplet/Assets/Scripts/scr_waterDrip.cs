using UnityEngine;
using System.Collections;

public class scr_waterDrip : MonoBehaviour {

    public Object waterDrop;
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
            if (!CR_running) StartCoroutine(Drip());
        }
    }

    IEnumerator Drip()
    {
        CR_running = true;
        yield return new WaitForSeconds(delay);
        Instantiate(waterDrop, new Vector3(transform.position.x, transform.position.y - 2, transform.position.z + 1), Quaternion.identity);
        CR_running = false;
    }
}
