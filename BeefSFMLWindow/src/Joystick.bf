using System;
using SFML.System;

namespace SFML.Window
{
	public enum JoystickAxis
	{
		X,
		Y,
		Z,
		R,
		U,
		V,
		PovX,
		PovY
	}

	public static class Joystick
	{
		public static bool IsConnected(uint joystick) => sfJoystick_isConnected((uint32)joystick);

		public static uint GetButtonCount(uint joystick) => sfJoystick_getButtonCount((uint32)joystick);

		public static bool HasAxis(uint joystick, JoystickAxis axis) => sfJoystick_hasAxis((uint32)joystick, axis);

		public static bool IsButtonPressed(uint joystick, uint button) => sfJoystick_isButtonPressed((uint32)joystick, (uint32)button);

		public static float GetAxisPosition(uint joystick, JoystickAxis axis) => sfJoystick_getAxisPosition((uint32) joystick, axis);

		public static void Update() => sfJoystick_update();

		// Native functions

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfJoystick_isConnected(uint32 joystick);

		[Import(CSFML_WINDOW), CLink]
		private static extern uint32 sfJoystick_getButtonCount(uint32 joystick);

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfJoystick_hasAxis(uint32 joystick, JoystickAxis axis);

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfJoystick_isButtonPressed(uint32 joystick, uint32 button);

		[Import(CSFML_WINDOW), CLink]
		private static extern float sfJoystick_getAxisPosition(uint32 joystick, JoystickAxis axis);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfJoystick_update();
	}
}
