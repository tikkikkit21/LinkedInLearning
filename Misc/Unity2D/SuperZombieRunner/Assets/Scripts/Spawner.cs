using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Spawner : MonoBehaviour
{
    public GameObject[] prefabs;
    public float delay = 2.0f;
    public Boolean active = true; // used to shut down spawner when game is done
    public Vector2 delayRange = new Vector2(1, 2);

    // Start is called before the first frame update
    void Start()
    {
        ResetDelay();
        StartCoroutine(EnemyGenerator());
    }

    IEnumerator EnemyGenerator()
    {
        yield return new WaitForSeconds(delay);

        if (active)
        {
            var newTransform = transform;
            GameObjectUtil.Instantiate(
                prefabs[UnityEngine.Random.Range(0, prefabs.Length)],
                newTransform.position
            );
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
