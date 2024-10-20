using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Explode : MonoBehaviour
{
    public Debris debris;
    public int totalDebris = 10;

    void OnTriggerEnter2D(Collider2D target)
    {
        // explode only when we hit a game object with "Deadly" tag
        if (target.gameObject.tag == "Deadly")
        {
            OnExplode();
        }
    }

    void OnExplode()
    {
        var t = transform;
        // spawn some debris on death
        for (int i = 0; i < totalDebris; i++) {
            t.TransformPoint(0, -100, 0);

            // create a debris object
            var clone = Instantiate(debris, t.position, Quaternion.identity) as Debris;
            var body2D = clone.GetComponent<Rigidbody2D>();

            // add a random explosion force
            body2D.AddForce(Vector3.right * Random.Range(-1000, 1000));
            body2D.AddForce(Vector3.up * Random.Range(500, 2000));
        }

        // kill the game object
        Destroy(gameObject);
    }
}
