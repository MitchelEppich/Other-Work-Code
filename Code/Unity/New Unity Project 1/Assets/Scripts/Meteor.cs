using UnityEngine;
using System.Collections;

[RequireComponent(typeof(Rigidbody), typeof(SphereCollider))]
public class Meteor : MonoBehaviour {

    public GameObject meteorModel;

    public void Awake()
    {
        try
        {
            SphereCollider self = GetComponent<SphereCollider>();
            SphereCollider other = meteorModel.GetComponent<SphereCollider>();

            self.radius = other.radius;
            self.center = other.center;
            self.material = other.material;

            Destroy(other);

        } catch (MissingComponentException e)
        {
            Debug.Log(e);
        }

        GetComponent<Rigidbody>().AddForce(new Vector3(0f, -1000f, 0f));
        float size = Random.Range(1f, 5f);
        transform.localScale = new Vector3(size, size, size);
    }

}
