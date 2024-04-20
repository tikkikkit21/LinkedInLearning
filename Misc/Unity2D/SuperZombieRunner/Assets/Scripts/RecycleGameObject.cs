using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RecycleGameObject : MonoBehaviour
{
    public void Restart()
    {
        gameObject.SetActive(true);
    }

    public void Shutdown()
    {
        // "disables" the object without actually deleting it
        gameObject.SetActive(false);
    }
}
