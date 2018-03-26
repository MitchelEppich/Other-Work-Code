using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class scr_CityManager : MonoBehaviour {

	public GameObject build;

    public Text txt_cityMoney;

    private int cityMoney = 0;

    private List<GameObject> buildings;

    private void Start()
    {
		buildings = new List<GameObject>();
    }

    void Update () {

		CheckGrid ();

		foreach(GameObject build in buildings) {
			AddCityMoney(build.GetComponent<scr_BuildingManager>().profit);
        }
	}

    // Update GUI elements
    private void OnGUI()
    {
        txt_cityMoney.GetComponent<Text>().text = "City Money : " + cityMoney;
    }

    // Add money to the city treasury
    public void AddCityMoney(int amt)
    {
        cityMoney += amt;
    }

    // Add building to the city building index
    public void AddBuilding(GameObject build)
    {
        buildings.Add(build);
    } 

	// Place building on a grid system
	public void CheckGrid() {

		RaycastHit hit;
		Ray ray = Camera.main.ScreenPointToRay (Input.mousePosition);

		if (Physics.Raycast(ray, out hit)) {
			Vector3 pivotToPoint = hit.point - gameObject.transform.position;

			float tileZ = pivotToPoint.z / 4;
			tileZ = Mathf.Round (tileZ);

			float tileX = pivotToPoint.x / 4;
			tileX = Mathf.Round (tileX);

			float worldZ = gameObject.transform.position.z + tileZ * 4;
			float worldX = gameObject.transform.position.x + tileX * 4;

			if (Input.GetMouseButtonDown(0) && hit.collider.tag == "City") {
				Instantiate (build, new Vector3 (worldX, 0, worldZ), Quaternion.identity);
			}
		}
	}

    // -- Getter and Setters
    public int GetCityMoney()
    {
        return cityMoney;
    }
    public void SetCityMoney(int amt)
    {
        cityMoney = amt;
    }
}
