using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestroyOffscreen : MonoBehaviour
{
    // how far away object must be offscreen before destroyed
    public float offset = 16f;

    // private helper variables
    private bool offscreen;
    private float offScreenX = 0;
    private Rigidbody2D body2d;

    // checking player death
    public delegate void OnDestroy();
    public event OnDestroy DestroyCallback;

    void Awake()
    {
        body2d = GetComponent<Rigidbody2D>();
    }

    void Start()
    {
        // find halfway point in screen and add an offset to it
        var halfScreen = (Screen.width / PixelPerfectCamera.pixelsToUnits) / 2;
        offScreenX = halfScreen + offset;
    }

    void Update()
    {
        var posX = transform.position.x;
        var dirX = body2d.velocity.x;

        // check if x is beyond the screen on either side
        if (Mathf.Abs(posX) > offScreenX)
        {
            if (dirX < 0 && posX < -offScreenX)
            {
                offscreen = true;
            }
            else if (dirX > 0 && posX > offScreenX)
            {
                offscreen = true;
            }
        }
        else
        {
            offscreen = false;
        }

        if (offscreen)
        {
            OnOutOfBounds();
        }
    }

    // destroy an out of bounds object
    public void OnOutOfBounds()
    {
        offscreen = false;
        GameObjectUtil.Destroy(gameObject);

        // utilize provided delegate
        if (DestroyCallback != null)
        {
            DestroyCallback();
        }
    }
}
