using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public Vector2 moving = new Vector2();

    void Update()
    {
        moving.x = moving.y = 0;
        if (Input.GetKey(KeyCode.RightArrow))
        {
            moving.x = 1;
        }
        else if (Input.GetKey(KeyCode.LeftArrow))
        {
            moving.x = -1;
        }

        if (Input.GetKey(KeyCode.UpArrow))
        {
            moving.y = 1;
        }
        else if (Input.GetKey(KeyCode.DownArrow))
        {
            moving.y = -1;
        }
    }
}
