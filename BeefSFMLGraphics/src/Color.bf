using System;

namespace SFML.Graphics
{
	[CRepr, Ordered]
	public struct Color
	{
		public uint8 R, G, B, A;

		public this(uint8 red, uint8 green, uint8 blue, uint8 alpha)
		{
			R = red;
			G = green;
			B = blue;
			A = alpha;
		}

		public static readonly Color Red => Color(255, 0, 0, 255);
 		public static readonly Color Blue => Color(0, 0, 255, 255);
		public static readonly Color Green => Color(0, 255, 0, 255);
		public static readonly Color CornflowerBlue => Color(100, 149, 237, 255);
		public static readonly Color NotQuiteYellow => Color(255, 234, 4, 255);
		public static readonly Color White => Color(255, 255, 255, 255);
		public static readonly Color Black => Color(0, 0, 0, 255);
		public static readonly Color Clear => Color(0, 0 ,0, 0);
		public static readonly Color Gray => Color(127, 127, 127, 255);
	}
}
