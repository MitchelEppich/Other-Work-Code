using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Boat : MonoBehaviour {

    Animator anim;
    Rigidbody2D body;
    float appliedTorque = 0.0f;
    float currentTorque = 0.0f;
    float liveLimit = 0.0f;
    float speedMultiplier = 6.0f;
    Vector2 dir;
    public GameObject water_ripple;
    public GameObject motor_position;

    // Use this for initialization
    void Start() {
        anim = GetComponent<Animator>();
        body = GetComponent<Rigidbody2D>();
    }

    // Update is called once per frame
    void Update() {
        // Get front direction
        dir = transform.up;
        // Move Forward
        if (Input.GetKey(KeyCode.W))
        {
            anim.SetBool("accelerate", true);
            body.AddForce(dir * speedMultiplier);
        }
        if (Input.GetKeyUp(KeyCode.W))
        {
            anim.SetBool("accelerate", false);
        }
        // Slow Down
        if (Input.GetKey(KeyCode.S) && body.velocity.y > 0)
        { 
            anim.SetBool("deccelerate", true);
            body.AddForce(-dir * speedMultiplier);
        }
        if (Input.GetKeyUp(KeyCode.S) || body.velocity.y <= 0)
        { 
            anim.SetBool("deccelerate", false);
        }
        // Turn Right
        if (Input.GetKey(KeyCode.D))
        {
            anim.SetBool("turnRight", true);
            appliedTorque = liveLimit;
        }
        if (Input.GetKeyUp(KeyCode.D))
        {
            anim.SetBool("turnRight", false);
        }
        // Turn Left
        if (Input.GetKey(KeyCode.A))
        {
            anim.SetBool("turnLeft", true);
            appliedTorque = -liveLimit;
        }
        if (Input.GetKeyUp(KeyCode.A))
        {
            anim.SetBool("turnLeft", false);
        }
        // Moving Tracker
        if(body.velocity != Vector2.zero)
        {
            anim.SetBool("moving", true);
        }
        else
        {
            anim.SetBool("moving", false);
        }
        // Constant Lerping Torque
        liveLimit = 50 + (20 * body.velocity.magnitude);
        /// Transition Torque
        Debug.Log(currentTorque);
        if (Mathf.Abs(appliedTorque) < 1)
        {
            currentTorque += appliedTorque;
            appliedTorque = 0;
        }
        else if (appliedTorque != 0)
        {
            currentTorque += appliedTorque * 0.10f;
            appliedTorque *= 0.90f;
        }
        /// Limit Live torque
        if (currentTorque > liveLimit) currentTorque = liveLimit;
        if (currentTorque < -liveLimit) currentTorque = -liveLimit;
        /// Limit Max torque
        if (currentTorque > 300) currentTorque = 300;
        if (currentTorque < -300) currentTorque = -300;
        /// Apply torque
        body.AddTorque(currentTorque);
        /// Decrease torque
        currentTorque *= 0.95f;
        if (Mathf.Abs(currentTorque) < 0.4f) currentTorque = 0;
        // Spawn water ripples
        if (body.velocity.magnitude > 1)
        {
            float spawnTime = 0.8f * (1 - (body.velocity.magnitude / 15));
            Invoke("SpawnWaterRipple", spawnTime);
        }
    }

    void SpawnWaterRipple()
    {
        Instantiate(water_ripple, motor_position.transform.position, Quaternion.identity);
        CancelInvoke();
    }
}
