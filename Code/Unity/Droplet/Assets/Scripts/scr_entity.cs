using UnityEngine;
using System.Collections;

public class scr_entity : MonoBehaviour {

    BoxCollider2D bc2d;
    Rigidbody2D rg2d;

    public float gravityScale = 2f;
    public float mass = 1f;

    float speed = 1f;
    public float ground_speed = 1f;
    public float air_speed = 0.5f;
    public float jumpForce = 1f;

    public int grounded = 0;

	// Use this for initialization
	void Start () {
        bc2d = gameObject.AddComponent<BoxCollider2D>();
        rg2d = gameObject.AddComponent<Rigidbody2D>();

        rg2d.gravityScale = gravityScale;
        rg2d.mass = mass;

        rg2d.freezeRotation = true;
	}
	
	// Update is called once per frame
	void Update () {

        int key_jump = Input.GetKey("space") && grounded == 1 ? 1 : 0;

        rg2d.gravityScale = grounded == 0 && key_jump == 0? gravityScale : 0;

        speed = grounded == 1 ? ground_speed : air_speed;

        Vector2 pos = new Vector2(transform.position.x + speed * Input.GetAxis("Horizontal"), Mathf.Lerp(transform.position.y, transform.position.y + jumpForce * key_jump, 0.1f));
        transform.position = pos;
	}

    void OnCollisionStay2D(Collision2D coll)
    {
        if (coll.gameObject.tag == "t_solid")
        {
            grounded = 1;
        }
    }

    void OnCollisionExit2D(Collision2D coll)
    {
        if (coll.gameObject.tag == "t_solid")
        {
            grounded = 0;
        }
    }
}
