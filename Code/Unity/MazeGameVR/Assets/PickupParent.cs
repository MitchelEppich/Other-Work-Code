using UnityEngine;
using System.Collections;

[RequireComponent(typeof(SteamVR_TrackedObject))]
public class HMD_Player : MonoBehaviour {

    SteamVR_TrackedObject trackedObj;
    public GameObject model;

	void Awake () {
        trackedObj = GetComponent<SteamVR_TrackedObject>();
	}
	
	void FixedUpdate () {
        SteamVR_Controller.Device device = SteamVR_Controller.Input((int)trackedObj.index);
        if(device.GetPressUp(SteamVR_Controller.ButtonMask.Trigger))
        {
            Debug.Log("You are holding 'Touch' on the trigger.");
        }
    }
}
