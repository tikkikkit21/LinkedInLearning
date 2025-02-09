using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class StartGame : MonoBehaviour
{
    public string scene;

    // only want to load scene once
    private bool loadLock;

    void Start()
    {

    }

    void Update()
    {
        // 0 = left mouse
        if (Input.GetMouseButtonDown(0) && !loadLock)
        {
            LoadScene();
        }
    }

    void LoadScene()
    {
        loadLock = true;
        SceneManager.LoadScene(scene);
    }
}
