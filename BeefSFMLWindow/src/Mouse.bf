using System;
using SFML.System;

namespace SFML.Window
{
	public enum MouseButton
	{
		Left,
		Right,
		Middle,
		XButton1,
		XButton2,
		ButtonCount
	}

	public enum MouseWheel
	{
		VerticalWheel,
		HorizontalWheel
	}

	public static class SFMouse
	{
		public static bool CheckButtonPressed(MouseButton button) { return sfMouse_isButtonPressed(button); } 

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfMouse_isButtonPressed(MouseButton button);
	}
}
