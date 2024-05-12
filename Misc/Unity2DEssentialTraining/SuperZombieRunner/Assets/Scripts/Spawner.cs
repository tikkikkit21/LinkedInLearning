using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Spawner : MonoBehaviour
{
    public GameObject[] prefabs;
    public float delay = 2.0f;
    public bool active = true; // used to shut down spawner when game is done
    public Vector2 delayRange = new Vector2(1, 2);

    void Start()
    {
        ResetDelay();
        StartCoroutine(EnemyGenerator());
    }

    IEnumerator EnemyGenerator()
    {
        // first wait for delay
        yield return new WaitForSeconds(delay);

        // check if spawner is active
        if (active)
        {
            // new position for our spawned object
            var newTransform = transform;

            // instantiate a random prefab
            GameObjectUtil.Instantiate(
                prefabs[UnityEngine.Random.Range(0, prefabs.Length)],
                newTransform.position
            );

            // set new timer
            ResetDelay();
        }

        // restart coroutine
        StartCoroutine(EnemyGenerator());
    }

    void ResetDelay()
    {
        delay = UnityEngine.Random.Range(delayRange.x, delayRange.y);
    }
}
