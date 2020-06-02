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

		public static readonly Color Red 			=> .(255, 0, 0, 255);
		public static readonly Color Blue 			=> .(0, 0, 255, 255);
		public static readonly Color Gray 			=> .(127, 127, 127, 255);
		public static readonly Color Green 			=> .(0, 255, 0, 255);
		public static readonly Color White 			=> .(255, 255, 255, 255);
		public static readonly Color Black 			=> .(0, 0, 0, 255);
		public static readonly Color Clear 			=> .(0, 0 ,0, 0);
		public static readonly Color CornflowerBlue => .(100, 149, 237, 255);
		public static readonly Color PleasantYellow => .(255, 234, 4, 255);
	}
}
