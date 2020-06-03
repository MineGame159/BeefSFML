using System;
using SFML.System;

namespace SFML.Window
{

	public enum CursorType : uint32
	{
		Arrow,
		ArrowWait,
		Wait,
		Text,
		Hand,
		SizeHorinzontal,
		SizeVertical,
		SizeTopLeftBottomRight,
		SizeBottomLeftTopRight,
		SizeAll,
		Cross,
		Help,
		NotAllowed
	}


	public class Cursor : SFHandle<CursorHandle>, IDisposable
	{
		public this(CursorType type) : base(sfCursor_createFromSystem(type)) {}
		public this(uint8* pixels, Vector2u32 size, Vector2u32 hotspot) : base(sfCursor_createFromPixels(pixels, size, hotspot)) {}
		public ~this() { sfCursor_destroy(_handle); }

		public override void Dispose() { base.Dispose(); }

		// Native functions

		[Import(CSFML_WINDOW), CLink]
		private static extern CursorHandle sfCursor_createFromSystem(CursorType type);

		[Import(CSFML_WINDOW), CLink]
		private static extern CursorHandle sfCursor_createFromPixels(uint8* pixels, Vector2u32 size, Vector2u32 hotspot);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfCursor_destroy(CursorHandle handle);
	}
}
