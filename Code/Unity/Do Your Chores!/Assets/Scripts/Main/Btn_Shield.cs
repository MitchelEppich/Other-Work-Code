using UnityEngine;
using System.Collections;

public class Btn_Shield : MonoBehaviour
{
    public Hero hero;

    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        { 
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;
            if (Physics.Raycast(ray, out hit))
            {
                if (hit.transform.name == transform.name)
                    hero.shield = true;
            }
        }
    }
}

