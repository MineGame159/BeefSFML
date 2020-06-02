using System;
using SFML.System;
using SFML.Graphics.GLSL;
using System.IO;

namespace SFML.Graphics
{
	public class Shader : SFHandle<ShaderHandle>, IDisposable
	{
		public this(char8* vertexCode, char8* geometryCode, char8* fragmentCode) : base(sfShader_createFromMemory(vertexCode, geometryCode, fragmentCode)) {}
		public this(StringView vertexPath, StringView geometryPath, StringView fragmentPath) : base(0)
		{

			let vert = scope String(vertexPath);
			let geom = scope String(geometryPath);
			let frag = scope String(fragmentPath);

			FileUtility.ToRelativePath(vert);
			FileUtility.ToRelativePath(geom);
			FileUtility.ToRelativePath(frag);

			_handle = sfShader_createFromFile(vert, geom, frag);
		}

		public this(Stream vertexStream, Stream geometryStream, Stream fragmentStream) : base(0)
		{
			let vAdapter = scope SFStreamAdapter(vertexStream);
			let gAdapter = scope SFStreamAdapter(geometryStream);
			let fAdapter = scope SFStreamAdapter(fragmentStream);

			_handle = sfShader_createFromStream(vAdapter.GetCompatibleStream(), gAdapter.GetCompatibleStream(), fAdapter.GetCompatibleStream());
		}

		public ~this() { sfShader_destroy(_handle); }

		public void SetUniform(String name, float x) => sfShader_setFloatUniform(_handle, name, x);
		public void SetUniform(String name, int x) => sfShader_setIntUniform(_handle, name, x);
		public void SetUniform(String name, bool x) => sfShader_setBoolUniform(_handle, name, x);

		public void SetVecUniform(String name, Vec2<float> vector) => sfShader_setVec2Uniform(_handle, name, vector);
		public void SetVecUniform(String name, Vec3<float> vector) => sfShader_setVec3Uniform(_handle, name, vector);
		public void SetVecUniform(String name, Vec4<float> vector) => sfShader_setVec4Uniform(_handle, name, vector);

		public void SetVecUniform(String name, Vec2<int32> vector) => sfShader_setIvec2Uniform(_handle, name, vector);
		public void SetVecUniform(String name, Vec3<int32> vector) => sfShader_setIvec3Uniform(_handle, name, vector);
		public void SetVecUniform(String name, Vec4<int32> vector) => sfShader_setIvec4Uniform(_handle, name, vector);

		public void SetVecUniform(String name, Vec2<bool> vector) => sfShader_setBvec2Uniform(_handle, name, vector);
		public void SetVecUniform(String name, Vec3<bool> vector) => sfShader_setBvec3Uniform(_handle, name, vector);
		public void SetVecUniform(String name, Vec4<bool> vector) => sfShader_setBvec4Uniform(_handle, name, vector);

		public void SetMatUniform(String name, Mat3 matrix) => sfShader_setMat3Uniform(_handle, name, matrix);
		public void SetMatUniform(String name, Mat4 matrix) => sfShader_setMat4Uniform(_handle, name, matrix);

		public void SetTextureUniform(String name, Texture texture) => sfShader_setTextureUniform(_handle, name, texture.[Friend]_handle);
		public void SetTextureUniform(String name) => sfShader_setCurrentTextureUniform(_handle, name);

		public void SetArrayUniform(String name, float[] values) => sfShader_setFloatUniformArray(_handle, name, values.CArray(), (uint32)values.Count);

		public void SetArrayUniform(String name, Vec2<float>[] values) => sfShader_setVec2UniformArray(_handle, name, values.CArray(), (uint32)values.Count);
		public void SetArrayUniform(String name, Vec3<float>[] values) => sfShader_setVec3UniformArray(_handle, name, values.CArray(), (uint32)values.Count);
		public void SetArrayUniform(String name, Vec4<float>[] values) => sfShader_setVec4UniformArray(_handle, name, values.CArray(), (uint32)values.Count);

		public void SetArrayUniform(String name, Mat3[] values) => sfShader_setMat3UniformArray(_handle, name, values.CArray(), (uint32)values.Count);
		public void SetArrayUniform(String name, Mat4[] values) => sfShader_setMat4UniformArray(_handle, name, values.CArray(), (uint32)values.Count);

		public uint32 GetNativeHandle() => sfShader_getNativeHandle(_handle);
		public void Bind() => sfShader_bind(_handle);

		public static bool IsAvailable => sfShader_isAvailable();
		public static bool IsGeometryAvailable => sfShader_isGeometryAvailable();

		[Import(CSFML_GRAPHICS), CLink]
		public static extern ShaderHandle sfShader_createFromFile(char8* vertexShaderFilename, char8* geometryShaderFilename, char8* fragmentShaderFilename);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern ShaderHandle sfShader_createFromMemory(char8* vertexShader, char8* geometryShader, char8* fragmentShader);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern ShaderHandle sfShader_createFromStream(InputStream vertexShaderStream, InputStream geometryShaderStream, InputStream fragmentShaderStream);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern void sfShader_destroy(ShaderHandle shader);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern void sfShader_setFloatUniform(ShaderHandle shader, char8* name, float x);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern void sfShader_setVec2Uniform(ShaderHandle shader, char8* name, Vec2<float> vector);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern void sfShader_setVec3Uniform(ShaderHandle shader, char8* name, Vec3<float> vector);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern void sfShader_setVec4Uniform(ShaderHandle shader, char8* name, Vec4<float> vector);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern void sfShader_setIntUniform(ShaderHandle shader, char8* name, int x);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern void sfShader_setIvec2Uniform(ShaderHandle shader, char8* name, Vec2<int32> vector);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern void sfShader_setIvec3Uniform(ShaderHandle shader, char8* name, Vec3<int32> vector);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern void sfShader_setIvec4Uniform(ShaderHandle shader, char8* name, Vec4<int32> vector);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern void sfShader_setBoolUniform(ShaderHandle shader, char8* name, bool x);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern void sfShader_setBvec2Uniform(ShaderHandle shader, char8* name, Vec2<bool> vector);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern void sfShader_setBvec3Uniform(ShaderHandle shader, char8* name, Vec3<bool> vector);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern void sfShader_setBvec4Uniform(ShaderHandle shader, char8* name, Vec4<bool> vector);

		[Import(CSFML_GRAPHICS), CLink]
		public static extern void sfShader_setMat3Uniform(ShaderHandle shader, char8* name, Mat3 matrix);

		[Import(CSFML_GRAPHICS), CLink]
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
