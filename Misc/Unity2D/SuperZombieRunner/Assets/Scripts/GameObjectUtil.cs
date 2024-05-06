using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameObjectUtil
{
    private static Dictionary<RecycleGameObject, ObjectPool> pools = new Dictionary<RecycleGameObject, ObjectPool>();

    public static GameObject Instantiate(GameObject prefab, Vector3 pos)
    {
        GameObject instance;

        // check if recycled script attach
        var recycledScript = prefab.GetComponent<RecycleGameObject>();
        if (recycledScript != null)
        {
            var pool = GetObjectPool(recycledScript);
            instance = pool.NextObject(pos).gameObject;
        }

        // if not, make a new one
        else
        {
            instance = GameObject.Instantiate(prefab);
            instance.transform.position = pos;
        }

        return instance;
    }

    // if object has a recycle script attached, we shut down instead of destroy
    public static void Destroy(GameObject gameObject)
    {
        var recycleGameObject = gameObject.GetComponent<RecycleGameObject>();

        // yes recycle, so we shutdown instead of destroy
        if (recycleGameObject != null)
        {
            recycleGameObject.Shutdown();
        }

        // no recycle so we destroy
        else
        {
            GameObject.Destroy(gameObject);
        }
    }

    private static ObjectPool GetObjectPool(RecycleGameObject reference)
    {
        ObjectPool pool;

        // if dictionary contains associated pool, use it
        if (pools.ContainsKey(reference))
        {
            pool = pools[reference];
        }

        // otherwise create a new one and use it
        else
        {
            var poolContainer = new GameObject(reference.gameObject.name + "ObjectPool");
            pool = poolContainer.AddComponent<ObjectPool>();
            pool.prefab = reference;
            pools.Add(reference, pool);
        }

        return pool;
    }
}
