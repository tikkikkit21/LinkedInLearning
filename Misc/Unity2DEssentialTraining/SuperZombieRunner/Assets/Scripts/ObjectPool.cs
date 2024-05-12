using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectPool : MonoBehaviour
{
    public RecycleGameObject prefab;
    // lists are mutable, arrays are not
    private List<RecycleGameObject> poolInstances = new List<RecycleGameObject>();

    // private helper method to create a new instance
    private RecycleGameObject CreateInstance(Vector3 pos)
    {
        // use native Instantiate to avoid infinite loop with recycler
        var clone = GameObject.Instantiate(prefab);

        // move clone to position
        clone.transform.position = pos;

        // nest clone in parent
        clone.transform.parent = transform;

        poolInstances.Add(clone);

        return clone;
    }

    // gets the next object available in pool
    public RecycleGameObject NextObject(Vector3 pos)
    {
        RecycleGameObject instance = null;

        // try to find an existing deactivated instance to reuse
        foreach (var go in poolInstances)
        {
            if (go.gameObject.activeSelf == false)
            {
                instance = go;
                instance.transform.position = pos;
            }
        }

        // if none, create new
        if (instance == null)
        {
            instance = CreateInstance(pos);
        }

        instance.Restart();

        return instance;
    }

}
