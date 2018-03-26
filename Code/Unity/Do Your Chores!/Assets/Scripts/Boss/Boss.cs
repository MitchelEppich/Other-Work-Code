using UnityEngine;
using System.Collections;

public class Boss : MonoBehaviour {

    public Vector3 start_pos;

    public float speed;
    public float stun_time;
    public float rest_time;
    public float step_time;

    public int health;
    public int stun;
    public int tick = 60;
    public int timer;
    
    private bool isAlive = true;

    private Renderer rend;

	void Awake () {
        rend = transform.GetComponent<Renderer>();

        start_pos = transform.position;
	}

	void Update () {

        if (health <= 0)
            isAlive = false;

	    if (stun != 0)
        {
            if (stun % (tick / 4) == 0)
                rend.enabled = !rend.enabled;

            stun--;
            return;
        }

        if (!rend.enabled) rend.enabled = true;

        if (isAlive)
        {
            if (timer > 0)
            {
                timer--;

                if (timer == 0)
                    timer = (int)-(step_time * tick);

                return;
            }

            transform.position += Vector3.left * speed * Time.deltaTime;

            if (timer == 0)
                timer = (int)(rest_time * tick);
            else if (timer < 0)
                timer++;

            return;
        }

        // Game Over :: Player Wins
        Debug.Log("Player Wins!");
	}
}
