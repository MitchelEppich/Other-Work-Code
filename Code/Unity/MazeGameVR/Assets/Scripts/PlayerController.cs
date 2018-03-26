using UnityEngine;
using System.Collections;

[RequireComponent(typeof(SteamVR_TrackedObject))]
public class PlayerController : MonoBehaviour {

    SteamVR_TrackedObject trackedObj;

    public Player playerInstance;

    public GameObject head;

    void Awake()
    {
        trackedObj = GetComponent<SteamVR_TrackedObject>();
        head = GameObject.Find("Camera (head)");
    }

    void FixedUpdate()
    {
        SteamVR_Controller.Device device = SteamVR_Controller.Input((int)trackedObj.index);

        Vector2 touch = device.GetAxis(Valve.VR.EVRButtonId.k_EButton_Axis0);
        if (device.GetTouchDown(SteamVR_Controller.ButtonMask.Touchpad))
        {

            touch.x = Mathf.Sign(touch.x) * (int)(Mathf.Abs(touch.x) + 0.25f);
            touch.y = Mathf.Sign(touch.y) * (int)(Mathf.Abs(touch.y) + 0.25f);

            if (touch.x == 0 && touch.y == 0)
            {
                return;
            }

            IntVector2 coordinates = CoordRelativeToUser(new IntVector2((int)touch.x, (int)touch.y));

            playerInstance.Move(coordinates.ToDirection());
        }
    }

    private IntVector2 CoordRelativeToUser(IntVector2 coordinates)
    {
        /*
            0 = North 0, 1
            90 = East 1, 0
            180 = South 0, -1
            270 = West -1, 0

        90 dif
            0 = West 0, 1 - > --
            90 = North 1, 0 -> -+
            180 = East 0, -1 -> ++
            270 = South -1, 0 -> +-

        180 dif
            0 = South 0, 1 - > /-2
            90 = West 1, 0 -> -2/
            180 = North 0, -1 -> /+2
            270 = East -1, 0 -> +2/

        270 diff
            0 = East 0, 1 - > +-
            90 = South 1, 0 -> --
            180 = West 0, -1 -> -+
            270 = North -1, 0 -> ++
        */

        int userRelativeRotation = (int)((head.transform.rotation.eulerAngles.y + 45) / 90);
        MazeDirection direction = coordinates.ToDirection();

        for(int i = 0; i < userRelativeRotation; i++)
        {
            direction = direction.GetNextClockwise();
        }

        return direction.ToIntVector2();
    }

}
