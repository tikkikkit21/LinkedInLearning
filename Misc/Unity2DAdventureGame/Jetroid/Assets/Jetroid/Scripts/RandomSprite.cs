using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RandomSprite : MonoBehaviour
{
    // array of possible sprites
    public Sprite[] sprites;

    // allows us to set a particular skin
    public int currentSprite = -1;

    void Start()
    {
        // select a random one
        if (currentSprite == -1)
        {
            currentSprite = Random.Range(0, sprites.Length);
        }

        // specific skin is selected
        else if (currentSprite > sprites.Length)
        {
            currentSprite = sprites.Length - 1;
        }

        // set skin
        GetComponent<SpriteRenderer>().sprite = sprites[currentSprite];
    }
}
