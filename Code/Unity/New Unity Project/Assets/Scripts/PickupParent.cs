using UnityEngine;
using System.Collections;

[RequireComponent(typeof(SteamVR_TrackedObject))]
public class PickupParent : MonoBehaviour {

    SteamVR_TrackedObject trackedObj;
    public GameObject model;

    public float baseSpeed = 2f;
    public float maxSpeed = 30f;
    public float rateOfSpeed = 0.2f;
    public float speed = 0f;

	void Awake () {
        trackedObj = GetComponent<SteamVR_TrackedObject>();
	}
	
	void FixedUpdate () {
        SteamVR_Controller.Device device = SteamVR_Controller.Input((int)trackedObj.index);
        if(device.GetTouch(SteamVR_Controller.ButtonMask.Trigger))
        {
            Debug.Log("You are holding 'Touch' on the trigger.");
        }

        if (device.GetTouchUp(SteamVR_Controller.ButtonMask.Trigger))
        {
            Debug.Log("You are holding 'Touch Up' on the trigger.");
        }

        if (device.GetTouchDown(SteamVR_Controller.ButtonMask.Trigger))
        {
            Debug.Log("You are holding 'Touch Down' on the trigger.");
        }

        if (device.GetPress(SteamVR_Controller.ButtonMask.Trigger))
        {
            Debug.Log("You are holding 'Press' on the trigger.");
            if (speed < maxSpeed)
                speed += rateOfSpeed;
        }

        if (device.GetPressUp(SteamVR_Controller.ButtonMask.Trigger))
        {
            Debug.Log("You are holding 'Press Up' on the trigger.");
            GameObject obj = GameObject.CreatePrimitive(PrimitiveType.Sphere);
            obj.gameObject.transform.localScale = new Vector3(0.3f, 0.3f, 0.3f);
            Rigidbody body = obj.AddComponent<Rigidbody>();
            body.velocity = model.transform.forward * speed;
            obj.gameObject.transform.position = new Vector3(transform.position.x, transform.position.y, transform.position.z);
        }

        if (device.GetPressDown(SteamVR_Controller.ButtonMask.Trigger))
        {
            Debug.Log("You are holding 'Press Down' on the trigger.");
            speed = baseSpeed;
        }
    }
}
