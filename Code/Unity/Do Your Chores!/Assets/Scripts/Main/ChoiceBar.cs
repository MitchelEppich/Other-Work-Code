using UnityEngine;
using System.Collections;

public class ChoiceBar : MonoBehaviour {

    public Boss boss;

    private float start_choice;
    private float start_scaleX;

    void Start()
    {
        start_scaleX = transform.localScale.x;
        transform.localScale = new Vector3(0, transform.localScale.y, transform.localScale.z);
    }

    void Update()
    {
        transform.localScale = new Vector3(start_scaleX * (boss.stun / start_choice), transform.localScale.y, transform.localScale.z);
    }
}
