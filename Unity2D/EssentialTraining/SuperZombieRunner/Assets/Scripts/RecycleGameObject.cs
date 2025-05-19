using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public interface IRecycle
{
    void Restart();
    void Shutdown();
}

public class RecycleGameObject : MonoBehaviour
{
    private List<IRecycle> recycleComponents;

    // manually go through every script, check if they implement IRecycle, then
    // add relevant objects to our list
    void Awake()
    {
        var components = GetComponents<MonoBehaviour>();
        recycleComponents = new List<IRecycle>();

        foreach (var component in components)
        {
            if (component is IRecycle)
            {
                recycleComponents.Add(component as IRecycle);
            }
        }
    }

    // an object is being reused
    public void Restart()
    {
        gameObject.SetActive(true);

        foreach (var component in recycleComponents)
        {
            component.Restart();
        }
    }

    // "disables" the object without actually deleting it
    public void Shutdown()
    {
        gameObject.SetActive(false);
        foreach (var component in recycleComponents)
        {
            component.Shutdown();
        }
    }
}
