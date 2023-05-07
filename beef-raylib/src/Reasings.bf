/*******************************************************************************************
* 
*    Source:
*        https://github.com/raysan5/raylib/blob/master/examples/others/reasings.h
*
*    Changes:
*        - ported
*
*    Credits:
*        Ramon Santamaria (@raysan5) for providing the original reasings.h
* 
********************************************************************************************/

using System;

namespace Raylib.Reasings;

static
{
    // Linear Easing functions
    /// Ease: Linear
    public static float EaseLinearNone(float t, float b, float c, float d) { return (c * t / d + b); }
    /// Ease: Linear In
    public static float EaseLinearIn(float t, float b, float c, float d) { return (c * t / d + b); }
    /// Ease: Linear Out
    public static float EaseLinearOut(float t, float b, float c, float d) { return (c * t / d + b); }
    /// Ease: Linear In Out
    public static float EaseLinearInOut(float t, float b, float c, float d) { return (c * t / d + b); }

    // Sine Easing functions
    /// Ease: Sine In
    public static float EaseSineIn(float t, float b, float c, float d) { return (-c * Math.Cos(t / d * (Math.PI_f / 2f)) + c + b); }
    /// Ease: Sine Out
    public static float EaseSineOut(float t, float b, float c, float d) { return (c * Math.Sin(t / d * (Math.PI_f / 2f)) + b); }
    /// Ease: Sine In Out
    public static float EaseSineInOut(float t, float b, float c, float d) { return (-c / 2f * (Math.Cos(Math.PI_f * t / d) - 1f) + b); }

    // Circular Easing functions
    /// Ease: Circular In
    public static float EaseCircIn(float t, float b, float c, float d)
    {
        var t;
        t /= d;
        return (-c * (Math.Sqrt(1f - t * t) - 1f) + b);
    }
    /// Ease: Circular Out
    public static float EaseCircOut(float t, float b, float c, float d)
    {
        var t;
        t = t / d - 1f;
        return (c * Math.Sqrt(1f - t * t) + b);
    }
    /// Ease: Circular In Out
    public static float EaseCircInOut(float t, float b, float c, float d)
    {
        var t;
        if ((t /= d / 2f) < 1f)
            return (-c / 2f * (Math.Sqrt(1f - t * t) - 1f) + b);
        t -= 2f;
        return (c / 2f * (Math.Sqrt(1f - t * t) + 1f) + b);
    }

    // Cubic Easing functions
    /// Ease: Cubic In
    public static float EaseCubicIn(float t, float b, float c, float d)
    {
        var t;
        t /= d;
        return (c * t * t * t + b);
    }
    /// Ease: Cubic Out
    public static float EaseCubicOut(float t, float b, float c, float d)
    {
        var t;
        t = t / d - 1f;
        return (c * (t * t * t + 1f) + b);
    }
    /// Ease: Cubic In Out
    public static float EaseCubicInOut(float t, float b, float c, float d)
    {
        var t;
        if ((t /= d / 2f) < 1f)
            return (c / 2f * t * t * t + b);
        t -= 2f;
        return (c / 2f * (t * t * t + 2f) + b);
    }

    // Quadratic Easing functions
    /// Ease: Quadratic In
    public static float EaseQuadIn(float t, float b, float c, float d)
    {
        var t;
        t /= d;
        return (c * t * t + b);
    }
    /// Ease: Quadratic Out
    public static float EaseQuadOut(float t, float b, float c, float d)
    {
        var t;
        t /= d;
        return (-c * t * (t - 2f) + b);
    }
    /// Ease: Quadratic In Out
    public static float EaseQuadInOut(float t, float b, float c, float d)
    {
        var t;
        if ((t /= d / 2) < 1)
            return (((c / 2) * (t * t)) + b);
        return (-c / 2f * (((t - 1f) * (t - 3f)) - 1f) + b);
    }

    // Exponential Easing functions
    /// Ease: Exponential In
    public static float EaseExpoIn(float t, float b, float c, float d) { return (t == 0f) ? b : (c * Math.Pow(2f, 10f * (t / d - 1f)) + b); }
    /// Ease: Exponential Out
    public static float EaseExpoOut(float t, float b, float c, float d) { return (t == d) ? (b + c) : (c * (-Math.Pow(2f, -10f * t / d) + 1f) + b); }
    /// Ease: Exponential In Out
    public static float EaseExpoInOut(float t, float b, float c, float d)
    {
        if (t == 0f) return b;
        if (t == d) return (b + c);

        var t;
        if ((t /= d / 2f) < 1f)
            return (c / 2f * Math.Pow(2f, 10f * (t - 1f)) + b);

        return (c / 2f * (-Math.Pow(2f, -10f * (t - 1f)) + 2f) + b);
    }

    // Back Easing functions
    /// Ease: Back In
    public static float EaseBackIn(float t, float b, float c, float d)
    {
        var t;
        float s = 1.70158f;
        float postFix = t /= d;
        return (c * (postFix) * t * ((s + 1f) * t - s) + b);
    }

    /// Ease: Back Out
    public static float EaseBackOut(float t, float b, float c, float d)
    {
        var t;
        float s = 1.70158f;
        t = t / d - 1f;
        return (c * (t * t * ((s + 1f) * t + s) + 1f) + b);
    }

    /// Ease: Back In Out
    public static float EaseBackInOut(float t, float b, float c, float d)
    {
        var t;
        float s = 1.70158f;
        if ((t /= d / 2f) < 1f)
        {
            s *= 1.525f;
            return (c / 2f * (t * t * ((s + 1f) * t - s)) + b);
        }

        float postFix = t -= 2f;
        s *= 1.525f;
        return (c / 2f * ((postFix) * t * ((s + 1f) * t + s) + 2f) + b);
    }

    // Bounce Easing functions
    /// Ease: Bounce Out
    public static float EaseBounceOut(float t, float b, float c, float d)
    {
        var t;
        if ((t /= d) < (1f / 2.75f))
        {
            return (c * (7.5625f * t * t) + b);
        }
        else if (t < (2f / 2.75f))
        {
            float postFix = t -= (1.5f / 2.75f);
            return (c * (7.5625f * (postFix) * t + 0.75f) + b);
        }
        else if (t < (2.5 / 2.75))
        {
            float postFix = t -= (2.25f / 2.75f);
            return (c * (7.5625f * (postFix) * t + 0.9375f) + b);
        }
        else
        {
            float postFix = t -= (2.625f / 2.75f);
            return (c * (7.5625f * (postFix) * t + 0.984375f) + b);
        }
    }

    /// Ease: Bounce In
    public static float EaseBounceIn(float t, float b, float c, float d) { return (c - EaseBounceOut(d - t, 0f, c, d) + b); }
    /// Ease: Bounce In Out
    public static float EaseBounceInOut(float t, float b, float c, float d)
    {
        if (t < d / 2f)
            return (EaseBounceIn(t * 2f, 0f, c, d) * 0.5f + b);
        else
            return (EaseBounceOut(t * 2f - d, 0f, c, d) * 0.5f + c * 0.5f + b);
    }

    // Elastic Easing functions
    /// Ease: Elastic In
    public static float EaseElasticIn(float t, float b, float c, float d)
    {
        if (t == 0f)
            return b;
        var t;
        if ((t /= d) == 1f) return (b + c);

        float p = d * 0.3f;
        float a = c;
        float s = p / 4f;
        float postFix = a * Math.Pow(2f, 10f * (t -= 1f));

        return (-(postFix * Math.Sin((t * d - s) * (2f * Math.PI_f) / p)) + b);
    }

    /// Ease: Elastic Out
    public static float EaseElasticOut(float t, float b, float c, float d)
    {
        if (t == 0f)
            return b;
        var t;
        if ((t /= d) == 1f)
            return (b + c);

        float p = d * 0.3f;
        float a = c;
        float s = p / 4f;

        return (a * Math.Pow(2f, -10f * t) * Math.Sin((t * d - s) * (2f * Math.PI_f) / p) + c + b);
    }

    /// Ease: Elastic In Out
    public static float EaseElasticInOut(float t, float b, float c, float d)
    {
        if (t == 0f)
            return b;
        var t;
        if ((t /= d / 2f) == 2f)
            return (b + c);

        float p = d * (0.3f * 1.5f);
        float a = c;
        float s = p / 4f;

        if (t < 1f)
        {
            float postFix = a * Math.Pow(2f, 10f * (t -= 1f));
            return -0.5f * (postFix * Math.Sin((t * d - s) * (2f * Math.PI_f) / p)) + b;
        }

        float postFix = a * Math.Pow(2f, -10f * (t -= 1f));

        return (postFix * Math.Sin((t * d - s) * (2f * Math.PI_f) / p) * 0.5f + c + b);
    }

}