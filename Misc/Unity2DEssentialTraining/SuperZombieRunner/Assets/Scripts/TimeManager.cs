using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TimeManager : MonoBehaviour
{
    public void ManipulateTime(float newTime, float duration)
    {
        // speed up time a little bit so things can finish running
        if (Time.timeScale == 0)
        {
            Time.timeScale = 0.1f;
        }

        StartCoroutine(FadeTo(newTime, duration));
    }

    IEnumerator FadeTo(float value, float time)
    {
        for (float t = 0f; t < 1; t += Time.deltaTime / time)
        {
            Time.timeScale = Mathf.Lerp(Time.timeScale, value, t);

            // if we're really close to time, just skip to it
            if (Mathf.Abs(value - Time.timeScale) < 0.01f)
            {
                Time.timeScale = value;
                yield break;
            }

            yield return null;
        }
    }
}
