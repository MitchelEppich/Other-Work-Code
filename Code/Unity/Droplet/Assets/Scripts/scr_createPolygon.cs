using UnityEngine;
using System.Collections;

public class scr_createPolygon : MonoBehaviour {

    public GameObject go;
    public Material mat;
    public int verts = 4;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
        updatePolygon(ref go);
	}

    void updatePolygon(ref GameObject obj)
    {
        for (int i = 0; i < 2; i++)
        {
            // Destroy old game object
            Destroy(obj);

            // New Mesh and game object
            obj = new GameObject();
            obj.name = "GameObject";
            Mesh mesh = new Mesh();

            // Components
            MeshFilter MF = obj.AddComponent<MeshFilter>();
            MeshRenderer MR = obj.AddComponent<MeshRenderer>();

            // Create mesh
            mesh = CreatePolygon(1, obj.name + "Mesh", verts);

            // Assign Materials
            MR.material = mat;

            // Assign mesh to game object 
            MF.mesh = mesh;
        }
    }

    Mesh CreatePolygon(int num, string name, int vertices)
    {
        float radius = 2.0f;

        Mesh mesh = new Mesh(); // Create Mesh

        Vector3[] vertex = new Vector3[vertices]; // Create vertex map

        // Create Vertices in circular form
        for (int i = 0; i < 360; i += 360 / vertices)
        {
            float heading = i * Mathf.Deg2Rad;
            vertex[i] = new Vector3(Mathf.Cos(heading) * radius, Mathf.Sin(heading) * radius, 0);
        }

        Vector2[] uvs = new Vector2[vertex.Length]; // Create UV Map

        // Create Uvs
        for (int i = 0; i < vertex.Length; i++)
        {
            if ((i%2) == 0)
            {
                uvs[i] = new Vector2(0, 0);
            }
            else
            {
                uvs[i] = new Vector2(1, 1);
            }
        }

        // Triangles
        int[] tris = new int[3 * (vertex.Length - 2)];
        int C1, C2, C3;

        if (num == 0)
        {
            C1 = 0;
            C2 = 1;
            C3 = 2;

            for (int i = 0; i < tris.Length; i+=3)
            {
                tris[i] = C1;
                tris[i + 1] = C2;
                tris[i + 2] = C3;

                C2++;
                C3++;
            }
        }
        else
        {
            C1 = 0;
            C2 = vertex.Length - 1;
            C3 = vertex.Length - 2;

            for (int i = 0; i < tris.Length; i += 3)
            {
                tris[i] = C1;
                tris[i + 1] = C2;
                tris[i + 2] = C3;

                C2--;
                C3--;
            }
        }

        // Assign data to mesh
        mesh.vertices = vertex;
        mesh.uv = uvs;
        mesh.triangles = tris;

        // Recalculations
        mesh.RecalculateNormals();
        mesh.RecalculateBounds();
        mesh.Optimize();

        // Name mesh
        mesh.name = name;

        // Return the mesh
        return mesh;
    }
}
