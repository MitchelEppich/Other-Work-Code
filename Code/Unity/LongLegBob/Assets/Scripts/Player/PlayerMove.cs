using UnityEngine;
using System.Collections;

public class PlayerMove : MonoBehaviour {

    public float speed;
    public float acceleration;

    public int direction;
    private bool isMoving;
    private bool isStomping;
    private bool isThrowing;
    private bool isDying;
    private bool isHit;
    private bool isWaving;
    private bool isCleaning;
    private bool isIdling;

    private Animator anim;
    private Rigidbody2D body;

    void Awake()
    {
        anim = GetComponent<Animator>();
        body = GetComponent<Rigidbody2D>();
    }

    void Update()
    {

        isMoving = move_right || move_right || dx == 0

        anim.SetBool("isStomping", isStomping);
        anim.SetBool("isWalking", isMoving);
        anim.SetBool("isIdling", isIdling);
    }
    /*
    private bool Move()
    {

        if (isStomping)
            return false;

        direction = System.Convert.ToInt32(Input.GetKey(KeyCode.RightArrow)) - System.Convert.ToInt32(Input.GetKey(KeyCode.LeftArrow));

        if (direction != 0)
        {
            if (Mathf.Abs(body.velocity.x) < speed) body.velocity += new Vector2(direction, 0) * acceleration;
            transform.localScale = new Vector3(Mathf.Abs(transform.localScale.x) * direction, transform.localScale.y, transform.localScale.z);
        }

        if (Mathf.Abs(body.velocity.x) < acceleration * 10f && direction == 0)
        {
            body.velocity = Vector2.zero;
            return isWalking = false;
        }
        else
        {
            return isWalking = true;
        }
    }

    private bool Attack()
    {
        if (Input.GetKey(KeyCode.Space))
        {
            return isStomping = true;
        }

        return isStomping = false;
    }

    private void Idle()
    {
        isIdling = true;
    }*/

}
