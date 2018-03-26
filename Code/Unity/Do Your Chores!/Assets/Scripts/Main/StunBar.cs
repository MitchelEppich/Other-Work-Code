using UnityEngine;
using System.Collections;

public class StunBar : MonoBehaviour {

    public Boss boss;

    private float start_stun;
    private float start_scaleX;

    void Start()
    {
        start_scaleX = transform.localScale.x;
        transform.localScale = new Vector3(0, transform.localScale.y, transform.localScale.z);
    }

    void Update()
    {
        if (boss.stun != 0 && start_stun == 0)
        {
            start_stun = boss.stun;
        }

        transform.localScale = new Vector3(start_scaleX * (boss.stun / start_stun), transform.localScale.y, transform.localScale.z);
    }
}
