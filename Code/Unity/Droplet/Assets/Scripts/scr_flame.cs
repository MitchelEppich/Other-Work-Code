using UnityEngine;
using System.Collections;

public class scr_flame : MonoBehaviour {

    public float speed = 1.5f;
    public float duration = 15f;

    public GameObject debri;

    int exit = 0;

	// Use this for initialization
	void Start () {
        speed = Random.Range(0.5f, 4.0f);
	}
	
	// Update is called once per frame
	void Update () {
        if (duration <= 5)
        {
            Animator anim = GetComponent<Animator>();

            if (!anim.enabled && exit == 0)
            {
                anim.enabled = true;
                exit = 1;
            }
            else if (exit == 1)
            {
                for (int i = 0; i < 8; i++)
                {
                    GameObject d = Instantiate(debri, transform.position, Quaternion.identity) as GameObject;
                    d.transform.eulerAngles = new Vector3(0, 0, Random.Range(0, 360));
                    d.GetComponent<Rigidbody2D>().AddForce(d.transform.up * 100);
                }
                exit = 2;
            }

            if (anim.GetBool("Done"))
            {
                Destroy(gameObject);
            }

        }

        if (duration > 0) transform.position = Vector2.Lerp(transform.position, new Vector2(transform.position.x, transform.position.y + speed * duration--), 0.05f);
	}
}
