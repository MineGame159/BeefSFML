using System;

namespace SFML.Graphics
{
	[CRepr]
	public struct RenderStates
	{
		public BlendMode BlendMode;
		public Matrix3x3 Matrix;
		public Texture Texture;
		public Shader Shader;
	}
}
