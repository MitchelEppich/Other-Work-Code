using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Collectable_Controller : MonoBehaviour {

	public GameObject item;

	public Vector3 offset;
	public Rect rect;

	private bool showGUI = false;

	public void Update() {
		
	}

	void OnGUI() {
		if (showGUI) {
			Vector2 point = Camera.main.WorldToScreenPoint (transform.position + offset);
			string text = "Press 'Enter' To Harvest...";
			Vector2 size = GUI.skin.label.CalcSize (new GUIContent (text)) / 2;
			rect.x = point.x - size.x;
			rect.y = Screen.height - point.y - rect.height;
			GUI.Label (rect, text);
		}
	}

	void OnTriggerEnter(Collider other) {
		if (other.gameObject.CompareTag ("Player")) {
			showGUI = true;
		}
	}

	void OnTriggerStay(Collider other) {
		if (other.gameObject.CompareTag("Player")) {
			if (Input.GetKeyDown(KeyCode.C)) {
				// Do something
				Destroy(this.gameObject);
			}
		}
	}

	void OnTriggerExit(Collider other) {
		if (other.gameObject.CompareTag("Player")) {
			showGUI = false;
		}
	}
}
