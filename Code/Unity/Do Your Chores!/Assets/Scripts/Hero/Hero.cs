using UnityEngine;
using System.Collections;

public class Hero : MonoBehaviour {

    public Boss boss;

    private Renderer rend;

    public Vector2 start_pos;

    public float rest_time;
    public float shield_time;

    public int timer;
    public int tick = 60;

    public bool attack;
    public bool shield;
    public bool shielded;

	void Awake () {
        rend = transform.GetComponent<Renderer>();
        start_pos = transform.position;
	}

	void Update () {
        
        if (shielded)
        {
            rend.material.color = Color.blue;
            if (transform.position.x != start_pos.x)
            {
                shielded = false;
                boss.transform.position = boss.start_pos;
                transform.position = start_pos;
            }
        } else
            rend.material.color = Color.green;

        if (timer != 0)
        {
            timer--;
            shield = attack = false;
            return;
        } else
        {
            shielded = false;
        }

        if (shield || attack)
            timer = (int)(rest_time * tick);

        if (attack)
        {
            attack = false;
            if (boss.stun == 0)
            {
                boss.health -= 1;
                boss.stun = boss.tick * 10;
            }
        }

        if (shield)
        {
            shield = false;
            timer = (int)(shield_time * tick);
            shielded = true;
        }

        if (transform.position.x != start_pos.x)
        {
            // Game Over :: Player Loses
            Debug.Log("Player Loses!");
        }
    }
}
