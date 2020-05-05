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
		public static void SetPosition(Vector2i position, Window relativeTo) => sfMouse_setPosition(position, relativeTo?.[Friend]_handle);
		public static Vector2i GetPosition(Window relativeTo) => sfMouse_getPosition(relativeTo?.[Friend]_handle);

		public static bool CheckButtonPressed(MouseButton button) => sfMouse_isButtonPressed(button); 

		[Import(CSFML_WINDOW), CLink]
		static extern bool sfMouse_isButtonPressed(MouseButton button);

		[Import(CSFML_WINDOW), CLink]
		static extern Vector2i sfMouse_getPosition(void* relativeTo);

		[Import(CSFML_WINDOW), CLink]
		static extern void sfMouse_setPosition(Vector2i position, void* relativeTo);
	}
}
