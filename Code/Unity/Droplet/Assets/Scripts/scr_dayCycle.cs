using UnityEngine;
using System.Collections;

public class scr_dayCycle : MonoBehaviour {

    public float duration = 1.0f;
    public float alphaStart = 0.3f;
    public float alphaEnd = 1.0f;
    public Renderer renderer;
	// Use this for initialization
	void Start () {
        renderer = GetComponent<Renderer>();

    }
	
	// Update is called once per frame
	void Update () {
        float lerp = Mathf.PingPong(Time.time, duration) / duration;
        Color color = renderer.material.color;
        color.a = Mathf.Lerp(alphaStart, alphaEnd, lerp);
        renderer.material.color = color;
	}
}
