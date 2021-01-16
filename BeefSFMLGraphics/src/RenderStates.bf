using System;
using SFML.System;

namespace SFML.Graphics
{

	[CRepr, Ordered]
	public struct RenderStates
	{
		public BlendMode Mode;
		public Matrix3x3 Matrix = Matrix3x3.Identity;
		private TextureHandle _textureHandle;
		private ShaderHandle _shaderHandle;

		public void SetTexture(Texture texture) mut
		{
			if (texture == null) {
				_textureHandle = 0;
				return;
			}

			_textureHandle = texture.[Friend]_handle;
		} 
		public void SetShader(Shader shader) mut
		{
			if (shader == null) {
				_shaderHandle = 0;
				return;
			}

			_shaderHandle = shader.[Friend]_handle;
		}

		public this(BlendMode mode, Texture texture, Shader shader, Matrix3x3? matrix)
		{
			Mode = mode;
			_textureHandle = texture == null ? 0 : texture.[Friend]_handle;
			_shaderHandle = shader == null ? 0 : shader.[Friend]_handle;
			Matrix = matrix ?? Matrix3x3.Identity;
		}
	}
}
