using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow : MonoBehaviour
{
    public GameObject target;
    private Transform t;

    public float scale = 4;

    void Awake()
    {
        var cam = GetComponent<Camera>();
        cam.orthographicSize = (Screen.height / 2f) / scale;
    }

    void Start()
    {
        t = target.transform;
    }

    void Update()
    {
        if (target != null)
        {
            // sets position of camera to target x,y
            transform.position = new Vector3(t.position.x, t.position.y, transform.position.z);
        }
    }
}
