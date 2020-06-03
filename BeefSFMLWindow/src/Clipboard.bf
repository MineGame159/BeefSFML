using System;
using SFML.System;

namespace SFML.Window
{
	public static class Clipboard
	{
		public static StringView GetString() => StringView(sfClipboard_getString());

		public static void SetString(StringView text) => sfClipboard_setString(text.ToScopeCStr!());

		// Native functions

		[Import(CSFML_WINDOW), CLink]
		private static extern char8* sfClipboard_getString();
		
		[Import(CSFML_WINDOW), CLink]
		private static extern void sfClipboard_setString(char8* text);
	}
}
