using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class scr_BuildingManager : MonoBehaviour {

    public int profit = 100;
    public int debt = 50;

    private GameObject city;

	void Start () {
		city = GameObject.FindWithTag("City"); // Find current city object -- city_plane
        city.GetComponent<scr_CityManager>().AddBuilding(gameObject); // Add current object to city index -- buildings
	}

	void Update () {
		
	}
}
