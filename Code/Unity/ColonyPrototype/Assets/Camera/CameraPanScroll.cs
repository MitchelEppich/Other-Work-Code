using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraPanScroll : MonoBehaviour {

    Camera viewCamera;

    float panSpeed = 1.0f;
    float scrollSpeed = 1.0f;

    // Use this for initialization
    void Start () {
        viewCamera = Camera.main;
    }

    private void FixedUpdate()
    {
        if (Input.GetMouseButton(2))
        {
            // Move camera to mouse position
            Ray ray = viewCamera.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;
            if (!Physics.Raycast(ray, out hit))
            {
                return;
            }

            var pos = hit.point;
            pos.y = 50;
            print(pos);

            viewCamera.transform.position = pos;
        }

    }
}
