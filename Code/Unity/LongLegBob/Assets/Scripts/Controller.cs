using UnityEngine;
using System.Collections;

public class Controller : MonoBehaviour
{

    public bool move_right;
    public bool move_left;
    public bool move_up;
    public bool move_down;

    public bool toggle_right;
    public bool toggle_left;
    public bool toggle_up;
    public bool toggle_down;

    public bool attack_weak;
    public bool attack_strong;
    public bool attack_range;

    public enum KeyMap
    {
        right = KeyCode.RightArrow,
        left = KeyCode.LeftArrow
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        move_right = Input.GetKey(KeyMap.right.ToString());
        move_left = Input.GetKey(KeyMap.left.ToString());
    }
}
