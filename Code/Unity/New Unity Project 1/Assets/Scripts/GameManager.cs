using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class GameManager : MonoBehaviour
{

	public Maze mazePrefab;

	public Player playerPrefab;

    public Meteor meteorPrefab;

	private Maze mazeInstance;

	private Player playerInstance;

    private List<Meteor> meteorInstances = new List<Meteor>();

	private void Start ()
    {
        /*StartCoroutine(*/
        BeginGame();//);
	}
	
	private void Update ()
    {
		if (Input.GetKeyDown(KeyCode.Space))
        {
			RestartGame();
		}
	}

	private void BeginGame ()
    {
		Camera.main.clearFlags = CameraClearFlags.Skybox;
		Camera.main.rect = new Rect(0f, 0f, 1f, 1f);
		mazeInstance = Instantiate(mazePrefab) as Maze;
        /*yield return StartCoroutine(*/
        mazeInstance.Generate();//);
		playerInstance = Instantiate(playerPrefab) as Player;
		playerInstance.SetLocation(mazeInstance.GetCell(mazeInstance.RandomCoordinates));
        InvokeRepeating("BeginMeteor", 0.01f, 0.1f);
        Camera.main.clearFlags = CameraClearFlags.Depth;
		Camera.main.rect = new Rect(0f, 0f, 0.5f, 0.5f);
	}

	private void RestartGame ()
    {
		StopAllCoroutines();
		Destroy(mazeInstance.gameObject);
		if (playerInstance != null)
        {
			Destroy(playerInstance.gameObject);
		}
        /*StartCoroutine(*/
        BeginGame();//);
	}

    private void BeginMeteor()
    {

        Meteor newMeteor = Instantiate(meteorPrefab) as Meteor;
        meteorInstances.Add(newMeteor);
        newMeteor.name = "Meteor " + meteorInstances.Count;
        newMeteor.transform.parent = transform;
        Vector3 cellPosition = mazeInstance.GetCell(mazeInstance.RandomCoordinates).transform.localPosition;
        newMeteor.transform.localPosition = new Vector3(cellPosition.x + 0.5f, 10f, cellPosition.z);

    }
}