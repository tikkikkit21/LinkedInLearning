using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InputState : MonoBehaviour
{
    public bool actionButton;
    public float absVelX = 0f;
    public float absVelY = 0f;
    public bool standing;
    public float standingThreshold = 1f;

    private Rigidbody2D body2d;

    void Awake()
    {
        body2d = GetComponent<Rigidbody2D>();
    }

    void Update()
    {
        // pressing any key will trigger player jump
        actionButton = Input.anyKeyDown;
    }

    void FixedUpdate()
    {
        // use abs since we don't care about direction of movement
        absVelX = System.Math.Abs(body2d.velocity.x);
        absVelY = System.Math.Abs(body2d.velocity.y);

        // this is a cheap way to do it. In more complex games, we would check
        // if a player is standing on something solid via colliders
        standing = absVelY <= standingThreshold;
    }
}
