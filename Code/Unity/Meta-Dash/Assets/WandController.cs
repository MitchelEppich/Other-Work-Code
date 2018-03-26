using UnityEngine;
using System.Collections;

public class WandController : MonoBehaviour
{
    private Valve.VR.EVRButtonId gripButton = Valve.VR.EVRButtonId.k_EButton_Grip;
    public bool gripButtonDown = false;
    public bool gripButtonUp = false;
    public bool gripButtonPressed = false;


    private Valve.VR.EVRButtonId triggerButton = Valve.VR.EVRButtonId.k_EButton_SteamVR_Trigger;
    public bool triggerButtonDown = false;
    public bool triggerButtonUp = false;
    public bool triggerButtonPressed = false;

    private SteamVR_Controller.Device controller { get { return SteamVR_Controller.Input((int)trackedObj.index); } }
    private SteamVR_TrackedObject trackedObj;

	// Use this for initialization
	void Start()
    {
        trackedObj = GetComponent<SteamVR_TrackedObject>();
           }

    void FireProjectile(GameObject projectile)
    {

        GameObject bullet = projectile;
        bullet.gameObject.tag = "Projectile";
        Rigidbody body;

        bullet.transform.position = transform.position + Camera.main.transform.forward * 2;
        body = bullet.AddComponent<Rigidbody>();

        bullet.GetComponent<SphereCollider>().isTrigger = true;

        body.mass = 10;

        bullet.AddComponent<Bullet>();

        body.velocity = Camera.main.transform.forward * 40;
    }

    GameObject CreateSphere()
    {
        //GameObject obj = Instantiate (Resources.Load ("BreakBall")) as GameObject;
        GameObject obj = GameObject.CreatePrimitive(PrimitiveType.Sphere);
        Vector3 scale = obj.transform.localScale;

        scale.x = scale.y = scale.z = 0.3f;

        obj.transform.localScale = scale;

        obj.AddComponent<Bullet>();
        //obj.AddComponent<ExplosionScript> ();

        return obj;
    }

    // Update is called once per frame
    void Update()
    {
               if (controller == null)
        {
            Debug.Log("Controller not initialized");
                        return;
                    }
        
        gripButtonDown = controller.GetPressDown(gripButton);
        gripButtonUp = controller.GetPressUp(gripButton);
        gripButtonPressed = controller.GetPress(gripButton);
        
        triggerButtonDown = controller.GetPressDown(triggerButton);
        triggerButtonUp = controller.GetPressUp(triggerButton);
        triggerButtonPressed = controller.GetPress(triggerButton);
        
        if (triggerButtonDown)
        {
            FireProjectile(CreateSphere());
        }

                if (gripButtonDown)
        {
            Debug.Log("Grip Button was just pressed");
                    }
                if (gripButtonUp)
        {
            Debug.Log("Grip Button was just unpressed");
                    }
                if (triggerButtonDown)
        {
            Debug.Log("Trigger Button was just pressed");
                    }
                if (triggerButtonUp)
        {
            Debug.Log("Trigger Button was just unpressed");
                    }
           }
}
