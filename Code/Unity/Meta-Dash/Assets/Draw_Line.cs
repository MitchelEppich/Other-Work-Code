using UnityEngine;
using System.Collections;

public class Draw_Line : MonoBehaviour {

    public Vector3 block_density = new Vector3(1, 1, 1); // Default 1 x 1 x 1
    public Vector3 block_dimension = new Vector3(1, 1, 1); // Default 1 x 1 x 1
    public Vector3 line_angle = new Vector3(0, 0, 0); // Default 0 x 0 x 0

    public Vector3 distance_to = new Vector3(1, 1, 1); // Default 1 x 1 x 1

    public int particle_count = 0;

	// Use this for initialization
	void Start () {
        Vector3 block_scale = new Vector3(
                block_dimension.x / (int)block_density.x,
                block_dimension.y / (int)block_density.y,
                block_dimension.z / (int)block_density.z
            );
        Vector3 block_cache = new Vector3(
                Mathf.Floor((distance_to.x / block_dimension.x) * (int)block_density.x),
                Mathf.Floor((distance_to.y / block_dimension.y) * (int)block_density.y),
                Mathf.Floor((distance_to.z / block_dimension.z) * (int)block_density.z)
            );

        // Create A and B
        GameObject start_node = GameObject.CreatePrimitive(PrimitiveType.Cube);
        start_node.transform.localScale = new Vector3(block_scale.x * 2, block_scale.y * 2, block_scale.z * 2);

        GameObject end_node = GameObject.CreatePrimitive(PrimitiveType.Cube);
        end_node.transform.localScale = new Vector3(block_scale.x * 2, block_scale.y * 2, block_scale.z * 2);
        end_node.transform.position = new Vector3(
                distance_to.x - block_scale.x,
                distance_to.y - block_scale.y,
                distance_to.z - block_scale.z
            );

        end_node.transform.parent = start_node.transform;

        for (int y = 0; y < block_cache.y; y++) // Width
        {
            for (int x = 0; x < block_cache.x; x++) // Length
            {
                for (int z = 0; z < block_cache.z; z++) // Height
                {
                    GameObject cube = GameObject.CreatePrimitive(PrimitiveType.Cube);
                    cube.transform.localScale = block_scale;

                    cube.transform.localPosition = new Vector3((cube.transform.localScale.x * x), (cube.transform.localScale.y * y), (cube.transform.localScale.z * z));

                    cube.transform.parent = start_node.transform;

                    cube.AddComponent<BoxCollider>();
                    Rigidbody body = cube.AddComponent<Rigidbody>();
                    body.isKinematic = true;

                    particle_count++;
                }
            }
        }

        start_node.transform.eulerAngles = line_angle;
        Destroy(end_node);
        start_node.GetComponent<Renderer>().enabled = false;
        start_node.name = "Segment 1";
    }

    // Update is called once per frame
    void Update()
    {

    }
}
