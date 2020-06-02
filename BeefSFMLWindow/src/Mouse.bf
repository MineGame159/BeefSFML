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

	public static class Mouse
	{
		public static bool CheckButtonPressed(MouseButton button) { return sfMouse_isButtonPressed(button); }
		public static void SetPosition(Window relativeTo, Vector2i position) => sfMouse_setPosition(position, relativeTo.[Friend]_handle);
		public static Vector2i GetPosition(Window relativeTo) => sfMouse_getPosition(relativeTo.[Friend]_handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfMouse_isButtonPressed(MouseButton button);

		[Import(CSFML_WINDOW), CLink]
		private static extern Vector2i sfMouse_getPosition(WindowHandle handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfMouse_setPosition(Vector2i position, WindowHandle handle);
	}
}
