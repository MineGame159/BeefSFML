using System;


namespace SFML.Window
{
	public enum WindowEventType	: uint32
	{
		Closed,
		Resized,
		LostFocus,
		GainedFocus,
		TextEntered,
		KeyPressed,
		KeyReleased,
		MouseWheelMoved,
		MouseWheelScrolled,
		MouseButtonPressed,
		MouseButtonReleased,
		MouseMoved,
		MouseEntered,
		MouseLeft,
		JoystickButtonPressed,
		JoystickButtonReleased,
		JoystickMoved,
		JoystickConnected,
		JoystickDisconnected,
		TouchBegan,
		TouchMoved,
		TouchEnded,
		SensorChanged
	}

	/*
	public enum WindowEventUnion 
	{
	    case Closed;
	    case Resized(SizeEventData);
	    case LostFocus;
	    case GainedFocus;
	    case TextEntered(TextEventData);
	    case KeyPressed(KeyEventData);
	    case KeyReleased(KeyEventData);
		case MouseWheelMoved(MouseWheelEventData);
	    case MouseWheelScrolled(MouseWheelScrollEventData);
	    case MouseButtonPressed(MouseButtonEventData);
	    case MouseButtonReleased( MouseButtonEventData);
	    case MouseMoved(MouseMoveEventData);
	    case MouseEntered;
	    case MouseLeft;
	    case JoystickButtonPressed(JoystickButtonEventData);
	    case JoystickButtonReleased(JoystickButtonEventData);
	    case JoystickMoved(JoystickMoveEventData);
	    case JoystickConnected(JoystickConnectEventData);
	    case JoystickDisconnected(JoystickConnectEventData);
	    case TouchBegan(TouchEventData);
	    case TouchMoved(TouchEventData);
	    case TouchEnded(TouchEventData);
	    case SensorChanged(SensorEventData);
	}
	*/

	/*C-like discriminated union because i couldn't get the above variant to play nice with csfml*/
	[CRepr, Union]
	public struct WindowEvent
	{
		public readonly WindowEventType Type;
		public readonly SizeEventData Size;
		public readonly TextEventData Text;
		public readonly KeyEventData Key;
		public readonly MouseWheelEventData MouseWheel;
		public readonly MouseWheelScrollEventData MouseScroll;
		public readonly MouseButtonEventData MouseButton;
		public readonly MouseMoveEventData MouseMove;
		public readonly JoystickButtonEventData JoystickButton;
		public readonly JoystickMoveEventData JoystickMove;
		public readonly JoystickConnectEventData JoystickConnect;
		public readonly TouchEventData Touch;
		public readonly SensorEventData Sensor;
	}

	[CRepr, Ordered]
	public struct KeyEventData
	{
		private readonly WindowEventType Type;
		public readonly Keycode Key;
		public readonly int32 Alt;
		public readonly int32 Control;
		public readonly int32 Shift;
		public readonly int32 System;
	}

	[CRepr, Ordered]
	public struct SizeEventData
	{
		private readonly WindowEventType Type;
		public readonly uint32 Width;
		public readonly uint32 Height;
	}

	[CRepr, Ordered]
	public struct TextEventData
	{
		private readonly WindowEventType Type;
		public readonly uint32 Unicode;
	}

	[CRepr, Ordered]
	public struct MouseMoveEventData
	{
		private readonly WindowEventType Type;
		public readonly int32 X;
		public readonly int32 Y;
	}

	[CRepr, Ordered]
	public struct MouseButtonEventData
	{
		private readonly WindowEventType Type;
		public readonly MouseButton Button;
		public readonly int32 X;
		public readonly int32 Y;
	}

	[CRepr, Ordered]
	public struct MouseWheelEventData
	{
		private readonly WindowEventType Type;
		public readonly int32 Delta;
		public readonly int32 X;
		public readonly int32 Y;
	}

	[CRepr, Ordered]
	public struct MouseWheelScrollEventData
	{
		private readonly WindowEventType Type;
		public readonly MouseWheel Wheel;
		public readonly float Delta;
		public readonly int32 X;
		public readonly int32 Y;
	}

	[CRepr, Ordered]
	public struct JoystickMoveEventData
	{
		private readonly WindowEventType Type;
		public readonly uint32 ID;
		public readonly JoystickAxis Axis;
		public readonly float Position;
	}

	[CRepr, Ordered]
	public struct JoystickButtonEventData
	{
		private readonly WindowEventType Type;
		public readonly uint32 ID;
		public readonly uint32 Button;
	}

	[CRepr, Ordered]
	public struct JoystickConnectEventData
	{
		private readonly WindowEventType Type;
		public readonly uint32 ID;
	}

	[CRepr, Ordered]
	public struct TouchEventData
	{
		private readonly WindowEventType Type;
		public readonly uint32 Finger;
		public readonly int32 X;
		public readonly int32 Y;
	}

	[CRepr, Ordered]
	public struct SensorEventData
	{
		private readonly WindowEventType Type;
		public readonly float X;
		public readonly float Y;
		public readonly float Z;
	}
}
