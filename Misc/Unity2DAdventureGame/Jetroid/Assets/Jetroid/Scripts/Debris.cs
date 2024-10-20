using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Debris : MonoBehaviour
{
    private SpriteRenderer renderer2d;
    private Color start;
    private Color end;
    private float t = 0f;

    void Start()
    {
        renderer2d = GetComponent<SpriteRenderer>();

        // creating starting and end points for our color
        start = renderer2d.color;
        end = new Color(start.r, start.g, start.b, 0f);
    }

    void Update()
    {
        // use Time.deltaTime to ensure consistent transition between frames
        t += Time.deltaTime;
        renderer2d.material.color = Color.Lerp(start, end, t / 2);

        // once debris is invisible, destroy it 
        if (renderer2d.material.color.a <= 0f) {
            Destroy(gameObject);
        }
    }
}
