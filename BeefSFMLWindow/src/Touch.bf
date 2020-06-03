using System;
using SFML.System;

namespace SFML.Window
{
	public static class Touch
	{
		public static bool IsDown(uint finger) => sfTouch_isDown((uint32)finger);

		public static Vector2i GetPosition(uint finger, Window window) => sfTouch_getPosition((uint32)finger, window.[Friend]_handle);

		// Native functions

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfTouch_isDown(uint32 finger);
		
		[Import(CSFML_WINDOW), CLink]
		private static extern Vector2i sfTouch_getPosition(uint32 finger, WindowHandle relativeTo);
	}
}
