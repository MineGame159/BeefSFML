using System;
using SFML.System;
using SFML.Graphics.GLSL;
using System.IO;

namespace SFML.Graphics
{
	
	public class Shader : SFHandle<ShaderHandle>, IDisposable
	{
		//public this(String vertexPath, String geometryPath, String fragmentPath) : base(sfShader_createFromFile(vertexPath, geometryPath, fragmentPath)) {}
		//public this(char8* vertexCode, char8* geometryCode, char8* fragmentCode) : base(sfShader_createFromMemory(vertexCode, geometryCode, fragmentCode)) {}

		public this(Stream vertexStream, Stream geometryStream, Stream fragmentStream) : base(sfShader_createFromStream(null, null, null)) { }

		public override void Dispose()
		{
			base.Dispose();
		}

		[Import(CSFML_GRAPHICS), CLink]
		public static extern ShaderHandle sfShader_createFromFile(char8* vertexShaderFilename, char8* geometryShaderFilename, char8* fragmentShaderFilename);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern ShaderHandle sfShader_createFromMemory(char8* vertexShader, char8* geometryShader, char8* fragmentShader);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern ShaderHandle sfShader_createFromStream(void* vertexShaderStream, void* geometryShaderStream, void* fragmentShaderStream);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_destroy")]
		public static extern void Destroy(ShaderHandle shader);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setFloatUniform")]
		public static extern void SetFloatUniform(ShaderHandle shader, char8* name, float x);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setVec2Uniform")]
		public static extern void SetVec2Uniform(ShaderHandle shader, char8* name, Vec2<float> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setVec3Uniform")]
		public static extern void SetVec3Uniform(ShaderHandle shader, char8* name, Vec3<float> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setVec4Uniform")]
		public static extern void SetVec4Uniform(ShaderHandle shader, char8* name, Vec4<float> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setIntUniform")]
		public static extern void SetIntUniform(ShaderHandle shader, char8* name, int x);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setIvec2Uniform")]
		public static extern void SetVec2IntUniform(ShaderHandle shader, char8* name, Vec2<int> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setIvec3Uniform")]
		public static extern void SetVec3IntUniform(ShaderHandle shader, char8* name, Vec3<int> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setIvec4Uniform")]
		public static extern void SetVec4IntUniform(ShaderHandle shader, char8* name, Vec4<int> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setBoolUniform")]
		public static extern void SetBoolUniform(ShaderHandle shader, char8* name, bool x);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setBvec2Uniform")]
		public static extern void SetVec2BoolUniform(ShaderHandle shader, char8* name, Vec2<bool> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setBvec3Uniform")]
		public static extern void SetVec3BoolUniform(ShaderHandle shader, char8* name, Vec3<bool> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setBvec4Uniform")]
		public static extern void SetVec4BoolUniform(ShaderHandle shader, char8* name, Vec4<bool> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setMat3Uniform")]
		public static extern void SetMat3Uniform(ShaderHandle shader, char8* name, Mat3 matrix);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setMat4Uniform")]
		public static extern void sfShader_setMat4Uniform(ShaderHandle shader, char8* name, Mat4 matrix);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern void sfShader_setTextureUniform(ShaderHandle shader, char8* name, TextureHandle texture);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern void sfShader_setCurrentTextureUniform(ShaderHandle shader, char8* name);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfShader_setFloatUniformArray(ShaderHandle shader, char8* name, float* data, uint32 length);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfShader_setVec2UniformArray(ShaderHandle shader, char8* name, Vec2<float>* data, uint32 length);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfShader_setVec3UniformArray(ShaderHandle shader, char8* name, Vec3<float>* data, uint32 length);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfShader_setVec4UniformArray(ShaderHandle shader, char8* name, Vec4<float>* data, uint32 length);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfShader_setMat3UniformArray(ShaderHandle shader, char8* name, Mat3* data, uint32 length);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfShader_setMat4UniformArray(ShaderHandle shader, char8* name, Mat4* data, uint32 length);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern uint32 sfShader_getNativeHandle(ShaderHandle shader);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfShader_bind(ShaderHandle shader);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfShader_isAvailable();

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfShader_isGeometryAvailable();
	}
}
