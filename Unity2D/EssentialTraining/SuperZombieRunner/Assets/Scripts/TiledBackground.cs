using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TiledBackground : MonoBehaviour
{
    public int textureSize = 32; // needs to power of 2
    public bool scaleHorizontally = true;
    public bool scaleVertically = true;

    void Start()
    {
        var newWidth = !scaleHorizontally
            ? 1
            : Mathf.Ceil(Screen.width / (textureSize * PixelPerfectCamera.scale));

        var newHeight = !scaleVertically
            ? 1
            : Mathf.Ceil(Screen.height / (textureSize * PixelPerfectCamera.scale));

        transform.localScale = new Vector3(
            newWidth * textureSize,
            newHeight * textureSize,
            1
        );

        GetComponent<Renderer>().material.mainTextureScale = new Vector3(
            newWidth,
            newHeight,
            1
        );
    }
}
