using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class scr_CameraController : MonoBehaviour {

    int screen_x = Screen.width / 2;
    int screen_y = Screen.height / 2;

    void Update ()
    {
		if (Input.GetKey(KeyCode.UpArrow)) {
            // Pan forward
            transform.Translate(transform.forward * 5);
		}
        if (Input.GetKey(KeyCode.DownArrow))
        {
            // Pan backward
            transform.Translate(-transform.forward * 5);
        }
        if (Input.GetKey(KeyCode.RightArrow))
        {
            // Pan right
            transform.Translate(Vector3.right * 5);
        }
        if (Input.GetKey(KeyCode.LeftArrow))
        {
            // Pan left
            transform.Translate(Vector3.left * 5);
        }
        if (Input.GetAxis("Mouse ScrollWheel") > 0f) 
        {
            // Zoom out
            transform.Translate(Vector3.forward * 5);
        }
        if (Input.GetAxis("Mouse ScrollWheel") < 0f)
        {
            // Zoom in
            transform.Translate(Vector3.back * 5);
        }
        if (Input.GetMouseButton(2))
        {
            float mouse_x = Input.mousePosition.x;
            float mouse_y = Input.mousePosition.y;

            float distance_x = mouse_x - screen_x;
            float distance_y = mouse_y - screen_y;

            float percent_x = distance_x / screen_x;
            float percent_y = distance_y / screen_y;

            //Debug.Log("Before : " + percent_x + " " + screen_x + " " + distance_x);

            percent_x *= 1;
            percent_y *= 1;

            //Debug.Log(percent_x);

            // Rotate on Gimbal
            //transform.RotateAround(Vector3.zero, -transform.up, percent_x * Time.deltaTime);
            //.RotateAround(Vector3.zero, transform.right, percent_y * Time.deltaTime);

            transform.rotation = Quaternion.AngleAxis(percent_x, transform.up);
            Debug.Log(transform.localRotation);
            //transform.rotation = Quaternion.AngleAxis(percent_y, -transform.right);//Quaternion.Euler(transform.rotation.x + percent_y, transform.rotation.y + -percent_x, 0);
        }
    }
}
