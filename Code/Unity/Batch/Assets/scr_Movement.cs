using UnityEngine;
using System.Collections;

public class scr_Movement : MonoBehaviour {

    #region Key Bindings

    int key_right, key_left, key_up, key_down;

    #endregion
    #region Stats
    float speed = 1.0f;
    #endregion

    // Use this for initialization
    void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
        KeyUpdate();

        float dy = (key_up - key_down) * speed;
        float dx = (key_right - key_left) * speed;

        Move(transform.position.x + dx, transform.position.y + dy);

    }

    void KeyUpdate ()
    {
        key_right = Input.GetKey("right") ? 1 : 0;
        key_left = Input.GetKey("left") ? 1 : 0;
        key_up = Input.GetKey("up") ? 1 : 0;
        key_down = Input.GetKey("down") ? 1 : 0;
    }

    void Move (float x, float y)
    {
        transform.position = new Vector3(x, y, 0);
    }
}
