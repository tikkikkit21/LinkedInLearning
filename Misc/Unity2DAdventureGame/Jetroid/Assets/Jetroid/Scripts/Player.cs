using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class Player : MonoBehaviour
{
    private Rigidbody2D body2d;
    private SpriteRenderer renderer2d;
    private PlayerController controller;
    private Animator animator;

    // ground movement
    public float speed = 150f;
    public Vector2 maxVelocity = new Vector2(60, 100);

    // flying movement
    public float jetSpeed = 200f;
    public bool standing;
    public float standingThreshold = 4f;
    public float airSpeedMultiplier = 0.3f;

    void Start()
    {
        body2d = GetComponent<Rigidbody2D>();
        renderer2d = GetComponent<SpriteRenderer>();
        controller = GetComponent<PlayerController>();
        animator = GetComponent<Animator>();
    }

    void Update()
    {
        // use absolute value since we don't care about direction
        var absVelX = Mathf.Abs(body2d.velocity.x);
        var absVelY = Mathf.Abs(body2d.velocity.y);

        standing = absVelY <= standingThreshold;

        var forceX = 0f;
        var forceY = 0f;

        // walking logic
        if (controller.moving.x != 0)
        {
            if (absVelX < maxVelocity.x)
            {
                var newSpeed = speed * controller.moving.x;
                forceX = standing
                ? newSpeed
                : newSpeed * airSpeedMultiplier;
                renderer2d.flipX = forceX < 0;
            }

            animator.SetInteger("AnimState", 1);
        }
        else
        {
            animator.SetInteger("AnimState", 0);
        }

        // flying logic
        if (controller.moving.y != 0)
        {
            if (absVelY < maxVelocity.y)
            {
                forceY = jetSpeed * controller.moving.y;
            }

            animator.SetInteger("AnimState", 2);
        }
        else if (absVelY > 0 && !standing)
        {
            animator.SetInteger("AnimState", 3);
        }

        // apply calculated force
        body2d.AddForce(new Vector2(forceX, forceY));
    }
}
