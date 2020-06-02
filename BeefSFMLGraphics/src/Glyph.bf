using System;

namespace SFML.Graphics
{
	[CRepr, Ordered]
	public struct Glyph
	{
		public float Advance;
		public FloatRect Bounds;
		public IntRect TextureRect;
	}
}
