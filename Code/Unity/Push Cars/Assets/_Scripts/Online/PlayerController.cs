using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;
using UnityEngine.Networking.NetworkSystem;

public class PlayerController : NetworkBehaviour {

    public List<GameObject> cars = new List<GameObject>();

    public GameObject car;
    public GameObject currentCar = null;

    public float speed = 0;
    public float rotSpeed = 0;

    void Update () {
        // Check if local player
        if (!isLocalPlayer)
            return;

        // Spawn Car
        if (Input.GetKeyDown(KeyCode.Q))
        {
            CmdSpawnCar(gameObject.transform.position);
        }

        if (currentCar != null && Input.GetKeyDown(KeyCode.F))
        {
            currentCar = null;
            GetComponent<Renderer>().enabled = true;
        }

        if (currentCar != null)
        {
            DriveCar();
        }
        else
        {
            Move();
        }
    }

    private void DriveCar()
    {
        NetworkInstanceId carId = currentCar.GetComponent<NetworkIdentity>().netId;

        if (Input.GetAxis("Vertical") != 0)
            CmdMoveCar(carId, Input.GetAxis("Vertical"));

        if (Input.GetAxis("Horizontal") != 0)
            CmdTurnCar(carId, Input.GetAxis("Horizontal"));

        if (Input.GetAxis("Jump") != 0)
            CmdBrakeCar(carId, Mathf.Abs(Input.GetAxis("Jump")));
    }

    private void Move()
    {
        float currentMSpeed = speed * Input.GetAxis("Vertical");
        float currentRSpeed = rotSpeed * Input.GetAxis("Horizontal");

        // Rotate Player
        transform.Rotate(Vector3.up * Time.deltaTime * currentRSpeed);

        // Move Player
        gameObject.transform.Translate(Vector3.forward * Time.deltaTime * currentMSpeed);
    }

    /// <summary>
    /// Commands and RPC
    /// </summary>

    // Request Server to spawn object
    [Command]
    private void CmdSpawnCar(Vector3 pos)
    {
        // Spawn Car
        GameObject newCar = Instantiate(car, pos, Quaternion.identity);
        NetworkServer.Spawn(newCar);
        RpcSendMessage("Spawned Car...");
        RpcSyncCars(newCar);
        RpcSendMessage("Synced Car...");
    }

    [ClientRpc]
    private void RpcSendMessage(String msg)
    {
        Debug.Log("SERVER : " + msg);
    }

    [ClientRpc]
    private void RpcSyncCars(GameObject newCar)
    {
        GameObject[] players = GameObject.FindGameObjectsWithTag("Player");
        foreach(GameObject player in players)
        {
            player.GetComponent<PlayerController>().cars.Add(newCar);
        }
    }

    // Request Server to drive car
    [Command]
    private void CmdMoveCar(NetworkInstanceId id, float val)
    {
        GameObject obj = NetworkServer.FindLocalObject(id).gameObject;

        obj.GetComponent<Dot_Truck_Controller>().Move(val);
    }

    [Command]
    private void CmdTurnCar(NetworkInstanceId id, float val)
    {
        GameObject obj = NetworkServer.FindLocalObject(id).gameObject;

        obj.GetComponent<Dot_Truck_Controller>().Turn(val);
    }

    [Command]
    private void CmdBrakeCar(NetworkInstanceId id, float val)
    {
        GameObject obj = NetworkServer.FindLocalObject(id).gameObject;

        obj.GetComponent<Dot_Truck_Controller>().Brake(val);
    }
}
