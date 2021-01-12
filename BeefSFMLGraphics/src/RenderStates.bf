using System;
using SFML.System;

namespace SFML.Graphics
{

	[CRepr, Ordered]
	public struct RenderStates
	{
		public BlendMode Mode;
		public Matrix3x3 Matrix = Matrix3x3.Identity;
		private TextureHandle TextureH;
		private ShaderHandle ShaderH;

		public this(BlendMode mode, Texture texture, Shader shader, Matrix3x3? matrix)
		{
			Mode = mode;
			TextureH = texture == null ? 0 : texture.[Friend]_handle;
			ShaderH = shader == null ? 0 : shader.[Friend]_handle;
			Matrix = matrix ?? Matrix3x3.Identity;
		}
	}
}
