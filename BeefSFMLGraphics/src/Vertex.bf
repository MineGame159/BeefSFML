using System;
using SFML.System;


namespace SFML.Graphics
{
	[CRepr]
	struct Vertex
	{
		public Vector2f Position;
		public Color Color;
		public Vector2f TextureCoords;

		public this(Vector2f position, Color color, Vector2f textureCoords)
		{
			Position = position;
			Color = color;
			TextureCoords = textureCoords;
		}
	}
}
