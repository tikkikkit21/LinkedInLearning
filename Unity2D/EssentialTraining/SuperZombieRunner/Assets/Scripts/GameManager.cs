using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using System;

public class GameManager : MonoBehaviour
{
    private GameObject floor;
    private Spawner spawner;
    public GameObject playerPrefab;
    private GameObject player;
    private TimeManager timeManager;
    private bool gameStarted;

    // blinking text
    public TMP_Text continueText;
    private bool blink;
    private float blinkTime = 0f;

    // high score
    public TMP_Text scoreText;
    private float timeElapsed = 0f;
    private float bestTime = 0f;
    private bool beatBestTime;

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

        // initialize time scale to 0
        Time.timeScale = 0;

        // initialize text
        continueText.text = "PRESS ANY BUTTON TO START";

        // load best time
        bestTime = PlayerPrefs.GetFloat("BestTime");
    }

    void Update()
    {
        // if game is paused, any key will restore time flow
        if (!gameStarted && Time.timeScale == 0)
        {
            if (Input.anyKeyDown)
            {
                timeManager.ManipulateTime(1, 1f);
                ResetGame();
            }
        }

        if (!gameStarted)
        {
            // manually create blink animation for text
            blinkTime++;
            if (blinkTime % 40 == 0)
            {
                blink = !blink;
            }
            continueText.canvasRenderer.SetAlpha(blink ? 0 : 1);

            // new high score = diff color
            var textColor = beatBestTime ? "#FF0" : "#FFF";

            scoreText.text = "TIME: " + FormatTime(timeElapsed) + "\n<color=" + textColor + ">BEST: " + FormatTime(bestTime) + "</color>";
        }
        else
        {
            timeElapsed += Time.deltaTime;
            scoreText.text = "TIME: " + FormatTime(timeElapsed);
        }
    }

    void OnPlayerKilled()
    {
        gameStarted = false;

        // spawner stops when player dies
        spawner.active = false;

        // unlink callback to avoid memory leaks
        var playerDestroyScript = player.GetComponent<DestroyOffscreen>();
        playerDestroyScript.DestroyCallback -= OnPlayerKilled;

        // reset velocity so player can drop in again on respawn
        player.GetComponent<Rigidbody2D>().velocity = Vector2.zero;

        // pause time
        timeManager.ManipulateTime(0, 5.5f);

        // change text words to "restart"
        continueText.text = "PRESS ANY BUTTON TO RESTART";

        // save high score
        if (timeElapsed > bestTime)
        {
            bestTime = timeElapsed;
            PlayerPrefs.SetFloat("BestTime", bestTime);
            beatBestTime = true;
        }
    }

    // creates a new player prefab and starts up the spawner
    void ResetGame()
    {
        gameStarted = true;

        // activate spawner
        spawner.active = true;

        // drop in a new player from the sky
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

        // remove text
        continueText.canvasRenderer.SetAlpha(0);

        // reset time elapsed
        timeElapsed = 0f;

        // reset flag
        beatBestTime = false;
    }

    string FormatTime(float value)
    {
        TimeSpan time = TimeSpan.FromSeconds(value);
        return string.Format("{0:D2}:{1:D2}", time.Minutes, time.Seconds);
    }
}
