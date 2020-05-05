using System;
using SFML.System;
using SFML.Graphics.GLSL;
using System.Collections;

namespace SFML.Graphics
{
	public static sealed class ShaderFactory
	{
		public static void SetTextureUniform(ref Shader shader, char8* name, Texture texture) => sfShader_setTextureUniform(shader, name, texture.[Friend]_handle);

		public static void SetFloatUniformArray(Shader shader, char8* name, float[] data) => sfShader_setFloatUniformArray(shader, name, data.CArray(), (uint32)data.Count);
		public static void SetVec2UniformArray(Shader shader, char8* name, Vec2<float>[] data) => sfShader_setVec2UniformArray(shader, name, data.CArray(), (uint32)data.Count);
		public static void SetVec3UniformArray(Shader shader, char8* name, Vec3<float>[] data) => sfShader_setVec3UniformArray(shader, name, data.CArray(), (uint32)data.Count);
		public static void SetVec4UniformArray(Shader shader, char8* name, Vec4<float>[] data) => sfShader_setVec4UniformArray(shader, name, data.CArray(), (uint32)data.Count);

		public static void SetMat3UniformArray(ref Shader shader, char8* name, Mat3[] data) => sfShader_setMat3UniformArray(shader, name, data.CArray(), (uint32)data.Count);
		public static void SetMat4UniformArray(ref Shader shader, char8* name, Mat4[] data) => sfShader_setMat4UniformArray(shader, name, data.CArray(), (uint32)data.Count);

		public static bool IsAvailable => sfShader_isAvailable();
		public static bool IsGeometryAvailable => sfShader_isGeometryAvailable();

		public static uint32 GetGLHandleFor(Shader shader) => sfShader_getNativeHandle(shader);
		public static void BindShader(Shader shader) => sfShader_bind(shader);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_createFromFile")]
		public static extern Shader CreateFromFile(char8* vertexShaderFilename, char8* geometryShaderFilename, char8* fragmentShaderFilename);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_createFromMemory")]
		private static extern Shader CreateFromMemory(char8* vertexShader, char8* geometryShader, char8* fragmentShader);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_createFromStream")]
		private static extern Shader CreateFromStream(void* vertexShaderStream, void* geometryShaderStream, void* fragmentShaderStream);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_destroy")]
		private static extern void Destroy(Shader shader);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setFloatUniform")]
		private static extern void SetFloatUniform(Shader shader, char8* name, float x);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setVec2Uniform")]
		private static extern void SetVec2Uniform(Shader shader, char8* name, Vec2<float> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setVec3Uniform")]
		private static extern void SetVec3Uniform(Shader shader, char8* name, Vec3<float> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setVec4Uniform")]
		private static extern void SetVec4Uniform(Shader shader, char8* name, Vec4<float> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setIntUniform")]
		private static extern void SetIntUniform(Shader shader, char8* name, int x);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setIvec2Uniform")]
		private static extern void SetVec2IntUniform(Shader shader, char8* name, Vec2<int> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setIvec3Uniform")]
		private static extern void SetVec3IntUniform(Shader shader, char8* name, Vec3<int> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setIvec4Uniform")]
		private static extern void SetVec4IntUniform(Shader shader, char8* name, Vec4<int> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setBoolUniform")]
		private static extern void SetBoolUniform(Shader shader, char8* name, bool x);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setBvec2Uniform")]
		private static extern void SetVec2BoolUniform(Shader shader, char8* name, Vec2<bool> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setBvec3Uniform")]
		private static extern void SetVec3BoolUniform(Shader shader, char8* name, Vec3<bool> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setBvec4Uniform")]
		private static extern void SetVec4BoolUniform(Shader shader, char8* name, Vec4<bool> vector);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setMat3Uniform")]
		private static extern void SetMat3Uniform(Shader shader, char8* name, Mat3 matrix);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setMat4Uniform")]
		private static extern void sfShader_setMat4Uniform(Shader shader, char8* name, Mat4 matrix);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfShader_setTextureUniform(Shader shader, char8* name, void* texture);

		[Import(CSFML_GRAPHICS), LinkName("sfShader_setCurrentTextureUniform")]
		private static extern void SetCurrentTextureUniform(Shader shader, char8* name);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfShader_setFloatUniformArray(Shader shader, char8* name, float* data, uint32 length);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfShader_setVec2UniformArray(Shader shader, char8* name, Vec2<float>* data, uint32 length);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfShader_setVec3UniformArray(Shader shader, char8* name, Vec3<float>* data, uint32 length);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfShader_setVec4UniformArray(Shader shader, char8* name, Vec4<float>* data, uint32 length);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfShader_setMat3UniformArray(Shader shader, char8* name, Mat3* data, uint32 length);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfShader_setMat4UniformArray(Shader shader, char8* name, Mat4* data, uint32 length);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern uint32 sfShader_getNativeHandle(Shader shader);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfShader_bind(Shader shader);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfShader_isAvailable();

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfShader_isGeometryAvailable();
	}
}
