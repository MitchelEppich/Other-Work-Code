using UnityEngine;
using System.Collections;

public class Weapon_Laser : MonoBehaviour {

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

        //obj.AddComponent<ExplosionScript> ();

        return obj;
    }

    // Update is called once per frame
    void Update()
    {

        //if (SteamVR_Controller.Input(deviceIndex).GetPressDown(SteamVR_Controller.ButtonMask.Trigger))
        //{
        //    FireProjectile(CreateSphere());
       // }
    }
}
