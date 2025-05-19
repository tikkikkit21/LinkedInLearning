using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LookForward : MonoBehaviour
{
    public Transform sightStart, sightEnd;
    public string layer = "Solid";

    // collision variables
    private bool collision;
    public bool needsCollision = true;

    void Start()
    {

    }

    void Update()
    {
        collision = Physics2D.Linecast(
            sightStart.position,
            sightEnd.position,
            1 << LayerMask.NameToLayer(layer)
        );

        // draws a green line from start and end position, only shows up in the
        // scene
        Debug.DrawLine(sightStart.position, sightEnd.position, Color.green);

        if (collision == needsCollision) {
            transform.localScale = new Vector3(transform.localScale.x == 1 ? -1 : 1, 1, 1);
        }
    }
}
