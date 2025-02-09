using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Jump : MonoBehaviour
{
    public float jumpSpeed = 240f;
    public float forwardSpeed = 20f;
    private Rigidbody2D body2d;
    private InputState inputState;

    void Awake()
    {
        body2d = GetComponent<Rigidbody2D>();
        inputState = GetComponent<InputState>();
    }

    void Update()
    {
        if (inputState.standing)
        {
            if (inputState.actionButton)
            {
                // if player is behind center of screen (x=0), jump forward as
                // well
                var xSpeed = transform.position.x < 0 ? forwardSpeed : 0;
                body2d.velocity = new Vector2(xSpeed, jumpSpeed);
            }
        }
    }
}
