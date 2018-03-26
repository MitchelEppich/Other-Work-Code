using UnityEngine;
using System.Collections;

public class HealthBar : MonoBehaviour {

    public Boss boss;

    private float start_health;
    private float start_scaleX;
	
	void Awake()
    {
        start_health = boss.health;
        start_scaleX = transform.localScale.x;
    }

	void Update () {
        transform.localScale = new Vector3(start_scaleX * (boss.health / start_health), transform.localScale.y, transform.localScale.z);
	}
}
