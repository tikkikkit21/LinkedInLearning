using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Collectible : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {

    }

    // triggered when another box collider collides with it
    void OnTriggerEnter2D(Collider2D target)
    {
        // only player can collect this item
        if (target.gameObject.tag == "Player")
        {
            Destroy(gameObject);
        }
    }
}
