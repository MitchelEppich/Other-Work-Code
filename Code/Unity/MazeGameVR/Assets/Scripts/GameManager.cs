using UnityEngine;
using System.Collections;

public class GameManager : MonoBehaviour {

    public bool HMD_Support;
    public Maze mazePrefab;
    public Player playerPrefab;

    private Maze mazeInstance;
    private Player playerInstance;

	void Start () {
        StartCoroutine(BeginGame());
	}
	
	void Update () {
	    if (Input.GetKeyDown(KeyCode.Space))
        {
            RestartGame();
        }
	}

    private IEnumerator BeginGame()
    {
        if(!HMD_Support) Camera.main.clearFlags = CameraClearFlags.Skybox;
        if (!HMD_Support) Camera.main.rect = new Rect(0f, 0f, 1f, 1f);
        mazeInstance = Instantiate(mazePrefab) as Maze;
        yield return StartCoroutine(mazeInstance.Generate());
        if (HMD_Support) playerInstance = Instantiate(playerPrefab) as Player;
        if (HMD_Support) playerInstance.SetLocation(mazeInstance.GetCell(mazeInstance.RandomCoordinates));
        if (HMD_Support)
        {
            GameObject.Find("Controller (left)").GetComponent<PlayerController>().playerInstance = playerInstance;
            GameObject.Find("Controller (right)").GetComponent<PlayerController>().playerInstance = playerInstance;
        }
        if (!HMD_Support) Camera.main.clearFlags = CameraClearFlags.Depth;
        if (!HMD_Support) Camera.main.rect = new Rect(0f, 0f, 0.5f, 0.5f);
    }

    private void RestartGame()
    {
        StopAllCoroutines();
        Destroy(mazeInstance.gameObject);
        if (playerInstance != null)
        {
            Destroy(playerInstance.gameObject);
        }
        StartCoroutine(BeginGame());
    }
}
