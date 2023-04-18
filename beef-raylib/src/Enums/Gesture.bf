using System;

namespace Raylib;

/// Gesture
[CRepr]
public enum Gesture : int32
{
    /// No gesture
	None = 0,
    /// Tap gesture
	Tap = 1,
    /// Double tap gesture
	Doubletap = 2,
    /// Hold gesture
	Hold = 4,
    /// Drag gesture
	Drag = 8,
    /// Swipe right gesture
	SwipeRight = 16,
    /// Swipe left gesture
	SwipeLeft = 32,
    /// Swipe up gesture
	SwipeUp = 64,
    /// Swipe down gesture
	SwipeDown = 128,
    /// Pinch in gesture
	PinchIn = 256,
    /// Pinch out gesture
	PinchOut = 512
}