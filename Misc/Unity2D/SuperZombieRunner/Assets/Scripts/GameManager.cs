using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    private GameObject floor;
    private Spawner spawner;
    public GameObject playerPrefab;
    private GameObject player;
    private TimeManager timeManager;
    private bool gameStarted;

    void Awake()
    {
        floor = GameObject.Find("Foreground");
        spawner = GameObject.Find("Spawner").GetComponent<Spawner>();
        timeManager = GetComponent<TimeManager>();
    }

    void Start()
    {
        // properly position floor
        var floorHeight = floor.transform.localScale.y;
        var pos = floor.transform.position;

        pos.x = 0;
        pos.y = -((Screen.height / PixelPerfectCamera.pixelsToUnits) / 2)
        + (floorHeight / 2);

        floor.transform.position = pos;

        // deactivate spawner
        spawner.active = false;

        Time.timeScale = 0;
    }

    void Update()
    {
        if (!gameStarted && Time.timeScale == 0)
        {
            if (Input.anyKeyDown)
            {
                timeManager.ManipulateTime(1, 1f);
                ResetGame();
            }
        }
    }

    void OnPlayerKilled()
    {
        // spawner stops when player dies
        spawner.active = false;

        // unlink callback to avoid memory leaks
        var playerDestroyScript = player.GetComponent<DestroyOffscreen>();
        playerDestroyScript.DestroyCallback -= OnPlayerKilled;

        // reset velocity so player can drop in again on respawn
        player.GetComponent<Rigidbody2D>().velocity = Vector2.zero;

        // pause time
        timeManager.ManipulateTime(0, 5.5f);
        gameStarted = false;
    }

    // creates a new player prefab and starts up the spawner
    void ResetGame()
    {
        spawner.active = true;
        gameStarted = true;
        player = GameObjectUtil.Instantiate(
            playerPrefab,
            new Vector3(
                0,
                (Screen.height / PixelPerfectCamera.pixelsToUnits) / 2 + 100,
                0
            )
        );

        // link callback to destroy script
        var playerDestroyScript = player.GetComponent<DestroyOffscreen>();
        playerDestroyScript.DestroyCallback += OnPlayerKilled;
    }
}
