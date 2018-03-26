using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Character_Controller : MonoBehaviour {

	public float move_speed;
	public float rotation_speed;
	public float jump_force;

	private Rigidbody body;

	// Use this for initialization
	void Start () {
		// Get Rigidbody component
		body = gameObject.GetComponent <Rigidbody> ();
	}
	
	// Update is called once per frame
	void FixedUpdate () {
		movement ();
	}

	private void movement() {
		/// Move Forward or Backwards
		// Get direction of movement
		float move_direction = Input.GetAxisRaw ( "Vertical" );
		gameObject.transform.position += gameObject.transform.forward * ( move_speed * move_direction );

		/// Rotate around center of character
		// Get direction of rotation
		float rotation_direction = Input.GetAxisRaw ( "Horizontal" );
		gameObject.transform.Rotate ( new Vector3 ( 0, ( rotation_speed * rotation_direction ), 0 ) );

		/// Jump 
		// Check if jumping
		bool canJump = checkIfGrounded();
		float isJumping = Input.GetAxisRaw ( "Jump" );
		if (canJump && isJumping == 1) {
			body.AddForce ( Vector3.up * jump_force );
		}
	}

	private bool checkIfGrounded() {

		if (body.velocity.y == 0)
			return true; // Not solution for ground test!

		return false;
	}
}
